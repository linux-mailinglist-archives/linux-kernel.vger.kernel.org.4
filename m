Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505776D3CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjDCFVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjDCFVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFE5C174;
        Sun,  2 Apr 2023 22:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD837614A9;
        Mon,  3 Apr 2023 05:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5635C433EF;
        Mon,  3 Apr 2023 05:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680499272;
        bh=Mj47Qs23bdwv1bF+3GKPtoumqI9bOKyr2shj6muWIEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/ZUv/5JhIq3gjDZ3+c0yUzAuJanRGFd5cFeQj89qw2F7Jf2pTLvybuOhDisRE1os
         hBjA96W8ZXjvii/iSpNTQZJCpTq/RVlHVyqz6Yd9OzW0fBAOu6oIceUXEb5gF2CmCr
         ua1L71VUP4okfczraqNvEW1mMx7+hQrIjE3AKwXIx9fUN0uVTZLw+S9iiLyEiLYQDt
         p3nGq4Q831L59lefm8SiD/0CefCzZHLSYI4b3hONjD8VU3rd72GZDtdTI9bgE2M0Ts
         5LQ/CE/Bo81xrUrHzvDAaD+q9ZW+S8oHDGDZYgm8BXThVCCcm5eJKxV0l8hEvpOW87
         L52hSgtqHRhBA==
Date:   Mon, 3 Apr 2023 10:51:07 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: pci_generic: Add Foxconn T99W510
Message-ID: <20230403052107.GF4627@thinkpad>
References: <20230329072239.93632-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230329072239.93632-1-slark_xiao@163.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 03:22:39PM +0800, Slark Xiao wrote:
> The Foxconn T99W510 device is designed based on Qualcomm
> SDX24. Add 3 variants for different potential customer.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 91d02f84ba21..db0a0b062d8e 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -363,6 +363,15 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
>  	.event_cfg = mhi_foxconn_sdx55_events,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
> +	.name = "foxconn-sdx24",
> +	.config = &modem_foxconn_sdx55_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = false,
> +};
> +
>  static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.name = "foxconn-sdx55",
>  	.fw = "qcom/sdx55m/sbl1.mbn",
> @@ -587,6 +596,15 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* T99W373 (sdx62) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d9),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
> +	/* T99W510 (sdx24), variant 1 */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f0),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
> +	/* T99W510 (sdx24), variant 2 */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f1),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
> +	/* T99W510 (sdx24), variant 3 */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f2),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
>  	/* MV31-W (Cinterion) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
