Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221E76803C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjA3CTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjA3CTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:19:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03AF166D3;
        Sun, 29 Jan 2023 18:19:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63C0EB80E16;
        Mon, 30 Jan 2023 02:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00280C433D2;
        Mon, 30 Jan 2023 02:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675045154;
        bh=sfRFl9eurTl6D6oQNSWpmYF2UPFn3f9oe1HYl9BRm+I=;
        h=From:To:Cc:Subject:Date:From;
        b=ZWYBg6E3cCQ/fQLR1AlCtRIP8H3Czz/JkQV2Pj+Jv4pzOF3LWgwWIvOZpDUlPM2HB
         TBQYhynXrfEs6Fw+AMxs0tsuphFw04owECikyAgwJ5DRQHz+woft83LoBFaDAoinbC
         iRGEGe35/JbF46Wd4bji4J8/QVvqVIeQXDzSdOwj1sgCmEQiA10Q4q5bi3X+abqys7
         ubR1tUq8F8fs9R7k/jvWppy5kq2K41zDwN7b7zS5qLjwBX499TyMjsDlSrAiO4w+YK
         XutKQ3NW2vmXy9AQ5KptOxFQfD2hcaQGte8lJiXR4I13eRkASdHeYDenqz+rPQcI1n
         u8Ji4AtzqyeFA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] .gitignore: ignore *.mbx
Date:   Mon, 30 Jan 2023 11:19:02 +0900
Message-Id: <20230130021902.4088173-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'b4' command creates a *.mbx file. Ignore it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 22984d22d29e..4dc02ef62202 100644
--- a/.gitignore
+++ b/.gitignore
@@ -33,6 +33,7 @@
 *.lz4
 *.lzma
 *.lzo
+*.mbx
 *.mod
 *.mod.c
 *.o
-- 
2.34.1

