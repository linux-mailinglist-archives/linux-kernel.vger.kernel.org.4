Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68206718E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjEaWLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjEaWLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:11:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B993C1B5;
        Wed, 31 May 2023 15:10:48 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKj72G000593;
        Wed, 31 May 2023 21:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VHOFkZmblWbnnte6Y9rr/Bw7ZQSwWuV9SYToKy4yhYk=;
 b=I8Yob7XSzmy/PgayxsQPOvqmCGJilWGsC79i16tvgn2XGMKBzsWkwuXd3A/bQzdUibUN
 Xfi6OHiLo7PjAydsFp0obOUl48H7ev4VDaPJZRrk9zBfkrvksB/kBNvcIIwbPBPyieQV
 g0CfWZkRRo1WiLsMxG32T8Pw8/h8bcaelXKc3ToMqmU3qp6cIw7ptHnBI2QQPjY3FmPo
 L/YZGxlH/X7V7juTGfwJ6NjsU44b5mG6Fig6q9bUbBQMXJDc/naDiFYg3F/8hantqcmH
 xphjOAaIahvqEdJ7aDwQFAoevV2nM3eoULnn4UnE2bAsU/WuEhs+cW7zkbkJAOUCZXUQ LA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxbt8g9g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:36:17 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VLaGKJ004352
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:36:16 GMT
Received: from [10.110.35.28] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 14:36:15 -0700
Message-ID: <f69b6e5c-e6d6-b575-9e9c-6516a3dfe5e8@quicinc.com>
Date:   Wed, 31 May 2023 14:36:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 0/2] Patches for introducing traces in remoteproc.
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <cover.1685486994.git.quic_gokukris@quicinc.com>
 <63da3282-6a94-3807-b23f-73c4c6111936@quicinc.com>
In-Reply-To: <63da3282-6a94-3807-b23f-73c4c6111936@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HEmNJ8YFqFBAtYT02VMBgeuYs23V1euu
X-Proofpoint-ORIG-GUID: HEmNJ8YFqFBAtYT02VMBgeuYs23V1euu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=669
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310181
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2023 2:35 PM, Trilok Soni wrote:
> On 5/31/2023 2:28 PM, Gokul krishna Krishnakumar wrote:
>> V4: Add config symbol REMOTEPROC_TRACEPOINTS to enable traces
>>      Rename rproc_qcom.h to remoteproc_tracepoints.h
>>      Rename qcom_tracepoints.c to remoteproc_tracepoints.c
>>      Switch to EXPORT_SYMBOL_GPL
> 
> 
> Any reasons you have not sent these patches to mailing list?

I don't see linux-arm-msm mailing list. Are you CCing all the required 
lists and maintainers?

---Trilok Soni
