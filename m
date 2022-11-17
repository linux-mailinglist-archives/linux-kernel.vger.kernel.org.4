Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD13262E450
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiKQScT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbiKQSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:30:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BEA86A6E;
        Thu, 17 Nov 2022 10:30:18 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHhqaF028297;
        Thu, 17 Nov 2022 18:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=JMoAY9JAgqNKqBsxlGm0L9X/81Ci47XElVkAJrmD7Co=;
 b=kvqYcuV2wkNwaOQ5GKWWnuLWjQDYhxiQo9PIY3U8ZEnTnWijyQy7AmdgUd9anOwrVQmQ
 YDZWciaTsr/rKZn3RXm2COieriSuPGe3Oa976h6PvCp52yNzJG89Pa9a9qd/RYWEIRHf
 m03tjGhoPOHV1qbhkUiqKAk/NAOo1YibCfOJ8tzmNnQY87Yw7svfxIsZ2EoHZWUzdxO5
 h3qCp52DkvdtTUGAMc0f3p0bBtF23I7Fzd9kSYp+mJIlwPd1LdBIhd+4wWIHdlaTivZz
 XPOWPJOtPAn+v/n0LizM2Y5o6gryUAddfUZtAOnYWmtAOPzLH5nm6GhdrahqXpl6LSKD Ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykt0ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHGUo3010859;
        Thu, 17 Nov 2022 18:29:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kab0nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHITapL022894;
        Thu, 17 Nov 2022 18:29:42 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kab0gb-11;
        Thu, 17 Nov 2022 18:29:42 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     adrian.hunter@intel.com, bvanassche@acm.org,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com,
        draviv@codeaurora.org, beanhuo@micron.com,
        stanley.chu@mediatek.com, linux-scsi@vger.kernel.org,
        avri.altman@wdc.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: Remove check_upiu_size() from ufshcd.h
Date:   Thu, 17 Nov 2022 13:29:33 -0500
Message-Id: <166870943119.1584889.726238237744993435.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
References: <CGME20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3> <20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170133
X-Proofpoint-GUID: vzp6qa_KIDDOpWwgDK-X_tskmscgLHNP
X-Proofpoint-ORIG-GUID: vzp6qa_KIDDOpWwgDK-X_tskmscgLHNP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Nov 2022 14:53:49 +0900, Keoseong Park wrote:

> Commit 68078d5cc1a5 ("[SCSI] ufs: Set fDeviceInit flag to initiate
> device initialization") added check_upiu_size(), but no caller.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: ufs: Remove check_upiu_size() from ufshcd.h
      https://git.kernel.org/mkp/scsi/c/3d6d7930928a

-- 
Martin K. Petersen	Oracle Linux Engineering
