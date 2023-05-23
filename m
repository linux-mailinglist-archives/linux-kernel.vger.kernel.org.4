Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FC70E126
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbjEWP5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjEWP47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:56:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D70318B;
        Tue, 23 May 2023 08:56:55 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NFhBoY006556;
        Tue, 23 May 2023 15:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JkG0jJwY+HNo45imlfDWQJek8azwevKvDQrgTSX7ZYM=;
 b=hhVXYzrmvPLPAPgS8my5XdZb+scNNBY4IZFwNxcqV32/WpksCJRnIKPkETZUwc/jlLAN
 EMKroHfb2k49/I5hBwa+izU2+BE/B9D5D6C5WR9EBWT9srYv9A9TOOcaGwVg2C8q1dzw
 NDk0/hBTC6uH/dqd/8U0Rl9CSTjjpJiLStR35BoitlOTI9cX9qaerRFA3ZQhH7A9YRPZ
 49MXEeuyDPZ7HA9/hLnim2Z3hbeowbQ9fafEjs5Rvz/rITlk5ubFNqNsEhxrqIyi3dbF
 M3x8clX4bfGPleo72ou+mSc/ODtEU054Tv8i0Dov1qo65ufhAPZJvaLNwTrRXZ2HnTrS LQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrpmm1qhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 15:56:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34NFuaAC002143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 15:56:36 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 08:56:35 -0700
Message-ID: <71a6c04a-7ad8-97cd-b629-ce5f779d4578@quicinc.com>
Date:   Tue, 23 May 2023 09:56:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/5] accel/qaic fixes for 6.4
Content-Language: en-US
To:     <ogabbay@kernel.org>, <jacek.lawrynowicz@linux.intel.com>,
        <quic_pkanojiy@quicinc.com>, <stanislaw.gruszka@linux.intel.com>,
        <quic_carlv@quicinc.com>, <quic_ajitpals@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20230517193540.14323-1-quic_jhugo@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230517193540.14323-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xp7u_f0JiqGFAlVxjC2IzoXcJ49S19Z1
X-Proofpoint-GUID: Xp7u_f0JiqGFAlVxjC2IzoXcJ49S19Z1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230126
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2023 1:35 PM, Jeffrey Hugo wrote:
> During development of new features, we noticed some spots in the code that
> could be improved based on review feedback from the initial driver series.
> 
> Also two race condition fixes, one found during stress testing and another
> via code inspection.
> 
> Jeffrey Hugo (1):
>    accel/qaic: Fix NNC message corruption
> 
> Pranjal Ramajor Asha Kanojiya (4):
>    accel/qaic: Validate user data before grabbing any lock
>    accel/qaic: Validate if BO is sliced before slicing
>    accel/qaic: Flush the transfer list again
>    accel/qaic: Grab ch_lock during QAIC_ATTACH_SLICE_BO
> 
>   drivers/accel/qaic/qaic_control.c | 41 ++++++++------
>   drivers/accel/qaic/qaic_data.c    | 91 +++++++++++++++----------------
>   2 files changed, 70 insertions(+), 62 deletions(-)
> 

Pushed to drm-misc-fixes
