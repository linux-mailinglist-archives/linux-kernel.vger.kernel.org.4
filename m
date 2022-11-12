Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8BE6267F7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiKLIK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiKLIKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:10:49 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA50C13EAE;
        Sat, 12 Nov 2022 00:10:36 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.85]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3bb3-1p1qaI2IuR-010eZK; Sat, 12 Nov 2022 09:07:29 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 9585F3C1B9;
        Sat, 12 Nov 2022 09:07:24 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 3DC2DB98; Sat, 12 Nov 2022 09:07:22 +0100 (CET)
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 2/3] MAINTAINERS: Remove Michal Marek from Kbuild maintainers
Date:   Sat, 12 Nov 2022 09:07:16 +0100
Message-Id: <20221112080717.17914-3-nicolas@fjasle.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221112080717.17914-1-nicolas@fjasle.eu>
References: <20221112080717.17914-1-nicolas@fjasle.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WO3DCxb0hdBXsNQ31xVKOyKez8GzzcPHRi4+LZXfD1IZm+P4CZT
 UCPKqzPbUbQpkcI7T+msxUnVeuAjRu1xScMm01NItbPlAxcEJR7O7ICNkYpst9xfo5UT8xe
 SqkDNilULCCQ0mp9/sKD5Q9MfwWhZ2GwygBrYVvs8lv5xIFb3b7DSsZi28EpPudRS2svpI1
 7nHk4QWOVxHZnCLO0lpVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tdMunISeB5M=:KCWYiNNHQ/gYXCYerQ1jSn
 sYw4W3UUs1eQTYW7K9yXymk4aLMuKDmGnL4edJc/fgBN1kLEjG/sjkaXcATM2vupY+f8TSF9v
 SPoMSreN/J72QvjJfT0SWSqLHfgm9pcdYrRAQPTo7wFqBrEu6iEPsanr6FnRn9jGoQqLazNbs
 YxRKSk7/XZK1GARne+065b/wSCmIhR6+WXqVX83b1Gy+qp6u0DGG2OVhA3XRUxFXm2zNYvCOj
 m598adZAdL1HJyPYe8/2ao+UcMKNO5S53GY3WnljAWtoW2LilzIb2B5XB4XL8vQb+NVF1uwls
 CVduUgnuajTiLo4bPGxApJvNJszY2a4GKBaHyz0t5iqCngfSonGFnovQVxT0S/i2oiNorkw/f
 8XrmHZ4nYBF7iZ9n8lFmHDPwTgS6YZ9j3GPfeKdphIlkH5pKHH38RtBxobB8Er56gsyJxx8Cn
 Pdy4g/Kdpze8NDtgYDgvXcb8zEfOS53ZmK8vmnICXmZZgE9M0KFzcbDdrlL8owOMdYAZaA9hY
 JXmJJsB8lQN5WukqHO527/E+2OSMgKBJOl22x18IdbCYFgCGeQXTeeu81Em0AEnGmKRGGLsLE
 351ub0boZqNb1aNecAYK7vKUUXzM0VetSvbUrK5BmVWP6DuEQMeng2fu6eVBNRy23rlYS+uEG
 cqE+ife8xnXZsPXDm99ssGognvBvTTm9nzaMMrYa7tSiIW9IHxZ6qRbEemIuXIkdD9AqqPbeh
 +cuJLfCnFDGkmEAFytamQDJLOP4wCB+qanYwCY7IimTRAry4fXL5/Z4rTC8nDYJTVh9dWmmIL
 14ZClM+7/dmJURariEwB3uzBzpWVUnIp6hgLFi/A2WVl750f2nr2ecq4lx0M2I00d9m0euvoE
 WpHY2BzaqGE3fqUl0F8kFpUxMWA+7yHodwsT9n2cr8lciuWVFrW92JbvD66QiyXJ/IELBAB+L
 sRPeacPMFi64+vw52vwzeyz2vCWmU2yGubHE9A5pEPARi07KFZx+vI12t4OvKkNXck7QKkURq
 uifLbykgx5GS+EY4r/jdEB0EYtm5I23TmCRrWikTQhpNdFxxFAXYORDihkLPr3eox47sT9Tcb
 j/BMWXHmXD2Hy21p0GnAmIfjq3mTuU21fkfJWc5q7v4n8MMTRT+oeXxJXff4H1JR+j6S7V1rH
 2F0oFJEs0+OaV4nfcPQQBsxtwgTLZ30gm5NsYKfkzvD13+ckTJym9T1Vf8sKfYoOUJYBCROMM
 au1pd2xQK6ML71237udgKKoiYlsgzle0mDuhZSZyKQJkhJ/RjzAEnf2XTk1kJ/LxQRaLaEbig
 NhLou8pKFjkHbBbyV5FbYYJlsPjzPg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Michal Marek from Kbuild maintainers as there is no response from him
since October 2017.  Add an entry for Michal in CREDITS.

Michal, thanks for maintaining Kbuild for almost eight years!

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

Changes since v1:
  * Add missing 'no' to commit msg (Randy)
  * Add CREDITS entry for Michal (Nick)

diff --git a/CREDITS b/CREDITS
index 1841184c834d..1606f1ad29b4 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2447,6 +2447,10 @@ S: 482 Shadowgraph Dr.
 S: San Jose, CA  95110
 S: USA
 
+N: Michal Marek
+E: michal.lkml@markovi.net
+D: Kbuild Maintainer 2009-2017
+
 N: Martin Mares
 E: mj@ucw.cz
 W: http://www.ucw.cz/~mj/
diff --git a/MAINTAINERS b/MAINTAINERS
index f37c6a9a8fac..48e45633b223 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11083,7 +11083,6 @@ F:	fs/autofs/
 
 KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
 M:	Masahiro Yamada <masahiroy@kernel.org>
-M:	Michal Marek <michal.lkml@markovi.net>
 R:	Nathan Chancellor <nathan@kernel.org>
 R:	Nick Desaulniers <ndesaulniers@google.com>
 R:	Nicolas Schier <nicolas@fjasle.eu>
-- 
2.37.2

