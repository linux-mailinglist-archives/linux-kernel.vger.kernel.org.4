Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7664656DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiL0S3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiL0S31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:29:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800A5B84F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 10:29:26 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRFv5jk002157;
        Tue, 27 Dec 2022 18:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+v3e7a1zliKsDV1q/rqzmquSG93OGIaKXSrzYuaYnLk=;
 b=Zbin1VVgbusvd8ESpjlNfD9jjVJHkW9A93WifwzSC2uqknIwwtk6sZpLYRqWc17n+bcn
 Lo/84NwAfD6lsi/bq90wehePJ1O5lV5F3i1VSJoWNp33qI/t8NI0WY4MEwp9dE5rB9wz
 OZfxtuM4dpGKyF/i0O0/9NHxOAEL4TdomFbDuo7uJ110CBS6SsVwOGAcPHDVetC2nNIk
 JUf1xTSBauns1SHgZaIhxZSQcTv+BbNK9L9ec88BTZ4+jxp6ZL9NW8j7uPjNx8kim/vM
 KgKwj6qQuPRwpaC9G5XJ5J8McTsK1BTPTAlFymQvCvSVMRQIdQndemIwE7tFiDRNnomp 6g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnpsvnye1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 18:29:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRITKuR024391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 18:29:20 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 10:29:20 -0800
Message-ID: <5db3ee62-d864-1eb7-65c3-21e86037cbe0@quicinc.com>
Date:   Tue, 27 Dec 2022 11:29:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] habanalabs/uapi: move uapi file to drm
Content-Language: en-US
To:     Oded Gabbay <ogabbay@kernel.org>, <airlied@gmail.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20221226213227.26953-1-ogabbay@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20221226213227.26953-1-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5mIBXYwb4-UDmRbD_TN4nRX5CZALFMvT
X-Proofpoint-ORIG-GUID: 5mIBXYwb4-UDmRbD_TN4nRX5CZALFMvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_13,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=869 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270152
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/2022 2:32 PM, Oded Gabbay wrote:
> Move the habanalabs.h uapi file from include/uapi/misc to
> include/uapi/drm, and rename it to habanalabs_accel.h.
> 
> This is required before moving the actual driver to the accel
> subsystem.
> 
> Update MAINTAINERS file accordingly.
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

This would impact the hl-thunk project at 
https://github.com/HabanaAI/hl-thunk as the open userspace, right?  I 
don't appear to see corresponding changes there.  Is there a dev branch 
I'm missing?

-Jeff
