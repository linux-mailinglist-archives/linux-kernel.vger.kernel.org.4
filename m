Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C37C662F67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjAISnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjAISm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:42:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820BFAA;
        Mon,  9 Jan 2023 10:42:57 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309HSAYx023069;
        Mon, 9 Jan 2023 18:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NCv2WqPMa69lj81BskxdmvW2mVd28UyK0NGD6E3f7TM=;
 b=LGq51nCtJEEFh7i17EfVs+gco1M2XnZU0BwKX+wosrCcjDTSPUHv++ehH4WCNmbEwTlT
 DW667gKs6JsYqHLYsEUglItwajNQ0C0lO9XR2WOWUySXfGcqISSvRb70Fh9BPg/9/Ay8
 7gbz/Rwjv/2p1VMIPeNuz5YeA4LEjDhusS1UOd9aXAZ5ZSNuvRF/jUzouxNlLrSZmfLk
 sFrX3cT2jOQWFBOi1WAmXhKoJotFm7Im0r2jaCPhh66X4wolfUo/dH4fCST2FNM7sxHI
 bA0BwOUDq2rznjuB7+dvb69TQg6GFArTJx6IKBwfB1Y/ipH9jvvW/kr4BSrO50hGL8i8 Uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my1wu3r26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 18:42:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309Igs2T030757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 18:42:54 GMT
Received: from [10.110.108.111] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 10:42:53 -0800
Message-ID: <14568b67-91bc-5ed3-e887-41e265993033@quicinc.com>
Date:   Mon, 9 Jan 2023 10:42:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Out-of-tree devfreq governor header
Content-Language: en-US
From:   John Moon <quic_johmoo@quicinc.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <ccooper@quicinc.com>, <mkrom@qti.qualcomm.com>,
        <quic_tsoni@quicinc.com>
References: <58121e22-a992-e8c8-2add-e3279be25185@quicinc.com>
In-Reply-To: <58121e22-a992-e8c8-2add-e3279be25185@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WqWrkr8bLXnE-4Kzt0y9cvS62xZ94sa8
X-Proofpoint-GUID: WqWrkr8bLXnE-4Kzt0y9cvS62xZ94sa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_12,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1031 mlxscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090133
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing CC list. Apologies!

On 1/9/2023 10:30 AM, John Moon wrote:
> Hi all,
> 
> We have an out-of-tree devfreq governor which uses the "governor.h" 
> header from "drivers/devfreq". The source code for the governor is 
> public on CodeLinaro [1].
> 
> Currently, the driver directly includes the "governor.h" header even 
> though it's not a public header. A comment at the top of "governor.h" 
> says explicitly: "This header is for devfreq governors in 
> drivers/devfreq/".
> 
> Could you please advise the best way to use this private devfreq header 
> from an out-of-tree governor? Could we move the header into 
> "include/linux"?
> 
> [1]: 
> https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-kernel/-/blob/gfx-kernel.lnx.1.0.r3-rel/governor_msm_adreno_tz.c#L20
> 
> Thanks,
> John
