Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FD460F0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiJ0HGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiJ0HGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:06:30 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348613B50A;
        Thu, 27 Oct 2022 00:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666854388; x=1698390388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFg7oOrxF7HbyrIiZPByc/B+nSnIpdZwB6Bt5w3mD/s=;
  b=bi4gXWRaTW3bW22xE3Upb36jPkWr5kxQynKsWQJi/JU0c00/ThC62w2+
   MnYctB5Rhdg8H1N+I9d3hIf2ZOOTWWWOlIvJNqryQXEPoPyGKEbLIXROl
   77xhJw0mmahkd1qHvpFbToWlBaP4mkoLoQGopSr69IMUZ2VxT2mqynOt/
   KeYDmn6y5Z3D1ZfFb/kCKEgUgGe2368lpUSOXF/ZmUwzMI46DGR0f7buW
   jmTilFslSTTUUjRAL6nbM2XX6PVBxaXexKX0+jmfjGONTOG9Pdc+G5v8/
   Pp6HSj8R1/960AFEOpCFJyiFWfpcaz1mejVq5e53ftEwVcevMWahPSrhd
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661810400"; 
   d="scan'208";a="27002168"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Oct 2022 09:06:26 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 27 Oct 2022 09:06:26 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 27 Oct 2022 09:06:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666854386; x=1698390386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFg7oOrxF7HbyrIiZPByc/B+nSnIpdZwB6Bt5w3mD/s=;
  b=Z3Wo+iC5qYcDa6g3IdzCQe6GjipkxOkRZHMHVEKKwgoK2fP1xqCUwoDA
   5mxrFf9ErDVO21qNExDrhXSzMndyyVd44imbnjKB0A0MRRgVIhMKbztUO
   zdTq/uqlnaJ08jAG6sIqtzie1OWyBsgc4REW/rG0iKhLulL0lzp46q5QB
   k5cEelUpwVJyc87a56qRyaE1B5oRogI9a+tcXh5JS+I7HguPpYMqNm+fO
   paLJ/ZlMUa5Oxr/vgTCk086r4cJyjv6Mif2BFNYxQvmABiOpQRYLTkz8G
   z5fceF8cdd6nsQm243pdMN+w554dgYvIjdyBibZQiyxnqzMCyjzhgrknX
   g==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661810400"; 
   d="scan'208";a="27002167"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Oct 2022 09:06:26 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 89ACC280056;
        Thu, 27 Oct 2022 09:06:26 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     jun.li@nxp.com, frank.li@nxp.com, a-govindraju@ti.com,
        gregkh@linuxfoundation.org, hzpeterchen@gmail.com,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pawell@cadence.com,
        peter.chen@kernel.org, rogerq@kernel.org, stable@kernel.org
