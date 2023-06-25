Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EAB73CE59
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 06:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjFYEBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 00:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjFYEBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 00:01:42 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D009E54;
        Sat, 24 Jun 2023 21:01:41 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39eab4bcee8so1644742b6e.0;
        Sat, 24 Jun 2023 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687665700; x=1690257700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=il2Eo5SXZ9yPaXNHu3oPyc5gYpQ+HxkMWx3hVwUFlv0=;
        b=hwKxmamiS+OWy43piU3UhTqWoqmC1Z+CkglEnWVqQCcjRvbyIAAGZtrNPMJRSugmsf
         eZx9dh2exeNsSeoRjZhtXIfJzLExVJ4MNeou3XgzOTeIXA8s6kRrO29jogLW0pesD9SF
         EhuDyWuWEIacKy5nsYAlfzTF1qadKvK0wJj/S+J6lPwfvHwf6OeKF8+6lI1l7ee6YJWw
         hrk9V0iTWKF/NmUZpwBDpYW3lbTIJXhKTbODQofIwI64ym55BMFFxw0biVtTUqkb9OQ0
         3msYrjUL2S0F6/XVWNAb0pOl6cSkVkoC+vy2+sDKqPqE478sbzJDZNlUlkjtvpgb40jG
         i5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687665700; x=1690257700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=il2Eo5SXZ9yPaXNHu3oPyc5gYpQ+HxkMWx3hVwUFlv0=;
        b=k0mCedH2l3f/3r7YiALPGakSqZbz+Ru04Zj7C7ab8xhkOoufx/xTSBIh70wi6U5DFL
         kDYj4oK6h4N3kgbd/QFdCLPb3Bd0lgkZk8zCjeNMntvOKoa4+Cx8f0/kh18OmMTjEZWG
         5kRD3YfnsVMmNFPg64jV/1hfFmjl9QejwGpRAyWeZguNRD5EMmxlQb2IMwWY0tlbcXjx
         z2/cPISOAQHPYxK3CAQBihdl5/Yn2OuKHiai+Aq+A8ZsD/vA6OGLYwbNIvWTHuUgKfqj
         yrR/3Iqijyq/wcTSSiLz45TIqgy3Zj/2q7boLyEEK/DmkdHMb5TTuOLGwv/8hkjubtRN
         4m0A==
X-Gm-Message-State: AC+VfDwlDN6bAAqkah2KKrCugsrzFGhHwvdgB6RsuVgt6HNDFIkdbkA/
        jfzO9kumOWVwHgEsAhNwX88=
X-Google-Smtp-Source: ACHHUZ5uHW2XsKuOlkC/j4klRTU9DOHckzQe3b+fzQ1lC7+f0ZrsQcUhS6+xQLzHk/rI0Yd2x43QAQ==
X-Received: by 2002:a05:6808:24b:b0:3a0:83b6:975b with SMTP id m11-20020a056808024b00b003a083b6975bmr9009538oie.48.1687665700257;
        Sat, 24 Jun 2023 21:01:40 -0700 (PDT)
Received: from [192.168.220.128] ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001b50b8439e0sm1841443plt.96.2023.06.24.21.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 21:01:39 -0700 (PDT)
Message-ID: <8569ced1-ed6d-18b3-5223-a8bd923f864b@gmail.com>
Date:   Sun, 25 Jun 2023 12:01:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] usb: ohci-at91: Fix the unhandle interrupt when resume
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230622025739.13934-1-aarongt.shen@gmail.com>
 <4cf867a9-3c78-403a-aaeb-91f6cf099a3d@rowland.harvard.edu>
 <c2d0b37a-3ee1-e07e-e265-c71895474ba8@gmail.com>
 <9c702495-a839-43ea-85b7-1c0a0c54ec73@rowland.harvard.edu>
Content-Language: en-US
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <9c702495-a839-43ea-85b7-1c0a0c54ec73@rowland.harvard.edu>
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

