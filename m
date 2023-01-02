Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0465AE21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjABIa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjABIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:30:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083FAE7C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:30:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so40721160lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtiFQpyWhpU5ex37LxYmByZTtx64yGOprdYoXMKibYc=;
        b=n1TVVWwSUQdO4/Y6dHg574l1nbWHzqX5oWXwr1OUGxHMY+d7mxwhRUC8cPImKYCT/y
         8xanzMicEq/864fBVGMZUtX26ZhqVicRuWkuzOsG4vNA0u1E2kOKrv9CYewbdsihSO9L
         DoqJA1EteBJzlyeZHC6PtaiwhNAy35R5D3QZby4GchWZi7HLxJJN/DgMoViPZyrjBR8y
         H6fyq8TnY9FVz+F4EysOmrGkzAp9oyeaOr4+dj0aYBl1RhNUUx/aJwsVRMxBJtCszwk3
         FaiLgEXTLpoww25G0rdycB2Gfg2AgqH+gS7XNDxZoRbyjAv/ngBuXwDuJ80dJNA8290L
         2zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtiFQpyWhpU5ex37LxYmByZTtx64yGOprdYoXMKibYc=;
        b=NtvqfA7t04jBDw2d3s4DS+TP5IukHhjZh6ATBMbkzKpvAbYsOydlcTqWt9CeN+Okds
         Le+Uj8J3yhR4ArTrBu5PfAt6hQe1Bzxd/vfZnbhDUKuYbt6Gpreb/Y7q5JY3uY2azG9K
         /2iXH3R1xY3RRy91FoeTLEC39MSmwc9ThtXMwEQZlGwaJJfw1uUiggfr8FTyq+1JwpRP
         PduKE+gW16QwSxe4N5hLmY/qM8bx/acwnBrinHMI8Cxa2XKc9GKceY7AzWOVK3ZFd2d0
         LueJ5IPuA0MXEWMfePqkrN7pw9n2ac+94ymVa4WILQTBffzKoou7A5PAPp1Zrr60+2Rw
         H3Yw==
X-Gm-Message-State: AFqh2krmfpNN0L/WNMMTyq7vvwdpJXjN9kLbUH/J5zDB6XnIIE7FcI7p
        RFp61Z4OS9LsuPhSOy5neHWfVA==
X-Google-Smtp-Source: AMrXdXtHLYARNcvpffbs1r2sdcc97L2+H9iPXEjItpIwDj3p2J/1deLZLgAoR0gW2EMmnQmQT6waOQ==
X-Received: by 2002:a05:6512:2316:b0:4b0:6023:6f6f with SMTP id o22-20020a056512231600b004b060236f6fmr13521416lfu.57.1672648242380;
        Mon, 02 Jan 2023 00:30:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d13-20020a056512368d00b0049478cc4eb9sm4363058lfs.230.2023.01.02.00.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 00:30:41 -0800 (PST)
Message-ID: <6451aafa-7021-0769-d408-9dba40d58668@linaro.org>
Date:   Mon, 2 Jan 2023 09:30:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 1/3] usb: support Samsung Exynos xHCI Controller
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858@epcas2p3.samsung.com>
 <1672307866-25839-2-git-send-email-dh10.jung@samsung.com>
 <bc531774-ed70-39b7-3534-5683dff20591@linaro.org>
 <20230102062448.GC74470@ubuntu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230102062448.GC74470@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 07:24, Jung Daehwan wrote:
> On Thu, Dec 29, 2022 at 11:25:58AM +0100, Krzysztof Kozlowski wrote:
>> On 29/12/2022 10:57, Daehwan Jung wrote:
>>> Currently, dwc3 invokes just xhci platform driver without any data.
>>> We add xhci node as child of dwc3 node in order to get data from
>>> device tree. It populates "xhci" child by name during initialization
>>> of host. This patch only effects if dwc3 node has a child named "xhci"
>>> not to disturb original path.
>>>
>>> We add "samsung,exynos-xhci" compatible in xhci platform driver
>>
>> Where? It is not documented.
> 
> I submitted the patch of dt bindings on same patchset.
> Is there any missing documentation?

This is your first patch in the series and in this patch there is no
such bindings. Re-order the patches to have proper order.

> 
>>
>>> to support Exynos SOCs. 
>>
>> That's so not true. You do nothing to support Exynos SoC here. Please
>> stop pasting incorrect and misleading commit msgs.
> 
> I agree misleading commit msgs. I will modify it.
> 
>>
>>> We introduce roothub wakeup, which uses roothub
>>> as system wakeup source. It needs xhci platform driver to override
>>> roothub ops.
>>
>> You did not explain why you introduced wakelocks...
>>
> 
> I'm sorry I didn't write description enough.
> I add it below.
> 
>>
>> (...)
>>
>>>  	if (shared_hcd) {
>>>  		usb_remove_hcd(shared_hcd);
>>>  		xhci->shared_hcd = NULL;
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>> index 79d7931c048a..693495054001 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>>> @@ -5502,6 +5502,10 @@ void xhci_init_driver(struct hc_driver *drv,
>>>  			drv->check_bandwidth = over->check_bandwidth;
>>>  		if (over->reset_bandwidth)
>>>  			drv->reset_bandwidth = over->reset_bandwidth;
>>> +		if (over->bus_suspend)
>>> +			drv->bus_suspend = over->bus_suspend;
>>> +		if (over->bus_resume)
>>> +			drv->bus_resume = over->bus_resume;
>>>  	}
>>>  }
>>>  EXPORT_SYMBOL_GPL(xhci_init_driver);
>>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>>> index c9f06c5e4e9d..cb9c54a6a22c 100644
>>> --- a/drivers/usb/host/xhci.h
>>> +++ b/drivers/usb/host/xhci.h
>>> @@ -1752,6 +1752,8 @@ struct xhci_hub {
>>>  struct xhci_hcd {
>>>  	struct usb_hcd *main_hcd;
>>>  	struct usb_hcd *shared_hcd;
>>> +	struct wakeup_source *main_wakelock;
>>> +	struct wakeup_source *shared_wakelock;
>>
>> Drop wakelocks. This is not related to USB and not needed here. Do you
>> see anywhere else in core kernel code usage of the wakelocks?
>>
>> You got this comment already, didn't you? So why you do not address it?
>>
> 
> I want to add a new feature in xhci platform driver. I want to make it
> possible to enter system sleep while usb host connected like USB Mouse.
> It gets system enter sleep only if there's no usb transaction at all.
> Deciding if there's tranaction or not is in root hub because it's parent
> of all child usb devices.


I have USB mouse connected to my system and the system enters suspend,
thus I don't think this patch solves this particular issue.

Best regards,
Krzysztof

