Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600885EF112
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiI2I7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiI2I7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:59:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0C13EEB5;
        Thu, 29 Sep 2022 01:59:01 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T61W0O030109;
        Thu, 29 Sep 2022 08:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CE9uFsaxdAEWIB6+EJVZmyz8usrpOD8S2lF/OOKQ+nc=;
 b=OHUX8/5f3aijozNlTk2SazuBw89nzIdL+Q777AceGRuT3i910u7aojtL7WKRIiyqrZRj
 JPoxqLZ3IGiEbCr3BUGJddry17DQ3FAlW48K+kMRItG9+qNAPPxsjgVm0uK8gIurIbcM
 x/pgbErTC7W5fZZHDQx8dr4+H4XH8t9wuMFNw2D/Wzq1I6mkUaRLmuGxERnAGmA+2aGq
 h6m5NkMx2VzfmUdBmNB3a/NCVOYy1mOy3+e5NAW0RMzX1g4uqUSvjs6dQbI0+YZmVFhU
 ZiZp9zquWqv+AYM/Y/pTWHMqvb9cODzCH3a9nnFcm2rGJ5EupuGfYs5SNxa7U3z4QfRY KQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvm75aspb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 08:58:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28T8wqU8009650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 08:58:52 GMT
Received: from [10.216.29.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 01:58:48 -0700
Message-ID: <cc71c6e3-012e-9f26-14a7-6b920434c640@quicinc.com>
Date:   Thu, 29 Sep 2022 14:28:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Update SNPS Phy params for
 SC7280
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1664435628-4011-1-git-send-email-quic_kriskura@quicinc.com>
 <07a62d5a-1241-982b-74ca-04ebadfc9f38@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <07a62d5a-1241-982b-74ca-04ebadfc9f38@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SzKmTd9c1ERMXBMSRPRwa7yOwOgCZEbu
X-Proofpoint-GUID: SzKmTd9c1ERMXBMSRPRwa7yOwOgCZEbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_04,2022-09-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=880 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290054
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2022 1:20 PM, Krzysztof Kozlowski wrote:
> On 29/09/2022 09:13, Krishna Kurapati wrote:
>> Override the SNPS Phy tuning parameters for SC7280 devices. These
>> values are common for both trogdor and herobrine variants.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

  Thanks for the review.

I pushed patch [1] previously for the overriding params for idp 
platform. The first 2 patches of that series are merged. Just wanted to 
request you to ignore the third patch in that series [1] and consider 
this current patch for merging.

[1] : 
https://lore.kernel.org/linux-devicetree/1664435628-4011-1-git-send-email-quic_kriskura@quicinc.com/T/#u

Regards,
Krishna,
