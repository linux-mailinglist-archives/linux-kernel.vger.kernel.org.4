Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48150718D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjEaVzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEaVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:55:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F156107;
        Wed, 31 May 2023 14:55:17 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKkfUY022062;
        Wed, 31 May 2023 21:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6Q1COm6KJ0jDab7WP/lBk+W/nicQvcv4h6J0db+PS+8=;
 b=G1eCPF9L6InKVaZ6T3LvKiOhNLfOBd9fXkFjOjTWO7/BIqBSL3X50fBb+lXR6X0DOHVc
 1y9SjTq4lpCkrGqCEcYVdYZ3eXwDlkUcpmQYxeN1AUhL1JFmC5yspMWPwFOlBpEU5GfT
 UOE/+k1xg41QqCs7p69KpN1xD4XCSxbvsVeyhd7DxXKRa47tINUm90MFEdWKvgVCZMwN
 ariWvIVRiWXU0n+u0l+yZIIQSECdhKt5Nt3VKSW6BDSNAqp4opfdwQD6mrufPq6ZpuuM
 inK0oDYcgTiIWLLwzsBzNViDLPdgkGm8X+349q5Npb/0ufvKQw3/E/VI1Y2jlsvSfYRj 5g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx5pxhb28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:35:26 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VLZPIr016756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:35:25 GMT
Received: from [10.110.35.28] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 14:35:23 -0700
Message-ID: <63da3282-6a94-3807-b23f-73c4c6111936@quicinc.com>
Date:   Wed, 31 May 2023 14:35:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 0/2] Patches for introducing traces in remoteproc.
Content-Language: en-US
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
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <cover.1685486994.git.quic_gokukris@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GJCAFlYxv2Kcr4ymPC2I_eKKbqwG6-NT
X-Proofpoint-ORIG-GUID: GJCAFlYxv2Kcr4ymPC2I_eKKbqwG6-NT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=825
 lowpriorityscore=0 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310181
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2023 2:28 PM, Gokul krishna Krishnakumar wrote:
> V4: Add config symbol REMOTEPROC_TRACEPOINTS to enable traces
>      Rename rproc_qcom.h to remoteproc_tracepoints.h
>      Rename qcom_tracepoints.c to remoteproc_tracepoints.c
>      Switch to EXPORT_SYMBOL_GPL


Any reasons you have not sent these patches to mailing list?

> 
> V3: Split the Patch to 2 as per suggestion from Mukesh, fixed format
> error from v2.
> 
> V2: Moved the traces to common code from the qcom_pas driver as per
> Bjorns review, fixed text as per Triloks suggestion, Updated QuiC
> copyright to 2023.
> 
> [1]: https://lore.kernel.org/all/20230224165142.17745-2-quic_gokukris@quicinc.com/
> 
> Gokul krishna Krishnakumar (2):
>    remoteproc: Introduce traces for remoteproc events
>    remoteproc: qcom: Add remoteproc tracing
> 
>   drivers/remoteproc/Kconfig                    |   5 +
>   drivers/remoteproc/Makefile                   |   1 +
>   drivers/remoteproc/qcom_common.c              |  37 +++++
>   drivers/remoteproc/qcom_q6v5.c                |   9 ++
>   drivers/remoteproc/remoteproc_core.c          |   8 ++
>   drivers/remoteproc/remoteproc_tracepoints.c   |  13 ++
>   include/trace/events/remoteproc_tracepoints.h | 129 ++++++++++++++++++
>   7 files changed, 202 insertions(+)
>   create mode 100644 drivers/remoteproc/remoteproc_tracepoints.c
>   create mode 100644 include/trace/events/remoteproc_tracepoints.h
> 
