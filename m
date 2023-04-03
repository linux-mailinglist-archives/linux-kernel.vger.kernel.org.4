Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5AF6D4D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjDCQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjDCQX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:23:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F49A1722
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:23:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v6-20020a05600c470600b003f034269c96so8238933wmo.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680539034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFndR9/W7h5aU4Fe2XwyfApUNUusTQXxY5Oh96Y5H08=;
        b=CtTiSqSFHAGl4ZEfSiggNEz/WxSjrXIU2rznjS7Pkq3KwaNVbsNHM12116ZNSm0hFx
         Ra5Yng5Pf/c9ha+QNvcrgPErs9g/2EY68USmA7SkakP0CCJwsrcpFU+Fd4YmzAmdNksY
         CMBH7q/02vbPZGRCQU3izxJb4dMo4IBQtu6xkUGKxnq92rVuiaPIlpJxvQc0gz2HEnSt
         axU/EdtXzAIQ+ooRKbpXiiiLdV7e/rtOzAed0oe0P5Zosb1IWLfjMyWlsvLC8Fh9MpAs
         cvD2jYvyxDosKBQY2qPFirKGk+7yK0e8TI74LzOwt4DvNvP2qcAyh4OrXMdwlrpDpdhB
         uGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFndR9/W7h5aU4Fe2XwyfApUNUusTQXxY5Oh96Y5H08=;
        b=g0WS+8uCt3GJ6p7gVRCURxjlo4FH1d+HvU2oVzErNqenzi4CfhyoXYyqNUgMtAPoyJ
         HyolAOsnq7Ny9HdDr7mLWtPgBwKDpnfkltoZTjJPI4xnbkqFQbbzn7SD4k8vMMHAskWi
         yuljJdI/0Z+QZjlIvxtHCAb/ftAHqhk+B4tqp2dhg+lNtp3zXbTuLvkzNg5io4IiWQgM
         wnfBNpe8BvyZvp9YbHon9wKATgssBtgTBLIZXDSWdDnlgHVbUvdrczSO16AHQsSODtSW
         d0Wxc2vdcr/rpsj37HCoSo9chh7awJWX+VcFrjJE4GPr573YOR1o+eCVJ9vBCLzPP33d
         NkGw==
X-Gm-Message-State: AAQBX9dd19th1wXSJgaVaSAg2HuIWclPGu/hnHT39R1CI5o1M2k+t8nW
        goPt7k+keDiwvg3LQPHjM5zSvA==
X-Google-Smtp-Source: AKy350ZZPQWfRfhSBhaKJt9xUPQT5lnd+wtqe4yw8S5/nkujjQGTDIndtUur9npBczaCf+bffLIE2Q==
X-Received: by 2002:a1c:790c:0:b0:3ee:7022:5eda with SMTP id l12-20020a1c790c000000b003ee70225edamr71884wme.7.1680539034050;
        Mon, 03 Apr 2023 09:23:54 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003ee2a0d49dbsm19829116wmo.25.2023.04.03.09.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:23:53 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 03 Apr 2023 18:23:49 +0200
Subject: [PATCH v4 4/5] checkpatch: allow Closes tags with links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-doc-checkpatch-closes-tag-v4-4-d26d1fa66f9f@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=JWAyyZjGBbmZg+JymplXrtlAtGV5+g63c0hsDcABK3c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkKv2U9pxJZQmA2qxcy8C6ndEKwxhMC5jKICAeo
 /KdeI4aYd6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCr9lAAKCRD2t4JPQmmg
 c8CWD/4t2tntee0dqHJBpYlhPe0YgSwRRQjNEmynoe5ThrSE27/qjs5NjmKUQPhnZxrZndhidOl
 k0nP42S/nkrKEVnBEeysL8rtoKop9SW2MClE884+4UscaXNjIJ5M6NY65vPmbK3mcuAsdlQma/q
 zNOeT7JAv5BodTJYOcqfqRpX119oXW3lYjYwkKIJX5/Vci6MsrAEv2uLJDMmr9J6Rn6SpALzjGM
 sL7N3cKglHqMjVeHvwtrCoapyiiz7t6QYT+sVGsjMFwIl2qirsZrSs/+MnvNrOdezw59rSRcAUw
 Ndm4rMaSfFupPQtUuKffG9OHDWHfXCZ9sCSBvIkTW8MEh0hsYO/6/mKsSKm7zT4UDqE4xxgNUMf
 PUO5rQRMDS9ykwJlzI++0l/WgVIWihGvtUHRMM8w3Hp0S18mIq8eFv1VGAGBOgvz6Yd/XmEImQy
 PvwcnjQNLn6a1jJMIdWwIDSpynueZZ6WxcBhaVjvhKfJSNKs7Qq8FpUkytWhZVBk4e16z8oaPBx
 q+Og7Gx+WFwkgJP9kuAvXXMH8lBbyfWJqxHsI7l2QoMYcj91UaALxIboZwiRsRsp99RfNWYzi1N
 9j5OD3rVlM7AVQ1DS9Lw2MdcaS4QzG5DDctQDZFuP+voPXXkaaaKuxcIf+6/ve5D+da4b1UeIfI
 h2GMWTisn6HyVHQ==
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

As a follow-up of a previous patch modifying the documentation to
allow using the "Closes:" tag, checkpatch.pl is updated accordingly.

checkpatch.pl now no longer complain when the "Closes:" tag is used by
itself:

  commit 76f381bb77a0 ("checkpatch: warn when unknown tags are used for links")

... or after the "Reported-by:" tag:

  commit d7f1d71e5ef6 ("checkpatch: warn when Reported-by: is not followed by Link:")

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/373
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v4:
 - remove the "Fixes" tags. (Joe Perches)
 - "Reported-by:" should be followed by a "Closes:" tag. (Thorsten
   Leemhuis)

v3:
 - split into 2 patches: the previous one adds a list with all the
   "link" tags. This one only allows the "Closes" tag. (Joe Perches)
 - "Closes" is no longer printed between parenthesis. (Thorsten
   Leemhuis)
---
 scripts/checkpatch.pl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1647ef72480e..f8a57f400570 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -620,7 +620,7 @@ our $signature_tags = qr{(?xi:
 	Cc:
 )};
 
-our @link_tags = qw(Link);
+our @link_tags = qw(Link Closes);
 
 #Create a search and print patterns for all these strings to be used directly below
 our $link_tags_search = "";
@@ -3174,14 +3174,14 @@ sub process {
 				}
 			}
 
-# check if Reported-by: is followed by a Link:
+# check if Reported-by: is followed by a Closes: tag
 			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Link: with a URL to the report\n" . $herecurr . "\n");
-				} elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {
+					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
+				} elsif ($rawlines[$linenr] !~ m{^closes:\s*https?://}i) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Link: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
 				}
 			}
 		}

-- 
2.39.2

