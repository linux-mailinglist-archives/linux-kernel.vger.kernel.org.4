Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EFC664391
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbjAJOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbjAJOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:47:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91144FCEE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:47:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso7198626wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Na36X1GB51nJZLV+wR9SqcSDYHAa+6yCRZvq/1xVmy0=;
        b=Z4obp+OiY1ytxl7l/l/UZ9CxhhUw2KWYuCSj702seXCShA8HtfVVZYCN7oqgQJuZ4x
         j9nQF5T9PfjPqcUG6fADvyCZXEgkabDMGDrDG4wvDldqYexYHO/0bIogwJQXZrdTTDrY
         oaYzz9/zA4wbvIrQVdjjdiKOMWa4mF8EiGWtVIwrDBbnT1zEbuScAhRP8EjpUDCGwAqi
         IZ+mphlIuul1XekGoefWkgtteIG4LMck0FuXH87oNbFUQ7n6Kws6J2nv4l2kgTJLybsb
         G5IKHyl60hg2T+rgsUpX/RGRgphC3E468/acnJJ49MI/8rbURBwFSRdGIOLCjwo2sn9y
         b8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na36X1GB51nJZLV+wR9SqcSDYHAa+6yCRZvq/1xVmy0=;
        b=IyaLjS8fhPMkSyPoG0wIBmCB5WtzZIWFiQKnloCrG8Tdla9B7xYGTcVhFgXDIyP935
         NI987AZRwf8EozKtAxisHyr9zq8oYNZStAug/LkAqqmGoFipPnbfiX5YzOGtshObj0iG
         aKQATrmBT4FirQjMmTgxXw7lbgBiCXOeScxQf+3+O2FYVAhi4Ive45MP9RakD2hW25nB
         LD8ttCQ7kzBj7UZeLvH5mOu1hUnLhwcUV7aQMX/FH9iG6Iio6Vah9QD7eg8ZI0O0b9mp
         5n28cVKMv+R9kGgQu0kgvP4FlQ2ewyeet6NriuYyimsBZ82DPwyPvp3TzqFbb8jVShLp
         4Wcw==
X-Gm-Message-State: AFqh2koVcPOpRuez2+41i/GPxkvnwD1qxen4xPREi6OyIlq1jw6Al2Ah
        d5pojQWm6qza1ATG1jT1HeKIsALoXcx3dzytfqM=
X-Google-Smtp-Source: AMrXdXtBIb2NrIIUG2tKsL4GAjOZk509zdwPumpZE1VhKtPgS0LGTLF6H/oNnS8YAvhSHX3FWGSf1w==
X-Received: by 2002:a05:600c:3c88:b0:3d9:69fd:7707 with SMTP id bg8-20020a05600c3c8800b003d969fd7707mr47153368wmb.2.1673362045953;
        Tue, 10 Jan 2023 06:47:25 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r126-20020a1c2b84000000b003d35c845cbbsm19291934wmr.21.2023.01.10.06.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 06:47:25 -0800 (PST)
Message-ID: <cf5e9339-2511-1135-71da-a8342b264414@linaro.org>
Date:   Tue, 10 Jan 2023 14:47:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: ieee80211_handle_wake_tx_queue and dynamic ps regression
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-kernel@vger.kernel.org, alexander@wetzel-home.de,
        johannes.berg@intel.com, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
References: <19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org>
 <06f76774-1b2e-f563-7128-7d5b9547dfe9@linaro.org>
In-Reply-To: <06f76774-1b2e-f563-7128-7d5b9547dfe9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 12:44, Bryan O'Donoghue wrote:
> + linux-wireless
> On 10/01/2023 12:35, Bryan O'Donoghue wrote:
>> commit a790cc3a4fad75048295571a350b95b87e022a5a 
>> (wake_tx_queue-broken-23-08-01)
>> Author: Alexander Wetzel <alexander@wetzel-home.de>
>> Date:   Sun Oct 9 18:30:39 2022 +0200
>>
>>      wifi: mac80211: add wake_tx_queue callback to drivers
>>
>> is causing a regression with
>>
>> - CONF_PS = 1
>> - CONF_DYNAMIC_PS = 0
>> - ieee80211_handle_wake_tx_queue
>>
>> In this case we get stuck in a loop similar to this
>>
>> // IEEE80211_CONF_CHANGE_PS
>> [   17.255480] wcn36xx: wcn36xx_change_ps/312 enable
>> [   18.088835] ieee80211_tx_h_dynamic_ps/263 setting 
>> IEEE80211_QUEUE_STOP_REASON_PS
>> [   18.088906] ieee80211_handle_wake_tx_queue/334 entry
>> [   18.091505] ieee80211_dynamic_ps_disable_work/2250 calling 
>> ieee80211_hw_config()
>> [   18.095370] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue
>>
>> // IEEE80211_CONF_CHANGE_PS
>> [   18.102625] wcn36xx: wcn36xx_change_ps/312 disable
>> [   18.107643] wake_tx_push_queue/303 entry
>>
>> // txq is stopped here reason == IEEE80211_QUEUE_STOP_REASON_PS
>> [   18.107654] wake_tx_push_queue/311 q_stopped bitmask 0x00000002 
>> IEEE80211_QUEUE_STOP_REASON_PS true
>> [   18.107661] wake_tx_push_queue/324 exit
>> [   18.107667] ieee80211_handle_wake_tx_queue/342 exit
>> [   18.115560] ieee80211_handle_wake_tx_queue/334 entry
>> [   18.139937] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue
>> [   18.145163] wake_tx_push_queue/303 entry
>> [   18.150016] ieee80211_dynamic_ps_disable_work/2252 completed 
>> ieee80211_hw_config()
>>
>> // now we unset IEEE80211_QUEUE_STOP_REASON_PS but too late
>> [   18.151145] wake_tx_push_queue/311 q_stopped bitmask 0x00000002 
>> IEEE80211_QUEUE_STOP_REASON_PS true
>> [   18.155263] ieee80211_dynamic_ps_disable_work/2254 clearing 
>> IEEE80211_QUEUE_STOP_REASON_PS
>> [   18.162531] wake_tx_push_queue/324 exit
>> [   18.162548] ieee80211_handle_wake_tx_queue/342 exit
>> [   18.183639] ieee80211_dynamic_ps_disable_work/2259 cleared 
>> IEEE80211_QUEUE_STOP_REASON_PS
>>
>> // IEEE80211_CONF_CHANGE_PS runs again
>> [   18.215487] wcn36xx: wcn36xx_change_ps/312 enable
>>
>> We get stuck in that loop. Packets getting transmitted is a rare 
>> event, most are dropped.

BTW I considered implementing a wcn36xx specific wake_tx callback - 
which maybe should be done anyway.

I _don't_ see other drivers checking for q_stopped & 
IEEE80211_QUEUE_STOP_REASON_PS

Should they be ?

If they should check IEEE80211_QUEUE_STOP_REASON_PS, then right now, 
they don't. If they shouldn't check IEEE80211_QUEUE_STOP_REASON_PS then 
neither should the generic replacement ieee80211_handle_wake_tx_queue()

---
bod
