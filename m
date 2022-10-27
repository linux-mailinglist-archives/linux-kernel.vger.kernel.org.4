Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C98610471
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiJ0Vb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiJ0Vb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:31:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF786A53F;
        Thu, 27 Oct 2022 14:31:25 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RLSjqx030206;
        Thu, 27 Oct 2022 21:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0SJxsD87sf1OuymdeyD/l4za5tDm5KeqnBGxkxHAamM=;
 b=lxf3yZkVNCj6oWNHr6w7k1CZvsG8mrmZbh0F4zB9bh+wTEaaw4zY4E7yrQkIwB0OturL
 XwZFJnW8JMaUdX/EHvGE9RL9c0szVsdj49JANH3YpwfzWTUADDYuDDHJFgotvM+GfXca
 2C506+glrhQYuInf8ywCaMM8Sy8nzl4VWhO3TrOAEivIdMYSlqQyo5584iyr5izGqN6w
 1a+XCmslRPHja4KbYQreeQ/5aiBwtAw8O6t0Z6r7et0oL1YRtrIx/1iNz09L/wMed7Zb
 ESlBwYWHaA3bOVr56dz2oXESsATw5Au0coyyFx1T6+oRigcAwprcaQwXKN/b9ksKGDXC pQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahvu93f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 21:31:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29RLV9gq010715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 21:31:09 GMT
Received: from [10.110.41.43] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 14:31:08 -0700
Message-ID: <eeb3e06d-316a-1ff8-b4b8-c257fa03a206@quicinc.com>
Date:   Thu, 27 Oct 2022 14:31:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 5/5] dt-bindings: qcom,pdc: Introduce pdc bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-6-quic_molvera@quicinc.com>
 <20221027182240.E9FA0C433D6@smtp.kernel.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221027182240.E9FA0C433D6@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V2pSb2kE3eoOllPWGZHIZe95bOh0M6Bt
X-Proofpoint-ORIG-GUID: V2pSb2kE3eoOllPWGZHIZe95bOh0M6Bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=852
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270120
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 11:22 AM, Stephen Boyd wrote:
> Quoting Melody Olvera (2022-10-26 12:04:41)
>> Add compatible fields for QDU1000 and QRU1000 pdcs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
> Is there a reason why this patch continues to be included in what is
> otherwise a clk driver patch series? Can this patch be sent separately
> from the clk patches (and not Cced to clk maintainers/list) in the
> future?
Sure thing. On reflection, this belongs with the misc support patches.

Thanks,
Melody
