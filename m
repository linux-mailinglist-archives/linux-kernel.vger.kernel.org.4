Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373E162E44A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbiKQSap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbiKQS36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:29:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CA97D53E;
        Thu, 17 Nov 2022 10:29:57 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHsmfZ028278;
        Thu, 17 Nov 2022 18:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=Ph50s/A2wBey7WwI4B/Y2YjKOIxDzxH+uhlt1zpDOiM=;
 b=B+e1Nwe24xDFU1nyySUYxjWFhRIzQA11lkGPjvxUyOnrhhqjYtMpS2V4+qcrcSysQVIv
 pXDenJ4pHxoaxktNcVz1vYMG/RvYI40HRE81BlCQywFQiQnK5ZLoVpdPyzg17N/f2I5P
 mEW75hngtJDTUE/susUZyvTUgxKCDU56HrlzaeNy5HaSgo8UY7PZ84ww0BUao4HtaxVL
 aARNRKpnE4q/MpxghAnDvQTbKRo5YK0f7djY0GGjSZZdgJGsFsWbsR5C4pBV9uBxNCas
 JGle/dJIYeGqrJKfqQffLFAIMN8IbMms2S413NvxLctUVu0WB3Q2o/OD/aFEPyKYF+Ul 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykt0vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHHaOp010894;
        Thu, 17 Nov 2022 18:29:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kab0pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:44 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHITapP022894;
        Thu, 17 Nov 2022 18:29:44 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kab0gb-13;
        Thu, 17 Nov 2022 18:29:44 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, fthain@linux-m68k.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>, schmitzmic@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: NCR5380: fix repeated words in comments
Date:   Thu, 17 Nov 2022 13:29:35 -0500
Message-Id: <166870943111.1584889.14839538149895035736.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221028133708.60030-1-yuanjilin@cdjrlc.com>
References: <20221028133708.60030-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=961 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170133
X-Proofpoint-GUID: siU5ah4iskZiFzL5ZKB7zFodt0M5qDSi
X-Proofpoint-ORIG-GUID: siU5ah4iskZiFzL5ZKB7zFodt0M5qDSi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 21:37:08 +0800, Jilin Yuan wrote:

> Delete the redundant word 'the'.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: NCR5380: fix repeated words in comments
      https://git.kernel.org/mkp/scsi/c/e47c49219c1e

-- 
Martin K. Petersen	Oracle Linux Engineering
