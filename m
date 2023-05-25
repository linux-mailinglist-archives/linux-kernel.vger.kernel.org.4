Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACEB710A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbjEYKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjEYKt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:49:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749810B;
        Thu, 25 May 2023 03:49:27 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P8BAuF011797;
        Thu, 25 May 2023 10:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2mS2U45kr5JMTtsJZuoWbB1M4W7I9XKqCsB0vzkHquM=;
 b=QXeBNJ92k81MhkVeYy8RAs1q9dceo6J++1Mc1K5nFb2OYYIeX3Yco0OPpFDpyQhJnvrg
 8VFDfIT/K+bp05mfBhN+tf7eIfntjO0PZ6zxUQAAZ74MLT8WnKbUnx/sLI4jUfMN4XeP
 yKcdUNqkWHwrmFuk5VkknCa4vguDzVb1VGbnN/ZD2N4piGfmDFQ6s34mWWELW2N4C08d
 gn1Q4KXOYN0i9UyboDVoCWb++522MYF1P44UQQabA0223R26UAnu58x9U2GJN5F/f+9V
 IVsX1GyfZLS+RFvleJd+xfIKcMCo8+bUcBd0kPDD/0uJ1veX9qUlQVj3BbfF9zSXxbD5 lA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsp509ysj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 10:49:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PAnMcK010598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 10:49:22 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 03:49:17 -0700
Message-ID: <8432dd81-6015-7839-1d9b-a80b350e2720@quicinc.com>
Date:   Thu, 25 May 2023 16:19:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: (subset) [PATCH V3 0/6] Incremental patches on minimal boot
 support
To:     Bjorn Andersson <andersson@kernel.org>, <agross@kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Devi Priya <quic_devipriy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>
CC:     <quic_arajkuma@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230425084010.15581-1-quic_devipriy@quicinc.com>
 <168454808161.2842337.17993685425906614863.b4-ty@kernel.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <168454808161.2842337.17993685425906614863.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lwXRw80Lx-NjGTHodCHPvVJFFzJ_e93_
X-Proofpoint-ORIG-GUID: lwXRw80Lx-NjGTHodCHPvVJFFzJ_e93_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250089
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/20/2023 7:31 AM, Bjorn Andersson wrote:
> On Tue, 25 Apr 2023 14:10:04 +0530, Devi Priya wrote:
>> Patchset V9 of the series: Add minimal boot support for IPQ9574 has been
>> merged and is available in linux-next/master.
>> V12 being the latest revision posted in the series, the delta between
>> revisions V9 and V12 is posted as a separate series as suggested by
>> Bjorn to avoid possible confusions.
>>
>> This series adds the delta changes between revisions V9 and V12.
>>
>> [...]
> Applied, thanks!
>
> [1/6] arm64: dts: qcom: ipq9574: Update the size of GICC & GICV regions
>        commit: 6fb45762691d12d9812c41d20b2f5db1412047ae
> [5/6] arm64: dts: qcom: ipq9574: Drop bias_pll_ubi_nc_clk input
>        commit: 4fc6a939aba4c0aa723b9da8363d262d3d60e57e
> [6/6] arm64: dts: qcom: ipq9574: rename al02-c7 dts to rdp433
>        (no commit info)


Hi Bjorn,


I don't see the [6/6] in qcom/for-next.  Some part of the below 
change[1] is also missed in qcom/for-next [2], I'm not sure if this is 
because of missing [6/6]. Kindly let me know if I am missing something.

[1] 
https://lore.kernel.org/linux-arm-msm/168499048186.3998961.10536295689489328026.b4-ty@kernel.org/T/#t

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=9ef42640504e09ecc79530b6e532ebf48305516b


Thanks,


>
> Best regards,
