Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030BB67B671
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbjAYP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjAYP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:56:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F94511154;
        Wed, 25 Jan 2023 07:56:15 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PDaHPb003861;
        Wed, 25 Jan 2023 15:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=K4VENOAaeiW6kNzq+vuIJFNkf2nAt63m7drjWWR5KtI=;
 b=Jfa/gI5l5O8xry+49Hcz8Tk/9kr77VYv8+dje8FX/EcAZ4lPkqxaDNZUl83u5EV7Jyph
 Bca4dVhb4zCYGqfRV3cIrHcGruK2jt+nKyfshqtasiFqGz0fBdtchYt2nvBJXDejk9eU
 5IUKOeIGPTBuGg5h8rPrvfR4HHKOzuJKXNrtloCCEzKKZ4RYgn96P8fUlxIhz2EFtGx7
 oIy5oDHY9AWCJuZ88MIo4G2YyoqNJ5xUGLS9HszWi3/nCvtRYDAtGI8VxJaMVcTGQHE2
 su6bIZlu3lkC+IEwUj2RmLW5nzAQ8xEyxsQZgJjmwfrywIid8YhP+yAgdh5Lc2YCg3Bk MQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb2nsrh6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 15:55:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PFtx76023028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 15:55:59 GMT
Received: from [10.50.43.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 07:55:50 -0800
Message-ID: <29c2e17f-9e53-f428-2df2-bc728ace49fe@quicinc.com>
Date:   Wed, 25 Jan 2023 21:25:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 07/10] dt-bindings: firmware: document IPQ5332 SCM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-8-quic_kathirav@quicinc.com>
 <455eb061-ed59-2783-b8d6-7276e7103d3f@linaro.org>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <455eb061-ed59-2783-b8d6-7276e7103d3f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3_tHdniqflTXvGeukAd0H5MpuhBwA0Px
X-Proofpoint-GUID: 3_tHdniqflTXvGeukAd0H5MpuhBwA0Px
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_09,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250142
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2023 4:46 PM, Krzysztof Kozlowski wrote:
> On 25/01/2023 11:45, Kathiravan Thirumoorthy wrote:
>> From: Kathiravan T <quic_kathirav@quicinc.com>
>>
>> Document the compatible for IPQ5332 SCM.
> Subject:
> dt-bindings: firmware: qcom,scm:


Thanks for the review, will fix it in V2.


>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
> Best regards,
> Krzysztof


Thanks,

Kathiravan T.

