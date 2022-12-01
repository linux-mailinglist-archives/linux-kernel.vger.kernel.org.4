Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A163E87E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLADqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLADp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:45:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD169B7B5;
        Wed, 30 Nov 2022 19:45:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B12cw7e018211;
        Thu, 1 Dec 2022 03:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=eUZSuD6Ck+iIbeSpDoF+YRInnNgPcThl19RdUEEW/ss=;
 b=fFk4F/brugyQIyKVt0Iz1MP08zHWWVHdMoGfGvSgYh3x7TbCtef6kS3cJnCYLjqwMNEO
 oCcZA6YL3+eIx95hJsvSZSRcm1Db4CyxGtDO/CAAJ6ur6OZ8rjL+Ae4tPg+J87bvhHsn
 S6V/MoUulp6tNeuD3J4AKI6cGsjgCuftsc07pM8DMC5vFBj62uMkQ6w/+3d7OD14iDxY
 vYYVLUxKh4ElV2cYaYorGi3v2pkEUPO/pUHav3DVhYRui1tqQNKwR9PD9vZm4vt+6qiF
 ZHM/GYIuU1EXNkBeQ+GEzJsg4PvmTlohsJLfRzQpGLwBzrZP/NFyCsNeBSM1H7cIDFuN Pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xhtbnq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B12r6iR007594;
        Thu, 1 Dec 2022 03:45:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2cpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpa033801;
        Thu, 1 Dec 2022 03:45:45 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-8;
        Thu, 01 Dec 2022 03:45:45 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     alim.akhtar@samsung.com, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, bvanassche@acm.org, avri.altman@wdc.com,
        Chanwoo Lee <cw9316.lee@samsung.com>,
        linux-scsi@vger.kernel.org, adrian.hunter@intel.com,
        beanhuo@micron.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: core: Separate function name and message
Date:   Thu,  1 Dec 2022 03:45:09 +0000
Message-Id: <166986602279.2101055.17731102594848456832.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111062126.7307-1-cw9316.lee@samsung.com>
References: <CGME20221111062158epcas1p1c3ef28f75c39a1c1dc4c473266462fc8@epcas1p1.samsung.com> <20221111062126.7307-1-cw9316.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=958 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-GUID: vKYrk17FYYnHm-XcUXaNz5-D7Q4-sq38
X-Proofpoint-ORIG-GUID: vKYrk17FYYnHm-XcUXaNz5-D7Q4-sq38
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 15:21:26 +0900, Chanwoo Lee wrote:

> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> Separate the function name and message to make it easier to check the log.
> Modify messages to fit the format of others.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: ufs: core: Separate function name and message
      https://git.kernel.org/mkp/scsi/c/859ed37c9c3f

-- 
Martin K. Petersen	Oracle Linux Engineering
