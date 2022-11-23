Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB476634CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiKWBOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiKWBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:13:33 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D14E635C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:12:24 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMNgtxi012457;
        Wed, 23 Nov 2022 01:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=uivm2Ei4DOSRQnGcYSbHK0a5R+84Xf4SNedCaI18Zjg=;
 b=ZlJbDUanJPxJExx4P9ZRyrAcfWn9sgB6P89l5RY3O6Jv96eCz2vgrZqBpfbWuOWVNrzu
 29+bYgCbP1P8x8vBEN/T8rz8cWlr0x/N5K594uIoPs5iHVLchAbPwI0z3Z727SjxIeAl
 9jwn2fgthBmEpVx0k5KcpT4Z3nsza2gtpv+G9PrHUlXVH4DYvr5W1nICLTIEjvbSLMvS
 f6cf0YfVxMuaamXqPeoUfTwbCFOkgW70EshbGbpaY5MCQshp6O8pXQorC24XtmxXomHA
 JzcOo+Md3TWofHK5Q5xorQzWF7dULrBy+aj/YwTXvfATg2D6HNzRJhix359dd4/bbTB/ eg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3m11wabgpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 01:12:19 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A665E809F5A;
        Wed, 23 Nov 2022 01:12:18 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5C5018005C6;
        Wed, 23 Nov 2022 01:12:18 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 1/5] checkpatch: improve Kconfig help text patch parsing
Date:   Tue, 22 Nov 2022 19:11:58 -0600
Message-Id: <20221123011202.939319-2-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123011202.939319-1-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
 <20221123011202.939319-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wJ5tyofWE0xKsFa1m5XInDX0qX1xzE1p
X-Proofpoint-ORIG-GUID: wJ5tyofWE0xKsFa1m5XInDX0qX1xzE1p
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=998 suspectscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230007
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While parsing Kconfig help text, allow the strings that affect
parsing (e.g., help, bool, tristate, and prompt) to be in existing
text, not just added text (i.e., allow both + and a space character
at the beginning of the line).

This improves parsing of a patch like:

+config CRYPTO_SHA512_S390
+       tristate "SHA384 and SHA512 (s390)"
+       depends on S390
        select CRYPTO_HASH
        help
-         SHA512 secure hash standard (DFIPS 180-2).
+         SHA-384 and SHA-512 secure hash algorithms (FIPS 180)

-         This version of SHA implements a 512 bit hash with 256 bits of
-         security against collision attacks.
+         Architecture: s390

-         This code also includes SHA-384, a 384 bit hash with 192 bits
-         of security against collision attacks.
+         It is available as of z10.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c8a616a9d034..1d9e563e768a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3490,11 +3490,11 @@ sub process {
 				next if ($f =~ /^-/);
 				last if ($f !~ /^[\+ ]/);	# !patch context
 
-				if ($f =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+				if ($f =~ /^[\+ ]\s*(?:bool|tristate|prompt)\s*["']/) {
 					$needs_help = 1;
 					next;
 				}
-				if ($f =~ /^\+\s*help\s*$/) {
+				if ($f =~ /^[\+ ]\s*help\s*$/) {
 					$has_help = 1;
 					next;
 				}
@@ -3519,7 +3519,8 @@ sub process {
 			    $help_length < $min_conf_desc_length) {
 				my $stat_real = get_stat_real($linenr, $ln - 1);
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a help paragraph that fully describes the config symbol\n" . "$here\n$stat_real\n");
+				     "please write $min_conf_desc_length lines of help text that fully describes the config symbol (detected $help_length lines)\n" .
+				     "$here\n$stat_real\n");
 			}
 		}
 
-- 
2.38.1

