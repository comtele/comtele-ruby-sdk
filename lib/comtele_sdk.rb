require "comtele_sdk/version"
require 'rest-client'
require 'json'

module ComteleSdk
    class AccountService 

        def initialize(api_key)
            @api_key = api_key
            @base_address = 'https://sms.comtele.com.br/api/v2' 
            @headers = {
                'Accept': 'application/json',
                'Content-type': 'application/json',            
                'auth-key': @api_key
            }   
        end    
    
        def get_account_by_username(username)    
            url = @base_address + '/accounts/' + username
            response = RestClient.get(url, @headers)
            
            return JSON.parse(response)
        end
    
        def get_all_accounts
            url = @base_address + '/accounts'
            response = RestClient.get(url, @headers)
            
            return JSON.parse(response)
        end
    end

    class ContextMessageService
        def initialize(api_key)
            @api_key = api_key
            @base_address = 'https://sms.comtele.com.br/api/v2' 
            @headers = {
                'Accept': 'application/json',
                'Content-type': 'application/json',            
                'auth-key': @api_key
            }  
        end
    
        def send(sender, context_rule_name, receivers)
            url = @base_address + '/sendcontextmessage'   
            
            payload = JSON.generate({
                'sender': sender,
                'contextRuleName': context_rule_name,
                'receivers': receivers.join(',')
            })
    
            response = RestClient.post(url, payload, @headers)
    
            return JSON.parse(response)
        end 
    
        def schedule(sender, context_rule_name, schedule_date, receivers)
            url = @base_address + '/schedulecontextmessage'   
            
            payload = JSON.generate({
                'sender': sender,
                'contextRuleName': context_rule_name,
                'scheduleDate': schedule_date,
                'receivers': receivers.join(',')
            })
    
            response = RestClient.post(url, payload, @headers)
    
            return JSON.parse(response)
        end 
    
        def get_report(start_date, end_date, sender = '', context_rule_name = '')
            url = @base_address + '/contextreporting?startDate=' + start_date + '&endDate=' + end_date + '&sender=' + sender + '&contextRuleName=' + context_rule_name
            response = RestClient.get(url, @headers)
            
            return JSON.parse(response)
        end 
    end

    class CreditService
        def initialize(api_key)
            @api_key = api_key
            @base_address = 'https://sms.comtele.com.br/api/v2' 
            @headers = {
                'Accept': 'application/json',
                'Content-Type': 'application/json',            
                'auth-key': @api_key
            }
        end
    
        def get_credits(username)
            url = @base_address + '/credits/' + username
            response = RestClient.get(url, @headers)
    
            return JSON.parse(response)
        end 
    
        def get_my_credits
            url = @base_address + '/credits'
            response = RestClient.get(url, @headers)
    
            return JSON.parse(response)
        end 
    
        def get_history(username)
            url = @base_address + '/balancehistory/' + username
            response = RestClient.get(url, @headers)
    
            return JSON.parse(response)
        end 
    
        def add_credits(username, amount)
            url = @base_address + '/credits/'+ username + '?amount=' + amount.to_s        
            response = RestClient.put(url, {}, @headers)
    
            return JSON.parse(response)
        end 
    end

    class DeliveryStatus
        ALL = 'all'
        DELIVERED = 'true'
        UNDELIVERED = 'false'
    end

    class ReplyService
        def initialize(api_key)
            @api_key = api_key
            @base_address = 'https://sms.comtele.com.br/api/v2' 
            @headers = {
                'Accept': 'application/json',
                'Content-type': 'application/json',            
                'auth-key': @api_key
            }  
        end
    
        def get_report(start_date, end_date, sender = '')
            url = @base_address + '/replyreporting?startDate=' + start_date + '&endDate=' + end_date + '&sender=' + sender 
            response = RestClient.get(url, @headers)
            
            return JSON.parse(response)
        end 
    end

    class ReportGroupType
        MONTHLY = 'true'
        DAILY = 'false'
    end 

    class TextMessageService
        def initialize(api_key)
            @api_key = api_key
            @base_address = 'https://sms.comtele.com.br/api/v2' 
            @headers = {
                'Accept': 'application/json',
                'Content-type': 'application/json',            
                'auth-key': @api_key
            }   
        end
    
        def send(sender, content, receivers)
            url = @base_address + '/send'   
            
            payload = JSON.generate({
                'sender': sender,
                'content': content,
                'receivers': receivers.join(',')
            })
    
            response = RestClient.post(url, payload, @headers)
    
            return JSON.parse(response)
        end 
    
        def schedule(sender, content, schedule_date, receivers)
            url = @base_address + '/schedule'
            
            payload =  JSON.generate({
                'sender': sender,
                'content': content,
                'scheduleDate': schedule_date,
                'receivers': receivers.join(',')
            })
    
            response = RestClient.post(url, payload, @headers)
    
            return JSON.parse(response)
        end 
    
        def get_detailed_report(start_date, end_date, delivery_status)
            url = @base_address + '/detailedreporting?startDate=' + start_date + '&endDate=' + end_date + '&delivered=' + delivery_status
            response = RestClient.get(url, @headers)
            
            return JSON.parse(response)
        end
    
        def get_consolidated_report(start_date, end_date, group_type)
            url = @base_address + '/consolidatedreporting?startDate=' + start_date + '&endDate=' + end_date + '&group=' + group_type
            response = RestClient.get(url, @headers)
            
            return JSON.parse(response)    
        end 
    end

    class BlacklistService
        def initialize(api_key)
            @api_key = api_key
            @base_address = 'https://sms.comtele.com.br/api/v2' 
            @headers = {
                'Accept': 'application/json',
                'Content-type': 'application/json',            
                'auth-key': @api_key
            }   
        end

        def get_blacklist()
            url = @base_address + '/blacklist'  
            response = RestClient.get(url, @headers)
            
            return JSON.parse(response)  
        end

        def get_by_phone_number(phone_number)
            url = @base_address + '/blacklist?id=' + phone_number   
            response = RestClient.get(url, @headers)
            
            return JSON.parse(response) 
        end

        def insert(phone_number)
            url = @base_address + '/blacklist'   
            
            payload = JSON.generate({ 'phoneNumber': phone_number })    
            response = RestClient.post(url, payload, @headers)
    
            return JSON.parse(response)
        end 

        def remove(phone_number)
            url = @base_address + '/blacklist?id=' + phone_number   
            response = RestClient.delete(url, {}, @headers)
            
            return JSON.parse(response) 
        end
    end
end
