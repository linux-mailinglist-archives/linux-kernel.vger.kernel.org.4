Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0397062F96F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbiKRPho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbiKRPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:37:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE05BD43;
        Fri, 18 Nov 2022 07:37:41 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIE7Vjn004828;
        Fri, 18 Nov 2022 15:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=LJjueMsxaMQsANjbbq1IvowlPbGA5ZyiwUeFPz7qduo=;
 b=kOEs+4Sl0YP+dO9Tr+gomsrvOTh9PZZpPl4QeLpqrwiIvM+zNQ2q1KnhS4SRSUJZCWDi
 /eqNSx1zdFqpT+WlOAZgLPaexbD+X8R7XNaoiidOTfbfrHMYV486nHQZnUmEtfPU18IZ
 nn1ku6vKpeE3u7turF1tLVOCZT82BkbuoYjkJ37CFdl+iHXkZp9qIrLXHnq3vFe6SZNN
 BZWQc8cHgPnByX0xiclYrATgRb2xt/vTr116N+xSIyt0NlwOOjsDHyR6G9nEQU4zZRxH
 7mi085/+8FO+JcSHND0kqCyJsqVg4ViNr9TIiMcakUcUjQv6mceeLLyXD+QMo3gm3ypy Nw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx9jjw3nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:37:39 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AIFbGiD011525;
        Fri, 18 Nov 2022 15:37:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3kwu4yh39q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:37:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AIFbWNA64487698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 15:37:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D801F4C046;
        Fri, 18 Nov 2022 15:37:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A65594C040;
        Fri, 18 Nov 2022 15:37:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 18 Nov 2022 15:37:32 +0000 (GMT)
Date:   Fri, 18 Nov 2022 16:37:31 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 6.1-rc6
Message-ID: <Y3emu4epRB+EcdoM@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G1iTzKDkQJ5IuIe3Uyp_-EL68Wh2riSp
X-Proofpoint-GUID: G1iTzKDkQJ5IuIe3Uyp_-EL68Wh2riSp
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_02,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.1-rc6.

Thank you,
Alexander

The following changes since commit 30d17fac6aaedb40d111bb159f4b35525637ea78:

  scripts/min-tool-version.sh: raise minimum clang version to 15.0.0 for s390 (2022-10-31 13:34:56 +0100)

are available in the Git repository at e3c11025bcd2142a61abe5806b2f86a0e78118df:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-5

for you to fetch changes up to :

  s390: avoid using global register for current_stack_pointer (2022-11-04 12:06:47 +0100)

----------------------------------------------------------------
s390 updates for 6.1-rc6

- Fix deadlock in discontiguous saved segments (DCSS) block device
  driver. When adding a disk and scanning partitions the scan would
  not break out early without a missed flag.

- Avoid using global register variable for current_stack_pointer
  due to an old bug in gcc versions prior to gcc-8.4. Due to this
  bug a broken code is generated, which leads to stack corruptions.

----------------------------------------------------------------
Gerald Schaefer (1):
  s390/dcssblk: fix deadlock when adding a DCSS

Vasily Gorbik (1):
  s390: avoid using global register for current_stack_pointer

 arch/s390/include/asm/processor.h | 11 ++++++++++-
 drivers/s390/block/dcssblk.c      |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 87be3e855bf7..c907f747d2a0 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -199,7 +199,16 @@ unsigned long __get_wchan(struct task_struct *p);
 /* Has task runtime instrumentation enabled ? */
 #define is_ri_task(tsk) (!!(tsk)->thread.ri_cb)
 
-register unsigned long current_stack_pointer asm("r15");
+/* avoid using global register due to gcc bug in versions < 8.4 */
+#define current_stack_pointer (__current_stack_pointer())
+
+static __always_inline unsigned long __current_stack_pointer(void)
+{
+	unsigned long sp;
+
+	asm volatile("lgr %0,15" : "=d" (sp));
+	return sp;
+}
 
 static __always_inline unsigned short stap(void)
 {
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 93b80da60277..b392b9f5482e 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -636,6 +636,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	dev_info->gd->minors = DCSSBLK_MINORS_PER_DISK;
 	dev_info->gd->fops = &dcssblk_devops;
 	dev_info->gd->private_data = dev_info;
+	dev_info->gd->flags |= GENHD_FL_NO_PART;
 	blk_queue_logical_block_size(dev_info->gd->queue, 4096);
 	blk_queue_flag_set(QUEUE_FLAG_DAX, dev_info->gd->queue);
 
