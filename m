Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA07413E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjF1Ocv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:32:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:11160 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbjF1Ocl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:32:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBEeoH026308;
        Wed, 28 Jun 2023 14:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W7WnL8mgHuMiFaub7gEfEGkF/nZF/hE5lIKpRJEdEjY=;
 b=gKRjO4/6SGMS8/6q6UZiww5JA600Q14Ao08rtvNKK2jkQ3uxHoSMOF8CiEDubvnfbNRF
 vx9fh8EJ7pVird/8mFFxShypEZgjoQi/OenLd8kBk72KRHrT1dTU7KUPg8pdOzMvDoT7
 Vyp2btEbHNScPTmXNB0F913cQ2LiQcqbKUvFmjGoBAc+XGEjS7UAf2NLZoupkPoezvfU
 kbKyf7+aKf1c+Lb9a1AxXje9e7/BzVMJzd6rwQ8j46aZAA/xHlHKnZPJEBZG+Vg18LCI
 2vll5l4Ae/pmgxGcw5V6/t3hH4Kk+zhqMQwq0KgsebvEXUXuYu19KqfGtbrAIHvCYiBv dw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgemk15dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 14:32:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SEWMCj000945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 14:32:22 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Wed, 28 Jun
 2023 07:32:14 -0700
Message-ID: <c3a6a217-dc5c-4814-1d32-c951f2f92495@quicinc.com>
Date:   Wed, 28 Jun 2023 08:32:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v12 00/10] (no cover subject)
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Robert Marko <robimarko@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7VLS1VKQlhiTuDoTyXT8FpSL2LgcIDiN
X-Proofpoint-ORIG-GUID: 7VLS1VKQlhiTuDoTyXT8FpSL2LgcIDiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/2023 8:00 AM, Konrad Dybcio wrote:
> Changes in v12:
> - Add the !independent! patch to block cpufreq-dt from probing on 8998 (it tries
>    to when we attach OPP tables to the CPU nodes)
> - Include all promised changes to the CPR3 driver from v11 (I managed to
>    send the wrong version of that patch last time around..)
> - Partially rewrite debugfs code (to make it work and be cleaner)
> - use FIELD_PREP/GET throughout the driver (managed to squash a bug when
>    exploring that)
> - Fix and finish the removal of cpr_get_ro_factor() by introducing
>    cpr_thread_desc.ro_scaling_factor_common
> - Replace underscores in node names with '-'
> - Fix some formatstring issues that clang apparently doesn't care about
> - Link to v11: https://lore.kernel.org/r/20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org
> 
> Add support for Core Power Reduction v3, v4 and Hardened
> 
> Changes in v11:
> 
> CPR COMMON:
> - split the commonizing patch, make it actually do what it says on the
>    tin..
> - fix some overflow bugs
> 
> CPR3:
> - fix some overflow bugs
> - don't assume "lack of qcom,opp-?loop-vadj" means val=0"
> 
> CPR BINDINGS:
> - drop quotes in items
> - drop clock-names (there's just a single one)
> - rewrite the description a bit
> - fix up the example
> - drop bogus minItems
> - "acc-syscon" -> "qcom,acc"
> 
> DTS:
> - fix qfprom children so that the bits=<> doesn't overflow reg[size]
> - drop unrelated changes
> - place one reg entry per line
> 
> Link to v10: https://lore.kernel.org/r/20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org
> 
> Changes in v10:
> - Skip "Let qcom,opp-fuse-level be a 2-long array" (Applied by Viresh)
> - Use b4 (it may be the first time you're receiving this if git send-email
>    omitted you before..)
> - +Cc Robert Marko (expressed interest in previous revisions)
> - Add "Document CPR3 open/closed loop volt adjustment"
> CPR:
> - %hhu -> %u (checkpatch)
> CPR BINDINGS:
> - Drop QCS404 fuse set (it doesn't use this driver, what did I even think..)
>    but leave the allOf:if: block for expansion (sdm660, msm8996, ipqABCD should
>    follow soon..)
> - Drop Rob's R-b (as things changed *again*, please take one more look to make
>    sure you're okay with this file, Rob..)
> 
> Link to v9:
> https://lore.kernel.org/linux-arm-msm/20230116093845.72621-1-konrad.dybcio@linaro.org/
> 
> Changes in v9:
> - Restore forgotten MAINTAINERS patch (oops)
> CPR:
> - Include the missing header (big oops!)
> - Fix kconfig dependencies
> CPR bindings:
> - Fix cpu reg in example (why didn't dt_binding_check scream at that)
> - Add newlines between nodes in example
> - Change opp table node names to opp-table-cpu[04]
> - Change opp table labels to cpu[04]_opp_table
> - Change CPRh opp subnode names to opp-N from oppN
> - Remove some stray newlines
> - Bring back nvmem-cell-names and add the 8998's set
> - Allow power-domains for VDDCX_AO voting
> - Remove Rob's r-b, there's been quite a bit of changes..
> CPR DT:
> - Send the correct revision of the patch this time around..
> OPP bindings:
> - Add Rob's ack
> 
> Link to v8:
> https://lore.kernel.org/linux-arm-msm/20230110175605.1240188-1-konrad.dybcio@linaro.org/
> 
> Changes in v8:
> - Overtake this series from AGdR
> - Apply all review comments from v7 except Vladimir's request to
>    not create the include/ header; it will be strictly necessary for
>    OSM-aware cpufreq_hw programming, which this series was more or
>    less created just for..
> - Drop QCS404 dtsi change, account for not breaking backwards compat
>    in [3/5]
> - Add type phandle type reference to acc-syscon in [1/5]
> - Update AGdR's email addresses for maintainer entries
> - Add [2/5] to make dt_binding_check happy
> - Separate the CPRh DT addition from cpufreq_hw addition, sort and
>    properly indent new nodes
> - Drop CPR yaml conversion, that happened in meantime
> - Reorder the patches to make a bit more sense
> - Tested again on MSM8998 Xperia XZ Premium (Maple)
> - I take no responsibility for AGdR's cheeky jokes, only the code!
> 
> Link to v7:
> https://lore.kernel.org/lkml/20210901155735.629282-1-angelogioacchino.delregno@somainline.org/
> 
> Changes in v7:
> - Rebased on linux-next as of 210901
> - Changed cpr_read_efuse calls to nvmem_cell_read_variable_le_u32,
>    following what was done in commit c77634b9d916
> 
> Changes in v6:
> - Fixes from Bjorn's review
> - After a conversation with Viresh, it turned out I was abusing the
>    OPP API to pass the APM and MEM-ACC thresholds to qcom-cpufreq-hw,
>    so now the driver is using the genpd created virtual device and
>    passing drvdata instead to stop the abuse
> - Since the CPR commonization was ignored for more than 6 months,
>    it is now included in the CPRv3/4/h series, as there is no point
>    in commonizing without having this driver
> - Rebased on v5.13
> 
> Changes in v5:
> - Fixed getting OPP table when not yet installed by the caller
>    of power domain attachment
> 
> Changes in v4:
> - Huge patch series has been split for better reviewability,
>    as suggested by Bjorn
> 
> Changes in v3:
> - Fixed YAML doc issues
> - Removed unused variables and redundant if branch
> 
> Changes in v2:
> - Implemented dynamic Memory Accelerator corners support, needed
>    by MSM8998
> - Added MSM8998 Silver/Gold parameters
> 
> This commit introduces a new driver, based on the one for cpr v1,
> to enable support for the newer Qualcomm Core Power Reduction
> hardware, known downstream as CPR3, CPR4 and CPRh, and support
> for MSM8998 and SDM630 CPU power reduction.
> 
> In these new versions of the hardware, support for various new
> features was introduced, including voltage reduction for the GPU,
> security hardening and a new way of controlling CPU DVFS,
> consisting in internal communication between microcontrollers,
> specifically the CPR-Hardened and the Operating State Manager.
> 
> The CPR v3, v4 and CPRh are present in a broad range of SoCs,
> from the mid-range to the high end ones including, but not limited
> to, MSM8953/8996/8998, SDM630/636/660/845.
> 
> As to clarify, SDM845 does the CPR/SAW/OSM setup in TZ firmware, but
> this is limited to the CPU context; despite GPU CPR support being not
> implemented in this series, it is planned for the future, and some
> SDM845 need the CPR (in the context of GPU CPR) to be configured from
> this driver.
> 
> It is also planned to add the CPR data for MSM8996, since this driver
> does support the CPRv4 found on that SoC, but I currently have no time
> to properly test that on a real device, so I prefer getting this big
> implementation merged before adding more things on top.
> 
> As for MSM8953, we (read: nobody from SoMainline) have no device with
> this chip: since we are unable to test the cpr data and the entire
> driver on that one, we currently have no plans to do this addition
> in the future. This is left to other nice developers: I'm sure that
> somebody will come up with that, sooner or later
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> AngeloGioacchino Del Regno (8):
>        cpufreq: blacklist MSM8998 in cpufreq-dt-platdev
>        MAINTAINERS: Add entry for Qualcomm CPRv3/v4/Hardened driver
>        dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
>        soc: qcom: cpr: Move common functions to new file
>        soc: qcom: cpr-common: Add support for flat fuse adjustment
>        soc: qcom: cpr-common: Add threads support
>        soc: qcom: Add support for Core Power Reduction v3, v4 and Hardened
>        arm64: dts: qcom: msm8998: Configure CPRh
> 
> Konrad Dybcio (2):
>        dt-bindings: opp: v2-qcom-level: Document CPR3 open/closed loop volt adjustment
>        soc: qcom: cpr: Use u64 for frequency
> 
>   .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   14 +
>   .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    |  289 ++
>   MAINTAINERS                                        |    6 +
>   arch/arm64/boot/dts/qcom/msm8998.dtsi              |  757 ++++++
>   drivers/cpufreq/cpufreq-dt-platdev.c               |    1 +
>   drivers/soc/qcom/Kconfig                           |   22 +
>   drivers/soc/qcom/Makefile                          |    2 +
>   drivers/soc/qcom/cpr-common.c                      |  362 +++
>   drivers/soc/qcom/cpr-common.h                      |  109 +
>   drivers/soc/qcom/cpr.c                             |  394 +--
>   drivers/soc/qcom/cpr3.c                            | 2855 ++++++++++++++++++++
>   include/soc/qcom/cpr.h                             |   17 +
>   12 files changed, 4460 insertions(+), 368 deletions(-)
> ---
> base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
> change-id: 20230217-topic-cpr3h-de232bfb47ec
> 
> Best regards,

Tested on the Lenovo Miix 630 (8998).  No issues observed.

Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
