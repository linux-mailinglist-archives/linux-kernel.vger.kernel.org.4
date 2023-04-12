Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747FB6DE947
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDLCFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDLCFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:05:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198835246;
        Tue, 11 Apr 2023 19:05:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLLCUE005453;
        Wed, 12 Apr 2023 02:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=SUluKX6kMH5F8rxXKuyyOiRlFa+0Og0Y3g87pm6MptE=;
 b=qsM3YOUamIssOk2UP6D3lQRzRBqpA1m8HZqhxaCU6NlhlreYAIPOYwMGXuM6418qNsSf
 vc8Sn8mJ8o3PtQyw00zpM0vB2rWFRY9IQ7qbsf0taq4d/DSuWhH3/GxovK1omCMvWJ72
 ZOsQJnrAvetelvXW+6qaCOXiT8GMC/MCf50CqlE5SelWuXA/uZi8mmAkGjjcsLulDDni
 10e9f1QNFPJ3g7RpTzlIdlRA0/qofDPh6wJjCDPmDCJayvhomcxcOP8ws5+tWYrixcZi
 8AyE4CpUhfqMDlzcS+rDhqKiyrBt9vQYvaHx23yDGis9172mk14CPU7SlGnVYpq8PomD +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7evcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:05:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNhQ2G008117;
        Wed, 12 Apr 2023 02:05:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwc54tvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:05:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33C24xec031283;
        Wed, 12 Apr 2023 02:05:02 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3puwc54tqc-9;
        Wed, 12 Apr 2023 02:05:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     nathan@kernel.org, ndesaulniers@google.com,
        Tom Rix <trix@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: target: core: remove unused prod_len variable
Date:   Tue, 11 Apr 2023 22:04:49 -0400
Message-Id: <168126077050.185856.6929741169277283722.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329132421.1809362-1-trix@redhat.com>
References: <20230329132421.1809362-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=816 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120016
X-Proofpoint-ORIG-GUID: Bzr9rLvJ9Uc6Adx10VyXJuCcXBuhzbJA
X-Proofpoint-GUID: Bzr9rLvJ9Uc6Adx10VyXJuCcXBuhzbJA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 09:24:21 -0400, Tom Rix wrote:

> clang with W=1 reports
> drivers/target/target_core_spc.c:229:6: error: variable
>   'prod_len' set but not used [-Werror,-Wunused-but-set-variable]
>         u32 prod_len;
>             ^
> This variable is not used so remove it.
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: target: core: remove unused prod_len variable
      https://git.kernel.org/mkp/scsi/c/aa4d7812cf2c

-- 
Martin K. Petersen	Oracle Linux Engineering
