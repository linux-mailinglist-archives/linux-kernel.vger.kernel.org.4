Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80236AB37D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 00:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCEXZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 18:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 18:25:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F29193D9;
        Sun,  5 Mar 2023 15:25:49 -0800 (PST)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678058747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6rSyu/SFdLK2A9ifj4eu/x0Qf5lI/gtMUSsu75KyA44=;
        b=3xiA0vO1Dx4B1jlfw3QKB9JS6/z+ywG4Qdt4Mu5zwOOyFrQVDb0Jmry8JVJLujF6ssfZcj
        uUwkTERHweCf5iQDZNxy/Lgdz3PI/zZL7cbyIuxQ8N3nEBcUkCJJddmks5vRlk5k8be7AC
        rmjbtHuVRd0RjGwlVBTDxwaNO8fcG79YGRvuNOmHQaOHlaoduSrm7sQEzerokCmbmMYAac
        SP9OAM1RixFbOpw9q76KpnGXfxHMbD12NOIJhnXl9g4IA9pOcM8MoiMyRZNt/y/NQJEnhn
        7GgYM6ZHKu5/bvTsfSUmG7duelGF9vykrVGxEM3TN1NzQ2HigfybmiFMu2n9rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678058747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6rSyu/SFdLK2A9ifj4eu/x0Qf5lI/gtMUSsu75KyA44=;
        b=U5f+RAeNfnc2aWG5uvGSxnfNrAhBzcSiGbxSpDvXoyrRcHuwpogqDZNftYGSnJwPuRlFG5
        Btfa7Gb2YE+PrDBA==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] kbuild: deb-pkg: default dpkg-buildpackage --build
Date:   Mon,  6 Mar 2023 00:25:34 +0100
Message-Id: <20230305232536.19528-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

deb-pkg's dpkg-buildpackage invocation was changed in v6.2, unnecessarily
adding the --build parameter explicitly. Revert the change.

Bastian Germann (1):
  kbuild: deb-pkg: default dpkg-buildpackage --build

 scripts/Makefile.package | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.2

