Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E7F62E447
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiKQSac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbiKQS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:29:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BC7EBD5;
        Thu, 17 Nov 2022 10:29:47 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHIG5xI007355;
        Thu, 17 Nov 2022 18:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=g7wHvpPrP2BLx61xazIY/wVa57IWIeMQsvlgo/mZ7vc=;
 b=Sc1Ue5UKm7DH1RPD9tmg4nCGv2ResDiM626QrdJAL9AhJC+QBfecI0LwHDV6+dZBKQOO
 T1XvHzaiyrIlDcw2NiganXVTseQaPsqsPrioKrtQ809ODz5YOzbRBTWfe8qpyxkJTuvS
 mNgaZ5FIFiI1H815Kn1EL6c5tlCX9Y2QZh9rs3OuZ4v+x1k2zQkYXChZJZLTC0Iv7qX3
 iD35msDuDFvcM+xlrD6zy0DCgh0FOhBysZdHmOw46UOBpVDhjKvGNamA0o7WdAY56y+6
 /GfaWs0hr/zBe7AFOeAwAEJ7CWNz8L+ZTAkWF0t4GyEo4lf6tr6Tat0A50sM+hSg+0IB cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3nsa6nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHGbS2010856;
        Thu, 17 Nov 2022 18:29:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kab0m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:41 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHITapF022894;
        Thu, 17 Nov 2022 18:29:40 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kab0gb-8;
        Thu, 17 Nov 2022 18:29:40 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-scsi@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Remove unused variable found_devs
Date:   Thu, 17 Nov 2022 13:29:30 -0500
Message-Id: <166870943121.1584889.3157469158916542955.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221101104733.30363-1-colin.i.king@gmail.com>
References: <20221101104733.30363-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=929 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170133
X-Proofpoint-GUID: I3cVyau5iSuBEfgGjR1dewmrZQRfWyEe
X-Proofpoint-ORIG-GUID: I3cVyau5iSuBEfgGjR1dewmrZQRfWyEe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 10:47:33 +0000, Colin Ian King wrote:

> Variable found_devs is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: qla2xxx: Remove unused variable found_devs
      https://git.kernel.org/mkp/scsi/c/e137b81d30e7

-- 
Martin K. Petersen	Oracle Linux Engineering
