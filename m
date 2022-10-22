Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15856083F7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 05:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJVDwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 23:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJVDwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 23:52:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4702958FE;
        Fri, 21 Oct 2022 20:52:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29M3Bx85029625;
        Sat, 22 Oct 2022 03:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=K1CGpatTk8sQnVg8GLEU+yE81wxL5j2noj+WAB+heN4=;
 b=yT42GySS8m5lMXFQMqrUqHOsRZheBFBFYudU7T1LrxeE0H3ykLbJCmFknbKp0WNR4OX+
 qBB6vBvHJyKsvqWKf8mHxzareq2HLA2ZmIxZjfyiAQo48lJwFiCmsBvVHl3hYUIM2v96
 J69JrbNtOw6+mwQTXZ/lqeXnk0P5h8NkXysd2NnMHys8PA0G9Nakrz4xhPLhbDci1J8a
 Joq3QUpHc/22+w0q1IG0yBeeSOaWuQbTbcw8O/CDbYNTXxas+eZ0FYDJXtwNMCiLUfbj
 ZDFQl5qekhhVLfCU53u1R1axaXwgWNZ2AcKhFBm7r3kz4xu+8QeZVqZuq/E6TlFcdB2q Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc8db80pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:52:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29M1Xv7w016347;
        Sat, 22 Oct 2022 03:52:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y8hk8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:52:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29M3qOMQ004796;
        Sat, 22 Oct 2022 03:52:28 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kc6y8hk7g-7;
        Sat, 22 Oct 2022 03:52:28 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v2] scsi: mpi3mr: select CONFIG_SCSI_SAS_ATTRS
Date:   Fri, 21 Oct 2022 23:52:22 -0400
Message-Id: <166641048601.3488171.3335868464011605135.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017145517.93BCB6043B@lion.mk-sys.cz>
References: <20221017145517.93BCB6043B@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=873 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210220021
X-Proofpoint-ORIG-GUID: J_3Uy9-0MGfsMFaMpAXb0xMXVtc92VZi
X-Proofpoint-GUID: J_3Uy9-0MGfsMFaMpAXb0xMXVtc92VZi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 16:55:17 +0200 (CEST), Michal Kubecek wrote:

> Starting with commit 42fc9fee116f ("scsi: mpi3mr: Add helper functions to
> manage device's port"), kernel configured with CONFIG_SCSI_MPI3MR=m and
> CONFIG_SCSI_SAS_ATTRS=n fails to build because modpost cannot find symbols
> used in mpi3mr_transport.c:
> 
>   ERROR: modpost: "sas_port_alloc_num" [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
>   ERROR: modpost: "sas_remove_host" [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
>   ERROR: modpost: "sas_phy_alloc" [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
>   ERROR: modpost: "sas_phy_free" [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
>   ...
> 
> [...]

Applied to 6.1/scsi-fixes, thanks!

[1/1] scsi: mpi3mr: select CONFIG_SCSI_SAS_ATTRS
      https://git.kernel.org/mkp/scsi/c/65244389b1b3

-- 
Martin K. Petersen	Oracle Linux Engineering
