Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21866020DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJRCHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiJRCGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:06:47 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BAF8C460
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:05:52 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1324e7a1284so15345075fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPr95JmTZyyYVeLmfyOCTRL73nJAu3g8auu0MHNBHp4=;
        b=MgI9kMCXMFiIEdJjvVtVZ+Q/Ds/cbUyhGtsK/Jy7GJuMLk0LuWbQW39ZgspDZH8zWP
         vjXL8GR1VKyho4vpwuEKg1knkPuc7bfURtjHoUZ3L4zgMsY3yjfxmS9SRerEX7hBXuML
         8UflCd4aOX2ZQkRgOXkcdMraVQnRcROfvU6chvifW4rrFK8O/3CgyZKITFak2wan4Xni
         FRYbjWVsKgLnnwlNWnAASCf1ZJa1zvLtSJPDfsu4TzLPJvdRkWMoMQXQubNHzrlJfrPx
         MWXapWTXbETWDoSTFv5iLgoYwM84B6NUL1Ddh23ZiJyf5F+z4eY2WghDQJljRFYWQIfH
         4DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPr95JmTZyyYVeLmfyOCTRL73nJAu3g8auu0MHNBHp4=;
        b=7N7nviKwUqgdbSWg+gUt+x+qCub/vprcLFd+CA8XCmFbgPvOtQOAC/OsnzDQCdB1mI
         ELgPzqhKmaLw39ucNkoyC6OPXGBLm3uzOy6U4hzp9+4QjRQwZ8lGhXnIVDfYxTXTfgq2
         RwsysrGdiMMIj6G84W+ZezvLzg0/f6QeEbqNpsEZui2myX/Sh2ZQvuH32OLgOIekAoIJ
         97aZlmbXZBwYWUJ/q50YiDCdgaHP9rE0or/5kaQx0eFJGNJz6IY56w9gqt82+L6aj/HW
         LZadJNp4fLJKgH7jx3B4ATKZ9CO89XgSdWmNdRTNqR0Uo/HbYSswkoWkUljDfH/olCxD
         Qnjg==
X-Gm-Message-State: ACrzQf14dnoWcgTLiJ5pCPB08bdS0FXx8rY1gX3+zFc70kE3lS85F7aH
        lwX950Ay39r05xCbuhW2kL9GHw==
X-Google-Smtp-Source: AMsMyM6pk0m1i0VNTr6cqzYparON9dgIxMWeiaUxoeoppMrmo2jCQgoaXkrQwmtUUgGSx1GJHxDRLQ==
X-Received: by 2002:a05:6870:2108:b0:132:f883:2378 with SMTP id f8-20020a056870210800b00132f8832378mr360890oae.77.1666058680760;
        Mon, 17 Oct 2022 19:04:40 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id w10-20020a056870a2ca00b00127ba61535fsm5547004oak.15.2022.10.17.19.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 19:04:40 -0700 (PDT)
