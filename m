Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49D462B133
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKPCRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKPCRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:17:46 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0468D12ACB;
        Tue, 15 Nov 2022 18:17:44 -0800 (PST)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBmnD0gTXzqSSy;
        Wed, 16 Nov 2022 10:13:52 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 10:17:36 +0800
Message-ID: <6374483F.3060604@hisilicon.com>
Date:   Wed, 16 Nov 2022 10:17:35 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Pierre Gondois <pierre.gondois@arm.com>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chester Lin <clin@suse.com>,
        =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Chanho Min <chanho.min@lge.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        David Heidelberg <david@ixit.cz>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Sameer Pujar <spujar@nvidia.com>,
        Akhil R <akhilrajeev@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
        Vidya Sagar <vidyas@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Andi Shyti <andi@etezian.org>, <devicetree@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
        <linux-tegra@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-realtek-soc@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 09/23] arm64: dts: Update cache properties for hisilicon
References: <20221107155825.1644604-1-pierre.gondois@arm.com> <20221107155825.1644604-10-pierre.gondois@arm.com>
In-Reply-To: <20221107155825.1644604-10-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 2022/11/7 23:57, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).
> 
> Update the Device Trees accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Applied to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  2 ++
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  2 ++
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi  |  4 ++++
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi  |  4 ++++
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi  | 16 ++++++++++++++++
>  5 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 8343d0cedde3..a57f35eb5ef6 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -203,10 +203,12 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
>  
>  		A53_L2: l2-cache0 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		A73_L2: l2-cache1 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index ae0a7cfeeb47..f6d3202b0d1a 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -186,10 +186,12 @@ cpu7: cpu@103 {
>  
>  		CLUSTER0_L2: l2-cache0 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		CLUSTER1_L2: l2-cache1 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> index 7b2abd10d3d6..5b2b1bfd0d2a 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> @@ -211,18 +211,22 @@ cpu15: cpu@20303 {
>  
>  		cluster0_l2: l2-cache0 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster1_l2: l2-cache1 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster2_l2: l2-cache2 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster3_l2: l2-cache3 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> index 2f8b03b0d365..291c2ee38288 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> @@ -211,18 +211,22 @@ cpu15: cpu@10303 {
>  
>  		cluster0_l2: l2-cache0 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster1_l2: l2-cache1 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster2_l2: l2-cache2 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster3_l2: l2-cache3 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> index 1a16662f8867..b8746fb959b5 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> @@ -842,66 +842,82 @@ cpu63: cpu@70303 {
>  
>  		cluster0_l2: l2-cache0 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster1_l2: l2-cache1 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster2_l2: l2-cache2 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster3_l2: l2-cache3 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster4_l2: l2-cache4 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster5_l2: l2-cache5 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster6_l2: l2-cache6 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster7_l2: l2-cache7 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster8_l2: l2-cache8 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster9_l2: l2-cache9 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster10_l2: l2-cache10 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster11_l2: l2-cache11 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster12_l2: l2-cache12 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster13_l2: l2-cache13 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster14_l2: l2-cache14 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster15_l2: l2-cache15 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> 
