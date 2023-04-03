Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4856D3BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDCCPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDCCPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:15:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFAE9751;
        Sun,  2 Apr 2023 19:15:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332MSORR021806;
        Mon, 3 Apr 2023 02:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=Qh4xsa+hYKkLQLK4fIBniJowxdMYwm9VMHpEuPgQdRs=;
 b=FwTpM7jjRl4tkRPQ6D0E3Jx4B7pPpfnLO10R4VTz1nDgd3kPbUh62ErTIXCmr5YYXHDC
 2ydfZa+zYFgfY89OEq7Q93wiZIKF1UVuuFoZnH1fA1hmnQgkx8jAimHdb4/CzZmW2g7U
 i4LnII0YuTKdZscA6hw4gaTgqArwYlM8YJVlT7d0PWLRB4It0L0c1QCJsxnVfVmKp7Y4
 donusQwGUDLPj8QzK6Q0gt3282NNWM1GYZwq8ZOeP+juMiMS49Fo4HxCntZfghzP+cdq
 HMe7fleCufqB2MGhGcZr05ca1PmkVP9fgsZRp6lZys8ClArji1JNuSnJhcpeLy8JMBR1 +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5u9ykt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:15:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332LWKtB014223;
        Mon, 3 Apr 2023 02:15:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3ddbp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:15:18 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3332FHwh010318;
        Mon, 3 Apr 2023 02:15:18 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ppt3ddbn7-2;
        Mon, 03 Apr 2023 02:15:18 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ching Huang <ching2048@areca.com.tw>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 4/5] scsi: arcmsr: added driver proc_name
Date:   Sun,  2 Apr 2023 22:15:03 -0400
Message-Id: <168031383546.650124.15788928130062062087.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <045a0b360bd963987d9be08c1f0f785b47724caf.camel@areca.com.tw>
References: <045a0b360bd963987d9be08c1f0f785b47724caf.camel@areca.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=685 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030015
X-Proofpoint-ORIG-GUID: ets9GejCG4m9xhJj79h2eiomljX6BUv8
X-Proofpoint-GUID: ets9GejCG4m9xhJj79h2eiomljX6BUv8
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 01:24:41 +0800, ching Huang wrote:

> This patch added driver proc_name.
> 
> 

Applied to 6.4/scsi-queue, thanks!

[4/5] scsi: arcmsr: added driver proc_name
      https://git.kernel.org/mkp/scsi/c/76556de243ac

-- 
Martin K. Petersen	Oracle Linux Engineering
