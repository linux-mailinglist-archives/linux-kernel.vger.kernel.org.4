Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E139C60FC00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiJ0Pbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiJ0Pbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:31:40 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F0A7D787
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:31:34 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b25so1184812qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7w3uoa4FTdhJxZ25bhorxFzQiWVlOn9UmQFlyRtAHQ=;
        b=NLFK8pIKKGlAQazfnzNp1gflaHBJIKOKvnMDYgxyC0xDUH8Ogf77EsrRpXxSmAWvxm
         b72a8L4dhr/3GW9xyEcFaoQ4LtJ/dv+uYhwhmIwU6BNuX+9hEdU9ilayNdi5YTqGzyF5
         3SwgekK313p+Y1GKko68Xm+hW36fXMBgKMOcI29IPGkPRf61oeseaa1g+271EildMcfD
         Cktwt41M4n6iCaPlPCoASDT9L6d7sS+5MINL2q2zye21rp9JhoBQf8YCsxxHrE6recwF
         S9sTGWUN8vmQT84+hbWoALr6XVU+rEHTZm1tyenvCgmCzf8zZZlTdam/827mTGk5n6lG
         9iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7w3uoa4FTdhJxZ25bhorxFzQiWVlOn9UmQFlyRtAHQ=;
        b=CEklwatFNYUGUeVNgSIpDSov1yjZtWaXx/+ENFxd7G86GG/WSTykedyzHQojQnokBh
         HJuDf+RFrdUjMHjeXhHaSpHdGyJfnE7ALsyfGcyOdaCv03PzhMbsq70OGc9TOyWLf/dv
         9vnc6wEeV2wLTk8oMzIjwbkGU84wUhXjMnRBrRGqyh4a69+NRit26eyeqsRRh8s0McuA
         CBxVRWatfgAiQ61iVpXCJd/sr5ZQoorgW01WQRreMVzTYNFLjRT1AjpVIrEzO3yeMLKy
         JDdm3jdGGUbj1gN2OpVsIZxvMFSVCj/1qQT/Ad24BkUgGxqC5yrp1njzI10XWGm6bkie
         MuyA==
X-Gm-Message-State: ACrzQf0pJr5wINm/ECMihvyZTwhG3a/NeDdmfV+aau0QQtrduOTJFTL4
        vEty2Z7igUH46HkwRxpamf8ZKQ==
X-Google-Smtp-Source: AMsMyM50ZUKQ+BxlN4VWwwqQmQmSSvEjGpm5ds1123inMfNrhecYu7nftZmdqXMPusu9FK2VJhpv7w==
X-Received: by 2002:a05:620a:45ac:b0:6f8:7c0c:20f with SMTP id bp44-20020a05620a45ac00b006f87c0c020fmr8572431qkb.270.1666884693463;
        Thu, 27 Oct 2022 08:31:33 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a454f00b006ce2c3c48ebsm1187787qkp.77.2022.10.27.08.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:31:32 -0700 (PDT)
Message-ID: <ff5ed856-5ace-4087-bb2a-dfa932265710@linaro.org>
Date:   Thu, 27 Oct 2022 11:31:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/3] interconnect: qcom: Add QDU1000/QRU1000
 interconnect driver
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026190520.4004264-1-quic_molvera@quicinc.com>
 <20221026190520.4004264-4-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026190520.4004264-4-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 15:05, Melody Olvera wrote:
