Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBF6E7182
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjDSDUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjDSDU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:20:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D8110CF;
        Tue, 18 Apr 2023 20:20:26 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ILqAPH031839;
        Wed, 19 Apr 2023 03:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=sL7n544M2FFx8zOMKVb8XqVFksAtc7Bt0XJozZeFb8U=;
 b=fLo+neFQYgBy4L/+1t9vg9kyb/DRLnJKCpYq77PDGzXjUhWs82/MtnxVKtPriBxnnorj
 FFDmaDFpoP2He7jYEci7t56I0C5/FgHxoNE8d8R7PtvIjv2m0vPAMoMYlWe7yr3hquCC
 hsLvHtXdCTvuY/bOakpf6esBhwB5m3Gg8q4zmF/Z3OTLASOOMVBcZQa6SOxLxbvbH9oL
 vj9oDdQEvkkEGZC9ONicCiaWsw6cOfMG0vBng3Xp0XXj1b10St0kCCwE1DMJXs6uqlFX
 QORlRIqaYZXOm0fjHAV2BX7DIy5Zb9j4SKU6TaF+3SGVSdTrc+Pc5PdFJiBwaXFxiCH4 DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykycy92y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:20:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33J0LGWi037066;
        Wed, 19 Apr 2023 03:20:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcccvv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:20:23 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33J3KLpC012748;
        Wed, 19 Apr 2023 03:20:23 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pyjcccvts-4;
        Wed, 19 Apr 2023 03:20:23 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        error27@gmail.com, kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] scsi: scsi_debug: Fix missing error code in scsi_debug_init()
Date:   Tue, 18 Apr 2023 23:20:13 -0400
Message-Id: <168187437337.702980.15149771115917556403.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406074607.3637097-1-harshit.m.mogalapalli@oracle.com>
References: <20230406074607.3637097-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_17,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=801 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190029
X-Proofpoint-GUID: MPrdhA1pkuzGGh3vAzFJGXTPAFJOc7Nl
X-Proofpoint-ORIG-GUID: MPrdhA1pkuzGGh3vAzFJGXTPAFJOc7Nl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2023 00:46:07 -0700, Harshit Mogalapalli wrote:

> Smatch reports: drivers/scsi/scsi_debug.c:6996
> 	scsi_debug_init() warn: missing error code 'ret'
> 
> Although it is unlikely that KMEM_CACHE might fail, but if
> it does then ret might be zero. So to fix this explicitly
> mark ret as "-ENOMEM" and then goto driver_unreg.
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: scsi_debug: Fix missing error code in scsi_debug_init()
      https://git.kernel.org/mkp/scsi/c/b32283d75335

-- 
Martin K. Petersen	Oracle Linux Engineering
