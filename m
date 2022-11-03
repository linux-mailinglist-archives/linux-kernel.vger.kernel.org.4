Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD3617D12
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKCMuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiKCMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:50:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3812AE9;
        Thu,  3 Nov 2022 05:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F8BBB823C1;
        Thu,  3 Nov 2022 12:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA41DC433D6;
        Thu,  3 Nov 2022 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667479822;
        bh=u7zq92KkM1JW1e0MCT8+S4MFg2O1zjgM8MB9fFopD8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSnmaYrDBsjZq7ystKjIGqwH8CVbvgrMmgBThb/n4nmK36N0h3l6dGYHgG0GDEXia
         5ECVzS0xx046NaD4aWleJcymEwsKCesAjmz/z2TkL0uen0VavmCFPoxknyTFzls41F
         B6wdQ+XggSmUN4UoJjzq+jHC6MEDXY3l4druYSg3Ej34x9T8+xKCdKd5Qh+j06vE9K
         H2HHNmIlpFc45ZbVXuWgjs7nXn/e2rYPZo2XaDy1oq08nKfh47/4Gu/H3DlJ4ByEpf
         kQg1nrNwIjb91wyve2rWTLhqkb/IkYtPy8CHNuHF1mprwtyQgDh8x//LitWZnAWGM8
         pO9dn/d20znZw==
Date:   Thu, 3 Nov 2022 18:20:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        dnlplm@gmail.com, yonglin.tan@outlook.com,
        fabio.porcedda@gmail.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add macro for some vids
Message-ID: <20221103125009.GH8434@thinkpad>
References: <20221102024437.15248-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102024437.15248-1-slark_xiao@163.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:44:37AM +0800, Slark Xiao wrote:
> To make code neat and for convenience purpose, using macro for
> some vids.

s/using/use
s/vids/VIDs

> Refer to previous patch in pci_ids.h side, they are
> not allowed to add new entries of single driver needed. So we
> add it in our local file.
>

Reference to the previous patch has no relationship with this commit once
merged. How about,

"These macros are supposed to be added to pci_ids.h. But until the macros are
used in multiple places, it is not recommended. So adding it locally for now."
 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index c4259cb2d289..5abc778a5290 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -24,6 +24,10 @@
>  
>  #define HEALTH_CHECK_PERIOD (HZ * 2)
>  

Add a comment,

/* PCI VID definitions */

> +#define PCI_VENDOR_ID_THALES	0x1269
> +

No need of newline

> +#define PCI_VENDOR_ID_QUECTEL	0x1eac
> +

Just use a space after PCI_VENDOR_ID_QUECTEL like above.

Thanks,
Mani

>  /**
>   * struct mhi_pci_dev_info - MHI PCI device specific information
>   * @config: MHI controller configuration
> @@ -557,11 +561,11 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
> -	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> -	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> -	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x2001), /* EM120R-GL for FCCL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
> @@ -585,16 +589,16 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d9),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
>  	/* MV31-W (Cinterion) */
> -	{ PCI_DEVICE(0x1269, 0x00b3),
> +	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
>  	/* MV31-W (Cinterion), based on new baseline */
> -	{ PCI_DEVICE(0x1269, 0x00b4),
> +	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b4),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
>  	/* MV32-WA (Cinterion) */
> -	{ PCI_DEVICE(0x1269, 0x00ba),
> +	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00ba),
>  		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
>  	/* MV32-WB (Cinterion) */
> -	{ PCI_DEVICE(0x1269, 0x00bb),
> +	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00bb),
>  		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
>  	{  }
>  };
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
