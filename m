Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFC68E80C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBHGJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHGJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:09:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440063C2AC;
        Tue,  7 Feb 2023 22:09:22 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3185dvVc032726;
        Wed, 8 Feb 2023 06:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C876TZIIxAKzAAhsnriSnxWWg4V33lQLM2PjsHjnBiA=;
 b=OkdK1e9L0jAp/S5SztO2WXJyrsbIQjXsQmbjQCB/VzUB65rbN97vS1L6VdAsxmJgSD6M
 tM/yjfX/96fupbuzqfLBKjw6fzabylE/+vTwzx4AOI3atWqQTh8qqgO3xQCeW8VLMQ5r
 OhLloBtr26x7dgUcMTjg4u0/WZKwM6RofP1P9883wwoNI0VV8ufBibUCFKCzcGkVzgAY
 /Tu4n70rOYlSohCPxI8v0+jsKCug764Z0kUtwbsRKNonAbuvt5G1dF4Hv1u6gmFJLtNE
 q8bUmVBhl9pflkAxHHzs4bMRG0iVYmMwK5qmuD5B4/eMx4QsscgMvM1ROxdtxaUto2k9 zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkfesbeep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 06:09:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31869Hfd029968
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 06:09:17 GMT
Received: from [10.50.23.208] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 22:09:12 -0800
Message-ID: <df04b28e-3f2b-cac8-0990-55c7026b0fae@quicinc.com>
Date:   Wed, 8 Feb 2023 11:39:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: (subset) [PATCH 0/6] Add regulator support for IPQ9574 SoC
To:     Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <167572263442.3569822.4527590282812934469.b4-ty@kernel.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <167572263442.3569822.4527590282812934469.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Lym2p6nNKShWn54W0OLsArNKfTKlJoIE
X-Proofpoint-ORIG-GUID: Lym2p6nNKShWn54W0OLsArNKfTKlJoIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_02,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 mlxlogscore=895 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080054
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2023 4:00 AM, Bjorn Andersson wrote:
> On Fri, 13 Jan 2023 20:33:04 +0530, devi priya wrote:
>> IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator is used for
>> APSS voltage scaling.
>> This patch series adds the support for the same.
>> Also enables the RPM communication over the RPMSG framework
>>
>> This series depends on the below patchset
>> https://lore.kernel.org/linux-arm-msm/20230113143647.14961-1-quic_devipriy@quicinc.com/
>>
>> [...]
> 
> Applied, thanks!
> 
Thanks Bjorn!

> [1/6] soc: qcom: smd-rpm: Add IPQ9574 compatible
>        commit: 64dc69f3f36a71a95bfed8054d49600a7872415e
> 
> Best regards,
Regards,
Devi Priya
