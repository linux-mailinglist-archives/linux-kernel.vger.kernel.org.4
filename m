Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5308773D5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFZC2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFZC2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:28:36 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE244E54;
        Sun, 25 Jun 2023 19:28:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a1c162cdfeso1325338b6e.2;
        Sun, 25 Jun 2023 19:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687746513; x=1690338513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d07EwE8g+yc7wNG17fy7wXO+B9zTjhytplxN3znDkOo=;
        b=cw1S+ae/2xM2HzGCre0rEl7dYJyF4ZcbsoSM8E7NKkxlBQQyqM22kM2CKreZstuhpq
         VhPE2op6zi6NBpnPacLtXOtVTN3V1s3CTj/m+7MtniXSg3Q2rhKN8uZexvpBuLHc3dee
         83KcZWODwgY5bZ2yGqCuR6hvSOihYOULmivmaW9cY2qHH5H251fO8bOQrt5EcFBqaxCo
         MLf3TrvAl6eDdx65yyJD/23kBEWrJbAiV8lSYqmRA60RahSDzvx81UFdntu/nieO+2Op
         LL0cVBxhDC1v4lyzLu5ozb2CbzFAz5bCsAGxh33Xfnhgz6WQSZZjgVuT1n9hrwvHS17u
         bnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687746513; x=1690338513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d07EwE8g+yc7wNG17fy7wXO+B9zTjhytplxN3znDkOo=;
        b=LGQHSJk+2WK7CBz7q5AIEBNlfSqnu7B4pBrxuO70XCxTFMT0Upzkhm8AGAL0EN/srM
         z9PzpdU/sA0YynexLd0NS0xurwjv2VNYF6fGrEZARlNc9tuA1/fsmUy7d4IJ3iOpc0bE
         6WfdW1S8uUWuEhmGBMGtucOVcf8sy9nyH35/JIZiMv+onCLLeExfoHW7eF5cvuDyN4l/
         lN9+QE1yrXWOaWvoYQRj3TpNYiH0BQYuwi7Aa9JrEeA8My3o6fcShrsImWbSiXdvtHFc
         0D8Ob6tjxsK8+q7Qxyq7aI9wW0dLMsnDV1IC6a6jHNcw4Xu5G126D8qUUYhKzYvofi2c
         qKow==
X-Gm-Message-State: AC+VfDwkG4s6wkTX2lTmAoTFI/XY+DpCzcwGAKVoEw6dTVkd4oLZJ2Fu
        tQgk0Jqi0W+W7Wx5fwbPc9I=
X-Google-Smtp-Source: ACHHUZ4Q0ry54BpxtAQfduyo5cC1UFvZSrIEf7o9kdkVzENgsOv78sn5aZWqWgTZi1Ftc4DrqfTgtw==
X-Received: by 2002:a54:4091:0:b0:398:2f06:329 with SMTP id i17-20020a544091000000b003982f060329mr27376498oii.9.1687746512932;
        Sun, 25 Jun 2023 19:28:32 -0700 (PDT)
Received: from [192.168.220.128] ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id iz13-20020a170902ef8d00b001b7fe13c97csm1111555plb.72.2023.06.25.19.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 19:28:32 -0700 (PDT)
Message-ID: <ed353f12-7ba7-1831-2ac7-b6135b2a5abb@gmail.com>
Date:   Mon, 26 Jun 2023 10:28:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2] usb: ohci-at91: Fix the unhandle interrupt when resume
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230625161553.11073-1-aarongt.shen@gmail.com>
 <552b1ac6-2149-48fa-9432-49655bfbc366@rowland.harvard.edu>
Content-Language: en-US
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <552b1ac6-2149-48fa-9432-49655bfbc366@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 04:04:29AM GMT+8, Alan Stern wrote:
> On Mon, Jun 26, 2023 at 12:15:53AM +0800, Guiting Shen wrote:
>> The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
>> suspend which will let the ohci_irq() skip the interrupt after resume. And
>> nobody to handle this interrupt.
>>
>> According to the comment in ohci_hcd_at91_drv_suspend(), it need to reset
>> when resume from suspend(MEM) to fix.
>>
>> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
>> ---
>>  drivers/usb/host/ohci-at91.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
>> index b9ce8d80f20b..1a0356d9ea15 100644
>> --- a/drivers/usb/host/ohci-at91.c
>> +++ b/drivers/usb/host/ohci-at91.c
>> @@ -672,7 +672,12 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>>  	else
>>  		at91_start_clock(ohci_at91);
>>  
>> -	ohci_resume(hcd, false);
>> +	/*
>> +	 * need to reset according to the comment of suspend routine,
>> +	 * otherwise the ohci_irq would skip the interrupt if ohci_state
>> +	 * was OHCI_RH_HALTED.
>> +	 */
>> +	ohci_resume(hcd, !ohci_at91->wakeup);
> 
> This comment doesn't say why the code uses !ohci_at91->wakeup.  It 
> should explain that.  For example:
> 
> 	/*
> 	 * According to the comment in ohci_hcd_at91_drv_suspend()
> 	 * we need to do a reset if the 48-MHz clock was stopped,
> 	 * that is, if ohci_at91->wakeup is clear.  Tell ohci_resume()
> 	 * to reset in this case by setting its "hibernated" flag.
> 	 */
> 

Ok, Thank you!
Do I send the v3 patch after the merge window close?

-- 
Regards,
Guiting Shen

