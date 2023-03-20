Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35696C121B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjCTMnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjCTMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:43:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2E59776;
        Mon, 20 Mar 2023 05:43:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x15so1662301pjk.2;
        Mon, 20 Mar 2023 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679316214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuPNRur3NtDnFJVCvDkEsVvpqOyVBKyvwyaXnfO9pqQ=;
        b=QMgf8Le2567Br9ksKL7GWK1o3CI5/d/geLI8q2Tpae+sN4p5dtWy0TU8d154IWd9el
         k2eHxUtxg18PFCvrZv3gGPh9Yu+3x9+CdOyl/alM0efOpo4jys4fk0iLr6xWv+lvxVSb
         8LX4tkFuQRp3DNPaY8qW90NokPcLNXzF5uhztu8SmG2W3b3eBEqjNuWo4JSRHPtV6CSL
         w6bzCX8NhIdahw8f31d9/B8Sonxo7V4u/iijvJ0H26p4dvAIssh4cvlVD+HYYN/tiArX
         aHbbMJ5/nJFCHZeqY4DBSFtuZdd27bGIAqxaH1dCR1WteITU5JG/oSO0FIfONDsuJGeQ
         ZI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679316214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuPNRur3NtDnFJVCvDkEsVvpqOyVBKyvwyaXnfO9pqQ=;
        b=g7YMRlcF91a78Xi+8w+c8lKfDxZs4/3GuUgNkyOKgb4D/KJKaUz3jMwu/+TS4VVkEO
         jKWjHIyTCGmimqJnLGDaIZrQ3BSzlEJuq5zfZjBxr0VrMElrIjh6FsJnhfaEdBMXLUWH
         sMo98FEFtfZqoCDYJ2PF/fpUVL9AC6Gz9DjnPMBME2FDR4wkf0PK6LSleSnDq2w4xCCp
         CotCl1av24ZbIVyo9JFSyxfHTFU4donsDjyruln113RZJy234gqps7U8jHcc5ruQizb/
         9EofxxZU1p8/qD5e+BJ3l32sAGEAz0pycwg9yoDSQr9h2eEsnZ1OOfXPW5ZtPIA3Wzpv
         yPPg==
X-Gm-Message-State: AO0yUKUWfw11uQESVXWgzH1Nm2PKO05Kz9qQ1fHr+lnlan6Bb6afhqvU
        4RxtQj+ALUa1d6Alfvg+5Z8=
X-Google-Smtp-Source: AK7set9exICfpZxGY8h+eBzFIKrFFkrk0yOXMxizkoAm5tACLSpbGCmlrUA5F82wFem4X1ugpyK80A==
X-Received: by 2002:a17:90b:4acf:b0:23d:9a3:f571 with SMTP id mh15-20020a17090b4acf00b0023d09a3f571mr19188670pjb.20.1679316214106;
        Mon, 20 Mar 2023 05:43:34 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-6.three.co.id. [180.214.232.6])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090a2d8c00b0023440af7aafsm6114484pjd.9.2023.03.20.05.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 05:43:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7343A1065D0; Mon, 20 Mar 2023 19:43:29 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] Documentation: maintainer-tip: Rectify link to "Describe your changes" section of submitting-patches.rst
Date:   Mon, 20 Mar 2023 19:43:27 +0700
Message-Id: <20230320124327.174881-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=bagasdotme@gmail.com; h=from:subject; bh=FAEl/7SkBqFPoHqShwOaCVSmuT0ZoOhqKjAWrvmRTI8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkSIa8U3zaEsvBwi3b9MjvFo2LWZiqYvyjNcfopsfPiY Xftf6zuKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwETCMhn+qXt+UL5/0Lpl1bbP e0IXNxxJX/GE/ZBJSv8CYQnuBvvjqxj+R3zxWmVvsKvj2htVnsUpqQ83ld7a+WzHCZ65otdnv7V cwQcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general changelog rules for the tip tree refers to "Describe your
changes" section of submitting patches guide. However, the internal link
reference targets to non-existent "submittingpatches" label, which
brings reader to the top of the linked doc.

Correct the target. No changes to submitting-patches.rst since the
required label is already there.

Fixes: 31c9d7c8297558 ("Documentation/process: Add tip tree handbook")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 This patch is based on core/urgent branch of tip tree.

 Documentation/process/maintainer-tip.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 572a3289c9cbf3..178c95fd17dcad 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -128,8 +128,8 @@ uppercase letter and should be written in imperative tone.
 Changelog
 ^^^^^^^^^
 
-The general rules about changelogs in the process documentation, see
-:ref:`Documentation/process/ <submittingpatches>`, apply.
+The general rules about changelogs in the :ref:`Submitting patches guide
+<describe_changes>`, apply.
 
 The tip tree maintainers set value on following these rules, especially on
 the request to write changelogs in imperative mood and not impersonating

base-commit: 3e2619c4ebba2cab8414c55b131b7a28f628de3b
-- 
An old man doll... just what I always wanted! - Clara

