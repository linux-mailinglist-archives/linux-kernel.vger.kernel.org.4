Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED76083FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 05:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJVDxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 23:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJVDwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 23:52:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4B52A17D9;
        Fri, 21 Oct 2022 20:52:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29M1VkeB025001;
        Sat, 22 Oct 2022 03:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=zJ+6sNvNFs06nsJ6Qs3gQjj2BzrguBARnz0siwfKOqc=;
 b=SZYRExRreGa5wlblCq5wXw3pKDDrS/hy86m0h0ScWUQCN/tYebKEJz7H0+L8qdUrb6be
 UfhHCqjWLIyGXhIkxRiO4mTU1HcM8PfEQ9qtV6+l4I+W4BcgauHNt6jMJVG7wneGwytM
 GaIxpvyZMpHvMJNxq+BTBBrUPUjQ1o9Zwx2LaxKaond0rvl7lajRPn4+AlLSD8+tEXN0
 4lQdsEC7Ylft1zoLPWSU4803BfHBzG+9qpLAPk21Z/b/Tjw/+T8os4VMRDsRk++a4aIe
 nLrLrarZQK7U/GtOrt6YLKI++eirFwQVoKgdtuxZxmG0xe8zpL6OwwyiZDnZ1uahQO6d Sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xdr2x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:52:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29M1XXxL015262;
        Sat, 22 Oct 2022 03:52:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y8hk82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:52:27 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29M3qOMM004796;
        Sat, 22 Oct 2022 03:52:27 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kc6y8hk7g-5;
        Sat, 22 Oct 2022 03:52:27 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     stanley.chu@mediatek.com, Jinyoung CHOI <j-young.choi@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>, jejb@linux.ibm.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com, ALIM AKHTAR <alim.akhtar@samsung.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix typo for register name in comments
Date:   Fri, 21 Oct 2022 23:52:20 -0400
Message-Id: <166641048598.3488171.9974730226292316486.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017095815epcms2p110e3421b99bb9a937620b4d065d0ed12@epcms2p1>
References: <CGME20221017095815epcms2p110e3421b99bb9a937620b4d065d0ed12@epcms2p1> <20221017095815epcms2p110e3421b99bb9a937620b4d065d0ed12@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210220021
X-Proofpoint-GUID: LbsQFlSCCb-_tFQNHhROsh4ooP-DQZpP
X-Proofpoint-ORIG-GUID: LbsQFlSCCb-_tFQNHhROsh4ooP-DQZpP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 18:58:15 +0900, Keoseong Park wrote:

> Change "UTRMLCLR" to "UTMRLCLR".
> The meaning is "UTP Task Management Request List CLear Register"
> 
> 

Applied to 6.1/scsi-fixes, thanks!

[1/1] scsi: ufs: core: Fix typo for register name in comments
      https://git.kernel.org/mkp/scsi/c/4652b58fe3bb

-- 
Martin K. Petersen	Oracle Linux Engineering
