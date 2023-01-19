Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3E2672D58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjASAXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASAXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:23:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35C56EE3;
        Wed, 18 Jan 2023 16:23:42 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmwpJ016941;
        Thu, 19 Jan 2023 00:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=H/1R/6xWcAGLNV+ZBOH+uXU5OQ8cxdsbwB7MpYCD1CA=;
 b=QXc7g4ohjxLI3mJWM9MPJKtk5+CZ62zPH8/4aWelBDENFZDxtWBr7Ro/QCSC3qUyzcSH
 O7N+yz7O8/+hRSUGSogufz/Bgu6LTR93hmRnxejAif/sNcFJV+NiZdpzpfN/+hOfQ/6p
 0Ng+WGijvDuZdtBujRTUkSy2XH05XB/VV5rRw7F9EDj5IoutWBus+hvqHVGss5jUBhXD
 RQYUY++i7mzOY+l/kPeKdDKfB1TtLmxLmc1mbcz1e1BxTIEkjlbQ1C+y7G61kkuVFn2c
 Q3bVdhux5hqaCxpvB/Te3RQSgUxEPJN35uu/sEdCvyj+IszrvAboqc+597Wx4TDfaSrC KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaah1w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 00:23:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IMhXpw039637;
        Thu, 19 Jan 2023 00:23:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2tpbft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 00:23:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30J0NbuS029805;
        Thu, 19 Jan 2023 00:23:37 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n6r2tpbfm-1;
        Thu, 19 Jan 2023 00:23:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: uapi: Replace 0-length array with flexible array
Date:   Wed, 18 Jan 2023 19:23:34 -0500
Message-Id: <167408774135.3511403.11293460397797656426.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230105233042.never.913-kees@kernel.org>
References: <20230105233042.never.913-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=723
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190000
X-Proofpoint-GUID: vVPgMOuSM5vvnEB17n77u5tVDz9LWbJX
X-Proofpoint-ORIG-GUID: vVPgMOuSM5vvnEB17n77u5tVDz9LWbJX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023 15:30:46 -0800, Kees Cook wrote:

> Zero-length arrays are deprecated[1]. Replace struct
> fc_bsg_host_vendor_reply's "vendor_rsp" 0-length array with a flexible
> array. Detected with GCC 13, using -fstrict-flex-arrays=3:
> 
> drivers/scsi/qla2xxx/qla_isr.c: In function 'qla25xx_process_bidir_status_iocb.isra':
> drivers/scsi/qla2xxx/qla_isr.c:3117:54: warning: array subscript 0 is outside array bounds of '__u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
>  3117 |         bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = rval;
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> In file included from drivers/scsi/qla2xxx/qla_def.h:34,
>                  from drivers/scsi/qla2xxx/qla_isr.c:6:
> include/uapi/scsi/scsi_bsg_fc.h:219:15: note: while referencing 'vendor_rsp'
>   219 |         __u32 vendor_rsp[0];
>       |               ^~~~~~~~~~
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: uapi: Replace 0-length array with flexible array
      https://git.kernel.org/mkp/scsi/c/64b6deadc938

-- 
Martin K. Petersen	Oracle Linux Engineering
