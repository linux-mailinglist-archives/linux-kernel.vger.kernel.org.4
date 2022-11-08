Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42F86207F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiKHEDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiKHEDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:03:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55FC32BB4;
        Mon,  7 Nov 2022 20:02:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80Ns5G027235;
        Tue, 8 Nov 2022 04:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=IdsnlnKVZ5T48zTT5N067giSTkrjuyE94T7RI1M33Ig=;
 b=Eq+lwzy8kihzV9vLcvkcVAqJJepH1AeFm8qLV8OpQis1miJzy8Kga2qyfO8WxL6yhAl5
 BwXJOlRp96ynzRSTOvPD+fE6yYWxfJqXPYYcnsFC5xIwO9NvSFfVIr9QnFDuY3bzMfH7
 uVbo1QdwplaryezTbYK/CabU93o9t6J8erCZqoGBu84/JMNZ73cYdIqa7mxTZJGj9HSC
 BrvW40MRaOPC6mm9PnsqvnuRaIN1G8RQTucgnVrL1Ybq0CuLYsz5RlW0mzLY1Z8NeVJk
 FERZnUEMeXTmvP0RtozgfPNpR905aNsVqWYpdZz4yAB0SNnQcXt4Flh/Da/FjMtApq40 Jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfx5e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 04:02:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A81rcd2025648;
        Tue, 8 Nov 2022 04:01:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqfh3sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 04:01:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A841vce022774;
        Tue, 8 Nov 2022 04:01:57 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kpcqfh3s5-1;
        Tue, 08 Nov 2022 04:01:57 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Bean Huo <beanhuo@iokpp.de>, asutoshd@codeaurora.org,
        bvanassche@acm.org, tomas.winkler@intel.com, jejb@linux.ibm.com,
        avri.altman@wdc.com, stanley.chu@mediatek.com, beanhuo@micron.com,
        daejun7.park@samsung.com, alim.akhtar@samsung.com,
        cang@codeaurora.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Changes for ufshcd.c
Date:   Mon,  7 Nov 2022 23:01:48 -0500
Message-Id: <166787988587.644518.8561863997687493426.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221025222430.277768-1-beanhuo@iokpp.de>
References: <20221025222430.277768-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080020
X-Proofpoint-ORIG-GUID: 5Rwgpcx3Nm0KDOu99Mst0L6CS9hd05kh
X-Proofpoint-GUID: 5Rwgpcx3Nm0KDOu99Mst0L6CS9hd05kh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 00:24:27 +0200, Bean Huo wrote:

> From: Bean Huo <beanhuo@micron.com>
> 
> v4--v5:
>     1. Rebase the patch
>     2. Change commit message of patch 1/3
> 
> v3--v4:
>     1. Change patch 1/3 title
>     2. Fix one typo in patch 3/3
>     3. Fix coding type issue in  patch 2/3 based on Bart's comment
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/3] scsi: ufs: core: Revert "WB is only available on LUN #0 to #7"
      https://git.kernel.org/mkp/scsi/c/b43678ea5bbd
[2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
      https://git.kernel.org/mkp/scsi/c/dca899bc0223
[3/3] scsi: ufs: core: Use is_visible to control UFS unit descriptor sysfs nodes
      https://git.kernel.org/mkp/scsi/c/9d266e792b0f

-- 
Martin K. Petersen	Oracle Linux Engineering
