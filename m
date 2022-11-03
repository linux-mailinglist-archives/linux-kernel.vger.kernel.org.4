Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8472F617FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKCOqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiKCOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:46:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08BB630E;
        Thu,  3 Nov 2022 07:46:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h9so3187446wrt.0;
        Thu, 03 Nov 2022 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBACoTrABcSHWWCkv5Qw2Xy4zyiJ+SvfP16huFjzUQQ=;
        b=KKpE5P4nXuyH5+NvF9mS7cAYPakam249HcsYaZg3nXRAadkuQGTXxo1+aF/KxHGbCo
         aGkJxfxMT2UuuujOIRbQ0YhZ6r24M3hMC2JBNEzY4pGdjxuwhPAVh5iDbInxRA3qKSIv
         3Eux7yQrpxDJB+I3I0o6sfrfnzXhuN9YpmZFhXBUbxrz0oag876O0by5Kc9fJgxhwIse
         wcyRmppDSIwkd8J329a35tSxvUwvWi0TqKouZ8jNgwUZ4mmWaRzcHsWM8eU5Jl5PyLyl
         I42TCBL1ZcMK1MpKWesLhp3b8+8hlb7ShNW1gPfwyBWoE5MraoSHX20pq1lDCnRxRvi4
         lqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBACoTrABcSHWWCkv5Qw2Xy4zyiJ+SvfP16huFjzUQQ=;
        b=MjH1i8iYWQcqObP44i91QYkvoXH/GMPwCMAa2tFEUfomVswkpmiaqULVmhdnMzUEL9
         DH7wAXhFa1EouZlO0lNUi0gvlR1jCHFgoZQI5SA7/ICQzW8GqW9IkwnJcpi7kKLcOzV6
         I143xXX2HfkIIsjBZsJNga4+1pHqbN9VvMyN6Zqrc7h+4c7gkrbYi6mm2S81NaFBqh02
         Fpiyweo+mSWziewGugRFmTf1ZJHVTQCL8Pi0HTZ5q4yaWmqo3lQwsNgUOG9Pp+q9PR/i
         Q0E6FANYvfO6xhaULEoUkwtFgvOmlAulFrlImnZ9oGhJSd8QYt6rXKV+84Y2c35rLa/M
         tSZg==
X-Gm-Message-State: ACrzQf1q+BjfE6EoraEhoCxukcY9wc/rjr3oL/JfDNG1M9cqjqSZfVaC
        cYhO5knWmYfYvnTzBbL3qp4=
X-Google-Smtp-Source: AMsMyM4db/2ouQBL37ksg96clZ2mn1e/+5VrXW9XGSXyYE80JhXmhydbExQOdHje2b8V1q9kJvlZdw==
X-Received: by 2002:adf:e44f:0:b0:236:59a3:c5a8 with SMTP id t15-20020adfe44f000000b0023659a3c5a8mr19548570wrm.396.1667486784334;
        Thu, 03 Nov 2022 07:46:24 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id c5-20020a05600c0a4500b003b4a68645e9sm10992wmq.34.2022.11.03.07.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:46:23 -0700 (PDT)
Message-ID: <4ef07fc6-8faa-7878-2f91-9c9ae90e2f2d@gmail.com>
Date:   Thu, 3 Nov 2022 14:46:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] cpufreq: longhaul: Make array speeds static const
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103132141.79671-1-colin.i.king@gmail.com>
 <20221103143705.6g3geneixpmguaq5@vireshk-i7>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20221103143705.6g3geneixpmguaq5@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 14:37, Viresh Kumar wrote:
> On 03-11-22, 13:21, Colin Ian King wrote:
>> Don't populate the read-only array speeds on the stack but instead
>> make it static. Also makes the object code a little smaller.
> 
> How will that benefit ? I am just looking for a valid answer in commit log.

When the array is non-static there will be some executable code to put 
these values into the array that's on the stack (e.g. at run time). When 
it is static the array is filled at compile time and there is no 
executable code required to populate the array at run time.



> 
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/cpufreq/longhaul.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
>> index 3e000e1a75c6..25f8ef7bac47 100644
>> --- a/drivers/cpufreq/longhaul.c
>> +++ b/drivers/cpufreq/longhaul.c
>> @@ -407,7 +407,7 @@ static int guess_fsb(int mult)
>>   {
>>   	int speed = cpu_khz / 1000;
>>   	int i;
>> -	int speeds[] = { 666, 1000, 1333, 2000 };
>> +	static const int speeds[] = { 666, 1000, 1333, 2000 };
> 
> Why not make it global then ?

Making it static inside the function limits the scope to the function 
and so it's not globally visible. We don't like making stuff global 
unless we really need to.

Colin


