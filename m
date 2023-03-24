Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B266C856C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCXSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCXSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:53:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D36B5B90
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:53:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso3772753wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679683986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bN/V+wXkn6VKpx8ehUnZf15tp4N5UtPAc89buCNTYdI=;
        b=bu98ZAs0Afv51Za0kQE/RzrDrEwOt0xs2eqndfKe4rNxs+wqsDR0ptOIUDvlM6DQaz
         TShFbf4YJDjf+hY8JNkrKhxXnnMTZ8eePn3u6qckHSa8Qr/qf52PdiFTKi/Dn/Pq1Xfl
         5jxb14Cv6P/mPtxn6owPPgKAioRHp9HDgISGf1ZQ4R5V52HEM6WqHK6mHuDKSub5CfwY
         ZTw9XOlC8rd02KsQeEVzJrJajCIU2ZO4CkfNa/r5NDeINQNCI9iDW+JLOwJvHKp3TFIE
         2fBcd44eH6l5bamARPJ78bLa5Tyyl1xC0NszZ2oxkcih33o5bMewvKywv6r9PAXFn0K1
         5vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679683986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bN/V+wXkn6VKpx8ehUnZf15tp4N5UtPAc89buCNTYdI=;
        b=qFhz+65P6yUtN/6B8GI4X1qFCBIF1Hc7pNYh529t/EU0qQtHPGmZcTzWCslpUcDqnk
         rWcPGXBR2I4btQHovM6/W1fmmswWGzCQoCzLYc0BtcadtTyPvRsuZzcA4iq6fbDRCYg9
         5JyPjOHfVz1V2zfapRRZq1ZlVw+Bk5qio3Atwt3Qo6mdoXaB1IsXxyWCmEC6VgiysctF
         d1yPMZ6UNLSmxxWqe0lFfFhH5015vhGWo4U8hLVCGUuZjcINjcPT5pMfqHHbkE/O5+A1
         gK8V9Q0B/nqE6yzPFMRcATFbGtZvztj6uBcs2XLrHrz0QBJdsRIG+AMTTUS0RAiDJwi4
         bcwA==
X-Gm-Message-State: AO0yUKU9ruX8vCjec2HVwQY433Gynfq7Fo9/WSS1+y8ja3w6/I7/b6Cg
        xItDO2EXI2/Bo4ingplYttYIrQ==
X-Google-Smtp-Source: AK7set8LarYNE5XR9zQMQl74m9FglnwL3uYMLGTS7Xe71v0PquWOK+cq2G0SEkO3r0EPaLgMRwpUPw==
X-Received: by 2002:a7b:cbcc:0:b0:3ee:1afc:c14 with SMTP id n12-20020a7bcbcc000000b003ee1afc0c14mr3254271wmi.11.1679683985732;
        Fri, 24 Mar 2023 11:53:05 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002cfe685bfd6sm18948878wrw.108.2023.03.24.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 11:53:05 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 24 Mar 2023 19:52:47 +0100
Subject: [PATCH v2 2/2] checkpatch: allow Closes tags with links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?utf-8?q?Kai_Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3236;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=A6YcEFpnSEzRoE/JmsgqALbij5oTtx49G6r6xyFUvo8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkHfGOx31HhMzR0A+INyOMQmmGQah/4ZZO6p3Og
 2KcBLwkzDeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZB3xjgAKCRD2t4JPQmmg
 c/BWEADSzURwBTQcuMSbbLIgU0Ou5/VHGqfsm7MUZ7rhDqqBfUe7OXlZI/2tbKUDaZ7Gq3xszLG
 vHBLzvlwju+B7xLLRLBZ2w/cmoixV1m2S6gT9DHKn+F0ms95HfZmBFZXs/G0QylZNkmFWq9PPmw
 rlu5P9loP4G3/mw/8eToDGQLbeCU1uyUTKwOVupMbxNUqTOHwAQn5fM0LwDDrX8fsNCNo3ji/Rm
 zpkwxdjSrr7emjDnosJS+rBtSC/GUVVi8R4vs9Oxdpyr48L7Z4y4WloNTF4uzDVyjTrOv1KQSO8
 M1w5YzWQPAtNIPmZKlCdQIL2K1lwK7QsPEuslWEMf6uwz3rWZUP/QCOZ7UXPbhiFaYAVpERoQD7
 oCN8I92DG/RREDzdB/q0D+rZBs0mqaoVz49kt3X+Ju9DZIMsU+vgzVak6fmeFoIx23eBi8tYs5o
 4QMinXloHVfuH/au71si0QG4fcjKQb30CAAGMPIW4WXAAjGAGf169xQmHI4X8pUOvS43vqIbrRy
 2MOKPEnougitkE7BNLsZimh7AYWZc2ksJ/jI5vStDdcRaA0lpuxcxQelF8foCAyUMR4GfjjVoMA
 s01Yn1eBw5Dgx0sn8t4k3dRcQ5/zg4lqUdQVTrJqx1nJqU5BHSMShcGplYtO3nrrcfayLqOmGCZ
 fnn8Dbrs1p1SBkw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

