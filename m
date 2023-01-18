Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7CC67267E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjARSQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjARSPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:15:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E257D5867D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:15:46 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30II0R2t008180;
        Wed, 18 Jan 2023 18:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=IVmEkhTc43W3TP+gBU3TATYyuv7VwQ4Vmb7MxTOEwZk=;
 b=VH6B8feRsEEnGWiThkPbFe04ezSBSzzQFZTi/Ljz+o1h5RQfwXMDL/Nc6KD+G5WrXWk8
 tFMzvfzir7Z5d7VOtjD02koo/PxMJbgFsZR2BjRLfFw9bw4lrzlfza+GcxDCrfDGOG1H
 Cd4y7APw4XmQlRuzwtNWrbe6fpztk76tXZ1zWCmP1H5xEPE+ZAluVaWIpFyCeT2zlj8o
 j9nPwipXPDi/OKP/Qge+O/V97ksihb3BYIljNIsDsoPEpeJHpZ4LoLyuY1CP2QRlfUxm
 tJyssLUbZSHPn7cVx/Sw0xpGjswr6m5GZHqamU3rsYS+PgFUPqmNvGpSZGSWK6gINxVu CA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5t4jbm5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:15:26 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30IIFPXM016321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:15:25 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 10:15:25 -0800
Date:   Wed, 18 Jan 2023 10:15:23 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>, <kernel@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: defconfig: Enable missing configs for
 mt8192-asurada
Message-ID: <20230118181523.GD3322341@hu-bjorande-lv.qualcomm.com>
References: <20230112151238.1930126-1-nfraprado@collabora.com>
 <20230117155854.GE2350793@hu-bjorande-lv.qualcomm.com>
 <20230117201159.pcxnftapsjr2eotn@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117201159.pcxnftapsjr2eotn@notapiano>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rn1t54kR2QSjXXMnalnqOHuURT1O2XIC
X-Proofpoint-ORIG-GUID: Rn1t54kR2QSjXXMnalnqOHuURT1O2XIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=965
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:11:59PM -0500, Nícolas F. R. A. Prado wrote:
> On Tue, Jan 17, 2023 at 07:58:54AM -0800, Bjorn Andersson wrote:
> > On Thu, Jan 12, 2023 at 10:12:38AM -0500, Nícolas F. R. A. Prado wrote:
> > > Enable missing configs in the arm64 defconfig to get all devices probing
> > > on mt8192-asurada based machines.
> > > 
> > > The devices enabled are: MediaTek Bluetooth USB controller, MediaTek
> > > PCIe Gen3 MAC controller, MT7921E wireless adapter, Elan I2C Trackpad,
> > > MediaTek SPI NOR flash controller, Mediatek SPMI Controller, ChromeOS EC
> > > regulators, MT6315 PMIC, MediaTek Video Codec, MT8192 sound cards,
> > > ChromeOS EC rpmsg communication, all MT8192 clocks.
> > > 
> > > Support for DMA Restricted Pool is also enabled since it is used by the
> > > WiFi card on this platform.
> > > 
> > > REGULATOR_CROS_EC is enabled as builtin since it powers the MMC
> > > controller for the SD card, making it required for booting on some
> > > setups.
> > 
> > I presume this implies that there's no ramdisk to carry these additional
> > modules?
> 
> There may or may not be, at the discretion of the user, so enable by default.
> 

As long as the dependency chain is reasonably short this is okay with me.

> > 
> > > 
> > > By enabling the support for all of this platform's devices on the
> > > defconfig we make it effortless to test the relevant hardware both by
> > > developers as well as CI systems like KernelCI.
> > > 
> > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > 
> > > ---
> > > 
> > >  arch/arm64/configs/defconfig | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > index f3053e7018fe..4e806d8068f6 100644
> > > --- a/arch/arm64/configs/defconfig
> > > +++ b/arch/arm64/configs/defconfig
> [..]
> > > @@ -1092,6 +1104,18 @@ CONFIG_CLK_IMX8QXP=y
> > >  CONFIG_CLK_IMX8ULP=y
> > >  CONFIG_CLK_IMX93=y
> > >  CONFIG_TI_SCI_CLK=y
> > > +CONFIG_COMMON_CLK_MT8192_AUDSYS=y
> > > +CONFIG_COMMON_CLK_MT8192_CAMSYS=y
> > > +CONFIG_COMMON_CLK_MT8192_IMGSYS=y
> > > +CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
> > > +CONFIG_COMMON_CLK_MT8192_IPESYS=y
> > > +CONFIG_COMMON_CLK_MT8192_MDPSYS=y
> > > +CONFIG_COMMON_CLK_MT8192_MFGCFG=y
> > > +CONFIG_COMMON_CLK_MT8192_MMSYS=y
> > > +CONFIG_COMMON_CLK_MT8192_MSDC=y
> > > +CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
> > > +CONFIG_COMMON_CLK_MT8192_VDECSYS=y
> > > +CONFIG_COMMON_CLK_MT8192_VENCSYS=y
> > 
> > Are all these clock drivers needed in order to reach a ramdisk, with
> > working uart, where further kernel modules could be loaded?
> 
> No, but currently these configs can't be enabled as modules. So my intention is
> to enable all of them as builtin for now so we get the functionality there, and
> after the drivers and configs are reworked to allow building as modules (which
> should happen shortly after [1] is merged), I'll update the defconfig so that
> the non-essential ones for boot are set to =m.
> 

Sounds good to me.

Thanks,
Bjorn

> [1] https://lore.kernel.org/all/20230113110616.111001-1-angelogioacchino.delregno@collabora.com/
> 
> > 
> > >  CONFIG_COMMON_CLK_QCOM=y
> > >  CONFIG_QCOM_A53PLL=y
> > >  CONFIG_QCOM_CLK_APCS_MSM8916=y
> > > @@ -1398,6 +1422,7 @@ CONFIG_CRYPTO_DEV_HISI_SEC2=m
> > >  CONFIG_CRYPTO_DEV_HISI_ZIP=m
> > >  CONFIG_CRYPTO_DEV_HISI_HPRE=m
> > >  CONFIG_CRYPTO_DEV_HISI_TRNG=m
> > > +CONFIG_DMA_RESTRICTED_POOL=y
> > 
> > As this would alter the behavior of other platforms and devices, could
> > we please carry this in a patch of its own to aid bisection?
> 
> Sure.
> 
> Thanks,
> Nícolas
> 
> > 
> > Thanks,
> > Bjorn
> > 
> > >  CONFIG_CMA_SIZE_MBYTES=32
> > >  CONFIG_PRINTK_TIME=y
> > >  CONFIG_DEBUG_KERNEL=y
> > > -- 
> > > 2.39.0
> > > 
