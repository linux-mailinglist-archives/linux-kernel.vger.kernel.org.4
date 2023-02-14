Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A8696A76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjBNQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBNQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:57:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBDA4C13;
        Tue, 14 Feb 2023 08:57:50 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGXjMM027860;
        Tue, 14 Feb 2023 16:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=bHqikatdcLQwXjMkflGAbLzKKRERd6UuScGkCHBgt+o=;
 b=FhsxhAS9Zt75S+gm6VoNwJJR3GkvJSQJLZ/jcwHUMUJMbM6SMBZibeM9QDuCkZNDAfzf
 +NL1I1paMrJV/PNgQZEzDYjymxMUV99m4JplXgxDIuBhgwAZi9UqKHhaWAWKk7T15GLZ
 /k6H00FLaGR+iP+8vkx2pONOkxx8Lhh2/MwHMKQv9RA9ym/9AY9YVYmNJ0DBt8OMLydr
 gSTmI3zCa2AzQnMO+c/UDU33EX72kFXpE26bSweo2fWboZMsRwuZOLhWQWwr1EoqwPr3
 qmHyvw85hhwaqYgCxW/2hkkqblEC6rrNlLvMUIA6mmTL73kfunHXy9foDzSmFAVrq2Yr LA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtdxta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:57:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EGsv7Z009635;
        Tue, 14 Feb 2023 16:57:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5uuh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:57:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31EGuHoj039739;
        Tue, 14 Feb 2023 16:57:42 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1f5uuff-5;
        Tue, 14 Feb 2023 16:57:42 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: qla2xxx: Remove the unused variable wwn
Date:   Tue, 14 Feb 2023 11:57:31 -0500
Message-Id: <167639371125.486235.13464202684241083189.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207052234.24535-1-jiapeng.chong@linux.alibaba.com>
References: <20230207052234.24535-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=845 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140144
X-Proofpoint-GUID: ZoULYWGZVdV3ncI_flRZYpchLjX6Os2B
X-Proofpoint-ORIG-GUID: ZoULYWGZVdV3ncI_flRZYpchLjX6Os2B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2023 13:22:34 +0800, Jiapeng Chong wrote:

> Variable wwn is not effectively used, so delete it.
> 
> drivers/scsi/qla2xxx/qla_init.c:1657:6: warning: variable 'wwn' set but not used.
> 
> 

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: qla2xxx: Remove the unused variable wwn
      https://git.kernel.org/mkp/scsi/c/d48a62381a73

-- 
Martin K. Petersen	Oracle Linux Engineering