On Fri, Jun 23, 2023 at 23:52:53PM GMT+8, Alan Stern wrote:
> On Fri, Jun 23, 2023 at 11:44:04AM +0800, Guiting Shen wrote:
>>
>>
>> On Thu,Jun 22,2023 at 22:29:43PM GMT+8, Alan Stern wrote:
>>> On Thu, Jun 22, 2023 at 10:57:39AM +0800, Guiting Shen wrote:
>>>> The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
>>>> suspend which will let the ohci_irq() skip the interrupt after resume. And
>>>> nobody to handle this interrupt.
>>>>
>>>> Set the ohci->rh_state to OHCI_RH_SUSPEND instead of OHCI_RH_HALTED when
>>>> suspend to fix it.
>>>>
>>>> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
>>>> ---
>>>>   drivers/usb/host/ohci-at91.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
>>>> index b9ce8d80f20b..7a970e573668 100644
>>>> --- a/drivers/usb/host/ohci-at91.c
>>>> +++ b/drivers/usb/host/ohci-at91.c
>>>> @@ -645,7 +645,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>>>>   	 * REVISIT: some boards will be able to turn VBUS off...
>>>>   	 */
>>>>   	if (!ohci_at91->wakeup) {
>>>> -		ohci->rh_state = OHCI_RH_HALTED;
>>>> +		ohci->rh_state = OHCI_RH_SUSPENDED;
>>>
>>> It looks like this change ignores the comment immediately above it
>>> (just before the start of this hunk).
>>>
>>> If you want to find a way to handle IRQs better after the controller
>>> resumes, maybe you should change the resume routine instead of the
>>> suspend routine.
>>>
>>> Alan Stern
>>
>> The comment which was added with commit-id 0365ee0a8f745 may be outdated
>> because ohci_suspend() and ohci_at91_port_suspend() is used to suspend
>> instead of setting ohci->rh_state to OHCI_RH_HALTED.
> 
> The comment says nothing about ohci->rh_state; it talks about the 
> integrated transceivers and the 48 MHz clock.  I don't see why you would 
> think the comment is outdated.
> 

The comment says the reason to discard connection state by reset, but I
don't see any reset operation at ohci-at91 suspend/resume routine in
source code.And ohci_suspend() disable irq emission and mark HW
unaccessible  maybe do the same effect as set ohci->rh_state to
OHCI_RH_HALTED to discard connection state which I think the comment is
outdated.

>> What's more, I found that only ohci-at91 driver to set the ohci->rh_state
>> which may be unnessory because the ohci_suspend() disable irq emission and
>> mark HW unaccessible and ohci_at91_port_suspend() suspend the controller.
>>
>> Is it really need to set ohci->rh_state in ohci_hcd_at91_drv_suspend()?
>>
>> It maybe confused to set ohci->rh_state to OHCI_RH_SUSPEND in resume
>> routine.
> 
> I'm not really sure what that assignment was intended to accomplish, but 
> maybe it was meant to force a reset when the controller resumes.
> 
> You could get the same result by leaving ohci->rh_state set to 
> OHCI_RH_SUSPENDED but changing ohci_hcd_at91_drv_resume().  Instead of 
> calling ohci_resume(hcd, false), have it call:
> 
> 	ohci_resume(hcd, !ohci_at91->wakeup);
> 
> That way, if the wakeup flag is clear and the clock was stopped, 
> ohci_resume() will call ohci_usb_reset().  You should also add a comment 
> explaining the reason.
> 
> I can't test this because I don't have the AT91 hardware.
> 

It works by your methods to force a reset in my sama5d3 soc hardware.
And I found that the ohci->rh_state was already OHCI_RH_SUSPEND before
set it OHCI_RH_HALTED in suspend.So the question is whether to set it
OHCI_RH_HALETED in ohci-at91 suspend routine.

It also works by comment the ohci->rh_state = OHCI_RH_HALTED in suspend
routine.But I think it is safer to use your methods.

Do you have any suggestion on it before I send v2 patch latter.

-- 
Regards,
Guiting Shen

