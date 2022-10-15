Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656195FF778
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 02:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJOAEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 20:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJOAEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 20:04:02 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1DF4F3A4;
        Fri, 14 Oct 2022 17:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665792242; x=1697328242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5SDFFFA/FLhrANZV8QudiOYr7nwieAS8bXuy11w3Jeo=;
  b=gxZQre4yUF/sN8vBmJr9VFgwvi5ABYzc9FKC2LGpZJFsxPWkzwvya4RB
   WL0Dv8c5IURhvsPD8XI6Kdw6MSM8HV1Ce/OLJXtCzgnFfgV8e3xB1Z4u3
   Td4P2GlxhjWtJBDfrQH3xMJnAf5WfFurDtL/l//aH2Knb2jXGpYdhlS24
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Oct 2022 17:04:01 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 17:04:01 -0700
Received: from [10.110.77.177] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 17:04:01 -0700
Message-ID: <3ff4d91d-3f85-12bb-e826-f053db662e17@quicinc.com>
Date:   Fri, 14 Oct 2022 17:04:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/3] Add base device tree files for QDU1000/QRU1000
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221014221138.7552-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 3:11 PM, Melody Olvera wrote:
> This series adds the base device tree files and DTS support for the
> Qualcomm QDU1000 and QRU1000 IDP SoCs, including the clocks, tlmm, smmu,
> regulators, mmc, interconnects, cpufreq, and qup. 
>
> This patchset is based off of [1] which adds support for the PMIC arb used
> on these SoCs.
>
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
>
> [1] https://lore.kernel.org/all/20220914165212.3705892-3-vkoul@kernel.org/
Changes from v1:
- squashed dtsi changes and dts changes into one commit each
- changed qdru to qdu and used qru dtsi file for changes from qdu
- removed underscores from node names
- revised idle states and domain idle states
- sorted devices by addr
- removed undocumented fields
- fixed pin functions
- revised regulator node names
>
> Melody Olvera (3):
>   dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
>   arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
>   arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
>
>  .../devicetree/bindings/arm/qcom.yaml         |   16 +
>  arch/arm64/boot/dts/qcom/Makefile             |    2 +
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts      |  230 +++
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi         | 1646 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts      |  230 +++
>  arch/arm64/boot/dts/qcom/qru1000.dtsi         |   27 +
>  6 files changed, 2151 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>
>
> base-commit: dca0a0385a4963145593ba417e1417af88a7c18d
> prerequisite-patch-id: 5e7a02607aecd3f5346a2f450982601cf6935e54

