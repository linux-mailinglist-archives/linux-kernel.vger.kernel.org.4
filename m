Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEFF658BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiL2K0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiL2K0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:26:03 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C802ED
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:26:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p36so26925724lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1Hs/DwPZsz0wqIDur7TzV3TDktZpJYae1IE8frEXoo=;
        b=hK6JIUGu9CmIqNsWdz+2HdrmzNW2xetYQv224NZz/mnr1OiBbJo/9V1wWqxck6crtw
         k/RtPWiRMnjSgFdFpry9v3kHYKo8UB7QLKvB9fhaP4+r7hn/Il8z8ZBKW9VVjexI+1r9
         fJ4I6ScE2KAdwhfCsogENjUJxjVXegpYggq2MpjFi0o/BFQWX9z4jtIlh1XBsiWZbJb4
         wNckPFRyo1PtcM6DFMZTPauN4QIq0Vzf1QutZhu6D5nX04ciRS/4hJnllMv8U2FClVRD
         OjnVfVK4IRm5IK+3Epu0BFJOmmLQjgM8xFI7YIWepr5lb9aCyGgkvSnBMjWhmd26JuYu
         0HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1Hs/DwPZsz0wqIDur7TzV3TDktZpJYae1IE8frEXoo=;
        b=b1l95ycJrrUbDNT9GSfpoOKeHD5cK24bVrczAfYmbBj7u5q7OoVMx+PwWXj6+oiP6q
         /pe++sKHXNtIK9rn21+tYpbOlIDFEOCpieZGdF93um0BQYa8sIUUVavVmjmxB7ar+MAb
         4/SCkzkzyXyFoL8AVjOs+53g9BLYeUjg+5pA30POLMKGAX/HU05sR7aK5SMIzbOosDT0
         c8Dw512T78LtusbQ0hg9HVUA6Oz/nmZCgpOzi2zPqdHFcaBljQxFshq59PJCYpNXuyWW
         m/qxnceMsEirPz6Z9f8Uo1QRoF/3OxWh1G1BtT0sg5bydInYpDjWzqAz+bCXA3BzN+nZ
         ymzA==
X-Gm-Message-State: AFqh2kqTBtzMSh6U65iJOzcPlyAIvGRmuwUzmBGq1Co1UCW8HNln0q3O
        rF41nS9I78UmzRi+axDZ/iGsOw==
X-Google-Smtp-Source: AMrXdXsupYV6QX8Ph8JDF6Z3D/xD0D27tYEcuRB9b+69Q5P5AW3ID22VaDs6dwmdE8G1bA3GP9myOA==
X-Received: by 2002:a05:6512:4002:b0:4b5:637f:f1b0 with SMTP id br2-20020a056512400200b004b5637ff1b0mr8637100lfb.2.1672309560649;
        Thu, 29 Dec 2022 02:26:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e25-20020ac25479000000b004b58fadba35sm3021671lfn.296.2022.12.29.02.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 02:26:00 -0800 (PST)
Message-ID: <bc531774-ed70-39b7-3534-5683dff20591@linaro.org>
Date:   Thu, 29 Dec 2022 11:25:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 1/3] usb: support Samsung Exynos xHCI Controller
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858@epcas2p3.samsung.com>
 <1672307866-25839-2-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672307866-25839-2-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 10:57, Daehwan Jung wrote:
> Currently, dwc3 invokes just xhci platform driver without any data.
> We add xhci node as child of dwc3 node in order to get data from
> device tree. It populates "xhci" child by name during initialization
> of host. This patch only effects if dwc3 node has a child named "xhci"
> not to disturb original path.
> 
> We add "samsung,exynos-xhci" compatible in xhci platform driver

Where? It is not documented.

> to support Exynos SOCs. 

That's so not true. You do nothing to support Exynos SoC here. Please
stop pasting incorrect and misleading commit msgs.

> We introduce roothub wakeup, which uses roothub
> as system wakeup source. It needs xhci platform driver to override
> roothub ops.

You did not explain why you introduced wakelocks...


(...)

>  	if (shared_hcd) {
>  		usb_remove_hcd(shared_hcd);
>  		xhci->shared_hcd = NULL;
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 79d7931c048a..693495054001 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5502,6 +5502,10 @@ void xhci_init_driver(struct hc_driver *drv,
>  			drv->check_bandwidth = over->check_bandwidth;
>  		if (over->reset_bandwidth)
>  			drv->reset_bandwidth = over->reset_bandwidth;
> +		if (over->bus_suspend)
> +			drv->bus_suspend = over->bus_suspend;
> +		if (over->bus_resume)
> +			drv->bus_resume = over->bus_resume;
>  	}
>  }
>  EXPORT_SYMBOL_GPL(xhci_init_driver);
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index c9f06c5e4e9d..cb9c54a6a22c 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1752,6 +1752,8 @@ struct xhci_hub {
>  struct xhci_hcd {
>  	struct usb_hcd *main_hcd;
>  	struct usb_hcd *shared_hcd;
> +	struct wakeup_source *main_wakelock;
> +	struct wakeup_source *shared_wakelock;

Drop wakelocks. This is not related to USB and not needed here. Do you
see anywhere else in core kernel code usage of the wakelocks?

You got this comment already, didn't you? So why you do not address it?

Best regards,
Krzysztof

