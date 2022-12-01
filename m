Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098C563E8A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLADsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiLADrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:47:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48D1A0552;
        Wed, 30 Nov 2022 19:46:15 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B12rgWg028895;
        Thu, 1 Dec 2022 03:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=cntpssrBK9Mj0vu9Dh9t9hFTv36JyTZYssv2NVwvK1c=;
 b=iZu7PMliElA0tdYb8JKUchEqRm1W4/c989kNWpcwKCr7zfoLMm5Mp4Q7ho2YK6r4KuKx
 I4wks7JezLl8Jbs0b8a2kSAWvNeDipdcfoR97KHNMlRG5U9lCT6HzkTQhG1zNgzg4NIK
 rESTDqs1PQGyfy/8IJWv/hboJ7UaWb/4YXl42F1nPLAfSA8vzZNggQizsHFtB/TFlj6F
 iFr+YDRzNKB/LKUe7eC6emgfRbquu8XEyJizTV6JPUeXs746lJeXwXwdnoIG6jDYcOa5
 VGPdo0rbkkqiXBD+blsStA8WE3pp+71beLKfKQ6/z/qa2QTwfmj4gCsVgZHCK7zlUn8o VA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2vegw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:46:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B13NGrA007605;
        Thu, 1 Dec 2022 03:46:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2d34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:46:06 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbqK033801;
        Thu, 1 Dec 2022 03:46:06 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-30;
        Thu, 01 Dec 2022 03:46:05 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, Yu Zhe <yuzhe@nfschina.com>,
        shivasharan.srikanteshwara@broadcom.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        liqiong@nfschina.com, linux-kernel@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] scsi: megaraid_sas: fix some spelling mistakes in comment
Date:   Thu,  1 Dec 2022 03:45:31 +0000
Message-Id: <166986602297.2101055.12006536648078661788.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125020703.22216-1-yuzhe@nfschina.com>
References: <20221124092514.32032-1-yuzhe@nfschina.com> <20221125020703.22216-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=852 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-GUID: 1PgftRhJw0IKy84XxvCBKWNqet-drycd
X-Proofpoint-ORIG-GUID: 1PgftRhJw0IKy84XxvCBKWNqet-drycd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 10:07:03 +0800, Yu Zhe wrote:

> Fix typos in comment.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: megaraid_sas: fix some spelling mistakes in comment
      https://git.kernel.org/mkp/scsi/c/76dc609556c6

-- 
Martin K. Petersen	Oracle Linux Engineering
