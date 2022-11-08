Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9146207F6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiKHECc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiKHECT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:02:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CB111A10;
        Mon,  7 Nov 2022 20:02:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OUds027225;
        Tue, 8 Nov 2022 04:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=p7ZFrJOU7uPmtDJ2eDaTA1xoKp47Xds1vSVV4eepMMA=;
 b=DKKhKNgCcBfVy9haeB7xOzwN8SUSClRYNS/qsodVo00aau8GAaOvqMWptjvWbhPnwkf9
 HV7lRRr2hm8T562ck0s6KkGRiXqlsMhR+a8AYi60MuM0S9U/l2SvkzpDS5HXLT1l92RZ
 RQ/ldq7aklj3Ra2AN0XG1O51KIJrKWZSp3rFqx7eNUyUYXF8EL7vGHzcv6STqlhU4uI+
 dh2xhbfwqCs5G1ikQYK7u98Siw2jpN7F3esZa8tRg4eNixaj03fMmf2u/MjrXA6TvXep
 DZSYP3F2vhk7Cccm5s9v8S5eDu65waYIgLitRGKRHkqiyJMvzxxeCw9mhwRsbS5xhr0O kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngrenwge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 04:02:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A83VkOM025571;
        Tue, 8 Nov 2022 04:01:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqfh3sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 04:01:59 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A841vck022774;
        Tue, 8 Nov 2022 04:01:59 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kpcqfh3s5-4;
        Tue, 08 Nov 2022 04:01:59 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        linux-scsi@vger.kernel.org,
        YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: nsp_cs: remove variable i
Date:   Mon,  7 Nov 2022 23:01:51 -0500
Message-Id: <166787988584.644518.9749791903488833397.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221024141101.2161167-1-colin.i.king@gmail.com>
References: <20221024141101.2161167-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=981 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080020
X-Proofpoint-ORIG-GUID: t59t22_Jvp-K-S0kFi9N4tnYY0fkMdVb
X-Proofpoint-GUID: t59t22_Jvp-K-S0kFi9N4tnYY0fkMdVb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 15:11:01 +0100, Colin Ian King wrote:

> Variable i is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: nsp_cs: remove variable i
      https://git.kernel.org/mkp/scsi/c/25ad6f63e77e

-- 
Martin K. Petersen	Oracle Linux Engineering
