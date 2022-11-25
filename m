Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E47638E25
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKYQRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKYQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:17:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933C4D5DE;
        Fri, 25 Nov 2022 08:17:19 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APFVb8i001097;
        Fri, 25 Nov 2022 16:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=Dm84lYHUP0DCKGATEPbPqGGKJYxOWWrfEoqzOe9vTes=;
 b=pfqra83C68oOxuAPY4Qw7hA/AG1BK3JsWcS+Em6DS2ByQJodIKsHDx8OB27EsX0amlXT
 ncf8TlJxsUyFpRLkixozw9vKq/jnQxg1aW0u1ix9GVAyoO6PPDD9zuVd4xq3FSeNEbcs
 3/i7v2TZX8uoii0R5jEZwIlouSjiUEglyZ42zfZbS1JjkZ2y/IsjfAULkUGkbcwqdiaF
 ldsn6oTtTtJ23URaeqtH6JcZIj5l+GhYfPqE0v2SgPrKL+mp49zELdBkWCtm4ylYtNJW
 J4Si6WUihPhrtBI7LPDdx+1yKfnKzAcuRG2BKVkwfkybVlYhqWMrXxg1JpLC1p1IGBR/ 0g== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m30e5h0eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 16:17:17 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2APG73qM017524;
        Fri, 25 Nov 2022 16:17:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3kxps973w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 16:17:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2APGAr2b10289900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Nov 2022 16:10:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69ED5AE053;
        Fri, 25 Nov 2022 16:17:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C2EAE051;
        Fri, 25 Nov 2022 16:17:12 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.179.2.228])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 25 Nov 2022 16:17:11 +0000 (GMT)
Date:   Fri, 25 Nov 2022 17:17:09 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 6.1-rc7
Message-ID: <Y4DqhTPzzIz+GiyO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RFsnbeWG6TqJUeNHo-vMJ8TqibcL1ZhI
X-Proofpoint-GUID: RFsnbeWG6TqJUeNHo-vMJ8TqibcL1ZhI
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_08,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211250126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.1-rc7.

Thank you,
Alexander

The following changes since commit e3c11025bcd2142a61abe5806b2f86a0e78118df:

  s390: avoid using global register for current_stack_pointer (2022-11-04 12:06:47 +0100)

are available in the Git repository at e3c11025bcd2142a61abe5806b2f86a0e78118df:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-6

for you to fetch changes up to adba1a9b81d5020a9bf8332fee9ff0171fe7623d:

  MAINTAINERS: add S390 MM section (2022-11-17 20:23:30 +0100)

----------------------------------------------------------------
s390 updates for 6.1-rc7

- Fix size of incorrectly increased from four to eight bytes 
  TOD field of crash dump save area. As result in case of
  kdump NT_S390_TODPREG ELF notes section contains correct
  value and "detected read beyond size of field" compiler
  warning goes away.

- Fix memory leak in cryptographic Adjunct Processors (AP)
  module on initialization failure path.

- Add Gerald Schaefer <gerald.schaefer@linux.ibm.com> and
  Alexander Gordeev <agordeev@linux.ibm.com> as S390 memory
  management maintainers. Also rename the S390 section to
  S390 ARCHITECTURE to be a bit more precise.

----------------------------------------------------------------
Heiko Carstens (2):
  s390/crashdump: fix TOD programmable field size
  MAINTAINERS: add S390 MM section

Wei Yongjun (1):
  s390/ap: fix memory leak in ap_init_qci_info()

 MAINTAINERS                   | 11 ++++++++++-
 arch/s390/kernel/crash_dump.c |  2 +-
 drivers/s390/crypto/ap_bus.c  |  5 ++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea5fcf9047ea..c4f6d3490d13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17987,7 +17987,7 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/savage/
 
-S390
+S390 ARCHITECTURE
 M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
 M:	Alexander Gordeev <agordeev@linux.ibm.com>
@@ -18042,6 +18042,15 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/s390/net/
 
+S390 MM
+M:	Alexander Gordeev <agordeev@linux.ibm.com>
+M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
+L:	linux-s390@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
+F:	arch/s390/include/asm/pgtable.h
+F:	arch/s390/mm
+
 S390 PCI SUBSYSTEM
 M:	Niklas Schnelle <schnelle@linux.ibm.com>
 M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index dd74fe664ed1..e4ef67e4da0a 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -46,7 +46,7 @@ struct save_area {
 	u64 fprs[16];
 	u32 fpc;
 	u32 prefix;
-	u64 todpreg;
+	u32 todpreg;
 	u64 timer;
 	u64 todcmp;
 	u64 vxrs_low[16];
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 59ac98f2bd27..b02c631f3b71 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -233,8 +233,11 @@ static void __init ap_init_qci_info(void)
 	if (!ap_qci_info)
 		return;
 	ap_qci_info_old = kzalloc(sizeof(*ap_qci_info_old), GFP_KERNEL);
-	if (!ap_qci_info_old)
+	if (!ap_qci_info_old) {
+		kfree(ap_qci_info);
+		ap_qci_info = NULL;
 		return;
+	}
 	if (ap_fetch_qci_info(ap_qci_info) != 0) {
 		kfree(ap_qci_info);
 		kfree(ap_qci_info_old);
