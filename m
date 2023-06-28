Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D242741ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjF1V1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjF1V1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:27:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7B0210E;
        Wed, 28 Jun 2023 14:27:37 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SKvbk6023817;
        Wed, 28 Jun 2023 21:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E3xlbiz/oogAND8NeoIkYwev4is3nvBY4FThkGBj8FE=;
 b=XtVIcGh8VJ6UKsTFvY7ms5HTjqCoAYOSNAy46dOgojaA8RyfcGiJBKpJMEGWvC5wIySk
 TMQAPJevIK0cykkym1sOu0e4XFS1dgRtXFxY36/a/cP3OQ0n4fYCQkN1w4sh+2KPgwyZ
 5Z3yB9mPSB3TApPHLlDUmmMSieYndNKzapbHbe8FlxnOPq2oej0bo9aTlr1s6Eucy2GI
 cYhJw6ckzXOkmh3CDcfSSfLtm8+ENxGCpD9yOVQcTf116i/kGDjHuGGr0Xh33IJicPqz
 Obu2u7ghu5eF+B5iJMoNSNYg/Dpq1n6DTSd5AGUQAYEPWf6XfOjyf7g6Clp+EAykz3QH dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgaxctb4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 21:27:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SLRTeM021207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 21:27:29 GMT
Received: from [10.110.17.251] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Wed, 28 Jun
 2023 14:27:28 -0700
Message-ID: <b1e956cb-431f-197f-09de-7e407faffbf8@quicinc.com>
Date:   Wed, 28 Jun 2023 15:27:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] docs: networking: Update codeaurora references for rmnet
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, <quic_stranche@quicinc.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <andersson@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230628191606.25483-1-quic_jhugo@quicinc.com>
Content-Language: en-US
From:   "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <20230628191606.25483-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _P_HTuEuZSWqggrLcQn07mEd5sXWKPas
X-Proofpoint-ORIG-GUID: _P_HTuEuZSWqggrLcQn07mEd5sXWKPas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280190
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/2023 1:16 PM, Jeffrey Hugo wrote:
> source.codeaurora.org is no longer accessible and so the reference link
> in the documentation is not useful.  The content was mirrored over to
> Code Linaro so lets update the references to point there instead.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>   .../networking/device_drivers/cellular/qualcomm/rmnet.rst     | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> index 4118384cf8eb..a3d91034ef30 100644
> --- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> +++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> @@ -191,7 +191,7 @@ MAP header|IP Packet|Optional padding|MAP header|Command Packet|Optional pad...
>   ==========================
>   
>   rmnet userspace configuration is done through netlink library librmnetctl
> -and command line utility rmnetcli. Utility is hosted in codeaurora forum git.
> +and command line utility rmnetcli. Utility is hosted in Code Linaro git.
>   The driver uses rtnl_link_ops for communication.
>   
> -https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/dataservices/tree/rmnetctl
> +https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/dataservices/

I've discussed this with Jeffrey - I'll send a v2 which points to 
iproute2 instead as it has a rmnet module for configuration.
