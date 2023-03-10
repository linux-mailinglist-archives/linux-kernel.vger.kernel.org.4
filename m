Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BBC6B3499
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCJDOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCJDOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:14:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D02EB8BD;
        Thu,  9 Mar 2023 19:14:36 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329Lwv7h008506;
        Fri, 10 Mar 2023 03:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=ZQDkoOuVU4ImmZBpnAyX+3LIvJgALGGK/6O93qaTM+U=;
 b=gQ9yV9m4gewWi+5iMCnTaNTpxZiRBed9Sf0UrKIdqKbBuQJbVkp2VjFf+0BYngErCpUE
 szktGbybSbD5tCrvsXIKcAlooUsXEl/n5PPc2fXqM05nnx+l9PIi1EPW/wMqXphcVyZ+
 tv2tdSP6e2pm8+307u2c9NrgJmDc2GNMr21H/eqtvy/oiDUsNj8MzYCOhm9YhiHAnWjf
 iew6tY2oCDHSdoZvqClnDbo/fJobRtWUCbdQWS3y3jnn4YoHZ1nX23ln9FUj2uIt8CHo
 95kp5awl5VLB8oc2sp+p/ARiLAxvC7dWDySdPqEr4FESZ5Tr9Eleg+AQ+EIT5KF2ONKv Qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cma8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:14:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32A0WeO3026565;
        Fri, 10 Mar 2023 03:14:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g9w39km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:14:32 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32A3ETDK023573;
        Fri, 10 Mar 2023 03:14:31 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6g9w39jg-4;
        Fri, 10 Mar 2023 03:14:31 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: message: fusion: remove unused sas_persist_task work
Date:   Thu,  9 Mar 2023 22:14:24 -0500
Message-Id: <167841804067.2362455.1274954694445967635.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <b2ca2164-5347-8ec1-d8b6-3225df864173@I-love.SAKURA.ne.jp>
References: <b2ca2164-5347-8ec1-d8b6-3225df864173@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100023
X-Proofpoint-GUID: oOiZc2vnGR2Toio7QOjAR-4JAPvPqA_f
X-Proofpoint-ORIG-GUID: oOiZc2vnGR2Toio7QOjAR-4JAPvPqA_f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 00:02:41 +0900, Tetsuo Handa wrote:

> MPT_ADAPTER->sas_persist_task is no longer used since
> commit 3eb0822c6740 ("[SCSI] mpt fusion: Firmware event implementation
> using seperate WorkQueue").
> 
> 

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: message: fusion: remove unused sas_persist_task work
      https://git.kernel.org/mkp/scsi/c/314550680a00

-- 
Martin K. Petersen	Oracle Linux Engineering
