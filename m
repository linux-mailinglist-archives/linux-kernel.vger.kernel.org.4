Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8B675F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjATVN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjATVN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:13:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B9D8A4C;
        Fri, 20 Jan 2023 13:13:26 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KKhonO019470;
        Fri, 20 Jan 2023 21:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zq62gIvYUOYZp0PNrvkd+owZCAJA9jgIYgDD39UMtkg=;
 b=Sjjr6Q44OLoaSU9CxyMV9AtrdiUa+4/D5a8CVr+zC0E31T7mbKc/IGl2LnaKFAKgFBYO
 4ympxxfXOYUCR8+jZ0uh3lAtOaJMo9b6r866FxSXlIZaTPs25RMwDOEzdA6hAIxUy3Fn
 /n69ojdC1JN7/DxtiZ5bG0NNDRYSedmkye3uLKNmQDd6nZxpvK06AN5GjZ6EkbzNGLZs
 d7YGc2gO40q0dC45Wblarin0f+gbe4tMxFexRMvxq0tUFYiLNsPusX8fTiBI3ezbSboE
 ymMQZGL4pyUgWLbzDNEs9VY4hksRDC6YPtDlmTMUWyVWFGpDpQOloks/dFFoh4B2EjL6 ZQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7yc60cga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 21:13:17 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KLDHJ0009059
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 21:13:17 GMT
Received: from [10.110.31.254] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 20 Jan
 2023 13:13:16 -0800
Message-ID: <f709f410-f21b-b2e7-4e76-04b15fb2001a@quicinc.com>
Date:   Fri, 20 Jan 2023 13:13:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 0/2] Add base device tree files for QDU1000/QRU1000
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230112210722.6234-1-quic_molvera@quicinc.com>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20230112210722.6234-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oms45SBvs9RnGgrpTBNy5zskWvfLaBrE
X-Proofpoint-ORIG-GUID: oms45SBvs9RnGgrpTBNy5zskWvfLaBrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=751 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200202
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone review these patches please?

Thanks,
Melody

On 1/12/2023 1:07 PM, Melody Olvera wrote:
> This series adds the base device tree files and DTS support for the
> Qualcomm QDU1000 and QRU1000 IDP SoCs, including the clocks, tlmm, smmu,
> regulators, mmc, interconnects, cpufreq, and qup. 
>
> This patchset requires the dt-bindings changes from [1-3].
>
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
>
> [1] https://lore.kernel.org/all/20221216231426.24760-1-quic_molvera@quicinc.com/
> [2] https://lore.kernel.org/all/20230112204446.30236-1-quic_molvera@quicinc.com/
> [3] https://lore.kernel.org/all/20230112203653.23139-1-quic_molvera@quicinc.com/
>
> Changes from v5:
> - Moved XYZ-names fields under XYZ fields
> - Removed irrelevant comments
> - Updated ordering of some fields
> - Removed unneeded fields
> - Revised style on clocks and interrupts
>
> Changes from v4:
> - Added chassis-type
> - Added missing regulator voltages
> - Sorted includes
> - Remaned memory nodes
> - Reorganized nodes to start with compatible/reg
> - Removed unnecessary clocks
> - Switched to deleting nodes by label
> - Moved pin biases and drive strengths to dts files
>
> Changes from v3:
> - added PCIE and USB clocks
> - added missing qdu1000 compats
>
> Changes from v2:
> - Revised device nodes to match updated dt-bindings
> - Revised rpmh-rsc bindings to allow for generic regulator nodes
> - Updated soc ordering
> - Moved clock node to DTS files
> - Updated regulator nodes to be generic
> - Removed some unnecessary whitespace
>
> Melody Olvera (2):
>   arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
>   arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
>
>  arch/arm64/boot/dts/qcom/Makefile        |    2 +
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  453 ++++++++
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 1333 ++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts |  453 ++++++++
>  arch/arm64/boot/dts/qcom/qru1000.dtsi    |   26 +
>  5 files changed, 2267 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>
>
> base-commit: 0a093b2893c711d82622a9ab27da4f1172821336
> prerequisite-patch-id: d439ef85a730c7b736ed8c63162e24c7ae661b60
> prerequisite-patch-id: c55ff1a38fed5356caa8f40a85ef0b8ebc4d1fa4
> prerequisite-patch-id: 984e8570d2464f4027dc59294c10f47e7ae29a84

