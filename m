Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496BB634CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiKWBOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiKWBNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:13:34 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B1E637C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:12:24 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN0uaYm012985;
        Wed, 23 Nov 2022 01:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=53WUj66kSlTxVlm5E0/810fEfYL6naf3aRf1XIo5+s0=;
 b=jcEWBsoQEVQB8RnYobxTMMO2hQieHr4zUNoIL3L84rTQ50F+vArtQQmZ6FoCK8xfBxMU
 QEvrvUp5/sopm0o99IUWwxSernPNDmzOcccv7pKOBcp3K3M89WfJjj+A4jV9gajyBY2o
 dTf+bVYFAQCDyjgBSD1kSJVK5jGO9jIac0VsGIchKCrfwxagbrznWypuVSazx6P6dVxt
 loMnHn5+NRALkQUmKn/0q/9aYmTTCZClEO/qc1V74/lzv8dF67GGSRtru56s10n+tlje
 rsloY9PDP7/PnzPjD3dFRXl8jGXT7ryLv6Ehws396mY9JeDCdPqvkv4Lz2DZ5sEzb/VL Uw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3m19cyg342-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 01:12:20 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 3EB568066C3;
        Wed, 23 Nov 2022 01:12:20 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id DC89880037B;
        Wed, 23 Nov 2022 01:12:19 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 2/5] checkpatch: don't sanitise quotes in Kconfig files
Date:   Tue, 22 Nov 2022 19:11:59 -0600
Message-Id: <20221123011202.939319-3-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123011202.939319-1-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
 <20221123011202.939319-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o2LeRF8L6v_VKOy71p9bOgqrRcDdy68B
X-Proofpoint-GUID: o2LeRF8L6v_VKOy71p9bOgqrRcDdy68B
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=642
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230007
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Kconfig help text contains a single quote (e.g., can't),
checkpatch replaces all characters with X until another quote
appears in some later help text. This interferes with processing
keywords.

Don't sanitise lines if the file is a Kconfig file.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 scripts/checkpatch.pl | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1d9e563e768a..c907d5cf0ac8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2715,9 +2715,15 @@ sub process {
 			sanitise_line_reset($in_comment);
 
 		} elsif ($realcnt && $rawline =~ /^(?:\+| |$)/) {
-			# Standardise the strings and chars within the input to
-			# simplify matching -- only bother with positive lines.
-			$line = sanitise_line($rawline);
+			if (($realfile =~ /Kconfig/) ||
+			    (!$is_patch && $filename =~ /Kconfig/)) {
+				# Kconfig help text is free to use unmatched quotes
+				$line = $rawline;
+			} else {
+				# Standardise the strings and chars within the input to
+				# simplify matching -- only bother with positive lines.
+				$line = sanitise_line($rawline);
+			}
 		}
 		push(@lines, $line);
 
-- 
2.38.1

