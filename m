Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30E6860C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjBAHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBAHhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:37:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231118B00;
        Tue, 31 Jan 2023 23:37:40 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3117KSXN022135;
        Wed, 1 Feb 2023 07:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2RT/rhOGg20Q+aPg/QtSGgkYbu9VZL/9P3ketB6kPqk=;
 b=LQ/7qDEhioRLEhoWzz4yPMlBNeYxPXGs2TA//H3FKU7WarSwH4qAm3YdRwdV2wOiDZ/I
 vbE7r2duu/Ykg+T6Jw80F1gBCHgssYjGXuTDjVaTTyOKYW9pVzUn4edxuEJ494/vBVNy
 PiNmFaHCR06z67c6rAZTAbqmglQNG4Jc7fPodMIddY3bl41wFX9eT3Z9zMQm/8XjnTrV
 6uhq56W0/Vr0AaxEjUb6vPsocIK3t34phXhH07j33unuEvKOYLPQK4xo/MFR2Ov+LD1+
 m4YYAHryH474CHy3pfrSBpEnoSrSQj9F1JDNA5JJkd/uAiTctCRfwlmOOqr5mn4z95ji Jw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfkj280ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 07:37:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3117bJ7C002070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 07:37:19 GMT
Received: from [10.216.7.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 23:37:10 -0800
Message-ID: <b716d809-cf9e-dbcc-fe8f-265852bbaa83@quicinc.com>
Date:   Wed, 1 Feb 2023 13:07:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/5] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
CC:     Guru Das Srinagesh <quic_gurus@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230113160012.14893-1-quic_poovendh@quicinc.com>
 <20230113160012.14893-4-quic_poovendh@quicinc.com>
 <20230114011606.GA24659@quicinc.com>
 <659c81b0-b75e-9a6f-bd26-878bb9868397@quicinc.com>
 <Y9QHDXfpAETnCHi9@google.com>
From:   POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
In-Reply-To: <Y9QHDXfpAETnCHi9@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QU5VhwnqqD0-9g7SFJCaGnTzsRmKa2vw
X-Proofpoint-GUID: QU5VhwnqqD0-9g7SFJCaGnTzsRmKa2vw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_03,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=799 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010065
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/27/2023 10:47 PM, Lee Jones wrote:
> On Fri, 27 Jan 2023, POOVENDHAN SELVARAJ wrote:
>
>> On 1/14/2023 6:46 AM, Guru Das Srinagesh wrote:
>>> On Jan 13 2023 21:30, Poovendhan Selvaraj wrote:
>>>> Add support to read-modify-write TCSR register to modify only DLOAD bit.
>>> Could you please add more details on what problem this patch is fixing, and why
>>> this patch is needed?
>>>
>>> CrashDump collection is based on the DLOAD bit of TCSR register. To retain other bits, we read the register and modify only the DLOAD bit as the other bits have their own significance.
>>>
>>> Thank you.
>>>
>>> Guru Das.
>>>
>>> Regards,
>>> Poovendhan S
> Could you please fix your email client.
>
> I have no idea which text is yours, in any of your mails.

Okay, will fix it.

Regards,
Poovendhan S

