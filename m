Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C166DE94A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjDLCFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDLCF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:05:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA88346B2;
        Tue, 11 Apr 2023 19:05:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLNckW018343;
        Wed, 12 Apr 2023 02:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=YMf+TktTNtxRdUa+83bEENxd10ZcoQxkvFoiqch71C4=;
 b=QFRWsEvm/d3NFfGhOmHwUTFdbUYOl6484UgGAZeWCUEhpMoV3PxHnMCmxoV8GNMeLZy5
 lC1Iodmz5Gp0KsDA3OPFDT1imPgpbjyBWaYwNvSDA4Y5WM64Mh4wLLeEMZQdtXyDqQIM
 EfIMs+5fV/ef8KqYw6Pkj5QpeT+pEXOS/DKuim7jT3QdXhpYlET6I0HCjimF0m/qkwyC
 eH7LMWOjTms8tr8JYf2pfSa4lh9yesbozLdEAQHYHaopxcoMI7yCWY2DW9fM2QVN+Q+H
 nq7v48AI21Fx0W2CYGB5XgLpunC2B9v35goi7OS+2+4STzUKOmS90PIF6WTp4mixRuVX 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etpvgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:05:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNgOSt008095;
        Wed, 12 Apr 2023 02:05:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwc54tum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:05:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33C24xeW031283;
        Wed, 12 Apr 2023 02:05:01 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3puwc54tqc-6;
        Wed, 12 Apr 2023 02:05:01 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com, mrangankar@marvell.com, jejb@linux.ibm.com,
        nathan@kernel.org, ndesaulniers@google.com,
        Tom Rix <trix@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [SCSI] qla4xxx: remove unused count variable
Date:   Tue, 11 Apr 2023 22:04:46 -0400
Message-Id: <168126077056.185856.7146768863710533051.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331175757.1860780-1-trix@redhat.com>
References: <20230331175757.1860780-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=795 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120016
X-Proofpoint-GUID: 0k8hG55aQc2_zvGfouYKoNsTCggHguZh
X-Proofpoint-ORIG-GUID: 0k8hG55aQc2_zvGfouYKoNsTCggHguZh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 13:57:57 -0400, Tom Rix wrote:

> clang with W=1 reports
> drivers/scsi/qla4xxx/ql4_isr.c:475:11: error: variable
>   'count' set but not used [-Werror,-Wunused-but-set-variable]
>         uint32_t count = 0;
>                  ^
> This variable is not used so remove it.
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[1/1] qla4xxx: remove unused count variable
      https://git.kernel.org/mkp/scsi/c/3d2efb5470f5

-- 
Martin K. Petersen	Oracle Linux Engineering
