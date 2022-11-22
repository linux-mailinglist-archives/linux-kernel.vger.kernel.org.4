Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E8E633A14
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiKVK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiKVK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:28:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD505C773;
        Tue, 22 Nov 2022 02:24:24 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AM9YSti030893;
        Tue, 22 Nov 2022 10:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jPXGyVfaNK8Q3j8+d5AjYsIGzf5B5ksvgQ59ZOxQExQ=;
 b=WSdUvomdWsMdDAOf/DPAwF9lCJn67WjccIiHngj93iguyhgPZ3VO7RrrkWsB4L51iYXG
 RCPU/5XFR4dl3xvhfetXh/azMu9YZRP2LTMlZpVm0BE2c0QstgL0+3GBiwYMnP5o1Paj
 /W/2wwzQtUUrXuS0UghVAflDBpeqckSYDhQmBoYs21bN+/PC1URquXxt9neFcOVmdgRE
 PdgPFXlGMX56d22k22V+TFkbTvilKsX5Bn58vNziDFh+8J5y6Ez/3CJEcWl7EvUxCxSv
 wZRC4BvkksEkXSgeKWRiJWy8X/sh19xY+faqb6BgwdaPtyJixb4Ky4IAbr6zhnes9RTW tA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrac6nwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 10:24:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AMAOJBL017331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 10:24:19 GMT
Received: from [10.216.39.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 22 Nov
 2022 02:24:15 -0800
Message-ID: <4ac5d0be-e9c0-9eb3-8691-9759ed49d0f5@quicinc.com>
Date:   Tue, 22 Nov 2022 15:54:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>
References: <20221122094921.23109-1-quic_rjendra@quicinc.com>
 <e0fb4c60-3c84-cc52-b6ca-6ed081bb36ef@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <e0fb4c60-3c84-cc52-b6ca-6ed081bb36ef@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mWjY_bp3SWgHFXE6-LxDIThALpxQHoz2
X-Proofpoint-ORIG-GUID: mWjY_bp3SWgHFXE6-LxDIThALpxQHoz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=730 adultscore=0 clxscore=1015
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/2022 3:34 PM, Krzysztof Kozlowski wrote:
> On 22/11/2022 10:49, Rajendra Nayak wrote:
>> Add compatibles for the Pro SKU of the sc7280 CRD boards
>> which come with a Pro variant of the qcard.
>> The Pro qcard variant has smps9 from pm8350c ganged up with
>> smps7 and smps8.
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
> 
> What changed? It's v3 so there should be a changelog here. Same for patch 2.

sorry forgot to mention, no change for this patch, only PATCH 2/2 had some
minor nits fixed based on feedback from Matthias.

> 
> Best regards,
> Krzysztof
> 
