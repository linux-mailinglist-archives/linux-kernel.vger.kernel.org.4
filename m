Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1266E900
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjAQV6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjAQVve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:51:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A3A442EE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:12:28 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 054FA6602D2A;
        Tue, 17 Jan 2023 20:12:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673986346;
        bh=g3+YFgRcvbPTz7/8xFzAI9AbV4cEoOAZFx1BS/KPOhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HriWKgUC4gK3VT6GxZmqXhMEkKdnvgyPTaYrn3czuuSuc969Q06xGTbLJbTnv8Ldg
         s5qUcH+57TWwoWcQkpPXqEk2MLDd9P+egXSdEBadZvrMsrjby7GnD0ifiWFsgHLYma
         3bJm47Z3yjWWiHBdEhKURXUkX1NojJQMth1x1Zf9bVvYy9krbdCegj1fxsAWBctIFq
         1AGP0c0s4xVLmxF6fFGq7CvIdvUrdnoLUqvDOsvNrGWQYKZyLP7M/PVUaGky7xUD1I
         M4ENRXghARJYSTWRPgHU3vNACmDSsFg0HfIeLOPlkIlJSEhvcstBF5iHRNis1kXAU8
         p+wIhYE4qSQMQ==
Date:   Tue, 17 Jan 2023 15:11:59 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable missing configs for
 mt8192-asurada
Message-ID: <20230117201159.pcxnftapsjr2eotn@notapiano>
References: <20230112151238.1930126-1-nfraprado@collabora.com>
 <20230117155854.GE2350793@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117155854.GE2350793@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:58:54AM -0800, Bjorn Andersson wrote:
> On Thu, Jan 12, 2023 at 10:12:38AM -0500, Nícolas F. R. A. Prado wrote:
> > Enable missing configs in the arm64 defconfig to get all devices probing
> > on mt8192-asurada based machines.
> > 
> > The devices enabled are: MediaTek Bluetooth USB controller, MediaTek
> > PCIe Gen3 MAC controller, MT7921E wireless adapter, Elan I2C Trackpad,
> > MediaTek SPI NOR flash controller, Mediatek SPMI Controller, ChromeOS EC
> > regulators, MT6315 PMIC, MediaTek Video Codec, MT8192 sound cards,
> > ChromeOS EC rpmsg communication, all MT8192 clocks.
> > 
> > Support for DMA Restricted Pool is also enabled since it is used by the
> > WiFi card on this platform.
> > 
> > REGULATOR_CROS_EC is enabled as builtin since it powers the MMC
> > controller for the SD card, making it required for booting on some
> > setups.
> 
> I presume this implies that there's no ramdisk to carry these additional
> modules?

There may or may not be, at the discretion of the user, so enable by default.

> 
> > 
> > By enabling the support for all of this platform's devices on the
> > defconfig we make it effortless to test the relevant hardware both by
> > developers as well as CI systems like KernelCI.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >  arch/arm64/configs/defconfig | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index f3053e7018fe..4e806d8068f6 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
[..]
> > @@ -1092,6 +1104,18 @@ CONFIG_CLK_IMX8QXP=y
> >  CONFIG_CLK_IMX8ULP=y
> >  CONFIG_CLK_IMX93=y
> >  CONFIG_TI_SCI_CLK=y
> > +CONFIG_COMMON_CLK_MT8192_AUDSYS=y
> > +CONFIG_COMMON_CLK_MT8192_CAMSYS=y
> > +CONFIG_COMMON_CLK_MT8192_IMGSYS=y
> > +CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
> > +CONFIG_COMMON_CLK_MT8192_IPESYS=y
> > +CONFIG_COMMON_CLK_MT8192_MDPSYS=y
> > +CONFIG_COMMON_CLK_MT8192_MFGCFG=y
> > +CONFIG_COMMON_CLK_MT8192_MMSYS=y
> > +CONFIG_COMMON_CLK_MT8192_MSDC=y
> > +CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
> > +CONFIG_COMMON_CLK_MT8192_VDECSYS=y
> > +CONFIG_COMMON_CLK_MT8192_VENCSYS=y
> 
> Are all these clock drivers needed in order to reach a ramdisk, with
> working uart, where further kernel modules could be loaded?

No, but currently these configs can't be enabled as modules. So my intention is
to enable all of them as builtin for now so we get the functionality there, and
after the drivers and configs are reworked to allow building as modules (which
should happen shortly after [1] is merged), I'll update the defconfig so that
the non-essential ones for boot are set to =m.

[1] https://lore.kernel.org/all/20230113110616.111001-1-angelogioacchino.delregno@collabora.com/

> 
> >  CONFIG_COMMON_CLK_QCOM=y
> >  CONFIG_QCOM_A53PLL=y
> >  CONFIG_QCOM_CLK_APCS_MSM8916=y
> > @@ -1398,6 +1422,7 @@ CONFIG_CRYPTO_DEV_HISI_SEC2=m
> >  CONFIG_CRYPTO_DEV_HISI_ZIP=m
> >  CONFIG_CRYPTO_DEV_HISI_HPRE=m
> >  CONFIG_CRYPTO_DEV_HISI_TRNG=m
> > +CONFIG_DMA_RESTRICTED_POOL=y
> 
> As this would alter the behavior of other platforms and devices, could
> we please carry this in a patch of its own to aid bisection?

Sure.

Thanks,
Nícolas

> 
> Thanks,
> Bjorn
> 
> >  CONFIG_CMA_SIZE_MBYTES=32
> >  CONFIG_PRINTK_TIME=y
> >  CONFIG_DEBUG_KERNEL=y
> > -- 
> > 2.39.0
> > 
