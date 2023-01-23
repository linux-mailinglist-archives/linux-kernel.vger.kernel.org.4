Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF1678436
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjAWSKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjAWSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:09:52 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00B810DD;
        Mon, 23 Jan 2023 10:09:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b17so12244518pld.7;
        Mon, 23 Jan 2023 10:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h71nKMMoIsz/Hj/gRDZxwhWznaqWZtO0SjsrpPB1kLg=;
        b=PWY1yImt98IKvu6Ko3YTtCfv+8yn8N4dxMlxiGHXivINNgxb7PP+sYm5hWI1LQdG7E
         ond8CAGQ2lR+CZr8P5hQQBZrdZjMc3+6bsYtZlRg5zp4XDIeGAXLkeYpJY88xmHtyHO8
         gz1EOaYANqVyYjiVO1JEVde1YkvNPrZjnMo+wOi389kHTiHscrMdDoxqhC11nIHQZmGV
         KP/3IxJSKXWi68zCRWbuthTk8cX/OJYFPzq8MBuItmBYOrtrtFQw4Hwfhsscn9AEjjDw
         G6upwn5zsPFf+dXK6oWvdT84O0oVl1m2VDnLtOKgWdUB0RKpieK37Tjzw8NN7Wr24RAk
         TmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h71nKMMoIsz/Hj/gRDZxwhWznaqWZtO0SjsrpPB1kLg=;
        b=EJC5snrRBBL5J2ojgYzKfO4HY5H32DTsfoDgZNCuA8PIAsuKp1n409+Q6+st77tw0N
         kz0lojHgNRgRuru1BnwAzWa/6SQu0Nxc+Z++Surp3xrqBnSACgdRy7xYIrIR1eJOn+TF
         jCoz8aaIjRca/MH2eRy5j8HtqWp2D8HpN5JUYoVrBXCXI2fXHKpzUG0/77FmlwjwWKyn
         sd2lpK1owxy4VLOEf5OTdHyJEpA1nbeh0UcyZw26031M2F3s7f3abi8RsyhYxlFAExMH
         PKkq/BfURjYWUUPohWKO/G62+RBau/mJGDSvSt96M2DFtsBMJ4HVKYG3+FPJMS2TDSjl
         8cZg==
X-Gm-Message-State: AFqh2koKkL0t51y11T/BLgTKPQNRpda3NetHVVHfqk5Ar1+NciKq6Q9N
        9Jr/4aiIvRyvRBShALVPGkCb9Kd0Em3NmVEg
X-Google-Smtp-Source: AMrXdXvriK549J3m7w3rcIHWDRliO4pTnxtHs+t6Wr7eYLTul6vENMQYfhQaFVvWuyegieiSKLUIag==
X-Received: by 2002:a17:902:834b:b0:192:d230:6778 with SMTP id z11-20020a170902834b00b00192d2306778mr46543194pln.13.1674497391124;
        Mon, 23 Jan 2023 10:09:51 -0800 (PST)
Received: from [192.168.1.216] ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b00189fd83eb95sm11423plh.69.2023.01.23.10.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:09:50 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
X-Google-Original-From: Rishit Bansal <rishit.bansal0@gmail.com>
Message-ID: <f692cb5c-034b-be59-6c4d-688953b5a976@gmail.com>
Date:   Mon, 23 Jan 2023 23:39:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] platform/x86: hp-wmi: Handle Omen Key event
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120221214.24426-1-rishitbansal0@gmail.com>
 <53349ebc-7b47-de8a-e511-c8069a1bf315@redhat.com>
In-Reply-To: <53349ebc-7b47-de8a-e511-c8069a1bf315@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/01/23 19:13, Hans de Goede wrote:
> Hi,
>
> On 1/20/23 23:12, Rishit Bansal wrote:
>> Add support to map the "HP Omen Key" to KEY_PROG2. Laptops in the HP
>> Omen Series open the HP Omen Command Center application on windows. But,
>> on linux it fails with the following message from the hp-wmi driver:
>>
>> [ 5143.415714] hp_wmi: Unknown event_id - 29 - 0x21a5
>>
>> Also adds support to map Fn+Esc to KEY_FN_ESC. This currently throws the
>> following message on the hp-wmi driver:
>>
>> [ 6082.143785] hp_wmi: Unknown key code - 0x21a7
>>
>> There is also a "Win-Lock" key on HP Omen Laptops which supports
>> Enabling and Disabling the Windows key, which trigger commands 0x21a4
>> and 0x121a4 respectively, but I wasn't able to find any KEY in input.h
>> to map this to.
> We could add KE_IGNORE mappings to hp_wmi_keymap for those,
> doing so should silence the warnings about unknown codes.
>
> If you think this is useful please provide a separate follow-up
> patch for this.


Alright, I will make a follow up patch for this change.


>> Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
> I have merged this v2 now, but with some coding style changes,
> for your next patches please try to keep the indentation
> and sorting of things correct.


Thank you for pointing out and fixing up the styling issues! I'll surely 
keep this in mind for future patches.


>
>> ---
>> Changes since v1:
>>   - Add support for FN+Esc Key
>> ---
>>   drivers/platform/x86/hp/hp-wmi.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>> index 0a99058be813..ab858db551fb 100644
>> --- a/drivers/platform/x86/hp/hp-wmi.c
>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>> @@ -91,6 +91,7 @@ enum hp_wmi_event_ids {
>>   	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
>>   	HPWMI_SANITIZATION_MODE		= 0x17,
>>   	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
>> +	HPWMI_OMEN_KEY				= 0x1D,
> There is one <tab> too much before the '= 0x1D' and 0x1D should
> be between the 0x17 and 0x21 lines.
>
>>   };
>>   
>>   /*
>> @@ -219,6 +220,8 @@ static const struct key_entry hp_wmi_keymap[] = {
>>   	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
>>   	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
>>   	{ KE_KEY, 0x231b,  { KEY_HELP } },
>> +	{ KE_KEY, 0x21a5,  { KEY_PROG2 }}, /* HP Omen Key */
>> +	{ KE_KEY, 0x21a7, { KEY_FN_ESC }},
> These need to be above the 0x21a9 line, so sorted by base event code
> (lower 16 bits) Also you are missing a space in the indentation of
> the { KEY_FN_ESC } and there should be a space between the 2 }} at
> the end like on the other lines.
>
> Regards,
>
> Hans
>
>
>>   	{ KE_END, 0 }
>>   };
>>   
>> @@ -810,6 +813,7 @@ static void hp_wmi_notify(u32 value, void *context)
>>   	case HPWMI_SMART_ADAPTER:
>>   		break;
>>   	case HPWMI_BEZEL_BUTTON:
>> +	case HPWMI_OMEN_KEY:
>>   		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
>>   		if (key_code < 0)
>>   			break;