Message-ID: <913b1eb9-8bf4-2c3a-b0bd-96975d338c8d@kali.org>
Date:   Mon, 17 Oct 2022 21:04:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v1 1/1] usb: dwc3: Don't switch OTG -> peripheral if
 extcon is present
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20221017233510.53336-1-andriy.shevchenko@linux.intel.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20221017233510.53336-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10/17/22 6:35 PM, Andy Shevchenko wrote:
> From: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> If the extcon device exists, get the mode from the extcon device. If
> the controller is DRD and the driver is unable to determine the mode,
> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Fixes: 7a84e7353e23 ("Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"")
> Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/usb/dwc3/core.c | 49 +++++++++++++++++++++++++++++++++++++++-
>   drivers/usb/dwc3/drd.c  | 50 -----------------------------------------
>   2 files changed, 48 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index ea51624461b5..c0e7c76dc5c8 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -23,6 +23,7 @@
>   #include <linux/delay.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/of.h>
> +#include <linux/of_graph.h>
>   #include <linux/acpi.h>
>   #include <linux/pinctrl/consumer.h>
>   #include <linux/reset.h>
> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>   		 * mode. If the controller supports DRD but the dr_mode is not
>   		 * specified or set to OTG, then set the mode to peripheral.
>   		 */
> -		if (mode == USB_DR_MODE_OTG &&
> +		if (mode == USB_DR_MODE_OTG && !dwc->edev &&
>   		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
>   		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
>   		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
> @@ -1690,6 +1691,46 @@ static void dwc3_check_params(struct dwc3 *dwc)
>   	}
>   }
>   
> +static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> +{
> +	struct device *dev = dwc->dev;
> +	struct device_node *np_phy;
> +	struct extcon_dev *edev = NULL;
> +	const char *name;
> +
> +	if (device_property_read_bool(dev, "extcon"))
> +		return extcon_get_edev_by_phandle(dev, 0);
> +
> +	/*
> +	 * Device tree platforms should get extcon via phandle.
> +	 * On ACPI platforms, we get the name from a device property.
> +	 * This device property is for kernel internal use only and
> +	 * is expected to be set by the glue code.
> +	 */
> +	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
> +		return extcon_get_extcon_dev(name);
> +
> +	/*
> +	 * Try to get an extcon device from the USB PHY controller's "port"
> +	 * node. Check if it has the "port" node first, to avoid printing the
> +	 * error message from underlying code, as it's a valid case: extcon
> +	 * device (and "port" node) may be missing in case of "usb-role-switch"
> +	 * or OTG mode.
> +	 */
> +	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
> +	if (of_graph_is_present(np_phy)) {
> +		struct device_node *np_conn;
> +
> +		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> +		if (np_conn)
> +			edev = extcon_find_edev_by_node(np_conn);
> +		of_node_put(np_conn);
> +	}
> +	of_node_put(np_phy);
> +
> +	return edev;
> +}
> +
>   static int dwc3_probe(struct platform_device *pdev)
>   {
>   	struct device		*dev = &pdev->dev;
> @@ -1840,6 +1881,12 @@ static int dwc3_probe(struct platform_device *pdev)
>   		goto err2;
>   	}
>   
> +	dwc->edev = dwc3_get_extcon(dwc);
> +	if (IS_ERR(dwc->edev)) {
> +		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
> +		goto err3;
> +	}
> +
>   	ret = dwc3_get_dr_mode(dwc);
>   	if (ret)
>   		goto err3;
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 8cad9e7d3368..039bf241769a 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -8,7 +8,6 @@
>    */
>   
>   #include <linux/extcon.h>
> -#include <linux/of_graph.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/property.h>
> @@ -439,51 +438,6 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
>   	return NOTIFY_DONE;
>   }
>   
> -static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> -{
> -	struct device *dev = dwc->dev;
> -	struct device_node *np_phy;
> -	struct extcon_dev *edev = NULL;
> -	const char *name;
> -
> -	if (device_property_read_bool(dev, "extcon"))
> -		return extcon_get_edev_by_phandle(dev, 0);
> -
> -	/*
> -	 * Device tree platforms should get extcon via phandle.
> -	 * On ACPI platforms, we get the name from a device property.
> -	 * This device property is for kernel internal use only and
> -	 * is expected to be set by the glue code.
> -	 */
> -	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> -		edev = extcon_get_extcon_dev(name);
> -		if (!edev)
> -			return ERR_PTR(-EPROBE_DEFER);
> -
> -		return edev;
> -	}
> -
> -	/*
> -	 * Try to get an extcon device from the USB PHY controller's "port"
> -	 * node. Check if it has the "port" node first, to avoid printing the
> -	 * error message from underlying code, as it's a valid case: extcon
> -	 * device (and "port" node) may be missing in case of "usb-role-switch"
> -	 * or OTG mode.
> -	 */
> -	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
> -	if (of_graph_is_present(np_phy)) {
> -		struct device_node *np_conn;
> -
> -		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> -		if (np_conn)
> -			edev = extcon_find_edev_by_node(np_conn);
> -		of_node_put(np_conn);
> -	}
> -	of_node_put(np_phy);
> -
> -	return edev;
> -}
> -
>   #if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
>   #define ROLE_SWITCH 1
>   static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
> @@ -588,10 +542,6 @@ int dwc3_drd_init(struct dwc3 *dwc)
>   	    device_property_read_bool(dwc->dev, "usb-role-switch"))
>   		return dwc3_setup_role_switch(dwc);
>   
> -	dwc->edev = dwc3_get_extcon(dwc);
> -	if (IS_ERR(dwc->edev))
> -		return PTR_ERR(dwc->edev);
> -
>   	if (dwc->edev) {
>   		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
>   		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,

Thank you for the quick fix! Confirmed that this works for me on my 
Lenovo Yoga C630

Tested-by: Steev Klimaszewski <steev@kali.org>

