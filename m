Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F19626C98
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 00:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiKLXHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 18:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLXH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 18:07:27 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DA6DEEA;
        Sat, 12 Nov 2022 15:07:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id f5so20249163ejc.5;
        Sat, 12 Nov 2022 15:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGx1z94xX0S0Q2uexdgjiytkOSdjow5opg+2CcHBsa8=;
        b=Ws99vxEvUNfsLT+2UlB2fJ5YNDSLHWNxWEgmBBzaYL+VV5eFvWmMZPT+fA7jUOC7KV
         O52hYGWul5ZDOAfZXYU7Pm9yPg/+Urv1CnPektHEvvUDjJazk1ttC47g4wfhJilj76qU
         PyVoedahDs4XvR1SufQWYNoV0TxxkKcY2uxveODT8JAC7tTkAJ14+vF8+ESedY4moQcp
         jkyzNwLOUBnRXudwfRtMHCQF7H4rrAJtxhFjPtdTYm26RAcuLu1NHHdV8OuooHQ+gUBS
         7uxgQDaNXyHHvLcVV+P2MBOU9KhKO6aHN5EFkhE2+8NXvsQj/tOZKekGKwopVBQJgZd0
         wPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGx1z94xX0S0Q2uexdgjiytkOSdjow5opg+2CcHBsa8=;
        b=rtrIH1kfz/Xi2+WSPbZuvEEj6K6D9px5phHLxYg0Nl35mhMaGxdKsjm9KJnBaT7Hc+
         EqVRhzN3350YXZloywa0gLR6vfecGdK2cbn/njUqgEql2tCEMz6r1DnM9/qTbjRLN1aQ
         fmqHku0hgAGjnni1oH8xptb0IgIt+a/XnjdSQJ3ugbgEGT2bZf6DcsC+hIhmNsPKhmur
         ZLuFCi7Fwgsn2Y2Stk76jPWhlfCXRfsO8STl+1F016V4STijvlnJ60qeCFZpggVwEHAQ
         l8s00rSzjp5gsVoXnG5ReNC7BhYr/5gaNFtgqV/se5HvhVN0RPgVtdbKDCiwpFdc8ujQ
         28ug==
X-Gm-Message-State: ANoB5pkyKw6KfUPs+g4SbNvGVO/9u1yhnijjsR87OjmzoGqRkpROPr2k
        O9EWoKMI4GBtBoE+7TDgrnoNaeaw0cY=
X-Google-Smtp-Source: AA0mqf6Lnt03z6cV4Noq62oZyY/Y54wfY82hdIPe+UyvKLVeWiXySu8gwUs7AsYMURwuj8ZCGewLlA==
X-Received: by 2002:a17:907:2a8b:b0:79d:aacd:9338 with SMTP id fl11-20020a1709072a8b00b0079daacd9338mr6340466ejc.645.1668294444726;
        Sat, 12 Nov 2022 15:07:24 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:f7cb:2b0b:e078:caee? (2a02-a466-68ed-1-f7cb-2b0b-e078-caee.fixed6.kpn.net. [2a02:a466:68ed:1:f7cb:2b0b:e078:caee])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906118b00b0078cb06c2ef9sm2372634eja.8.2022.11.12.15.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 15:07:24 -0800 (PST)
Message-ID: <dcbf54db-3cc5-6863-2805-4aa1adce234a@gmail.com>
Date:   Sun, 13 Nov 2022 00:07:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] usb: dwc3: core: configure PHY before initializing host
 in dwc3_set_mode
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221112102506.34990-1-sven@svenpeter.dev>
 <1800f8ea-2dde-a420-3e99-56237bde1bb0@gmail.com>
 <f3378173-2e15-467c-b159-7d523533ffc5@app.fastmail.com>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <f3378173-2e15-467c-b159-7d523533ffc5@app.fastmail.com>
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

Hi,

Op 12-11-2022 om 23:46 schreef Sven Peter:
> Hi Ferry,
> 
> On Sat, Nov 12, 2022, at 23:15, Ferry Toth wrote:
>> Hi Sven,
>>
>> Op 12-11-2022 om 11:25 schreef Sven Peter:
>>> Usually, first the PHY is set to the correct mode and then the host or
>>> device side of the controller is initialized afterwards. Otherwise a PHY
>>> that's already used has to be reconfigured.
>>> dwc3_core_init_mode() does this correctly for both host and device and
>>> __dwc3_set_mode() does it correctly when switching to device mode.
>>> When setting up host mode however it first initializes xhci and only
>>> then changes the PHY's mode. Let's also do the operations in the correct
>>> order here.
>>>
>>> Fixes: 958d1a4c40dd ("usb: dwc3: core: program PHY for proper DRD modes")
>>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>> ---
>>>    drivers/usb/dwc3/core.c | 9 +++++----
>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index ad4d644e21a4..759d23d908fa 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -212,14 +212,15 @@ static void __dwc3_set_mode(struct work_struct *work)
>>>    
>>>    	switch (dwc->desired_dr_role) {
>>>    	case DWC3_GCTL_PRTCAP_HOST:
>>> +		if (dwc->usb2_phy)
>>> +			otg_set_vbus(dwc->usb2_phy->otg, true);
>>> +		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>> +		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>>> +
>>>    		ret = dwc3_host_init(dwc);
>>>    		if (ret) {
>>>    			dev_err(dwc->dev, "failed to initialize host\n");
>>>    		} else {
>>> -			if (dwc->usb2_phy)
>>> -				otg_set_vbus(dwc->usb2_phy->otg, true);
>>> -			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>> -			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>>>    			if (dwc->dis_split_quirk) {
>>>    				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
>>>    				reg |= DWC3_GUCTL3_SPLITDISABLE;
>> This patch breaks usb host mode on Intel Merrifield platform. I am
>> testing this on top of v6.0 +
>> * my 2 "usb: dwc3: core: defer probe on ulpi_read_id timeout" patches
>> (otherwise tusb1210 will not be probed on this platform)
>> * Revert "usb: dwc3: disable USB core PHY management" (with/without this
>> patch makes no difference)
>> * usb: dwc3: Do not get extcon device when usb-role-switch is used
>> (with/without this patch makes no difference)
>>
>> ftrace shows tusb1210 is indeed still probed, nevertheless in host mode
>> it seems vbus is not powered as my connected smsc95xx based hub is not
>> active (seems not plugged).
>>
>> Flipping the switch to device mode gadgets work fine.
>>
>> Could it be dwc3_host_init() needs to be called prior to otg_set_vbus()?
> 
> Huh, thanks for testing!
> 
> For the platform I'm working on I need to set the phy mode before dwc3_host_init()
> and then found the same code further below in dwc3_core_init_mode,
> 
> static int dwc3_core_init_mode(struct dwc3 *dwc)
> {
> [...]
> 	case USB_DR_MODE_HOST:
> 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> 
> 		if (dwc->usb2_phy)
> 			otg_set_vbus(dwc->usb2_phy->otg, true);
> 		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
> 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
> 
> 		ret = dwc3_host_init(dwc);
> 		if (ret)
> 			return dev_err_probe(dev, ret, "failed to initialize host\n");
> 		break;
> [...]
> }
> 
> so I'm quite surprised it causes issue in __dwc3_set_mode now.
> If otg_set_vbus indeed needs to happen after dwc3_host_init it should probably
> also be called afterwards in dwc3_core_init_mode as well.

Maybe there is a difference between the case USB_DR_MODE_HOST above and 
case USB_DR_MODE_OTG touched by this patch?
> 
> Best,
> 
> 
> Sven
