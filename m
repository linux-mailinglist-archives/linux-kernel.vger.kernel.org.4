Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E586C8745
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjCXVHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCXVHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:07:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C718AB2;
        Fri, 24 Mar 2023 14:07:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OL4P04006442;
        Fri, 24 Mar 2023 21:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=+ElARR84kFp7gt6xLMHjZPfjGKmiuRlyS1NrYeaNaz0=;
 b=p/Yqekw/w/pEMSmOYKn7fTU5FYr/jCO29DbX3nwMmu+0tSXU4b/utzx7FEhLpvI1D4R5
 BFWE2d/18+hGQGBMlcX6UpJ5vawXQ8UGJrHexIwH4JZO66QPSybTgeC3PRxAfAAYeI75
 Q3VBsvvWmYCkJ6C2zvwBQlmJaLIhqLDRD/nTq4HZw7Ogn3Qz14R4MgNsfzVszTpA7SZD
 4xS1cToFUU9lqYL5LgOjJg1xEnEerAH8Jkes6Aks4ulEk/3wBHN2qOAjOTn1stsTovc3
 4JKZYihumRRTKS0clbmRnlVuBN4zzFLgN5dsmT7cckoI4ovhZCSzEufjB5sqyKwlb7Ds Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phkey806x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:07:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OJt5aB027817;
        Fri, 24 Mar 2023 21:07:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk4se4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:07:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32OL76fG017159;
        Fri, 24 Mar 2023 21:07:09 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk4se2p-8;
        Fri, 24 Mar 2023 21:07:09 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     ketan.mukadam@broadcom.com, jejb@linux.ibm.com,
        Tom Rix <trix@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: be2iscsi: set some be_main.c variables storage-class-specifier to static
Date:   Fri, 24 Mar 2023 17:06:59 -0400
Message-Id: <167969123957.59527.2708612963090557447.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230314005157.536918-1-trix@redhat.com>
References: <20230314005157.536918-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240160
X-Proofpoint-GUID: bJoePzynSm6iCXUMSV1q0FSQO4-1qMP7
X-Proofpoint-ORIG-GUID: bJoePzynSm6iCXUMSV1q0FSQO4-1qMP7
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 20:51:57 -0400, Tom Rix wrote:

> smatch reports several warnings
> drivers/scsi/be2iscsi/be_main.c:148:1: warning:
>   symbol 'dev_attr_beiscsi_log_enable' was not declared. Should it be static?
> drivers/scsi/be2iscsi/be_main.c:158:1: warning:
>   symbol 'dev_attr_beiscsi_drvr_ver' was not declared. Should it be static?
> drivers/scsi/be2iscsi/be_main.c:159:1: warning:
>   symbol 'dev_attr_beiscsi_adapter_family' was not declared. Should it be static?
> drivers/scsi/be2iscsi/be_main.c:160:1: warning:
>   symbol 'dev_attr_beiscsi_fw_ver' was not declared. Should it be static?
> drivers/scsi/be2iscsi/be_main.c:161:1: warning:
>   symbol 'dev_attr_beiscsi_phys_port' was not declared. Should it be static?
> drivers/scsi/be2iscsi/be_main.c:162:1: warning:
>   symbol 'dev_attr_beiscsi_active_session_count' was not declared. Should it be static?
> drivers/scsi/be2iscsi/be_main.c:164:1: warning:
>   symbol 'dev_attr_beiscsi_free_session_count' was not declared. Should it be static ?
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: be2iscsi: set some be_main.c variables storage-class-specifier to static
      https://git.kernel.org/mkp/scsi/c/1efbacd2b95a

-- 
Martin K. Petersen	Oracle Linux Engineering
