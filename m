Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD560F4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiJ0KR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiJ0KRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:17:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C445EDB752
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:17:22 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RAA4nU005961;
        Thu, 27 Oct 2022 10:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=fG55fBexeMtPhT/uGjxoAaYENDzs4R3mS3BwVk01lno=;
 b=lxyVcQMAis70XUG4KeKD9X5U5E3/3SGpzWW21TH2wyx0bR7OceTPYS5hcO+U61wFjAK/
 cod6foe6UmFNzfkjDkEtHUQaaL2YhGWEyGP6N8pmxhn/8CSBKvB1UkrUOoUP2y9YJEw3
 Ol1Zk2D2pEWlUFY2UX4Rfg37fQ1m2/S5wjcNm3RpohdWqzORyon+bFLcZGdKi2X7Y5ik
 EYcKB39u+JPmoibZ/iDE+0aXwwgeOnE14q0tL1nxal3lC7eA8yxcvV61iDGUzHOK22lk
 K7xMfjWbhwTIKvrgp6wnz3VwrjHOXMkD2se6BydYgkuzu0jglDU/5GiXSZ43OtqJ6SCF ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahvsmpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 10:17:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29RAH923023305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 10:17:09 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 03:17:06 -0700
Date:   Thu, 27 Oct 2022 15:47:02 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <jaegeuk@kernel.org>, <chao@kernel.org>, <mhiramat@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH 2/2] f2fs: fix the msg data type
Message-ID: <20221027101702.GA18823@hu-pkondeti-hyd.qualcomm.com>
References: <1666861961-12924-1-git-send-email-quic_mojha@quicinc.com>
 <1666861961-12924-2-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1666861961-12924-2-git-send-email-quic_mojha@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 67saJliUz5pFVmH7TQJNmzs8nFWWDG7d
X-Proofpoint-GUID: 67saJliUz5pFVmH7TQJNmzs8nFWWDG7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_05,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270057
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:42:41PM +0530, Mukesh Ojha wrote:
> Data type of msg in f2fs_write_checkpoint trace should
> be const char * instead of char *.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  include/trace/events/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index ff57e7f..7fbfce4 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -1404,7 +1404,7 @@ TRACE_EVENT(f2fs_readpages,
>  
>  TRACE_EVENT(f2fs_write_checkpoint,
>  
> -	TP_PROTO(struct super_block *sb, int reason, char *msg),
> +	TP_PROTO(struct super_block *sb, int reason, const char *msg),
>  
>  	TP_ARGS(sb, reason, msg),
>  
LGTM. one minor comment.

Declare it const char pointer in the trace point structure also.

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 11f6b71..22960e6 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1429,7 +1429,7 @@ TRACE_EVENT(f2fs_write_checkpoint,
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(int,	reason)
-		__field(char *,	msg)
+		__field(const char *,	msg)
 	),
 
 	TP_fast_assign(

Thanks,
Pavan
