Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C8704A04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjEPKGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjEPKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:06:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D730F1;
        Tue, 16 May 2023 03:06:39 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G6M7hK009174;
        Tue, 16 May 2023 10:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9h0jmH84R2TaYymrs4MYfVGew85BHcwc0i5WV14Zc7c=;
 b=mfWui5iIyAgdJGcMyk4GReQHFMUVueU68FfRCJ4cpYSg76w9wBzqufHJTt3ZHmUswJU7
 VjAniv33dAsvu1SMTdV8lDWDTNYxMiry+1W1ZRBMuGiag5zyIBtnJaP143hc5zgimn9U
 XKQAMPIYOrGzVx5jFfpd4sXg3q2efJ+92ewm9hy6osCP2weku8mph+t0/ksUDS1iWzQC
 2oSR03LSCLWzhfWZCtb7gW/8ajwOyHtZkB9Q7lecWlPociVjtS+GlfS2not05/LvnOEC
 TWWcQl5yvsC5vxWpp4WFYhagRuVJ2mM4cEx5hEv/8ifj+CVDG2A2kohJFfPEMyHx2vUZ +w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qm1x08nrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 10:06:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GA6ToM021109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 10:06:29 GMT
Received: from [10.50.13.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 03:06:24 -0700
Message-ID: <75a408c2-3d41-95a3-5c48-a68c84ba4f57@quicinc.com>
Date:   Tue, 16 May 2023 15:36:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 0/6] Incremental patches on minimal boot support
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230425084010.15581-1-quic_devipriy@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230425084010.15581-1-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: quoBuvkMU_D9C7LoeVvqY0lCkq1ELWBS
X-Proofpoint-GUID: quoBuvkMU_D9C7LoeVvqY0lCkq1ELWBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160085
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/2023 2:10 PM, Devi Priya wrote:
> Patchset V9 of the series: Add minimal boot support for IPQ9574 has been
> merged and is available in linux-next/master.
> V12 being the latest revision posted in the series, the delta between
> revisions V9 and V12 is posted as a separate series as suggested by
> Bjorn to avoid possible confusions.
> 
> This series adds the delta changes between revisions V9 and V12.
> 
> V9 can be found at:
> https://lore.kernel.org/linux-arm-msm/20230316072940.29137-1-quic_devipriy@quicinc.com/
> 
> V12 can be found at:
> https://lore.kernel.org/linux-arm-msm/20230410135948.11970-1-quic_devipriy@quicinc.com/
> 
> Changes in V3:
> 	- Detailed change logs are added to the respective patches.
> 
> Changes in V2:
> https://lore.kernel.org/linux-arm-msm/20230417053355.25691-1-quic_devipriy@quicinc.com/
> 	- Updated the subject & commit message of [PATCH V2 1/4]
> 	- No changes were made to any other patches
> 
> Changes in V1:
> 	- The Delta between V9 & V12 is added to the change log of
> 	  the respective patches for quick reference
> 
Gentle reminder!

Thanks,
Devi Priya

> Devi Priya (6):
>    arm64: dts: qcom: ipq9574: Update the size of GICC & GICV regions
>    dt-bindings: clock: qcom,ipq9574-gcc: Add maintainer
>    clk: qcom: gcc-ipq9574: Clean up included headers
>    clk: qcom: gcc-ipq9574: constify struct clk_init_data
>    arm64: dts: qcom: ipq9574: Drop bias_pll_ubi_nc_clk input
>    arm64: dts: qcom: ipq9574: rename al02-c7 dts to rdp433
> 
>   .../bindings/clock/qcom,ipq9574-gcc.yaml      |   1 +
>   arch/arm64/boot/dts/qcom/Makefile             |   2 +-
>   ...ipq9574-al02-c7.dts => ipq9574-rdp433.dts} |   2 +-
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  14 +-
>   drivers/clk/qcom/gcc-ipq9574.c                | 434 +++++++++---------
>   5 files changed, 224 insertions(+), 229 deletions(-)
>   rename arch/arm64/boot/dts/qcom/{ipq9574-al02-c7.dts => ipq9574-rdp433.dts} (97%)
> 
