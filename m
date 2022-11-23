Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A47634CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiKWBOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiKWBNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:13:35 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30A2AFB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:12:27 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMNgJd1029821;
        Wed, 23 Nov 2022 01:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=/RlTiZLWuG8bRJv8ZA7ysw/ihW0wSsUpLCj7eFOnAnA=;
 b=C5WpVZEs0T+vQS+oNjlXTSRU7BPRD97eT7MhiLpwwx+I1QhpSVqUrek5RHpSn/RNEARt
 So9QAbD+e1EofHGqn40qyWg376cn8kj81KpA5tQlkWAAWRQhS160Lyqz8egPb9uaShLx
 WfRZ9UBIJKCH3k0r+m42N6rn4Ac4CZXYGy6nnyzPc2m1mz+ayCrkPJrYAk6OHPm3glja
 W7VvAUnCNHNOok3uVFy+0ovTHASwM09IQ3vQopec8XK8jwFN+pdq6AXVBhWjAPSo3ZFe
 2Xn7JeTJf9KhTtS6NYragGdz4Z3ObSMHByEZzLxb9PAlRNcp0YLyEea+tpKRpN8OpxBO Cw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m13u0tehx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 01:12:24 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C02192FCC1;
        Wed, 23 Nov 2022 01:12:23 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 6E105800369;
        Wed, 23 Nov 2022 01:12:23 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 5/5] checkpatch: ignore a file named b
Date:   Tue, 22 Nov 2022 19:12:02 -0600
Message-Id: <20221123011202.939319-6-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123011202.939319-1-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
 <20221123011202.939319-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1-ryaoU6EXcneHyP9pUzEm3YoYVfT46s
X-Proofpoint-GUID: 1-ryaoU6EXcneHyP9pUzEm3YoYVfT46s
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=630 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230007
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a file named "b" happens to exist, checkpatch complains
as it parses the patch lines specifying the filenames.

	WARNING: patch prefix 'b' exists, appears to be a -p0 patch

Squelch that by only complaining if that is a directory,
not a regular file, and print the whole path causing concern.
	WARNING: patch prefix './b' exists, appears to be a -p0 patch

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d11d58e36ee9..5a0252265d3f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2834,9 +2834,9 @@ sub process {
 
 			$p1_prefix = $1;
 			if (!$file && $tree && $p1_prefix ne '' &&
-			    -e "$root/$p1_prefix") {
+			    -d "$root/$p1_prefix") {
 				WARN("PATCH_PREFIX",
-				     "patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
+				     "patch prefix '$root/$p1_prefix' exists, appears to be a -p0 patch\n");
 			}
 
 			if ($realfile =~ m@^include/asm/@) {
-- 
2.38.1

