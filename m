Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF29706F17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEQRLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQRLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:11:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6C4198E;
        Wed, 17 May 2023 10:11:02 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HER0rV005335;
        Wed, 17 May 2023 17:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6q0xArWpEZhT4d+9ngBTBg23xYZkBDXNGbPrCv/UF5o=;
 b=KdezF0FyvbncMVobwMtegc5q1dTxViZnRhGmGcY6hlJItNZVXeMZNl/aid2gEbskgR0s
 fp5BeLPE9aayGA8hyAG8N6rgHNC6UX0CqxKatExsXkAVRYfQOsqzkHhmt3aZ2pT+8XD4
 JOCIB+CwnJvCWP7sGFhMFQVayFsUcfCPMMaHPd1+jxUlSkrSU7Zi6heq/jPK+Hc6D/32
 ZFolJMIroUT6+Ax0iGvc0P+XfZObVH4FHRvrHOM3FRAvzqKzJ2DYD5XnqPq7hLfScHrn
 iTGdj4PN5UYOE7n3codfpDDmwlrJmWWAqc2LHXDrFB+m1mMSyAoGRSCAH9ueoEqRlRKH qQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmbk7b5ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 17:10:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HHAXIU025352
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 17:10:33 GMT
Received: from [10.110.32.16] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 17 May
 2023 10:10:32 -0700
Message-ID: <8e4bde65-fe66-853b-8b87-f3b230a384df@quicinc.com>
Date:   Wed, 17 May 2023 10:10:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] accel/qaic: initialize ret variable to 0
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, <trix@redhat.com>,
        <ogabbay@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <jacek.lawrynowicz@linux.intel.com>,
        <stanislaw.gruszka@linux.intel.com>, <quic_pkanojiy@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20230517165605.16770-1-quic_jhugo@quicinc.com>
Content-Language: en-US
From:   Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20230517165605.16770-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O9dRqlgI_OB5q-Zuwbc59rWGZDx8R7un
X-Proofpoint-ORIG-GUID: O9dRqlgI_OB5q-Zuwbc59rWGZDx8R7un
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170140
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2023 9:56 AM, Jeffrey Hugo wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports
> drivers/accel/qaic/qaic_data.c:610:2: warning: Undefined or garbage
>    value returned to caller [core.uninitialized.UndefReturn]
>          return ret;
>          ^~~~~~~~~~
> 
>>From a code analysis of the function, the ret variable is only set some
> of the time but is always returned.  This suggests ret can return
> uninitialized garbage. However BO allocation will ensure ret is always
> set in reality.
> 
> Initialize ret to 0 to silence the warning.
> 
> Fixes: ff13be830333 ("accel/qaic: Add datapath")
> Signed-off-by: Tom Rix <trix@redhat.com>
> [jhugo: Reword commit text]
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>   drivers/accel/qaic/qaic_data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
> index 8ab26e64b231..e42c1f9ffff8 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -591,7 +591,7 @@ static int qaic_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struc
>   	struct qaic_bo *bo = to_qaic_bo(obj);
>   	unsigned long offset = 0;
>   	struct scatterlist *sg;
> -	int ret;
> +	int ret = 0;
>   
>   	if (obj->import_attach)
>   		return -EINVAL;


LGTM

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
