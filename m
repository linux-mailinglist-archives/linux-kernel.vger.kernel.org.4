Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BABD643509
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiLET4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiLET4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:56:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062762716F;
        Mon,  5 Dec 2022 11:55:20 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Jl4SD019136;
        Mon, 5 Dec 2022 19:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=2jN8CsTBm2ZHuGB0wdV52iEf3uKhXLmvCIlSxAXzXQc=;
 b=fyoZw48I2B7O47dXS4buZc1mJ4FdJA5WXD0V01aiQlA8ftFiPIYXZraTRwsoCiB66Pb+
 raEtfK9Ar3QxfrVPKx0MYfPZMuBMOsA0Fv0iq/+fw7Y86KYjSzTZGrSr+sz7wuG+Z1Y3
 lza6HVHM81J8Qcsxte3alDzHwC+nxHz7SzdIk23JdySQKHz6kJ4GslWG01+dNX3Ui1ga
 VqiLiyZrGd95FraMpUzqJQsUjTV4c7qu4jOxt9tpgxyCwEl1GCd61pEkCPlGYThI/J5y
 E5LJzbiXmRWv08nM7OQyuzO1mJ2T4y1JW06QlAJAJLIpO1HVvIqnAYWKhz15CmAu6jyH eA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7yrf51x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 19:55:06 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B5Jt5xw016220
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 19:55:05 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 11:55:05 -0800
Date:   Mon, 5 Dec 2022 11:55:04 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <andersson@kernel.org>, <vkoul@kernel.org>,
        <quic_cang@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <ahalaney@redhat.com>, <abel.vesa@linaro.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>
Subject: Re: [PATCH v4 14/23] scsi: ufs: ufs-qcom: Remove un-necessary
 WARN_ON()
Message-ID: <20221205195504.GC15334@asutoshd-linux1.qualcomm.com>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
 <20221201174328.870152-15-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20221201174328.870152-15-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f_1Lx_-etjM3_OYk7-vb1-KvX_nW5PmD
X-Proofpoint-ORIG-GUID: f_1Lx_-etjM3_OYk7-vb1-KvX_nW5PmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050166
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01 2022 at 09:45 -0800, Manivannan Sadhasivam wrote:
>In the reset assert and deassert callbacks, the supplied "id" is not used
>at all and only the hba reset is performed all the time. So there is no
>reason to use a WARN_ON on the "id".
>
>Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
>Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>---
> drivers/ufs/host/ufs-qcom.c | 4 ----
> 1 file changed, 4 deletions(-)
>
LGTM.

Reviewed-by: Asutosh Das <quic_asutoshd@quicinc.com>

>diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>index 7cd996ac180b..8bb0f4415f1a 100644
>--- a/drivers/ufs/host/ufs-qcom.c
>+++ b/drivers/ufs/host/ufs-qcom.c
>@@ -895,8 +895,6 @@ ufs_qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> {
> 	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
>
>-	/* Currently this code only knows about a single reset. */
>-	WARN_ON(id);
> 	ufs_qcom_assert_reset(host->hba);
> 	/* provide 1ms delay to let the reset pulse propagate. */
> 	usleep_range(1000, 1100);
>@@ -908,8 +906,6 @@ ufs_qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> {
> 	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
>
>-	/* Currently this code only knows about a single reset. */
>-	WARN_ON(id);
> 	ufs_qcom_deassert_reset(host->hba);
>
> 	/*
>-- 
>2.25.1
>
