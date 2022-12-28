Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32B657717
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiL1Nd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiL1NdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:33:07 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4950F5A7;
        Wed, 28 Dec 2022 05:33:05 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BSDWoW8088719;
        Wed, 28 Dec 2022 07:32:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672234370;
        bh=4YCOxMJnjSsz8u4Iw6/xtyCElou+fLA9tDITLKKOMqw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ShTRw6k8y1e0JYEvJc8bCoWCUysLdttyJ/GJTiuVktaT7vBS3/imG9pArdp7s0UdM
         S+iEuZ8sCfyeOK13EHLcTAHcaFd/fi05HaEJM6MudEKugDFacWPX2OXeKHt4k3VeGd
         yLxClkbTgw2LLMA/OZm0pBJYbF1Y3sJv/pXwM1NI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BSDWoHa083769
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Dec 2022 07:32:50 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 28
 Dec 2022 07:32:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 28 Dec 2022 07:32:50 -0600
Received: from [10.250.235.211] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BSDWhKb043709;
        Wed, 28 Dec 2022 07:32:44 -0600
Message-ID: <617decfc-bab6-2ba9-53de-c9a0462a2c2a@ti.com>
Date:   Wed, 28 Dec 2022 19:02:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] remoteproc: k3-c7x: Add support for C7xv DSP on AM62A
 SoC
Content-Language: en-US
To:     Hari Nagalla <hnagalla@ti.com>, <andersson@kernel.org>,
        <devicetree@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <linux-remoteproc@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <praneeth@ti.com>, <nm@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <devarsht@ti.com>
References: <20221228123655.15384-1-hnagalla@ti.com>
 <20221228123655.15384-3-hnagalla@ti.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20221228123655.15384-3-hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hari,

On 12/28/2022 6:06 PM, Hari Nagalla wrote:
> Add support to the K3 DSP remoteproc driver to configure the C7xv
> subsystem core on AM62A SoCs. The C7xv susbsytem is based on C71 DSP
> with anlytics engine for deep leraning purposes. The remoteproc
> handling for device management is similar to the C66/C71 DSPs on K3
> J7 family SoCs, even though there are additional hardware accelerators
> and IP updates to C7xv subsystem.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---

Signed-off-by of submitter should be at the last.

I see original author of the patch is Jai here. So you need to amend the
patch such that original author is set to Jai. His Signed-off-by should
be the first and then yours.

>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index eb9c64f7b9b4..ec626a37fef6 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -870,6 +870,10 @@ static const struct k3_dsp_mem_data c71_mems[] = {
>  	{ .name = "l1dram", .dev_addr = 0xe00000 },
>  };
>  
> +static const struct k3_dsp_mem_data c7xv_mems[] = {
> +	{ .name = "l2sram", .dev_addr = 0x800000 },
> +};
> +
>  static const struct k3_dsp_dev_data c66_data = {
>  	.mems = c66_mems,
>  	.num_mems = ARRAY_SIZE(c66_mems),
> @@ -884,10 +888,18 @@ static const struct k3_dsp_dev_data c71_data = {
>  	.uses_lreset = false,
>  };
>  
> +static const struct k3_dsp_dev_data c7xv_data = {
> +	.mems = c7xv_mems,
> +	.num_mems = ARRAY_SIZE(c7xv_mems),
> +	.boot_align_addr = SZ_2M,
> +	.uses_lreset = false,
> +};
> +
>  static const struct of_device_id k3_dsp_of_match[] = {
>  	{ .compatible = "ti,j721e-c66-dsp", .data = &c66_data, },
>  	{ .compatible = "ti,j721e-c71-dsp", .data = &c71_data, },
>  	{ .compatible = "ti,j721s2-c71-dsp", .data = &c71_data, },
> +	{ .compatible = "ti,am62a-c7xv-dsp", .data = &c7xv_data, },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, k3_dsp_of_match);
