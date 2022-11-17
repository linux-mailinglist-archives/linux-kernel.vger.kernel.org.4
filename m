Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8862D9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiKQLw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiKQLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:52:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622891F63A;
        Thu, 17 Nov 2022 03:52:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D2FBB81FF8;
        Thu, 17 Nov 2022 11:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92BEC433D6;
        Thu, 17 Nov 2022 11:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685931;
        bh=l3MH6GFNFGDN5SINuaxohX7iV5gNV7eWRU8EqGNSDxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXgcHMVFbT+npWGmBoz92NRbZ7aQe3WZYmIdOVtun5Iekkx6XpW94t1HgHacIpSip
         VIfuTi6GNyjpobU4wZIlAPWhTKbWaLDkQM52tPeHTJ9ym+5d4WD8muxTuxRHkv7NPa
         tJBVV/o5XyeaMQj+7iDs32SkrPggYWUPRKRrLsQH7Wb/ZDnkdEo0vV+BzdQN9G0c3u
         yWshSJ6mnaFdaE4hNk3kS465d6gs9pQSPhLlXqxWQK2oA/JYUxItVMVpomvxP48YdI
         QEjycZEwv+5e4hG6KxpnVfBsJc1UZPakVfE1cVMI2ZsJ5UCCPr6Ef1Th3mvqBFe4MM
         eUevAG4CX06zQ==
Date:   Thu, 17 Nov 2022 17:22:00 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        dnlplm@gmail.com, yonglin.tan@outlook.com,
        fabio.porcedda@gmail.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bus: mhi: host: pci_generic: Add definition for some
 VIDs
Message-ID: <20221117115200.GE93179@thinkpad>
References: <20221107112700.773-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107112700.773-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 07:27:00PM +0800, Slark Xiao wrote:
> To make code neat and for convenience purpose, add definition for some
> VIDs. Adding it locally until these VIDs are used in multiple places.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to mhi-next!

Thanks,
Mani

> ---
> v3: Update description
> v2: Update description and fix format issue
> ---
>  drivers/bus/mhi/host/pci_generic.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index c4259cb2d289..3a789bb2f631 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -24,6 +24,10 @@
>  
>  #define HEALTH_CHECK_PERIOD (HZ * 2)
>  
> +/* PCI VID definitions */
> +#define PCI_VENDOR_ID_THALES	0x1269
> +#define PCI_VENDOR_ID_QUECTEL	0x1eac
> +
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
> 

-- 
மணிவண்ணன் சதாசிவம்
