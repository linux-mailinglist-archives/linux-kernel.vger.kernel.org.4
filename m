Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7387499F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjGFKyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjGFKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:54:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E71BEE;
        Thu,  6 Jul 2023 03:54:00 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366AEbnF009506;
        Thu, 6 Jul 2023 10:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ih7z/Q3fMAtR53Mtzle7zDTJoHNfuUSl0vXeUw7jgYU=;
 b=gd2ie4l13tYVmQCY14f/kHEyzC22nbeMngbMIwFu2FFkMebuCBzscM4fQJbThc7yNNgF
 D/5YNK3xefTIxIkPKbbEYVzPLQ2ekvB7x/hLZshkV+siUTvXTWnum5UmkdyMPkzyiw27
 cHwBbX9Cs+HTwvdk1zGSllnvxUCzxePBxo/n6bzfUqrEOnyHXiZ56fELHjowkNEweE42
 NouD7WPFfaWyl37OEnSLo3qby92dnt1uCkUhM48b+duSdo6YxQe60/F0tDVL0zs4wkAd
 mSMb/MG97grdHgNgeM+e91xTCvIJwwYdW1lRQcuPdEkOIB1MxybeLFh69+9bY3f8HalT Lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rndvp1h49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 10:53:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366Arrot027853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 10:53:53 GMT
Received: from [10.216.13.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 03:53:49 -0700
Message-ID: <b994f92c-331b-ca64-01ec-ec285fb2a76e@quicinc.com>
Date:   Thu, 6 Jul 2023 16:23:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] dt-bindings: power: rpmpd: Remove the SoC specific
 entries
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688635218-23779-2-git-send-email-quic_rohiagar@quicinc.com>
 <318ab229-f29f-e6aa-16b8-79fa09013794@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <318ab229-f29f-e6aa-16b8-79fa09013794@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wiILH_ZUYwFX2d_LZY08-VzG9Bv0OXRm
X-Proofpoint-GUID: wiILH_ZUYwFX2d_LZY08-VzG9Bv0OXRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=555
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060096
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/2023 4:15 PM, Krzysztof Kozlowski wrote:
> On 06/07/2023 11:20, Rohit Agarwal wrote:
>> Remove the SoC specific entries and add a generic set of defines
>> that can be used by all the SoCs. This will remove the duplicate
>> entries among SoCs.
>> The arrangement of the defines is done according to the frequency
>> used in SoC specific entries in the driver to avoid wastage of
>> memory.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Please compile kernel with this commit and tell us what is wrong... Even
> if bindings were not an ABI, but they are, this would not work.
Do you mean that individually this commit would fail compilation?
Yes, we would need all the patches together for compilation to be 
successful.
Sorry for this mistake. Will keep in mind from next time.

Thanks,
Rohit.
> Best regards,
> Krzysztof
>
