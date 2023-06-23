Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EEA73B4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjFWKJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjFWKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:09:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADEC35AB;
        Fri, 23 Jun 2023 03:07:56 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N8TPLV026918;
        Fri, 23 Jun 2023 10:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zFqDMo7rpGAKhiEeRRQPX26218zJTZHgRvQDvL6TtYk=;
 b=oxZre7cmiwcf61z+uEjxcpoYwvOa/fOEqQdjyS09V+BjQ8aJIC4NJZxiYG+Ghy4aHjgp
 Bw4XHIUbO2K+DowgKssXvpTIUud+F31S6nHReZEnG0WhwtMAF/Jq39LCCH1VZBb8P1Ho
 buFHDHjB+yLIjhT8G8uvuoFExPv4Wofur62+haCNqmEbxI4bTzmLUUybAajXQDLi4DWP
 +1y56shWrfYHBbQq0hwNJhzPb1NCxh3MwB9hjiExPXHmVksUXO9ypC2oTl4KoLWEa7mG
 HCdhmuaL48MS6sZtpRDPdjwWF2rt1/fNG+l8gLz0wwoUkHxyTmXdCkCfJbcI13oO9uzu qg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc0sk5bkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:07:36 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NA7Z12014884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:07:35 GMT
Received: from [10.218.48.111] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 03:07:30 -0700
Message-ID: <84281f9f-18a3-2cd0-cb48-8cd64ae3391b@quicinc.com>
Date:   Fri, 23 Jun 2023 15:37:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] Update GCC clocks for QDU1000 and QRU1000 SoCs
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Melody Olvera <quic_molvera@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230616104941.921555-1-quic_imrashai@quicinc.com>
 <c963cc67-5c8d-4503-af0e-082ee0be8688@linaro.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <c963cc67-5c8d-4503-af0e-082ee0be8688@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8usBRA1Tp4urOLNEpEm55H2t7K_RWPa-
X-Proofpoint-ORIG-GUID: 8usBRA1Tp4urOLNEpEm55H2t7K_RWPa-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230090
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2023 4:51 PM, Konrad Dybcio wrote:
> On 16.06.2023 12:49, Imran Shaik wrote:
>> Update GCC clocks and add support for GDSCs for QDU1000 and QRU1000 SoCs.
>> Also, add support for v2 variant as well.
> Does that imply the first submission concerned v1/pre-mass-production chips?
> 
> We usually don't support these upstream, as they are rather short-lived and
> never (officially, anyway) escape Qualcomm internal..
> 
> Konrad

Sure, will update the next series to support only the latest hardware 
version.

Thanks,
Imran

>>
>> Imran Shaik (2):
>>    dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
>>    clk: qcom: gcc-qdu1000: Update GCC clocks and add support for GDSCs
>>
>>   .../bindings/clock/qcom,qdu1000-gcc.yaml      |   6 +-
>>   drivers/clk/qcom/gcc-qdu1000.c                | 162 ++++++++++++------
>>   include/dt-bindings/clock/qcom,qdu1000-gcc.h  |   4 +-
>>   3 files changed, 118 insertions(+), 54 deletions(-)
>>
