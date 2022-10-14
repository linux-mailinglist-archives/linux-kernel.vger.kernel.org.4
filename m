Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0FE5FF348
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiJNRzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJNRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:55:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB2D5E30F;
        Fri, 14 Oct 2022 10:55:04 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EHhFdZ027137;
        Fri, 14 Oct 2022 17:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=kcBMuUqCrFDIyUYHPm6sprdE+QukYKz3A/V/aplsMJE=;
 b=hf5uQ7Q9xE+22o56neVfoImRDc83xTyCl1jJmZiVuNUi9q1Q3Wthx1QPrFDlxaSjIHzh
 9FCcQBkyaUtA1tIoEEtWX5iHQTzEQIDPQVEP4Hni36ZKbGVOAhGZrpHXxBHzwApbO7TT
 0s+lAXgb5m2cLB9oEnf18YVuNIK+BANM68iZycqioyomcwYlSjLyrnYnhACIA9BIx3Ye
 bIJADLBdBgUhdSM27mkceaVmftMJ8an90gr7m4t18idn7kMGwICahA9ItyXxVC10e7Bu
 hTmHapm0dsEQbDY/7vhsXxIxcrcejzR5Ro3DHwW45ADwir2rPCTzOiw6YSbskU15s7uf Dg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k7cdr8fqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 17:55:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29EHos2N032706;
        Fri, 14 Oct 2022 17:55:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3k30u99qa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 17:55:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29EHsvQP66126242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 17:54:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E468A4062;
        Fri, 14 Oct 2022 17:54:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19D66A405B;
        Fri, 14 Oct 2022 17:54:57 +0000 (GMT)
Received: from localhost (unknown [9.171.62.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Oct 2022 17:54:57 +0000 (GMT)
Date:   Fri, 14 Oct 2022 19:54:55 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 6.1 merge window #2
Message-ID: <your-ad-here.call-01665770095-ext-6515@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CZqZ7RsPFA52biaBE9laLo08iYIKgFkN
X-Proofpoint-GUID: CZqZ7RsPFA52biaBE9laLo08iYIKgFkN
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=731
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull couple more s390 changes for 6.1.

Thank you,
Vasily

The following changes since commit 03785a69ae47a17fe57fee31058fef7cd3042977:

  Merge tag 's390-6.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2022-10-09 13:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-2

for you to fetch changes up to bf18140d30541c2c1e5c0f57879634f3d0d04912:

  s390/vmur: generate uevent on unsolicited device end (2022-10-10 10:15:10 +0200)

----------------------------------------------------------------
s390 updates for the 6.1 merge window #2

- Generate a change uevent on unsolicited device end I/O interrupt for z/VM
  unit record devices supported by the vmur driver. This event can be used to
  automatically trigger processing of files as they arrive in the z/VM reader.

----------------------------------------------------------------
Peter Oberparleiter (2):
      s390/vmur: remove unnecessary BUG statement
      s390/vmur: generate uevent on unsolicited device end

 drivers/s390/char/vmur.c | 37 ++++++++++++++++++++++++++++++++++---
 drivers/s390/char/vmur.h |  2 ++
 2 files changed, 36 insertions(+), 3 deletions(-)
