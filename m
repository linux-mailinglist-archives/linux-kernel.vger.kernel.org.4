Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30A5688802
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjBBUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjBBUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:09:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C16EADB;
        Thu,  2 Feb 2023 12:09:09 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312K5Zf0030590;
        Thu, 2 Feb 2023 20:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=qA3uetDnh5K8SDSrjjFDBGsSe3mOGPcwWz+hIKsXPQE=;
 b=LeL+x7hvQ2H80MdzqIq8DRoAuhKoBsFMKhYC2ruMBnh10UqKXU0ZiihDYMyTP9UY+kBR
 wbVTn2RMrFLIqBDzmtHtgLks2vz3t8pD48TVwletf65UVu35+0XU6TEuLiNwi+wobhMA
 A2u9dJep2cxVuooaxxqMGm+Lh24ah9C4vLtm8YxRryjPS+AhoYy++wqYVVC//EOT9Mp5
 cVOV8oFvVwin48E4wVYkHc3vNgNlpq2AxJvAWqW2flD/Uf87v6ui+BBDFIb8XXkXQkVA
 CmVVh5JwKltBJSIN56tbj6AHbhkxYvLp/3ipWhVrxOOjQrzWyc33jsiAk8gtA5dGPOOf pw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngcyjma80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 20:08:54 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312EttMI013226;
        Thu, 2 Feb 2023 20:08:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ncvshcq5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 20:08:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312K8mcX45285834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 20:08:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 822D820040;
        Thu,  2 Feb 2023 20:08:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D2D120049;
        Thu,  2 Feb 2023 20:08:48 +0000 (GMT)
Received: from osiris (unknown [9.171.10.177])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Feb 2023 20:08:48 +0000 (GMT)
Date:   Thu, 2 Feb 2023 21:08:46 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.2-rc7
Message-ID: <Y9wYTnwXVwg/3Dv3@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uZsbdLOLv9m-3P5MMxvZgRvHvcWrFDin
X-Proofpoint-GUID: uZsbdLOLv9m-3P5MMxvZgRvHvcWrFDin
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_13,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020179
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull a couple of s390 fixes.

Thanks,
Heiko

The following changes since commit 41e1992665a2701fa025a8b76970c43b4148446f:

  s390: workaround invalid gcc-11 out of bounds read warning (2023-01-17 19:00:59 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-4

for you to fetch changes up to 7ab41c2c08a32132ba8c14624910e2fe8ce4ba4b:

  s390/decompressor: specify __decompress() buf len to avoid overflow (2023-01-31 18:54:21 +0100)

----------------------------------------------------------------
s390 fixes for 6.2-rc7

- With CONFIG_VMAP_STACK enabled it is not possible to load the s390
  specific diag288_wdt watchdog module. Reason is that a pointer to a
  string is passed to an inline assembly; this string however is located on
  the stack, while the instruction within the inline assembly expects a
  physicial address. Fix this by copying the string to a kmalloc'ed buffer.

- The diag288_wdt watchdog module does not indicate that it accesses memory
  from an inline assembly, which it does. Add "memory" to the clobber list
  to prevent the compiler from optimizing code incorrectly away.

- Pass size of the uncompressed kernel image to __decompress() call.
  Otherwise the kernel image decompressor may corrupt/overwrite an
  initrd. This was reported to happen on s390 after commit 2aa14b1ab2c4
  ("zstd: import usptream v1.5.2").

----------------------------------------------------------------
Alexander Egorenkov (2):
      watchdog: diag288_wdt: do not use stack buffers for hardware data
      watchdog: diag288_wdt: fix __diag288() inline assembly

Vasily Gorbik (1):
      s390/decompressor: specify __decompress() buf len to avoid overflow

 arch/s390/boot/decompressor.c  |  2 +-
 drivers/watchdog/diag288_wdt.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/s390/boot/decompressor.c b/arch/s390/boot/decompressor.c
index 8dcd7af2911a..b519a1f045d8 100644
--- a/arch/s390/boot/decompressor.c
+++ b/arch/s390/boot/decompressor.c
@@ -80,6 +80,6 @@ void *decompress_kernel(void)
 	void *output = (void *)decompress_offset;
 
 	__decompress(_compressed_start, _compressed_end - _compressed_start,
-		     NULL, NULL, output, 0, NULL, error);
+		     NULL, NULL, output, vmlinux.image_size, NULL, error);
 	return output;
 }
diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 4cb10877017c..6ca5d9515d85 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -86,7 +86,7 @@ static int __diag288(unsigned int func, unsigned int timeout,
 		"1:\n"
 		EX_TABLE(0b, 1b)
 		: "+d" (err) : "d"(__func), "d"(__timeout),
-		  "d"(__action), "d"(__len) : "1", "cc");
+		  "d"(__action), "d"(__len) : "1", "cc", "memory");
 	return err;
 }
 
@@ -268,12 +268,21 @@ static int __init diag288_init(void)
 	char ebc_begin[] = {
 		194, 197, 199, 201, 213
 	};
+	char *ebc_cmd;
 
 	watchdog_set_nowayout(&wdt_dev, nowayout_info);
 
 	if (MACHINE_IS_VM) {
-		if (__diag288_vm(WDT_FUNC_INIT, 15,
-				 ebc_begin, sizeof(ebc_begin)) != 0) {
+		ebc_cmd = kmalloc(sizeof(ebc_begin), GFP_KERNEL);
+		if (!ebc_cmd) {
+			pr_err("The watchdog cannot be initialized\n");
+			return -ENOMEM;
+		}
+		memcpy(ebc_cmd, ebc_begin, sizeof(ebc_begin));
+		ret = __diag288_vm(WDT_FUNC_INIT, 15,
+				   ebc_cmd, sizeof(ebc_begin));
+		kfree(ebc_cmd);
+		if (ret != 0) {
 			pr_err("The watchdog cannot be initialized\n");
 			return -EINVAL;
 		}
