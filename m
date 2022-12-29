Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6F3658FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiL2RZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiL2RY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:24:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A361649C;
        Thu, 29 Dec 2022 09:24:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E04BA61881;
        Thu, 29 Dec 2022 17:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D196C433EF;
        Thu, 29 Dec 2022 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334654;
        bh=m9HPREp2BBaXTvbpQHx2WQprM9b37LXlFfRjZD2pPbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qt7/hxQDBIvlE+UOhExIE+gpA1yr2Ytl6cD8uXTtl6jgmBiTsoa9S2hzoepP7nwKs
         hhpc3+xHFhXVHpJMCUop4bill7ozLgMzwQO9LA8YMAFtxiODZoV/t6jq0Emw7Vrcpc
         e3wDGuhBEwoBzI4P7WQzE+OVPLDTQ1V36xIiwX6Tdlhhavqpe87KM/WVAf3FA/niGn
         Ujoi3sHXiSMn5Y2NVbd6ytWoXoohJM3TaDA3JajgPrNoErUXxWekYOsYNjAIXlTMEQ
         vMYOqfDifnyfUtz3zYMqXx6dcSELIGyAql3swkh8gUSPi1+mCzcYJTnQt6naxTJBRV
         xmQpIqRdURmSg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, pierre.gondois@arm.com
Cc:     linux-realtek-soc@lists.infradead.org, alim.akhtar@samsung.com,
        clin@suse.com, krzysztof.kozlowski+dt@linaro.org,
        tmaimon77@gmail.com, chris.obbard@collabora.com, ming.qian@nxp.com,
        william.zhang@broadcom.com, linux-arm-kernel@lists.infradead.org,
        Markus.Niebel@ew.tq-group.com, m.felsch@pengutronix.de,
        jszhang@kernel.org, viorel.suman@nxp.com, liviu.dudau@arm.com,
        openbmc@lists.ozlabs.org, agross@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, xiaoning.wang@nxp.com,
        mbrugger@suse.com, hayashi.kunihiko@socionext.com,
        aswani.reddy@samsung.com, linux-arm-msm@vger.kernel.org,
        s32@nxp.com, mhiramat@kernel.org, marex@denx.de,
        Steen.Hegelund@microchip.com, anand.gore@broadcom.com,
        thomas.lendacky@amd.com, pshete@nvidia.com,
        benjaminfair@google.com, diogo.ivo@tecnico.ulisboa.pt,
        jbx6244@gmail.com, heiko@sntech.de, tharvey@gateworks.com,
        vigneshr@ti.com, linux-rpi-kernel@lists.infradead.org,
        afaerber@suse.de, jun.li@nxp.com, victor.liu@nxp.com,
        linux-mediatek@lists.infradead.org, mperttunen@nvidia.com,
        peng.fan@nxp.com, abelvesa@kernel.org,
        chris.packham@alliedtelesis.co.nz, lpieralisi@kernel.org,
        laurent.pinchart@ideasonboard.com, ezequiel@vanguardiasur.com.ar,
        rafal@milecki.pl, jonathanh@nvidia.com,
        konrad.dybcio@somainline.org, UNGLinuxDriver@microchip.com,
        martin.blumenstingl@googlemail.com,
        linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
        qiangqing.zhang@nxp.com, amhetre@nvidia.com,
        linux-tegra@vger.kernel.org, andrew@lunn.ch, kristo@kernel.org,
        nm@ti.com, spujar@nvidia.com, leoyang.li@nxp.com,
        vadym.kochan@plvision.eu, daniel.machon@microchip.com,
        paul.elder@ideasonboard.com, khilman@baylibre.com,
        avifishman70@gmail.com, tali.perry1@gmail.com,
        linux-samsung-soc@vger.kernel.org, robh+dt@kernel.org,
        alexander.stein@ew.tq-group.com, festevam@gmail.com,
        brijeshkumar.singh@amd.com, oliver.graute@kococonnector.com,
        martink@posteo.de, shenwei.wang@nxp.com, f.fainelli@gmail.com,
        sumitg@nvidia.com, devicetree@vger.kernel.org, eagle.zhou@nxp.com,
        sebastian.hesselbarth@gmail.com, atenart@kernel.org,
        l.stach@pengutronix.de, xuwei5@hisilicon.com,
        tsahee@annapurnalabs.com, ping.bai@nxp.com, shawnguo@kernel.org,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        bcm-kernel-feedback-list@broadcom.com, neil.armstrong@linaro.org,
        suravee.suthikulpanit@amd.com, thierry.reding@gmail.com,
        rjui@broadcom.com, lars.povlsen@microchip.com,
        magnus.damm@gmail.com, geert+renesas@glider.be, wei.fang@nxp.com,
        linux-imx@nxp.com, gregory.clement@bootlin.com, yuenn@google.com,
        vidyas@nvidia.com, chanho.min@lge.com, david@ixit.cz,
        aford173@gmail.com, s.prashar@samsung.com,
        khuong@os.amperecomputing.com, sudeep.holla@arm.com,
        sbranden@broadcom.com, shijie.qin@nxp.com, venture@google.com,
        kursad.oney@broadcom.com, linux-renesas-soc@vger.kernel.org,
        hongxing.zhu@nxp.com, akhilrajeev@nvidia.com
Subject: Re: (subset) [PATCH v2 16/23] arm64: dts: Update cache properties for qcom
Date:   Thu, 29 Dec 2022 11:23:41 -0600
Message-Id: <167233461757.1099840.14261373049741719746.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107155825.1644604-17-pierre.gondois@arm.com>
References: <20221107155825.1644604-1-pierre.gondois@arm.com> <20221107155825.1644604-17-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 16:57:09 +0100, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).
> 
> Update the Device Trees accordingly.
> 
> [...]

Applied, thanks!

[16/23] arm64: dts: Update cache properties for qcom
        commit: 9435294c6517dc70bb608505b79097a58ea7c6a3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
