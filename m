Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157C873AF24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFWDoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWDoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:44:10 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C11BC1;
        Thu, 22 Jun 2023 20:44:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39ecbb4c7d3so135818b6e.3;
        Thu, 22 Jun 2023 20:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687491849; x=1690083849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pzk5WeXY5PESFs8BoVAqoYmY5ozRoBtfovjqPqBGXys=;
        b=aWva0+jEsYqoKec9WGNAQpfdxmkVktCPucqPay1ltBM4v1d0Msv13dY7Jr7J8QIZQI
         VKukSIPa7U5FP3k4tnw6m1pbcCJgSLlpTprRJ+Nhw9eZWTFN2SugYTDcM4Hw1g1gVBZg
         B0Rpuy72vbcRV3yBN+SSUKUqXQ6jsWK4QKbU4trSHubep3wd5sbkpFCAI2r448td4T/2
         cPSeXurVpS9d7LQZ3csNRXglfBiqdwAkyXiDvLj1AC/F24mh6+zg5FpmXf0SroP6gSI1
         +FmHkUwlKLlJyxFwZ/q1x5n1N5Rq0qkjYrKxoeDpQT1fx00gIQb5BkAfHdIhGBSn5lkV
         930Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687491849; x=1690083849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzk5WeXY5PESFs8BoVAqoYmY5ozRoBtfovjqPqBGXys=;
        b=FIxCC8MnBDPVN7AfnrE7G+uhpBJvLD2eJOSZChZ+pQTibh3ruk1XR8iwgTph1XXDNv
         AgnujAfHf3frup8WccZ7jP7zycUHupYwW4SoN2BwtT/Xzx3HWIIGrERD9+vVjg9uWiwc
         iU3tPUXfSv4LMXNab+HJi8XyrhzfclrAQjtyCZxs/tBCwGNxwyhejJFjIjb7teEPELIx
         FuxoitzXWswA0ASbSvSoJuVUefQgJfNs67IVGCZGyw5UpkJHf2dCLmWip89fJN304VBz
         4yBJFax/s2AkAm4nSmjdoy8ZUJY7lhmWuxqHsdbBen5Cg3zxGB+yyybzEVe70rQnXxvn
         795w==
X-Gm-Message-State: AC+VfDw8Mr2xEeEMuajbbihoxcCIOXfk8blHvi/nmfTBm0PLEINdeLpQ
        PhE1NRtC2KvZ4SlJQ8Ir1nuukgWLbLxDmF0A
X-Google-Smtp-Source: ACHHUZ62+MbpeNiwiGjnsTDcieQaCL2adS30aSdQPfcxkgIyg6LZYunjxjs88TStY0PIY+gYsmG+Kg==
X-Received: by 2002:a05:6808:1d9:b0:3a0:567f:35f5 with SMTP id x25-20020a05680801d900b003a0567f35f5mr5181247oic.47.1687491849050;
        Thu, 22 Jun 2023 20:44:09 -0700 (PDT)
Received: from [192.168.1.5] ([113.66.180.22])
        by smtp.gmail.com with ESMTPSA id nt10-20020a17090b248a00b0023d386e4806sm417926pjb.57.2023.06.22.20.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 20:44:08 -0700 (PDT)
Message-ID: <c2d0b37a-3ee1-e07e-e265-c71895474ba8@gmail.com>
Date:   Fri, 23 Jun 2023 11:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] usb: ohci-at91: Fix the unhandle interrupt when resume
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230622025739.13934-1-aarongt.shen@gmail.com>
 <4cf867a9-3c78-403a-aaeb-91f6cf099a3d@rowland.harvard.edu>
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <4cf867a9-3c78-403a-aaeb-91f6cf099a3d@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On Thu,Jun 22,2023 at 22:29:43PM GMT+8, Alan Stern wrote:
> On Thu, Jun 22, 2023 at 10:57:39AM +0800, Guiting Shen wrote:
>> The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
>> suspend which will let the ohci_irq() skip the interrupt after resume. And
>> nobody to handle this interrupt.
>>
>> Set the ohci->rh_state to OHCI_RH_SUSPEND instead of OHCI_RH_HALTED when
>> suspend to fix it.
>>
>> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
>> ---
>>   drivers/usb/host/ohci-at91.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
>> index b9ce8d80f20b..7a970e573668 100644
>> --- a/drivers/usb/host/ohci-at91.c
>> +++ b/drivers/usb/host/ohci-at91.c
>> @@ -645,7 +645,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>>   	 * REVISIT: some boards will be able to turn VBUS off...
>>   	 */
>>   	if (!ohci_at91->wakeup) {
>> -		ohci->rh_state = OHCI_RH_HALTED;
>> +		ohci->rh_state = OHCI_RH_SUSPENDED;
> 
> It looks like this change ignores the comment immediately above it
> (just before the start of this hunk).
> 
> If you want to find a way to handle IRQs better after the controller
> resumes, maybe you should change the resume routine instead of the
> suspend routine.
>
> Alan Stern

The comment which was added with commit-id 0365ee0a8f745 may be outdated
because ohci_suspend() and ohci_at91_port_suspend() is used to suspend 
instead of setting ohci->rh_state to OHCI_RH_HALTED.

What's more, I found that only ohci-at91 driver to set the 
ohci->rh_state which may be unnessory because the ohci_suspend() disable 
irq emission and mark HW unaccessible and ohci_at91_port_suspend() 
suspend the controller.

Is it really need to set ohci->rh_state in ohci_hcd_at91_drv_suspend()?

It maybe confused to set ohci->rh_state to OHCI_RH_SUSPEND in resume 
routine.

-- 
Best regards,
Guiting Shen
