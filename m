Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD3163E886
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiLADqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiLADqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:46:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F279F488;
        Wed, 30 Nov 2022 19:45:58 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B12cw7g018211;
        Thu, 1 Dec 2022 03:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=O+HPOiQ7l2cb329T2SzDhZwTpFIWp4htVgwEjgfoNns=;
 b=MIMoqXAn+SMwC7/IJRT/DWupZFNKblVRno8YAzyWtgaOk2axf+pi3+V3qYZL/LmSHf8B
 qucf81RzF7A5oSCA+FvXBF6ffZdoNe+UhGOCwSfYRJlcFAdxJ5VNnKBXef9kTrbbnxas
 5n+ofaXE10oVzo6eTIgh9vQEpCo+g7Vf+efDwBCDRXHlxF/9c6Eny3ekgyY6Jcgh6QSK
 b/YXlgvE2Sh/GhlzQdxBXSjpGlKHdVX9vYBi15F6EAknpzXaI3nHMqTUljmLOPTbDUdp
 +wkGeLZTc6rQC1qZbChiaHCv7/HsercM1Ms7eWjC00Bnw35zYCQQme+b/GD/PmLW9yb6 Fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xhtbnqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B13gV1O007615;
        Thu, 1 Dec 2022 03:45:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2cv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpt033801;
        Thu, 1 Dec 2022 03:45:55 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-18;
        Thu, 01 Dec 2022 03:45:55 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/2] scsi: Some minor scan improvements
Date:   Thu,  1 Dec 2022 03:45:19 +0000
Message-Id: <166986602295.2101055.8210314445754817433.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121121725.1910795-1-john.g.garry@oracle.com>
References: <20221121121725.1910795-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-GUID: _66lsjJCzqWsV2oAdtiSco2oQb-X532s
X-Proofpoint-ORIG-GUID: _66lsjJCzqWsV2oAdtiSco2oQb-X532s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 12:17:23 +0000, John Garry wrote:

> The __scsi_add_device() change is from another series which I sent a while
> ago.
> 
> The new change in do_scsi_scan_host() could be combined into the
> __scsi_add_device() change if I have anothter RB tag (hint, hint).
> 
> John Garry (2):
>   scsi: core: Use SCSI_SCAN_RESCAN in  __scsi_add_device()
>   scsi: core: Use SCSI_SCAN_INITIAL in do_scsi_scan_host()
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/2] scsi: core: Use SCSI_SCAN_RESCAN in __scsi_add_device()
      https://git.kernel.org/mkp/scsi/c/35bd6f9fd33b
[2/2] scsi: core: Use SCSI_SCAN_INITIAL in do_scsi_scan_host()
      https://git.kernel.org/mkp/scsi/c/425b27a04dd8

-- 
Martin K. Petersen	Oracle Linux Engineering
