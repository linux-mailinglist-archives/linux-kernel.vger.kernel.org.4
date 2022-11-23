Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82A634CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiKWBOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbiKWBNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:13:37 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC64E0AA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:12:28 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMNhDkp003319;
        Wed, 23 Nov 2022 01:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ukwxXPbGmLCn1spwphTBIES8Kmvp/s1JITBBYWi1oWM=;
 b=JM7lzIetQRcwBkmLMXXVKf7U7TqSEA2VZ7GxjorYSPpTB/tgaeAgTHSHwQ/4mDdb2lzl
 j+bigHyRb7mf43eRbrCxAx5diVukLNWcaL1EnmVIzLFq+o/TugdT43FyIFo8Si9Cewlb
 GYMk7ZgH4Tf5YeBfgZvzjqG0FPZRfoVE5qpur/k4b68AEuGJsmLmD/mgEzDh9lcYOKZ/
 0+vXcn7czYYzipkyyCGSDqgPOzUhQuj3ej4CmO0twvNszJm/w4ORorrwQw1lpHz4OUUi
 2+kq+uCwOHsVbFuJqmdpG2vmaMqfKuH9bzIMQ2V2ImSHGkWz84VhQU8zFlHzSCKXUGq/ bg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3m100tcu9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 01:12:22 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id A30952EECF;
        Wed, 23 Nov 2022 01:12:21 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5BC0E8005C6;
        Wed, 23 Nov 2022 01:12:21 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 3/5] checkpatch: check line length in Kconfig help text
Date:   Tue, 22 Nov 2022 19:12:00 -0600
Message-Id: <20221123011202.939319-4-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123011202.939319-1-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
 <20221123011202.939319-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ex98Q3_cjLyTg2i0s1b7KCjL5a6M5tm9
X-Proofpoint-GUID: ex98Q3_cjLyTg2i0s1b7KCjL5a6M5tm9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230007
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply the normal --max-line-length=nn line length checks to
Kconfig help text.

The default of 100 is only triggered by one existing line in
a file named Kconfig. Running with --max-line-length=80 reports
only a few long lines:
- 11 between 90 and 99 characters
- 25 betwen 81 and 89 characters
9 of which are due to long URLs.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 scripts/checkpatch.pl | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c907d5cf0ac8..1b7a98adcaeb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3496,7 +3496,7 @@ sub process {
 				next if ($f =~ /^-/);
 				last if ($f !~ /^[\+ ]/);	# !patch context
 
-				if ($f =~ /^[\+ ]\s*(?:bool|tristate|prompt)\s*["']/) {
+				if ($f =~ /^[\+ ]\s*(?:bool|tristate|string|hex|int|prompt)\s*["']/) {
 					$needs_help = 1;
 					next;
 				}
@@ -3515,12 +3515,27 @@ sub process {
 				# and so hopefully shouldn't trigger false
 				# positives, even though some of these are
 				# common words in help texts
-				if ($f =~ /^(?:config|menuconfig|choice|endchoice|
-					       if|endif|menu|endmenu|source)\b/x) {
+				if ($f =~ /^(?:config|menuconfig|
+					       choice|endchoice|
+					       comment|if|endif|
+					       menu|endmenu|source)\b/x) {
 					last;
 				}
+
+				# no further checking for lines with these keywords
+				if ($f =~ /^(?:default|def_bool|depends|select|imply)\b/x) {
+					next;
+				}
+
+				my ($length, $indent) = line_stats($f);
+				if ($length > $max_line_length) {
+					WARN("CONFIG_DESCRIPTION",
+					     "Kconfig help text line length ($length) too long: $f\n");
+				}
+
 				$help_length++ if ($has_help);
 			}
+
 			if ($needs_help &&
 			    $help_length < $min_conf_desc_length) {
 				my $stat_real = get_stat_real($linenr, $ln - 1);
-- 
2.38.1