> Add interconnect provider driver for Qualcomm QDU1000 and QRU1000
> platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/interconnect/qcom/Kconfig   |    9 +
>  drivers/interconnect/qcom/Makefile  |    2 +
>  drivers/interconnect/qcom/qdu1000.c | 1079 +++++++++++++++++++++++++++
>  drivers/interconnect/qcom/qdu1000.h |   95 +++
>  4 files changed, 1185 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/qdu1000.c
>  create mode 100644 drivers/interconnect/qcom/qdu1000.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 1a1c941635a2..fe38badf49ef 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -69,6 +69,15 @@ config INTERCONNECT_QCOM_QCS404
>  	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
>  	  platforms.
>  
> +config INTERCONNECT_QCOM_QDU1000
> +	tristate "Qualcomm QDU1000/QRU1000 interconnect driver"
> +	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on QDU1000-based
> +	  and QRU1000-based platforms.
> +
>  config INTERCONNECT_QCOM_RPMH_POSSIBLE
>  	tristate
>  	default INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 8e357528185d..eca2160e9c3f 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -11,6 +11,7 @@ qnoc-msm8996-objs			:= msm8996.o
>  icc-osm-l3-objs				:= osm-l3.o
>  qnoc-qcm2290-objs			:= qcm2290.o
>  qnoc-qcs404-objs			:= qcs404.o
> +qnoc-qdu1000-objs			:= qdu1000.o
>  icc-rpmh-obj				:= icc-rpmh.o
>  qnoc-sc7180-objs			:= sc7180.o
>  qnoc-sc7280-objs                        := sc7280.o
> @@ -35,6 +36,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) += qnoc-msm8996.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCM2290) += qnoc-qcm2290.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_QDU1000) += qnoc-qdu1000.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SC7280) += qnoc-sc7280.o
> diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
> new file mode 100644
> index 000000000000..e337990275ff
> --- /dev/null
> +++ b/drivers/interconnect/qcom/qdu1000.c
> @@ -0,0 +1,1079 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <dt-bindings/interconnect/qcom,qdu1000.h>
> +
> +#include "bcm-voter.h"
> +#include "icc-common.h"
> +#include "icc-rpmh.h"
> +#include "qdu1000.h"
> +
> +static struct qcom_icc_node qup0_core_master = {
> +	.name = "qup0_core_master",
> +	.id = QDU1000_MASTER_QUP_CORE_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_QUP_CORE_0 },
> +};
> +
> +static struct qcom_icc_node qup1_core_master = {
> +	.name = "qup1_core_master",
> +	.id = QDU1000_MASTER_QUP_CORE_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_QUP_CORE_1 },
> +};
> +
> +static struct qcom_icc_node alm_sys_tcu = {
> +	.name = "alm_sys_tcu",
> +	.id = QDU1000_MASTER_SYS_TCU,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 2,
> +	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node chm_apps = {
> +	.name = "chm_apps",
> +	.id = QDU1000_MASTER_APPSS_PROC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 4,
> +	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC,
> +		   QDU1000_SLAVE_GEMNOC_MODEM_CNOC, QDU1000_SLAVE_MEM_NOC_PCIE_SNOC
> +	},
> +};
> +
> +
> +static struct qcom_icc_node qnm_ecpri_dma = {
> +	.name = "qnm_ecpri_dma",
> +	.id = QDU1000_MASTER_GEMNOC_ECPRI_DMA,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node qnm_fec_2_gemnoc = {
> +	.name = "qnm_fec_2_gemnoc",
> +	.id = QDU1000_MASTER_FEC_2_GEMNOC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node qnm_pcie = {
> +	.name = "qnm_pcie",
> +	.id = QDU1000_MASTER_ANOC_PCIE_GEM_NOC,
> +	.channels = 1,
> +	.buswidth = 64,
> +	.num_links = 3,
> +	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC,
> +		   QDU1000_SLAVE_GEMNOC_MODEM_CNOC
> +	},
> +};
> +
> +static struct qcom_icc_node qnm_snoc_gc = {
> +	.name = "qnm_snoc_gc",
> +	.id = QDU1000_MASTER_SNOC_GC_MEM_NOC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node qnm_snoc_sf = {
> +	.name = "qnm_snoc_sf",
> +	.id = QDU1000_MASTER_SNOC_SF_MEM_NOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 4,
> +	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC,
> +		   QDU1000_SLAVE_GEMNOC_MODEM_CNOC, QDU1000_SLAVE_MEM_NOC_PCIE_SNOC
> +	},
> +};
> +
> +static struct qcom_icc_node qxm_mdsp = {
> +	.name = "qxm_mdsp",
> +	.id = QDU1000_MASTER_MSS_PROC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 3,
> +	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC,
> +		   QDU1000_SLAVE_MEM_NOC_PCIE_SNOC
> +	},
> +};
> +
> +static struct qcom_icc_node llcc_mc = {
> +	.name = "llcc_mc",
> +	.id = QDU1000_MASTER_LLCC,
> +	.channels = 8,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_EBI1 },
> +};
> +
> +static struct qcom_icc_node qhm_gic = {
> +	.name = "qhm_gic",
> +	.id = QDU1000_MASTER_GIC_AHB,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node qhm_qdss_bam = {
> +	.name = "qhm_qdss_bam",
> +	.id = QDU1000_MASTER_QDSS_BAM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node qhm_qpic = {
> +	.name = "qhm_qpic",
> +	.id = QDU1000_MASTER_QPIC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qhm_qspi = {
> +	.name = "qhm_qspi",
> +	.id = QDU1000_MASTER_QSPI_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qhm_qup0 = {
> +	.name = "qhm_qup0",
> +	.id = QDU1000_MASTER_QUP_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qhm_qup1 = {
> +	.name = "qhm_qup1",
> +	.id = QDU1000_MASTER_QUP_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qhm_system_noc_cfg = {
> +	.name = "qhm_system_noc_cfg",
> +	.id = QDU1000_MASTER_SNOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_SERVICE_SNOC },
> +};
> +
> +static struct qcom_icc_node qnm_aggre_noc = {
> +	.name = "qnm_aggre_noc",
> +	.id = QDU1000_MASTER_ANOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node qnm_aggre_noc_gsi = {
> +	.name = "qnm_aggre_noc_gsi",
> +	.id = QDU1000_MASTER_ANOC_GSI,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_GC },
> +};
> +
> +static struct qcom_icc_node qnm_gemnoc_cnoc = {
> +	.name = "qnm_gemnoc_cnoc",
> +	.id = QDU1000_MASTER_GEM_NOC_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 36,
> +	.links = { QDU1000_SLAVE_AHB2PHY_SOUTH, QDU1000_SLAVE_AHB2PHY_NORTH,
> +		   QDU1000_SLAVE_AHB2PHY_EAST, QDU1000_SLAVE_AOSS,
> +		   QDU1000_SLAVE_CLK_CTL, QDU1000_SLAVE_RBCPR_CX_CFG,
> +		   QDU1000_SLAVE_RBCPR_MX_CFG, QDU1000_SLAVE_CRYPTO_0_CFG,
> +		   QDU1000_SLAVE_ECPRI_CFG, QDU1000_SLAVE_IMEM_CFG,
> +		   QDU1000_SLAVE_IPC_ROUTER_CFG, QDU1000_SLAVE_CNOC_MSS,
> +		   QDU1000_SLAVE_PCIE_CFG, QDU1000_SLAVE_PDM,
> +		   QDU1000_SLAVE_PIMEM_CFG, QDU1000_SLAVE_PRNG,
> +		   QDU1000_SLAVE_QDSS_CFG, QDU1000_SLAVE_QPIC,
> +		   QDU1000_SLAVE_QSPI_0, QDU1000_SLAVE_QUP_0,
> +		   QDU1000_SLAVE_QUP_1, QDU1000_SLAVE_SDCC_2,
> +		   QDU1000_SLAVE_SMBUS_CFG, QDU1000_SLAVE_SNOC_CFG,
> +		   QDU1000_SLAVE_TCSR, QDU1000_SLAVE_TLMM,
> +		   QDU1000_SLAVE_TME_CFG, QDU1000_SLAVE_TSC_CFG,
> +		   QDU1000_SLAVE_USB3_0, QDU1000_SLAVE_VSENSE_CTRL_CFG,
> +		   QDU1000_SLAVE_DDRSS_CFG, QDU1000_SLAVE_IMEM,
> +		   QDU1000_SLAVE_PIMEM, QDU1000_SLAVE_ETHERNET_SS,
> +		   QDU1000_SLAVE_QDSS_STM, QDU1000_SLAVE_TCU
> +	},
> +};
> +
> +static struct qcom_icc_node qnm_gemnoc_modem_slave = {
> +	.name = "qnm_gemnoc_modem_slave",
> +	.id = QDU1000_MASTER_GEMNOC_MODEM_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_MODEM_OFFLINE },
> +};
> +
> +static struct qcom_icc_node qnm_gemnoc_pcie = {
> +	.name = "qnm_gemnoc_pcie",
> +	.id = QDU1000_MASTER_GEM_NOC_PCIE_SNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_PCIE_0 },
> +};
> +
> +static struct qcom_icc_node qxm_crypto = {
> +	.name = "qxm_crypto",
> +	.id = QDU1000_MASTER_CRYPTO,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qxm_ecpri_gsi = {
> +	.name = "qxm_ecpri_gsi",
> +	.id = QDU1000_MASTER_ECPRI_GSI,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 2,
> +	.links = { QDU1000_SLAVE_ANOC_SNOC_GSI, QDU1000_SLAVE_PCIE_0 },
> +};
> +
> +static struct qcom_icc_node qxm_pimem = {
> +	.name = "qxm_pimem",
> +	.id = QDU1000_MASTER_PIMEM,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_GC },
> +};
> +
> +static struct qcom_icc_node xm_ecpri_dma = {
> +	.name = "xm_ecpri_dma",
> +	.id = QDU1000_MASTER_SNOC_ECPRI_DMA,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { QDU1000_SLAVE_ECPRI_GEMNOC, QDU1000_SLAVE_PCIE_0 },
> +};
> +
> +static struct qcom_icc_node xm_gic = {
> +	.name = "xm_gic",
> +	.id = QDU1000_MASTER_GIC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_GC },
> +};
> +
> +static struct qcom_icc_node xm_pcie = {
> +	.name = "xm_pcie",
> +	.id = QDU1000_MASTER_PCIE,
> +	.channels = 1,
> +	.buswidth = 64,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_ANOC_PCIE_GEM_NOC },
> +};
> +
> +static struct qcom_icc_node xm_qdss_etr0 = {
> +	.name = "xm_qdss_etr0",
> +	.id = QDU1000_MASTER_QDSS_ETR,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node xm_qdss_etr1 = {
> +	.name = "xm_qdss_etr1",
> +	.id = QDU1000_MASTER_QDSS_ETR_1,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node xm_sdc = {
> +	.name = "xm_sdc",
> +	.id = QDU1000_MASTER_SDCC_1,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_usb3 = {
> +	.name = "xm_usb3",
> +	.id = QDU1000_MASTER_USB3,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qup0_core_slave = {
> +	.name = "qup0_core_slave",
> +	.id = QDU1000_SLAVE_QUP_CORE_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qup1_core_slave = {
> +	.name = "qup1_core_slave",
> +	.id = QDU1000_SLAVE_QUP_CORE_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_gem_noc_cnoc = {
> +	.name = "qns_gem_noc_cnoc",
> +	.id = QDU1000_SLAVE_GEM_NOC_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_GEM_NOC_CNOC },
> +};
> +
> +static struct qcom_icc_node qns_llcc = {
> +	.name = "qns_llcc",
> +	.id = QDU1000_SLAVE_LLCC,
> +	.channels = 8,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_LLCC },
> +};
> +
> +static struct qcom_icc_node qns_modem_slave = {
> +	.name = "qns_modem_slave",
> +	.id = QDU1000_SLAVE_GEMNOC_MODEM_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_GEMNOC_MODEM_CNOC },
> +};
> +
> +static struct qcom_icc_node qns_pcie = {
> +	.name = "qns_pcie",
> +	.id = QDU1000_SLAVE_MEM_NOC_PCIE_SNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_GEM_NOC_PCIE_SNOC },
> +};
> +
> +static struct qcom_icc_node ebi = {
> +	.name = "ebi",
> +	.id = QDU1000_SLAVE_EBI1,
> +	.channels = 8,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ahb2phy0_south = {
> +	.name = "qhs_ahb2phy0_south",
> +	.id = QDU1000_SLAVE_AHB2PHY_SOUTH,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ahb2phy1_north = {
> +	.name = "qhs_ahb2phy1_north",
> +	.id = QDU1000_SLAVE_AHB2PHY_NORTH,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ahb2phy2_east = {
> +	.name = "qhs_ahb2phy2_east",
> +	.id = QDU1000_SLAVE_AHB2PHY_EAST,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_aoss = {
> +	.name = "qhs_aoss",
> +	.id = QDU1000_SLAVE_AOSS,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_clk_ctl = {
> +	.name = "qhs_clk_ctl",
> +	.id = QDU1000_SLAVE_CLK_CTL,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_cpr_cx = {
> +	.name = "qhs_cpr_cx",
> +	.id = QDU1000_SLAVE_RBCPR_CX_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_cpr_mx = {
> +	.name = "qhs_cpr_mx",
> +	.id = QDU1000_SLAVE_RBCPR_MX_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_crypto_cfg = {
> +	.name = "qhs_crypto_cfg",
> +	.id = QDU1000_SLAVE_CRYPTO_0_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ecpri_cfg = {
> +	.name = "qhs_ecpri_cfg",
> +	.id = QDU1000_SLAVE_ECPRI_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_imem_cfg = {
> +	.name = "qhs_imem_cfg",
> +	.id = QDU1000_SLAVE_IMEM_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ipc_router = {
> +	.name = "qhs_ipc_router",
> +	.id = QDU1000_SLAVE_IPC_ROUTER_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_mss_cfg = {
> +	.name = "qhs_mss_cfg",
> +	.id = QDU1000_SLAVE_CNOC_MSS,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pcie_cfg = {
> +	.name = "qhs_pcie_cfg",
> +	.id = QDU1000_SLAVE_PCIE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pdm = {
> +	.name = "qhs_pdm",
> +	.id = QDU1000_SLAVE_PDM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pimem_cfg = {
> +	.name = "qhs_pimem_cfg",
> +	.id = QDU1000_SLAVE_PIMEM_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_prng = {
> +	.name = "qhs_prng",
> +	.id = QDU1000_SLAVE_PRNG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qdss_cfg = {
> +	.name = "qhs_qdss_cfg",
> +	.id = QDU1000_SLAVE_QDSS_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qpic = {
> +	.name = "qhs_qpic",
> +	.id = QDU1000_SLAVE_QPIC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qspi = {
> +	.name = "qhs_qspi",
> +	.id = QDU1000_SLAVE_QSPI_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qup0 = {
> +	.name = "qhs_qup0",
> +	.id = QDU1000_SLAVE_QUP_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qup1 = {
> +	.name = "qhs_qup1",
> +	.id = QDU1000_SLAVE_QUP_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_sdc2 = {
> +	.name = "qhs_sdc2",
> +	.id = QDU1000_SLAVE_SDCC_2,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_smbus_cfg = {
> +	.name = "qhs_smbus_cfg",
> +	.id = QDU1000_SLAVE_SMBUS_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_system_noc_cfg = {
> +	.name = "qhs_system_noc_cfg",
> +	.id = QDU1000_SLAVE_SNOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_SNOC_CFG },
> +};
> +
> +static struct qcom_icc_node qhs_tcsr = {
> +	.name = "qhs_tcsr",
> +	.id = QDU1000_SLAVE_TCSR,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_tlmm = {
> +	.name = "qhs_tlmm",
> +	.id = QDU1000_SLAVE_TLMM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_tme_cfg = {
> +	.name = "qhs_tme_cfg",
> +	.id = QDU1000_SLAVE_TME_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_tsc_cfg = {
> +	.name = "qhs_tsc_cfg",
> +	.id = QDU1000_SLAVE_TSC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_usb3 = {
> +	.name = "qhs_usb3",
> +	.id = QDU1000_SLAVE_USB3_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
> +	.name = "qhs_vsense_ctrl_cfg",
> +	.id = QDU1000_SLAVE_VSENSE_CTRL_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_a1noc_snoc = {
> +	.name = "qns_a1noc_snoc",
> +	.id = QDU1000_SLAVE_A1NOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_ANOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qns_anoc_snoc_gsi = {
> +	.name = "qns_anoc_snoc_gsi",
> +	.id = QDU1000_SLAVE_ANOC_SNOC_GSI,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_ANOC_GSI },
> +};
> +
> +static struct qcom_icc_node qns_ddrss_cfg = {
> +	.name = "qns_ddrss_cfg",
> +	.id = QDU1000_SLAVE_DDRSS_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_ecpri_gemnoc = {
> +	.name = "qns_ecpri_gemnoc",
> +	.id = QDU1000_SLAVE_ECPRI_GEMNOC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_GEMNOC_ECPRI_DMA },
> +};
> +
> +static struct qcom_icc_node qns_gemnoc_gc = {
> +	.name = "qns_gemnoc_gc",
> +	.id = QDU1000_SLAVE_SNOC_GEM_NOC_GC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_SNOC_GC_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qns_gemnoc_sf = {
> +	.name = "qns_gemnoc_sf",
> +	.id = QDU1000_SLAVE_SNOC_GEM_NOC_SF,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_SNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qns_modem = {
> +	.name = "qns_modem",
> +	.id = QDU1000_SLAVE_MODEM_OFFLINE,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_pcie_gemnoc = {
> +	.name = "qns_pcie_gemnoc",
> +	.id = QDU1000_SLAVE_ANOC_PCIE_GEM_NOC,
> +	.channels = 1,
> +	.buswidth = 64,
> +	.num_links = 1,
> +	.links = { QDU1000_MASTER_ANOC_PCIE_GEM_NOC },
> +};
> +
> +static struct qcom_icc_node qxs_imem = {
> +	.name = "qxs_imem",
> +	.id = QDU1000_SLAVE_IMEM,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qxs_pimem = {
> +	.name = "qxs_pimem",
> +	.id = QDU1000_SLAVE_PIMEM,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node srvc_system_noc = {
> +	.name = "srvc_system_noc",
> +	.id = QDU1000_SLAVE_SERVICE_SNOC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node xs_ethernet_ss = {
> +	.name = "xs_ethernet_ss",
> +	.id = QDU1000_SLAVE_ETHERNET_SS,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node xs_pcie = {
> +	.name = "xs_pcie",
> +	.id = QDU1000_SLAVE_PCIE_0,
> +	.channels = 1,
> +	.buswidth = 64,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node xs_qdss_stm = {
> +	.name = "xs_qdss_stm",
> +	.id = QDU1000_SLAVE_QDSS_STM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node xs_sys_tcu_cfg = {
> +	.name = "xs_sys_tcu_cfg",
> +	.id = QDU1000_SLAVE_TCU,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_bcm bcm_acv = {
> +	.name = "ACV",
> +	.num_nodes = 1,
> +	.nodes = { &ebi },
> +};
> +
> +static struct qcom_icc_bcm bcm_ce0 = {
> +	.name = "CE0",
> +	.num_nodes = 1,
> +	.nodes = { &qxm_crypto },
> +};
> +
> +static struct qcom_icc_bcm bcm_cn0 = {
> +	.name = "CN0",
> +	.num_nodes = 44,
> +	.nodes = { &qhm_qpic, &qhm_qspi,
> +		   &qnm_gemnoc_cnoc, &qnm_gemnoc_modem_slave,
> +		   &qnm_gemnoc_pcie, &xm_sdc,
> +		   &xm_usb3, &qhs_ahb2phy0_south,
> +		   &qhs_ahb2phy1_north, &qhs_ahb2phy2_east,
> +		   &qhs_aoss, &qhs_clk_ctl,
> +		   &qhs_cpr_cx, &qhs_cpr_mx,
> +		   &qhs_crypto_cfg, &qhs_ecpri_cfg,
> +		   &qhs_imem_cfg, &qhs_ipc_router,
> +		   &qhs_mss_cfg, &qhs_pcie_cfg,
> +		   &qhs_pdm, &qhs_pimem_cfg,
> +		   &qhs_prng, &qhs_qdss_cfg,
> +		   &qhs_qpic, &qhs_qspi,
> +		   &qhs_qup0, &qhs_qup1,
> +		   &qhs_sdc2, &qhs_smbus_cfg,
> +		   &qhs_system_noc_cfg, &qhs_tcsr,
> +		   &qhs_tlmm, &qhs_tme_cfg,
> +		   &qhs_tsc_cfg, &qhs_usb3,
> +		   &qhs_vsense_ctrl_cfg, &qns_ddrss_cfg,
> +		   &qns_modem, &qxs_imem,
> +		   &qxs_pimem, &xs_ethernet_ss,
> +		   &xs_qdss_stm, &xs_sys_tcu_cfg
> +	},
> +};
> +
> +static struct qcom_icc_bcm bcm_mc0 = {
> +	.name = "MC0",
> +	.num_nodes = 1,
> +	.nodes = { &ebi },
> +};
> +
> +static struct qcom_icc_bcm bcm_qup0 = {
> +	.name = "QUP0",
> +	.num_nodes = 2,
> +	.nodes = { &qup0_core_slave, &qup1_core_slave },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh0 = {
> +	.name = "SH0",
> +	.num_nodes = 1,
> +	.nodes = { &qns_llcc },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh1 = {
> +	.name = "SH1",
> +	.num_nodes = 11,
> +	.nodes = { &alm_sys_tcu, &chm_apps,
> +		   &qnm_ecpri_dma, &qnm_fec_2_gemnoc,
> +		   &qnm_pcie, &qnm_snoc_gc,
> +		   &qnm_snoc_sf, &qxm_mdsp,
> +		   &qns_gem_noc_cnoc, &qns_modem_slave,
> +		   &qns_pcie
> +	},
> +};
> +
> +static struct qcom_icc_bcm bcm_sn0 = {
> +	.name = "SN0",
> +	.num_nodes = 1,
> +	.nodes = { &qns_gemnoc_sf },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn1 = {
> +	.name = "SN1",
> +	.num_nodes = 6,
> +	.nodes = { &qhm_gic, &qxm_pimem,
> +		   &xm_gic, &xm_qdss_etr0,
> +		   &xm_qdss_etr1, &qns_gemnoc_gc
> +	},
> +};
> +
> +static struct qcom_icc_bcm bcm_sn2 = {
> +	.name = "SN2",
> +	.num_nodes = 5,
> +	.nodes = { &qnm_aggre_noc, &qxm_ecpri_gsi,
> +		   &xm_ecpri_dma, &qns_anoc_snoc_gsi,
> +		   &qns_ecpri_gemnoc
> +	},
> +};
> +
> +static struct qcom_icc_bcm bcm_sn7 = {
> +	.name = "SN7",
> +	.num_nodes = 2,
> +	.nodes = { &qns_pcie_gemnoc, &xs_pcie },
> +};
> +
> +static struct qcom_icc_bcm *clk_virt_bcms[] = {
> +	&bcm_qup0,
> +};
> +
> +static struct qcom_icc_node *clk_virt_nodes[] = {

This is array of const pointers, isn't it?

> +	[MASTER_QUP_CORE_0] = &qup0_core_master,
> +	[MASTER_QUP_CORE_1] = &qup1_core_master,
> +	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
> +	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
> +};
> +
> +static struct qcom_icc_desc qdu1000_clk_virt = {

This is const, isn't it?

Please base your work on some existing, new and updated sources, not
some old stuff. You are otherwise repeating same issues... Basing on
downstream code is also wrong choice.


Best regards,
Krzysztof

