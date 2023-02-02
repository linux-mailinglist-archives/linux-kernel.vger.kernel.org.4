Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE63687D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjBBMgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBBMgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:36:38 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7241184974
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:36:27 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312BcPrE004028;
        Thu, 2 Feb 2023 13:36:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=vfEQ+byTec7V2sg7Odj3rpVtBYXBn2st79ESMt6FUV0=;
 b=rupDROGwjI3ryvx1yAtJBmU37Mz/qTljDwikf47HBEhjlqckHE+KZPJJ5juHN/kplQDZ
 UIlf2WTpaYzpEZO8EDE/hFEsSXJrV+4MfqZj1xNiGVZoY5OVVuqKn4OlSVLFA0URJ4T9
 8uZDcLmT9VA2tnbd1X/84BWtyS5EhqE/GfrI0MKLt+nw+v+B36r6h2zc44/77rvJBM7L
 8unaLOuS7dm/f56xzkhrEH75c/i29xc1Ybd9tar4X7ZB1wZJLtQJtYA0RCkpRRBpvO9T
 x7jILpraesMFB07KLSDwgZjDYUhQpENeA/rx8Nx2tRLJzK0ZQh0tMn8MuU+QHQ3YEMiU cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3nfn39gvd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 13:36:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3400710002A;
        Thu,  2 Feb 2023 13:35:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2179F2128DC;
        Thu,  2 Feb 2023 13:35:58 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 2 Feb
 2023 13:35:56 +0100
Message-ID: <244541fb-993e-3c50-d671-0730811335ae@foss.st.com>
Date:   Thu, 2 Feb 2023 13:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable NVMEM driver for STM32
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Russell King <linux@armlinux.org.uk>
CC:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230130135951.1.I609229f603520144b3831bea4b026000ae0dd9a8@changeid>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230130135951.1.I609229f603520144b3831bea4b026000ae0dd9a8@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 14:00, Patrick Delaunay wrote:
> Enable the STMicroelectronics NVMEM drivers used on
> STM32 MPU, STM32MP15x and STM32MP13x, to access OTPs.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index d2f218341ad0..9b3ef21f44c1 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1209,6 +1209,7 @@ CONFIG_RAS=y
>   CONFIG_NVMEM_IMX_OCOTP=y
>   CONFIG_NVMEM_QCOM_QFPROM=y
>   CONFIG_NVMEM_ROCKCHIP_EFUSE=m
> +CONFIG_NVMEM_STM32_ROMEM=m
>   CONFIG_NVMEM_SUNXI_SID=y
>   CONFIG_NVMEM_VF610_OCOTP=y
>   CONFIG_NVMEM_MESON_MX_EFUSE=m

Applied on stm32-next.

Thanks.
Alex
