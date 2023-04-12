Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC76E00BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDLVWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLVWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:22:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5F19AB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681334517; i=j.neuschaefer@gmx.net;
        bh=2NkEXNzdSvLHDezuc3e95Ppy4PB6xfiWobcIdlZ2Mq0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=heNVrkO8V0JA6m6qAVX76ayzgy0jtcDI1MX8C7Uaw1rjIM6LwY2sKB5xugYz/DCjs
         EHjy05Y8y7C0T6mTgOFZ/Y7sF6K8CSerenKbM+WlcoNtTWIhfYsvLXCxyoNdZB3YdW
         WvMqRZpixnHS6GkmzVSqSOpKeoUqHIyJysYaR/Y070FZQu7JbNZ2HFnYxjDEQ6jxR0
         HuDvEOFIdLwHUwgS1a5mO5BZ207gY/+py1+idDeYXkonKeBgOdeVukjt3GcrQPLk96
         +r8iSYHYYonhoaq+ru9UbK+tK6awcDk6+r2AajX8qxPD/NTEwDFV0shpMjszUzCK86
         3doeYafMk3RFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1q80IA0yBP-00nSaK; Wed, 12
 Apr 2023 23:21:57 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/3] ARM: compressed: Bump MALLOC_SIZE to 128 KiB
Date:   Wed, 12 Apr 2023 23:21:25 +0200
Message-Id: <20230412212126.3966502-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wZAOHj/rfJsRhnvDlu5y2Pqf209q3GQxBJDNPOKh5N5aJE/28+u
 aiTYOIGQtqjo7mKUL2Ge+mmrO+v1wx2Ilp0Bdx3HscAKyzz1xnkU6JULKEApP5ucS3xblXQ
 M60hb/DFKUwIcjooNEcWjrBxnxOMlNYwgJ1WtCxlL7FpUo91a9QZIksmXVCkWneYb4k/kGV
 I8tTOyyrv5gc2q/o+z6Iw==
UI-OutboundReport: notjunk:1;M01:P0:nNpt2s/KZB4=;FZwzPIEsOrYhKsQ2vHPC+bc7IdD
 xn2kjP1QkVU+suszm+o38bgUmA2AukMfClil/xRcfNU2btUGsh9K8lS7fELArAzWY9Ru3LntF
 bIjTwx1icmJ8KOHFE/aAJceVd9RMNrFfKuWMBaYBcR5S6HC2ZLPy0ee68z6tbPwh0QQAY8u7K
 VYY2ec2QzkbpGGmNov45aH9YBwFoHN3XAa+Po1Wx+V9Kz06d2SGzPhz0wmSVJiyG4682IzVmh
 bxpIKxiHbg3oA+Zlz3LteC832eimhRyrxNpz22Ld7dYzEfNae8ggZnMG9sIl9kjdUnZRQZHkO
 1UW/PVZKY/C2+n0GfV0+/UkMuDXPmLL+4ywjD5ZLNnTbIpJQDolumKDG+1f2xH48hBf4H7BDl
 dM62mia8CRnL3feQtFWaL3JsMeA0X/KrlBJDTwryl7Ap66DmtP3jthw2GMJYJIg17Bn8/LA8Z
 Va8xp0GzI1PirUYfEfD9L3qO5ueXcr6nQz3fDSAkeyifNMwKAqhmAiFgZwylwtKJCWmGTdac1
 HZMDqVTTYq3C6XFCvDqowArHekDGllKf0heEgbuhhefNBKV14NTcbX03JldFgqeofXWYN+X2H
 O35OHbalTd7UGKXmgQDb93UHqw6tmj+PQZsIMEnX+bvU79Zvfxf9KCEZ0WcBCGlzVvNOvyoiF
 K3ZTVQnkBGbtlx5GqChTVFkymcQ6GyDsySGlNix2iKFgdPw05YmrWiN4Raq/0t1RP0p63HkMh
 8+z3/mjSPKIpLT4AXMC0dICmOzEoJBYQSOkrLSJqyKiS8gYshf7L0xJQzFDAhzvs773YgZhEG
 x/IqPFS3C8HFJShjcy8iI4WUNuR9ggypmZNKxF8eq0U2bOQ2SMJB6x3D3WumR4vFcqukoTZk2
 GcEeVJEeJI63J9Prl7eLOGdcXbZk5qdE982Qs4lv9B3k7ORIN26wLOdFnkvVCiz4nX3qbJ73u
 RXX5ok5RznmjNVLEJADdazInIMY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ZSTD compressor needs about 100 KiB.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/compressed/Makefile | 2 +-
 arch/arm/boot/compressed/head.S   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/=
Makefile
index 2ef651a78fa2a..dec565a5b1f21 100644
=2D-- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -69,7 +69,7 @@ ZTEXTADDR	:=3D 0
 ZBSSADDR	:=3D ALIGN(8)
 endif

-MALLOC_SIZE	:=3D 65536
+MALLOC_SIZE	:=3D 131072

 AFLAGS_head.o +=3D -DTEXT_OFFSET=3D$(TEXT_OFFSET) -DMALLOC_SIZE=3D$(MALLO=
C_SIZE)
 CPPFLAGS_vmlinux.lds :=3D -DTEXT_START=3D"$(ZTEXTADDR)" -DBSS_START=3D"$(=
ZBSSADDR)"
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/he=
ad.S
index 9f406e9c0ea6f..23fbbe94da6e8 100644
=2D-- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -337,7 +337,7 @@ restart:	adr	r0, LC1
 		get_inflated_image_size	r9, r10, lr

 #ifndef CONFIG_ZBOOT_ROM
-		/* malloc space is above the relocated stack (64k max) */
+		/* malloc space is above the relocated stack (128k max) */
 		add	r10, sp, #MALLOC_SIZE
 #else
 		/*
@@ -629,7 +629,7 @@ not_relocated:	mov	r0, #0
  */
 		mov	r0, r4
 		mov	r1, sp			@ malloc space above stack
-		add	r2, sp, #MALLOC_SIZE	@ 64k max
+		add	r2, sp, #MALLOC_SIZE	@ 128k max
 		mov	r3, r7
 		bl	decompress_kernel

=2D-
2.39.2

