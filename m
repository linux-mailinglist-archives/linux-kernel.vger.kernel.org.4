Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEDD67DC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjA0DXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjA0DXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:23:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C122C658;
        Thu, 26 Jan 2023 19:23:13 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R0O5Rh011550;
        Fri, 27 Jan 2023 03:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=8JeB9Wv9RJcfwiae8Nih4FmbRZMi/S8FXnvy1/4mj7g=;
 b=HdOHkN1RwFUq7JTQka68ANejeg4njohKWPvIPYwKrsZIkacZGtBj6bFqI5dOVfDb7we+
 VqJnSOou7UyOdPmyjD6FX/UqZfgXYaYyzLq7afbljO5ZlnOElAhu6j1IcbGFMbRcD84S
 ikESkn/3D4LFyn0tX6MWRBX01WFJIhqVTJIiPwId51cgpAuZWtspMN4palMbxnVRAL0t
 xm96ZlDCW0OE9T15pyTIc3IR7+dIWOLRb72TDIy3z+P3L/tg0ULwam1Uz9I5w7fEjgTf
 3FwH7tt2fZV8M9yh48CUMtqy6aFAj93edBKgiaTMhTp3rjp98fwyZw4i8HaZVi5Fderj Iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87xaburx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30R2U952006828;
        Fri, 27 Jan 2023 03:23:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8nxqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30R3N7ee036358;
        Fri, 27 Jan 2023 03:23:07 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n86g8nxpp-1;
        Fri, 27 Jan 2023 03:23:07 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: Re: [PATCH] include: ufs: Remove duplicate entry
Date:   Thu, 26 Jan 2023 22:22:54 -0500
Message-Id: <167478863283.3972592.11930218564794166190.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230114022010.27088-1-alim.akhtar@samsung.com>
References: <CGME20230114022406epcas5p4963a02aee5acb201c5e3495b6cfd44fe@epcas5p4.samsung.com> <20230114022010.27088-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=889 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270029
X-Proofpoint-GUID: 0hQwEiHIeBPnfhGBx2L2cJvSzju8Byhg
X-Proofpoint-ORIG-GUID: 0hQwEiHIeBPnfhGBx2L2cJvSzju8Byhg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2023 07:50:10 +0530, Alim Akhtar wrote:

> PA_GRANULARITY is duplicated, let's delete one of the entry.
> 
> 

Applied to 6.3/scsi-queue, thanks!

[1/1] include: ufs: Remove duplicate entry
      https://git.kernel.org/mkp/scsi/c/3730bea883cd

-- 
Martin K. Petersen	Oracle Linux Engineering
