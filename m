Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A075F845B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJHIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJHIpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:45:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2633414
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:45:17 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MkzFz1GfxzkXw1;
        Sat,  8 Oct 2022 16:42:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 16:45:09 +0800
Received: from [10.67.111.195] (10.67.111.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 16:45:08 +0800
Message-ID: <5fc5644c-6dd8-8a9e-bfcb-f959d32546c3@huawei.com>
Date:   Sat, 8 Oct 2022 16:45:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] ARM: mmp: Make some symbols static
To:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kbuild-all@lists.01.org>
References: <20220817081420.2106248-1-chenlifu@huawei.com>
From:   chenlifu <chenlifu@huawei.com>
In-Reply-To: <20220817081420.2106248-1-chenlifu@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.195]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/8/17 16:14, Chen Lifu 写道:
> These symbols pxa168_usb_phy_resources, pxa168_u2o_resources,
> pxa168_u2oehci_resources and pxa168_u2ootg_resources are not used
> outside of arch/arm/mach-mmp/devices.c, so mark them static.
> 
> Fixes the following sparse warning:
> 
> arch/arm/mach-mmp/devices.c:241:17: warning: symbol 'pxa168_usb_phy_resources' was not declared. Should it be static?
> arch/arm/mach-mmp/devices.c:262:17: warning: symbol 'pxa168_u2o_resources' was not declared. Should it be static?
> arch/arm/mach-mmp/devices.c:297:17: warning: symbol 'pxa168_u2oehci_resources' was not declared. Should it be static?
> arch/arm/mach-mmp/devices.c:324:17: warning: symbol 'pxa168_u2ootg_resources' was not declared. Should it be static?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>   arch/arm/mach-mmp/devices.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
> index 79f4a2aa5475..9968239d8041 100644
> --- a/arch/arm/mach-mmp/devices.c
> +++ b/arch/arm/mach-mmp/devices.c
> @@ -236,11 +236,11 @@ void pxa_usb_phy_deinit(void __iomem *phy_reg)
>   
>   #if IS_ENABLED(CONFIG_USB_SUPPORT)
>   static u64 __maybe_unused usb_dma_mask = ~(u32)0;
>   
>   #if IS_ENABLED(CONFIG_PHY_PXA_USB)
> -struct resource pxa168_usb_phy_resources[] = {
> +static struct resource pxa168_usb_phy_resources[] = {
>   	[0] = {
>   		.start	= PXA168_U2O_PHYBASE,
>   		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
>   		.flags	= IORESOURCE_MEM,
>   	},
> @@ -257,11 +257,11 @@ struct platform_device pxa168_device_usb_phy = {
>   	}
>   };
>   #endif /* CONFIG_PHY_PXA_USB */
>   
>   #if IS_ENABLED(CONFIG_USB_MV_UDC)
> -struct resource pxa168_u2o_resources[] = {
> +static struct resource pxa168_u2o_resources[] = {
>   	/* regbase */
>   	[0] = {
>   		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
>   		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
>   		.flags	= IORESOURCE_MEM,
> @@ -292,11 +292,11 @@ struct platform_device pxa168_device_u2o = {
>   	}
>   };
>   #endif /* CONFIG_USB_MV_UDC */
>   
>   #if IS_ENABLED(CONFIG_USB_EHCI_MV_U2O)
> -struct resource pxa168_u2oehci_resources[] = {
> +static struct resource pxa168_u2oehci_resources[] = {
>   	[0] = {
>   		.start	= PXA168_U2O_REGBASE,
>   		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
>   		.flags	= IORESOURCE_MEM,
>   	},
> @@ -319,11 +319,11 @@ struct platform_device pxa168_device_u2oehci = {
>   	.resource	= pxa168_u2oehci_resources,
>   };
>   #endif
>   
>   #if IS_ENABLED(CONFIG_USB_MV_OTG)
> -struct resource pxa168_u2ootg_resources[] = {
> +static struct resource pxa168_u2ootg_resources[] = {
>   	/* regbase */
>   	[0] = {
>   		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
>   		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
>   		.flags	= IORESOURCE_MEM,
friendly ping ...
