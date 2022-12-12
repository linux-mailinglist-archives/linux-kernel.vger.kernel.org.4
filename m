Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157F7649F91
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiLLNMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiLLNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:11:38 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E7712A97
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:11:31 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id d14so3300567ilq.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvrl4AgOpffK6XUxCxPp7bpXCu3gynENsW0aGqM5Df8=;
        b=DrgD9c7AREPKQOblN0GMrGIZC0uSxwypztZcVz2l5QmQo4c6a769cF1HJsF6PwfNu3
         peSGTkChjCi9uTlK+EJh2B+Ci2ZJxXNXfxytIPfWW8ngOI4Y0hI/z8rigSN09hEpliwx
         FzNHevXPCTD1wq44/0foJap3Bb6xVK7XN091s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvrl4AgOpffK6XUxCxPp7bpXCu3gynENsW0aGqM5Df8=;
        b=KR2tlbTsPv3xHNt8chvfHhrWf16ygDiNHEysS1LKijOgCjS2WUckDFJY2GJtcS3kYp
         IfRb/K0zEDZkWYKHLFDJ5Aor9Ui5vr5tMqMeTODdkDusyNKdNbpKl1dX7bPnfc+Qfr+C
         dd058ZHZRtooDhoNd+Mv4KVn1JDrUb6lVPDR5m888wUuHWqg+xO6ZXDFmAoS1xJdVjKH
         GFay2WTR7dhdGFyoySq6oYIxx2MLPoBHgs5ktSTXvETPLJchy7uSy2NrvsFQjt7dSizm
         AhgBMrS6KAsAUropI/KHkoa/P8wcOfWZ4xHpXBx50FBwgWdWOz3U1SjNxA0LfZ6vd7cx
         XXPw==
X-Gm-Message-State: ANoB5pkCqAE/1xPdg873WLl44YWfdg8i6BXfeIcHSJNEMSsku4oKTHKy
        GpFK3JWUTnWpXAfIldNR0OJUhA==
X-Google-Smtp-Source: AA0mqf4kRKyrpIH8gZB2TBhWAayXSxMY879hs+s0LqrpRQ5SCl6CKEwHPZ+WuorSjBUx1t498kLJ9g==
X-Received: by 2002:a05:6e02:58d:b0:303:7270:845e with SMTP id c13-20020a056e02058d00b003037270845emr9515931ils.26.1670850689500;
        Mon, 12 Dec 2022 05:11:29 -0800 (PST)
Received: from [10.211.55.3] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id l11-20020a92d94b000000b003024928a9afsm2988694ilq.83.2022.12.12.05.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:11:28 -0800 (PST)
Message-ID: <3d13301c-c3fa-5a59-d4b6-cb45bf3fa18c@ieee.org>
Date:   Mon, 12 Dec 2022 07:11:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] net: ipa: Remove redundant dev_err()
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Alex Elder <elder@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221211144722.754398-1-tegongkang@gmail.com>
 <f04435d8-9af3-1fde-c2bf-fadd045b10a1@gmail.com>
Content-Language: en-US
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <f04435d8-9af3-1fde-c2bf-fadd045b10a1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/22 10:34 AM, Heiner Kallweit wrote:
> On 11.12.2022 15:47, Kang Minchul wrote:
>> Function dev_err() is redundant because platform_get_irq_byname()
>> already prints an error.
>>
>> Signed-off-by: Kang Minchul <tegongkang@gmail.com>
>> ---
>>   drivers/net/ipa/gsi.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
>> index 55226b264e3c..585cfd3f9ec0 100644
>> --- a/drivers/net/ipa/gsi.c
>> +++ b/drivers/net/ipa/gsi.c
>> @@ -1967,11 +1967,8 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev, bool prefetch,
>>   
>>   	/* Get the GSI IRQ and request for it to wake the system */
>>   	ret = platform_get_irq_byname(pdev, "gsi");
>> -	if (ret <= 0) {
>> -		dev_err(gsi->dev,
>> -			"DT error %d getting \"gsi\" IRQ property\n", ret);
>> +	if (ret <= 0)
> 
> According to the function description it can't return 0.

That's great!  I explicitly checked for 0 because at the
time I couldn't *prove* that 0 was an invalid return, and
there was nothing obvious in the function saying so.  I
*thought* it was invalid but lacked the guidance in the
code to know for sure.

Here is the commit that fixed that:
   a85a6c86c25be driver core: platform: Clarify that IRQ 0 is invalid

And it turns out that this particular block of code got
moved but not modified after that comment commit:
   0b8d676108451 net: ipa: request GSI IRQ later

Anyway, I'm very pleased this can be simplified.

					-Alex

> You can further simplify the code.
> And you patch should be annotated net-next.
> 
>>   		return ret ? : -EINVAL;
>> -	}
>>   	irq = ret;
>>   
>>   	ret = request_irq(irq, gsi_isr, 0, "gsi", gsi);
> 

