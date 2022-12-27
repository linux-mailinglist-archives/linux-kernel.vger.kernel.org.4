Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C8657019
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiL0Vsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiL0Vs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:48:28 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E5B23;
        Tue, 27 Dec 2022 13:48:27 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0046B320092C;
        Tue, 27 Dec 2022 16:48:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 27 Dec 2022 16:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672177703; x=1672264103; bh=C0mduqepIxRredmqLCGAPlCT9
        t1Daw7dkB3PcPVQQ3E=; b=nY0dxDhsd+tCGN802X+bhYqSPy8PYau9FRg3vhaCY
        VvlLL9Y9Pl55nCRZPB2bRhJXzyJQu0c4A3ztUNZn/MOuBlvvFO4eHFyiTWk5eAvb
        /VNW9WPjpGL/AvyYsGUC1pWUXlFRdzxA9YZyqU5/v1mUtaOw/lTpEAJjO50YYdIz
        ny2vEjKAPgLt61JKet83zl3CoHvN7oxYquuReIjGkZhQTBUR2eMvZDosRsMewlPL
        R9IX0aN+T0F9Oh+f5FVcHRLfJRHc12k4JD2r2SYYtDVq2Dlnxf//67Jko527z1HJ
        nQF3rNM/lqHHVoh5VuhFNb8A6l6tCIgrh610v4h7FjxAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672177703; x=1672264103; bh=C0mduqepIxRredmqLCGAPlCT9t1Daw7dkB3
        PcPVQQ3E=; b=WurPVl/tTUBytSRQe8TuOosBIVTX78y/9kLmo0nTKx++EweK9bi
        bPf3xfzlDOl+Xxk4t0npclfNhzybYc/mN78UOfUsaBH7aeIduZ1km9PYZaA2ox5C
        9thueB6zjOrGdX6IV1VfekgbGHwr/UuhMN/kFGR4mcz2xztZGkJiLuKhLd7U1te8
        Ef8ZzRadLKUw1YOICJBOC2Cxsup56UJE6OdXERKe2l8jl+58F1brw8tSsbxvBMrY
        GrteUJO23aYlDhtS/GHXgyG5N4f+0bcUqOKZSj94P9be045o9PLojCn9q6gJk7iP
        F482qxgggzs5aOdPR0pJ9USIPkTpUFfhqtw==
X-ME-Sender: <xms:J2irY6cCTMzqB_B61qxc5Cgg-LKdNZYvXgCgdSWu22W0R6KzXgyslg>
    <xme:J2irY0NHqdJPlSJ7I5mjzn17BygVdHvaz_n8B58UDOWwwXvfICaDKTPV9tJ7ghTBM
    QGuSVi-FN_FJiR7rg>
X-ME-Received: <xmr:J2irY7jhPYty4dxYflo7b1uiZ7eQkv-jt562wv9gl3TwLWEZXylV6DLLBCKq0iicWeB00Tet1Xn_feCc7r26vI8DPr08IBQpwWo3dAr9s_62B_0wrAIlpzlZRxQQmCPPi8hrhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedtgdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:J2irY3_Xp8w9enFDzND1cbEa50Qd8R5feYGcv6JIQFelTUgAscaOJQ>
    <xmx:J2irY2ufavZLS8n4xel48H7vnazktM8ZRbR7WWvFnurO5TbjFflvFg>
    <xmx:J2irY-GeKvhlF8JpfCPKwGyycrjRAS4K66EEvj_BoD3--vAoD-etFA>
    <xmx:J2irY4XglnCQrG5Z4O3b48dJ1HvrXUELHT9fd7Jz9XEgchJO1vgDUg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Dec 2022 16:48:22 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Fix running modpost with musl libc
Date:   Tue, 27 Dec 2022 15:48:21 -0600
Message-Id: <20221227214821.16495-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3d57e1b7b1d4 ("kbuild: refactor the prerequisites of the modpost
rule") moved 'vmlinux.o' inside modpost-args, possibly before some of
the other options. However, getopt() in musl libc follows POSIX and
stops looking for options upon reaching the first non-option argument.
As a result, the '-T' option is misinterpreted as a positional argument,
and the build fails:

  make -f ./scripts/Makefile.modpost
     scripts/mod/modpost   -E   -o Module.symvers vmlinux.o -T modules.order
  -T: No such file or directory
  make[1]: *** [scripts/Makefile.modpost:137: Module.symvers] Error 1
  make: *** [Makefile:1960: modpost] Error 2

The fix is to move all options before 'vmlinux.o' in modpost-args.

Fixes: 3d57e1b7b1d4 ("kbuild: refactor the prerequisites of the modpost rule")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 scripts/Makefile.modpost | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 5eb5e8280379..0ee296cf520c 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -55,6 +55,17 @@ ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
 modpost-args += -n
 endif
 
+ifneq ($(KBUILD_MODPOST_WARN)$(missing-input),)
+modpost-args += -w
+endif
+
+# Read out modules.order to pass in modpost.
+# Otherwise, allmodconfig would fail with "Argument list too long".
+ifdef KBUILD_MODULES
+modpost-args += -T $(MODORDER)
+modpost-deps += $(MODORDER)
+endif
+
 ifeq ($(KBUILD_EXTMOD),)
 
 # Generate the list of in-tree objects in vmlinux
@@ -113,17 +124,6 @@ modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
 
 endif # ($(KBUILD_EXTMOD),)
 
-ifneq ($(KBUILD_MODPOST_WARN)$(missing-input),)
-modpost-args += -w
-endif
-
-ifdef KBUILD_MODULES
-modpost-args += -T $(MODORDER)
-modpost-deps += $(MODORDER)
-endif
-
-# Read out modules.order to pass in modpost.
-# Otherwise, allmodconfig would fail with "Argument list too long".
 quiet_cmd_modpost = MODPOST $@
       cmd_modpost = \
 	$(if $(missing-input), \
-- 
2.37.4

