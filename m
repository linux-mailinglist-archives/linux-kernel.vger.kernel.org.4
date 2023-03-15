Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0076C6BBB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjCORq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjCORqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:46:17 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E117CC1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:45:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id be16so14797846oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678902337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bN/V+wXkn6VKpx8ehUnZf15tp4N5UtPAc89buCNTYdI=;
        b=txLipfRL7537IPV2JXowDg7roRjwk4UpbUg+6CIVDFvtBSbOejLk4WG+yxPd9RFjrG
         fmgup7gZ0h1sm+IN7pqSdBKUhYmXZ5rXqEtOlBHihddilPhMBqEhKkLLs7WmCRt+HLKo
         VbAulh45WmYExYo2P/UlTfQptqJLIrF4ZiYsmItRpH66CXuoXL4+9iiSnNb+R/+a7EhQ
         6dlTOzPqbJAkUUl/zozkJPgGw/MGoLaTLGKsuy0zoVP+4JBJ1zjO5zjLbRduyVQQLkRm
         cm2u/AyZi2ddjFfxPyuJZg8Mb8AebiFD3H183kotSg9krWIMyUj063JhAkUptSiJy0xJ
         lv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bN/V+wXkn6VKpx8ehUnZf15tp4N5UtPAc89buCNTYdI=;
        b=j9nMOuNpPW9GPu1jABkfQ5YmDbV+oZRKyqoyPmO0BpfUnT9+48mau53rQTlHwlPebv
         lYmn8ONk1+gQGcICFPKR+RPMcP3Jil/wkckGckApli7Y28Xyji3Xd9kd3DfLmw77ykJG
         CHq9NU01gUy6rupB8tG+9exc82wBc3DJx9jl1plwjeCKLK+aurIzes25cxbYtSu8qjHm
         IAC3hsvFm5PorYkE8vg/ifJYGDSuHiBGoyOaQNxoHK+ahYZI/NcvQZ4tQJ9bqiXcJaBr
         uQ/unh+t0zP/2lEME1EJf7V1ZoOWbF6um+GL+lyDDshIy8OEdF7xzHmykMMKJWoavS0a
         4cYw==
X-Gm-Message-State: AO0yUKUECyfgiIDVEOpdMzrDC60Lw1QXzs7EQC8SIVXN9Rwsw8gMkI1x
        jNlTVnKwoi7AW1IzMLBP9mIhMg==
X-Google-Smtp-Source: AK7set+Ir9tTpNM3Sva61StQp6XzXA1AtwFZTH5151sazr8Y5ABGmWkcoRyy8RnHE+jA5ziTt+r6KQ==
X-Received: by 2002:aca:210e:0:b0:386:9bf4:4eca with SMTP id 14-20020aca210e000000b003869bf44ecamr1669333oiz.41.1678902335734;
        Wed, 15 Mar 2023 10:45:35 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p81-20020acad854000000b00383f0773beasm2381095oig.52.2023.03.15.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:45:35 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Wed, 15 Mar 2023 18:44:57 +0100
Subject: [PATCH 2/2] checkpatch: allow Closes tags with links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-doc-checkpatch-closes-tag-v1-2-1b83072e9a9a@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?utf-8?q?Kai_Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3236;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=A6YcEFpnSEzRoE/JmsgqALbij5oTtx49G6r6xyFUvo8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkEgQqZbkBzEdmtjdwU+q6yqQl7LtzZ9Yelc59S
 +5CdRSALLmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZBIEKgAKCRD2t4JPQmmg
 c1U4EACeDeP4TjzBX8m6lAjOhKEFKR+tLBg3fv4mundtsGnJf6E4kOr6/DkmaYaU321JdRMHmCl
 /ElPPmjdnvsGV67tBMg9E8w6rqCTTq1FpX0/xGEcUVAoAr8LyeRfsqNkpDz21e9QBroAvkAd6h/
 TLjLbi5Pz48fwDH3lnGhqF0HNN1eG8gzxROLU0V6Rs2eHYVU3c0V8nUtzimo8to88GSML+h5IBT
 RUwN2BM51YFvU3RrbAHwHNdxyFWYICjpKF4VFwd+l8Wzaefl3WahDe/DK4KKbnzLobU+unijETS
 QrRvGSwOrz6YwVdLjydiowAtkGamyuD9P/whxvbYD9ffgnxbQQRYZemJiba9y8t9YTiBeL1UIZE
 Zce2ds1zV5oI0ntWbQ5WvSZvu2zznGPRYWog6vwoc/o1dI/+XoDrlqArABqzvnQvUKRmQkH2jvC
 eaJX94JO8pyoLUcycR8zReMZU2zXQLxEcy+5xia053/dzadzat3WPoJ2neEYNtw+UwhgmxBeBuc
 pMwmXLskR2H6Do7wlu/vLu7XKqHw/jdl2VwkewMCgvpCezUGX4JqwR7Cxgb68/7X0PxWXDQ1T4d
 U6OgdQDR8ngxiF7eFNykfT7HGljiD43IW1Mz0L588R7iMfqQ6zUP9FwsGOkLXEFBKaPgm4jp5VG
 6F6rnvs4/nkPdSg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow-up of the previous patch modifying the documentation to
allow using the "Closes:" tag, checkpatch.pl is updated accordingly.

checkpatch.pl now mentions the "Closes:" tag between brackets to express
the fact it should be used only if it makes sense.

While at it, checkpatch.pl will not complain if the "Closes" tag is used
with a "long" line, similar to what is done with the "Link" tag.

Fixes: 76f381bb77a0 ("checkpatch: warn when unknown tags are used for links")
Fixes: d7f1d71e5ef6 ("checkpatch: warn when Reported-by: is not followed by Link:")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/373
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 scripts/checkpatch.pl | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd44d12965c9..d6376e0b68cc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3158,14 +3158,14 @@ sub process {
 				}
 			}
 
-# check if Reported-by: is followed by a Link:
+# check if Reported-by: is followed by a Link: (or Closes:) tag
 			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
-				} elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {
+					     "Reported-by: should be immediately followed by Link: (or Closes:) to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+				} elsif ($rawlines[$linenr] !~ m{^(link|closes):\s*https?://}i) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Link: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+					     "Reported-by: should be immediately followed by Link: (or Closes:) with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
 				}
 			}
 		}
@@ -3250,8 +3250,8 @@ sub process {
 					# file delta changes
 		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
 					# filename then :
-		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
-					# A Fixes: or Link: line or signature tag line
+		      $line =~ /^\s*(?:Fixes:|Link:|Closes:|$signature_tags)/i ||
+					# A Fixes:, Link:, Closes: or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
 			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
@@ -3266,13 +3266,13 @@ sub process {
 
 # Check for odd tags before a URI/URL
 		if ($in_commit_log &&
-		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link') {
+		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link' && $1 ne 'Closes') {
 			if ($1 =~ /^v(?:ersion)?\d+/i) {
 				WARN("COMMIT_LOG_VERSIONING",
 				     "Patch version information should be after the --- line\n" . $herecurr);
 			} else {
 				WARN("COMMIT_LOG_USE_LINK",
-				     "Unknown link reference '$1:', use 'Link:' instead\n" . $herecurr);
+				     "Unknown link reference '$1:', use 'Link:' (or 'Closes:') instead\n" . $herecurr);
 			}
 		}
 

-- 
2.39.2

