Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EBC6E7187
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjDSDUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjDSDUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:20:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9BD2;
        Tue, 18 Apr 2023 20:20:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IMSUv7002245;
        Wed, 19 Apr 2023 03:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=5f4VMJbHham+n1RQ4WUie8jH3PnxHTUMwq7L57skQkU=;
 b=JaOI+mDZmqiiT0rBwofdDsUNRYJCto/TBswth5HWhbToxbt4JdRAdqzJ7G0XJikPPVc6
 27x1TDWWIVphxKpoh6mWJ+vevpK5F6iTmrvIGFLP491TiMN0z5Ay1riYIORW8IYi/1fY
 oDuqFJWaDq7jZNkfRnKVlqcgharXGV2xEI3hRpNcZ5aGk0YwWRjCi+gdx7z3JKdmsWLM
 e8ZLiaMn0JdAXjcis8lGiQI6nMcHL1+98BheTnXqajY5Sb4SC0Nh4J2Qwb3JWZN6MNt7
 mZZ9/6PdeI1R5OcDBLtDC+m+Rs9gG7fq4Tq5tQeM1bP8vnZsbi11Nw+O1TxW6Ob6IkHr ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhty6du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:20:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33J26AHk037233;
        Wed, 19 Apr 2023 03:20:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcccvv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:20:23 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33J3KLpB012748;
        Wed, 19 Apr 2023 03:20:22 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pyjcccvts-3;
        Wed, 19 Apr 2023 03:20:22 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "Manoj N . Kumar" <manoj@linux.ibm.com>,
        "Matthew R . Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Spelling s/semahpore/semaphore/
Date:   Tue, 18 Apr 2023 23:20:12 -0400
Message-Id: <168187437339.702980.4296817245335455183.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <d7d04004b818d7ab5d62002f286b0a1b0b493193.1681208251.git.geert+renesas@glider.be>
References: <d7d04004b818d7ab5d62002f286b0a1b0b493193.1681208251.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_17,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=762 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190029
X-Proofpoint-GUID: LpXc5J00gNIvyg0m8VqPb4BVC-XB5ijq
X-Proofpoint-ORIG-GUID: LpXc5J00gNIvyg0m8VqPb4BVC-XB5ijq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 12:18:20 +0200, Geert Uytterhoeven wrote:

> Fix misspellings of "semaphore".
> 
> 

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: Spelling s/semahpore/semaphore/
      https://git.kernel.org/mkp/scsi/c/cabb63746511

-- 
Martin K. Petersen	Oracle Linux Engineering
