Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40234718D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjEaVvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEaVvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:51:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC0A3;
        Wed, 31 May 2023 14:51:47 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VL0Sdx014433;
        Wed, 31 May 2023 21:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yXNtQRlaIL4d/6KaiA3+rAZC/B5MC9YxcSX99PDLnng=;
 b=L70aKK2IGslqlEMF0ZGQ379PUQCjySyLDJwG9c7weV10RmeBHvsL3uetDSA6e3u846fH
 +7ASjaXA7uRGTAYdvSFakm4bMGBukK4VppYa+g9gx1l9Iu6s/vyFZcBxaSxndMfyaXt8
 pCalxF72/UqYxwho/pf/aGs/aU8Drwu+bJGqjU2rM+PYsuFUc1MWBWqPGKYUt0bT0eEQ
 Kn53b6M/i/VEOjSi9pAKq+D5dpqEWLlNepjrOYqqpcUUvhlDLTnxOYJsaHIejWo0SHb1
 ULAwe8D2tvv7+qO2xFwznPrff0qA7st0QL+ca3vyl0+ouY7NNTEGk/mlKfZKgr4LfwI7 2w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxdr982gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:51:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VLpg5U006982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:51:42 GMT
Received: from [10.110.35.28] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 14:51:41 -0700
Message-ID: <b332eaf8-2528-ad71-9118-6627bf9ab7c1@quicinc.com>
Date:   Wed, 31 May 2023 14:51:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/2] remoteproc: Introduce traces for remoteproc events
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
 <5c1744bc362fbc80615349f12c18c8ab5c4f0a6e.1685486994.git.quic_gokukris@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <5c1744bc362fbc80615349f12c18c8ab5c4f0a6e.1685486994.git.quic_gokukris@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _DakvxT1BperZx-W9-9ONP7AN6NH_n1V
X-Proofpoint-GUID: _DakvxT1BperZx-W9-9ONP7AN6NH_n1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=812 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310184
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
> Adding Traces for the following remoteproc events:
> 	rproc_subdev_event,
> 	rproc_interrupt_event,
> 	rproc_load_event,
> 	rproc_start_event,
> 	rproc_stop_event
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>   drivers/remoteproc/Kconfig                    |   5 +
>   drivers/remoteproc/Makefile                   |   1 +
>   drivers/remoteproc/remoteproc_tracepoints.c   |  13 ++
>   include/trace/events/remoteproc_tracepoints.h | 129 ++++++++++++++++++
>   4 files changed, 148 insertions(+)
>   create mode 100644 drivers/remoteproc/remoteproc_tracepoints.c
>   create mode 100644 include/trace/events/remoteproc_tracepoints.h
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index a850e9f486dd..2ef4f527f1c1 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -365,6 +365,11 @@ config XLNX_R5_REMOTEPROC
>   
>   	  It's safe to say N if not interested in using RPU r5f cores.
>   
> +config REMOTEPROC_TRACEPOINTS
> +	bool "Support for Remote Processor subsystem traces"
> +	help
> +	  Say y to add traces to the remoteproc events.

More information here please. What information these traces provide? How 
they can be useful to developers? More text will always be helpful.

---Trilok Soni