Subject: Re: [PATCH v2 1/1] usb: cdns3: host: fix endless superspeed hub port reset
Date:   Thu, 27 Oct 2022 09:06:22 +0200
Message-ID: <5877757.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221026190749.2280367-1-Frank.Li@nxp.com>
References: <20221026190749.2280367-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 26. Oktober 2022, 21:07:49 CEST schrieb Frank Li:
> From: Li Jun <jun.li@nxp.com>
> 
> When usb 3.0 hub connect with one USB 2.0 device and NO USB 3.0 device,
> some usb hub reports endless port reset message.
> 
> [  190.324169] usb 2-1: new SuperSpeed USB device number 88 using xhci-hcd
> [  190.352834] hub 2-1:1.0: USB hub found
> [  190.356995] hub 2-1:1.0: 4 ports detected
> [  190.700056] usb 2-1: USB disconnect, device number 88
> [  192.472139] usb 2-1: new SuperSpeed USB device number 89 using xhci-hcd
> [  192.500820] hub 2-1:1.0: USB hub found
> [  192.504977] hub 2-1:1.0: 4 ports detected
> [  192.852066] usb 2-1: USB disconnect, device number 89
> 
> The reason is the runtime pm state of USB2.0 port is active and
> USB 3.0 port is suspend, so parent device is active state.
> 
>  cat
> /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-hcd.1.auto/usb2/po
> wer/runtime_status
> 
>  suspended
> 
>  cat
> /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-hcd.1.auto/usb1/po
> wer/runtime_status
> 
>  active
> 
>  cat
> /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-hcd.1.auto/power/r
> untime_status
> 
>  active
> 
>  cat
> /sys/bus/platform/devices/5b110000.usb/5b130000.usb/power/runtime_status
> 
>  active
> 
> So xhci_cdns3_suspend_quirk() have not called. U3 configure is not applied.
> 
> move U3 configure into host start. Reinit again in resume function in case
> controller power lost during suspend.
> 
> Cc: stable@vger.kernel.org 5.10
> Signed-off-by: Li Jun <jun.li@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Change from V1 to V2.
>  - call xhci_cdns3_plat_start() in xhci_cdns3_resume_quirk
> in case power lost during suspend
> 
>  drivers/usb/cdns3/host.c | 56 ++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> index 9643b905e2d8..6164fc4c96a4 100644
> --- a/drivers/usb/cdns3/host.c
> +++ b/drivers/usb/cdns3/host.c
> @@ -24,11 +24,37 @@
>  #define CFG_RXDET_P3_EN		BIT(15)
>  #define LPM_2_STB_SWITCH_EN	BIT(25)
> 
> -static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd);
> +static void xhci_cdns3_plat_start(struct usb_hcd *hcd)
> +{
> +	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> +	u32 value;
> +
> +	/* set usbcmd.EU3S */
> +	value = readl(&xhci->op_regs->command);
> +	value |= CMD_PM_INDEX;
> +	writel(value, &xhci->op_regs->command);
> +
> +	if (hcd->regs) {
> +		value = readl(hcd->regs + XECP_AUX_CTRL_REG1);
> +		value |= CFG_RXDET_P3_EN;
> +		writel(value, hcd->regs + XECP_AUX_CTRL_REG1);
> +
> +		value = readl(hcd->regs + XECP_PORT_CAP_REG);
> +		value |= LPM_2_STB_SWITCH_EN;
> +		writel(value, hcd->regs + XECP_PORT_CAP_REG);
> +	}
> +}
> +
> +static int xhci_cdns3_resume_quirk(struct usb_hcd *hcd)
> +{
> +	xhci_cdns3_plat_start(hcd);
> +	return 0;
> +}
> 
>  static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
>  	.quirks = XHCI_SKIP_PHY_INIT | XHCI_AVOID_BEI,
> -	.suspend_quirk = xhci_cdns3_suspend_quirk,
> +	.plat_start = xhci_cdns3_plat_start,
> +	.resume_quirk = xhci_cdns3_resume_quirk,
>  };
> 
>  static int __cdns_host_init(struct cdns *cdns)
> @@ -90,32 +116,6 @@ static int __cdns_host_init(struct cdns *cdns)
>  	return ret;
>  }
> 
> -static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
> -{
> -	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> -	u32 value;
> -
> -	if (pm_runtime_status_suspended(hcd->self.controller))
> -		return 0;
> -
> -	/* set usbcmd.EU3S */
> -	value = readl(&xhci->op_regs->command);
> -	value |= CMD_PM_INDEX;
> -	writel(value, &xhci->op_regs->command);
> -
> -	if (hcd->regs) {
> -		value = readl(hcd->regs + XECP_AUX_CTRL_REG1);
> -		value |= CFG_RXDET_P3_EN;
> -		writel(value, hcd->regs + XECP_AUX_CTRL_REG1);
> -
> -		value = readl(hcd->regs + XECP_PORT_CAP_REG);
> -		value |= LPM_2_STB_SWITCH_EN;
> -		writel(value, hcd->regs + XECP_PORT_CAP_REG);
> -	}
> -
> -	return 0;
> -}
> -
>  static void cdns_host_exit(struct cdns *cdns)
>  {
>  	kfree(cdns->xhci_plat_data);

Although I could only test it on v5.15 downstream kernel
Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>



