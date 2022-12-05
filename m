Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E71642612
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLEJsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiLEJsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:48:32 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0BA13DDF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:48:30 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso10889758pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZnwPtKvQW/jye+b9cqc79eHyEu3FBg4FPXfjO+bNBM=;
        b=opnuKSlgkjT8O+bkJW0QWOW5PCNBodhJhMR0iAGYEdF6Z64dVrVC4au0CUrfTh0g3m
         15pViOIu8Q+A74wbXqLNwRGZ7xSI8+QloAVLnjQpaDbDp1KAtTxetUcOgAwF1FGUs+UR
         /JWbeCOhfx7JlLbKZU5v8smHjLRf8Yrmjb5wdqxMGqcCump9nCSJNSyKshwYFftUii8e
         1PdE7VKoR7Bm6BC8I0B6yJtSmO7wbILX0pgpAtAUw5eH6gUUne4hYUvZkddCe2d4CcZ7
         XCkAzVJVG6XdE19kP0BUd4tuZh7SdTcybkr9ELtInODRTSr23IPet0m9JbZlcezFarmC
         zpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZnwPtKvQW/jye+b9cqc79eHyEu3FBg4FPXfjO+bNBM=;
        b=nSgnDidldvTYZeFwA3QlB+nWxtjmm6gB0KxfkSPByX8NFzchgGPfPG4cTS3nI3e47J
         MCLRFJbEEKNhlJt7iyPmRNqLE7R5Jxh4kzMqllWWz0We04Pigym9AMskrh6xBPUzCxZJ
         psMWZsWoThGeQU+LTv02+pBS93m+6DBWfanx/faPSONoq+9rvU7zwJAjHpia9xq4ceuI
         3iWG8Pcg0fPOSq72cQva9KonNU1M2fSca67cYMpE0XZFHud+Exy0rei6sau1bGZRkIJL
         KQD6qjmHQrpgpKzE49kFzuAM0y+Sn6Ll05b7uhL0eEFc6f6BdSKT1KECV1Xyg/yR9YcA
         A+Ow==
X-Gm-Message-State: ANoB5pkekjlnsgY9isFQNtuYJdxMRyJl4OWFjcW34tTuRpVX0/oUkIKb
        un3oZEVEdTKrS9sbVfe4zcPLVVk6LLapQw==
X-Google-Smtp-Source: AA0mqf4rrOennd2qGbQIB0z3GsfXJV4beX3uVs7QyJlzWzsW9y1jbP8+vnrmBRSGnS0Ppq090ms6lA==
X-Received: by 2002:a17:903:1015:b0:189:854e:93b1 with SMTP id a21-20020a170903101500b00189854e93b1mr39424065plb.117.1670233710007;
        Mon, 05 Dec 2022 01:48:30 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.43])
        by smtp.gmail.com with ESMTPSA id 24-20020a630d58000000b0045751ef6423sm7865083pgn.87.2022.12.05.01.48.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Dec 2022 01:48:29 -0800 (PST)
From:   korantwork@gmail.com
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     alexs@kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: [PATCH] checkpatch: Add the backport commit format check
Date:   Mon,  5 Dec 2022 17:48:26 +0800
Message-Id: <20221205094826.44844-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinghui Li <korantli@tencent.com>

The backport commit has been  used to be misreported as Error
by checkpatch.pl like this:

'ERROR: Please use git commit description style
'commit <12+ chars of sha1> ("<title line>")' - ie:......
commit <sha1> upstream.

total: 1 errors, 0 warnings, 8 lines checked
'
So, add the backport commit format check to avoid the above mistake.

Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 scripts/checkpatch.pl | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1e5e66ae5a52..92ba39418239 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3252,6 +3252,10 @@ sub process {
 # A correctly formed commit description is:
 #    commit <SHA-1 hash length 12+ chars> ("Complete commit subject")
 # with the commit subject '("' prefix and '")' suffix
+# A correctly formed backport commit description is:
+#	commit <sha1> upstream.
+# or
+#	[ Upstream commit <sha1> ]
 # This is a fairly compilicated block as it tests for what appears to be
 # bare SHA-1 hash with  minimum length of 5.  It also avoids several types of
 # possible SHA-1 matches.
@@ -3278,6 +3282,7 @@ sub process {
 			my $herectx = $herecurr;
 			my $has_parens = 0;
 			my $has_quotes = 0;
+			my $backport = 0;
 
 			my $input = $line;
 			if ($line =~ /(?:\bcommit\s+[0-9a-f]{5,}|\bcommit\s*$)/i) {
@@ -3307,18 +3312,21 @@ sub process {
 				$long = 1 if ($input =~ /\bcommit\s+[0-9a-f]{41,}/i);
 				$space = 0 if ($input =~ /\bcommit [0-9a-f]/i);
 				$case = 0 if ($input =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
+				$backport = 1 if(($input =~ /\bcommit\s+[0-9a-f]{12,40}\supstream/i) ||
+								 ($input =~ /\B\[\s[Uu]pstream\scommit\s+[0-9a-f]{5,}\s\]/));
 			} elsif ($input =~ /\b([0-9a-f]{12,40})\b/i) {
 				$orig_commit = lc($1);
 			}

 			($id, $description) = git_commit_info($orig_commit,
 							      $id, $orig_desc);
 
 			if (defined($id) &&
 			    ($short || $long || $space || $case || ($orig_desc ne $description) || !$has_quotes) &&
-			    $last_git_commit_id_linenr != $linenr - 1) {
+			    $last_git_commit_id_linenr != $linenr - 1
+			    && !$backport) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);
+				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\nor check the backport commit description format\n" . $herectx);
 			}
 			#don't report the next line if this line ends in commit and the sha1 hash is the next line
 			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
-- 
2.27.0

