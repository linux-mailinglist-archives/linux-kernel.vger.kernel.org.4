Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE970E24B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbjEWQn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbjEWQnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:43:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D5A1BC;
        Tue, 23 May 2023 09:43:08 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDtYL6018995;
        Tue, 23 May 2023 16:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UyU0NaYg2TWIK438erc3k0fiHwEV3fW9ea3MjHTrpdU=;
 b=lrzz/UD9rJtFeGObDsL4riRDmZ3/nfxCSbfMBWhlGstRquZFy7RvquoI+9IxnPK7DFSa
 QNxe1MA/mhRcdChH/lnBh+sxyRzTj+req9TYrlBi8K0CLRh5erCLripivzsq0H9rg7Wb
 RkSbW+Kt1hm+M7F/zwFfgPjSyjjgBGRg/8lzGkFBOmpHPT5iGnpPVfPjvEarYCoEnsAg
 y4N1XYkH0p98W7zh67BiUT/NUHkc5g4E1a5/ygkuUiXvYgBgZpUkXdUrDbm1OP/WdQkT
 XzQBuCKaFZ6NZ5b/7Y8SGbl38dPk1/9cSZs/Nq+1YoZfhRWRSjN3fde9tNCc3WnnjMio eA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr8qrbe0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 16:43:07 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34NGh7A6006346
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 16:43:07 GMT
Received: from [10.110.35.41] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 09:43:06 -0700
Message-ID: <a13a29d7-124d-e580-ece1-04c891b92479@quicinc.com>
Date:   Tue, 23 May 2023 09:43:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] MAINTAINERS: Add Carl/Pranjal as QAIC reviewers
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, <quic_pkanojiy@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20230523161421.11017-1-quic_jhugo@quicinc.com>
From:   Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20230523161421.11017-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BBJzV4jPzhbnAvIrPxoIBgNg7DdisYYJ
X-Proofpoint-ORIG-GUID: BBJzV4jPzhbnAvIrPxoIBgNg7DdisYYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230133
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2023 9:14 AM, Jeffrey Hugo wrote:
> Carl and Pranjal have been reviewing the QAIC patches.  List them as
> reviewers so that they are copied on all developments which will make
> it easier for them to continue reviewing QAIC patches.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..a0ec9ee090a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17381,6 +17381,8 @@ F:	include/dt-bindings/clock/qcom,*
>   
>   QUALCOMM CLOUD AI (QAIC) DRIVER
>   M:	Jeffrey Hugo <quic_jhugo@quicinc.com>
> +R:	Carl Vanderlip <quic_carlv@quicinc.com>
> +R:	Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
>   L:	linux-arm-msm@vger.kernel.org
>   L:	dri-devel@lists.freedesktop.org
>   S:	Supported

ACK
