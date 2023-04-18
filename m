Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC16E59F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjDRG5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjDRG45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:56:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9721BC8;
        Mon, 17 Apr 2023 23:56:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec816c9d03so1999017e87.2;
        Mon, 17 Apr 2023 23:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681801011; x=1684393011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dA0tFrgEscDTi4fNivjO6EpmE8ixxAtZdpP5mEG8YhA=;
        b=J1KtyhMvdYqQzlX5mKACIwwP/pZMKqEJe0NsJVb9w2wnadi4D9kN97h+GAYJ+Ex3LQ
         m9K5CNQOJIaNkQ4fnuUV/qrkc46zKUh5vL0jzkczdIQ2nNsOGDaOqNytuANDgcnP61IM
         YLnCkiz3f6BbIH4for12d2vnFbhHg7rD3nHWxku5dc68E7YHlDgUgyOy3gqAhvU0IPiK
         NiF5vSZT//zGFSZe9eVpv6kR3BewGon5vTVwECna6OzsSoOwHEmGNOzoOuh/Cx8hvp0X
         upviemOBcCd2FZolz+6QNhd8vxiSwHZF2LoT4HpMtNX1fzh6qM/ZClNC5tMpfBjfb2Rd
         RKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801011; x=1684393011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA0tFrgEscDTi4fNivjO6EpmE8ixxAtZdpP5mEG8YhA=;
        b=eTH2aLJdk0vW2K5k2g4ab1xNG7tarC+FaZPM+SqLPV3GHztapcCOTBNHur12kYgSWO
         /80pgV1DPczpPjIalEv4Ec2wL9o6zP8e66g8BqCRpKzNMRwOVkoT4QTxTmK8j1pjuCzE
         gxgXp1D612x0FvNGjoF6y2bavfogHaOGUqjiBGDSre+ZPwAaHCvV2nNekiJM/MqKIPu1
         H4qmyNqjpTgIzfCcp7hdMAhoIC6u0PMczA79jo0upNNdyh8zbsOgfDZsfKCf626zRWd6
         OfgeSbL5otPHhd93KvmvrlrXJWpUX1tWUYva9nS20ePeaePiJ8/A72UQUCbLQB4bieWQ
         ynXg==
X-Gm-Message-State: AAQBX9c8VDws07lz+KwRPevKCrFJ8tboitGaxo89wSuzyltVO/ChwEYa
        NSGXLBmRJ4YaoHm8CYq2K/je/GuUV7kL7R5V
X-Google-Smtp-Source: AKy350bh4iLHJqw33FBsW9qjVRJKdFTJQRoNZvE4h1CO5+Y1a1rjVn07r/zxf/2lvXcOPgalcDaDsA==
X-Received: by 2002:ac2:4a89:0:b0:4ed:bfc6:d37c with SMTP id l9-20020ac24a89000000b004edbfc6d37cmr2535884lfp.55.1681801010645;
        Mon, 17 Apr 2023 23:56:50 -0700 (PDT)
Received: from [172.25.56.57] ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id m26-20020ac2425a000000b004cc9042c9cfsm2258225lfl.158.2023.04.17.23.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 23:56:50 -0700 (PDT)
Message-ID: <22a5bd86-8d41-14e2-bb5a-968d15618adf@gmail.com>
Date:   Tue, 18 Apr 2023 09:56:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] usb: typec: fix potential NULL dereference
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230417195003.19504-1-korotkov.maxim.s@gmail.com>
 <ZD41tLi3sMB71Xf2@kroah.com>
Content-Language: en-US
From:   Maxim Korotkov <korotkov.maxim.s@gmail.com>
In-Reply-To: <ZD41tLi3sMB71Xf2@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.2023 09:16, Greg Kroah-Hartman wrote:
> On Mon, Apr 17, 2023 at 10:50:03PM +0300, Maxim Korotkov wrote:
>> The pointer 'adev' was being dereferenced before being checked for NULL
>> in the 'type_alt mode_enter()' and 'type_alt mode_exit()' functions.
>> Although this is a hypothetical issue, it's better to move the pointer
>> assignment after the NULL check to avoid any potential problems.
>>
>> Found by Linux Verification Center with Svace static analyzer.
>>
>> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
>> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
>> ---
>>   drivers/usb/typec/bus.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
>> index 098f0efaa58d..ae0aca8f33db 100644
>> --- a/drivers/usb/typec/bus.c
>> +++ b/drivers/usb/typec/bus.c
>> @@ -125,13 +125,16 @@ EXPORT_SYMBOL_GPL(typec_altmode_notify);
>>    */
>>   int typec_altmode_enter(struct typec_altmode *adev, u32 *vdo)
>>   {
>> -	struct altmode *partner = to_altmode(adev)->partner;
>> -	struct typec_altmode *pdev = &partner->adev;
>> +	struct altmode *partner;
>> +	struct typec_altmode *pdev;
>>   	int ret;
>>   
>>   	if (!adev || adev->active)
>>   		return 0;
>>   
>> +	partner = to_altmode(adev)->partner;
>> +	pdev = &partner->adev;
> 
> As you point out, the original code is still fine here, we check before
> we actually use these values.
> 
> Also, can adev every actually be NULL?  In looking at the code paths, I
> can't see how that could happen.
> 
> thanks,
> 
> greg k-h

I agree that the adev will most likely never be NULL, but usually this 
pointer is checked before usage (for example in typec_altmode_notify() 
or typec_altmode_vdm()). It is a little odd that in these functions it 
utilized before check. Is it just extra check that can be removed?

best regards, Max
