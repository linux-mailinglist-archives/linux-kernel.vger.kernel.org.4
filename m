Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00E6684CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbjALU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbjALUz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:55:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA2E39F81;
        Thu, 12 Jan 2023 12:41:16 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CKeFex032281;
        Thu, 12 Jan 2023 20:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m0Jpw6X01y8WCQSENtUfrEshuGcSgnSenFJ8vlvXkic=;
 b=H1jqZn8roY0IcZjjF7wvVipYgtkvG5jFhmaDLjyCGL4nNehziZIEJUrvqkKzxn+H+5Zt
 vmgAGutGMgzcWY7MgBXbLKLd3mg24G6e9lKUBfVsK/oxEQ3datWsfzL+3lo67psnoEl4
 s9PFDXUIHyjSLZJdlN/j2xmX/G9r5RAi9zGhm8P0+eV/TCFCR+jZt9+NoPb3co6u16/B
 EVAu9v1JdfQ0vJTtc0javdH2QCqvhsNUcjuz78NS9O9HxMoMftJx3MI5D5YeAa0yNRIK
 HR62JMotSRdceUp/emvhYWKi+yBZ4eTQfgWpHzreX/SU2IWARk5GLS1SLoj6UyTG3zE+ nQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kxhn0hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 20:41:12 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CKfCQs003185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 20:41:12 GMT
Received: from [10.110.92.106] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 12 Jan
 2023 12:41:11 -0800
Message-ID: <cdb3404c-85f4-13b0-901b-7db55f6242af@quicinc.com>
Date:   Thu, 12 Jan 2023 12:41:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6] dt-bindings: soc: qcom,rpmh-rsc: Update to allow for
 generic nodes
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230112203653.23139-1-quic_molvera@quicinc.com>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20230112203653.23139-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S7yvHVDbdea5i6S7FEPHaOmHunE-FrCe
X-Proofpoint-ORIG-GUID: S7yvHVDbdea5i6S7FEPHaOmHunE-FrCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=899
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120147
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2023 12:36 PM, Melody Olvera wrote:
> Update the bindings to allow for generic regulator nodes instead of
> device-specific node names.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
Apologies; forgot the change log.


Changes from v5:
* Fixed buggy regulator pattern to include 0-9

Changes from v4:
* updated regulator pattern to accommodate more regulators

This patch comes from discussions on [1] and is separated out. It also
has updated pattern matching to match the comments left from [1].

[1] https://lore.kernel.org/all/20221026200429.162212-2-quic_molvera@quicinc.com/

> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> index b246500d3d5d..a4046ba60846 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> @@ -112,8 +112,9 @@ properties:
>      $ref: /schemas/power/qcom,rpmpd.yaml#
>  
>  patternProperties:
> -  '-regulators$':
> +  '^regulators(-[0-9])?$':
>      $ref: /schemas/regulator/qcom,rpmh-regulator.yaml#
> +    unevaluatedProperties: false
>  
>  required:
>    - compatible
>
> base-commit: 0a093b2893c711d82622a9ab27da4f1172821336

