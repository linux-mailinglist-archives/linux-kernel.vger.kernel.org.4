Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F496B0D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCHPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjCHPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:40:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE2D5F6D4;
        Wed,  8 Mar 2023 07:39:53 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328CkOQ7024262;
        Wed, 8 Mar 2023 15:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wsMjISGOQQMRy1FfKaAzLdVqMOJ5UvtspiE3r+kEdRw=;
 b=QCXYR0nHC79J8J7Xrf/zW9fB9zRjkwCTA2goDWvtym/Xto7NozTIJ9r4+f4KM+mjfA2F
 Tmpub8XbjNVR/j9mtgCx3DCewt1T/jSBSm1W1A5GjEzVU61BhTraKsFUuu+bZTsppIkj
 2vAuWZmnN+bejLnWjHKOAei5OpSzenApM4+CVfmRS6c6eTr45Zhcgr4SzhvRiCg6S29P
 SQgMX/oMNQmVQ5to8EMtsLqiKmv8LnRtqQsxneO8GQ9PJxxj8Yg821brRJOroUg2cUec
 hbpiKN7ehTUItx1JW9tGSueVg7G78A2U8t6KjMXBjuJWQI8++WQ1AgrR08io0CL1620R Rg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fgft2cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:39:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328FdOtp025042
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 15:39:24 GMT
Received: from [10.50.21.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 07:39:16 -0800
Message-ID: <ab803e21-76bf-308c-9df0-8b7b45b472b2@quicinc.com>
Date:   Wed, 8 Mar 2023 21:09:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V6 7/9] dt-bindings: firmware: qcom,scm: document IPQ5332
 SCM
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <dmitry.baryshkov@linaro.org>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230307062232.4889-1-quic_kathirav@quicinc.com>
 <20230307062232.4889-8-quic_kathirav@quicinc.com>
 <754a2d38-dd7b-48b6-80e5-683ca193e0b1@linaro.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <754a2d38-dd7b-48b6-80e5-683ca193e0b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5qu3b1LRn2GCRGTi8U7WtYPrUuzDIKJo
X-Proofpoint-ORIG-GUID: 5qu3b1LRn2GCRGTi8U7WtYPrUuzDIKJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=973
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/2023 4:31 PM, Konrad Dybcio wrote:
>
> On 7.03.2023 07:22, Kathiravan T wrote:
>> Document the compatible for IPQ5332 SCM.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
> Does this board not have a crypto engine / CE1 clock exposed via
> RPMCC? It will be enabled by default, but Linux should be aware
> of it, so that we don't gate it by accident.


IPQ5332 doesn't have the crypto engine and also it doesn't have RPMCC. 
Sorry, could you please help to explain how it is related to SCM?

Thanks, Kathiravan T.
