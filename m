Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DA863E877
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLADqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLADpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:45:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CBD9075D;
        Wed, 30 Nov 2022 19:45:50 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B13PNEa016224;
        Thu, 1 Dec 2022 03:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=ZxrtDorFQ/R2rZ5koH37w22CKnkTyrKU/uQoI5HMqho=;
 b=xC31LDfegAFETwLeSMgFaRyxCWeDmWY/Kj9zXik8KZ1YlSk7Sht3MEUBTIEpS+erUlf0
 S2mVsOupJAVCgFbFsXHDE4N1aua6a4ONE5TiCaHVJRqgB65Hk9TCc+zAoPdQpU9/1V5q
 I1l7ANLgHxtBvw2WTWHdaG/0JuoQWWWyOQZIh2SB9FZ/R/W61O1RNOXQGzr9MhfvhuuD
 87mq7F4vpJPPPQU+7/fj77JEzE6OYti6z/nW/GHqGS7yAXBK9UyCoPyBiwdvhu6nXzon
 tQfPrb4Erp9QouTDw8lUjBOCRkDZ1ELvdF8pAJoQWap85QVp3/NoOLBh1tWdUfTzXCij CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemjjng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B13f2uu007584;
        Thu, 1 Dec 2022 03:45:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2cnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpW033801;
        Thu, 1 Dec 2022 03:45:42 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-6;
        Thu, 01 Dec 2022 03:45:42 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     alim.akhtar@samsung.com, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, bvanassche@acm.org, avri.altman@wdc.com,
        Chanwoo Lee <cw9316.lee@samsung.com>,
        linux-scsi@vger.kernel.org, adrian.hunter@intel.com,
        beanhuo@micron.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: core: Change the variable's(check_for_bkops) type
Date:   Thu,  1 Dec 2022 03:45:07 +0000
Message-Id: <166986602279.2101055.2201748570214760705.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111062209.7365-1-cw9316.lee@samsung.com>
References: <CGME20221111062238epcas1p3418881a8f028e97afbb498645704c9c5@epcas1p3.samsung.com> <20221111062209.7365-1-cw9316.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-ORIG-GUID: PH8eSoU3snuvbcBUM2GxeHKrB5-eBYdZ
X-Proofpoint-GUID: PH8eSoU3snuvbcBUM2GxeHKrB5-eBYdZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 15:22:09 +0900, Chanwoo Lee wrote:

> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> It only checks true and false, so it can be used as a bool type.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: ufs: core: Change the variable's(check_for_bkops) type
      https://git.kernel.org/mkp/scsi/c/5277326d07fb

-- 
Martin K. Petersen	Oracle Linux Engineering
