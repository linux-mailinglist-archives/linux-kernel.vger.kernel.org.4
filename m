Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D56BB9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjCOQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCOQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:29:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE643668C;
        Wed, 15 Mar 2023 09:29:52 -0700 (PDT)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678897790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O5hu0wve15zl1g3iLoiwhMZMYA5i7YZFVzLNjsgX/Bk=;
        b=fUKcivI4UecMWp2/hETHbT7QiCCw+M8ZOEDw/Xuagzht7H7+MsmHl+ld5DPlVLO/Dl/Dy4
        JPWQMfkMilWHXASyiY1sYORAS4wkYof19r2+4WbttLOqhPPOFfqZZCMtyKhl2AbVVmesqn
        x5KNgoUwpm30Efw7+GRGB7/wG7kI2JDouyDGakDHNq38xuHnzEQEni/TGuR0crcQqCqM0X
        yGkcd8RhvaUXkOHSBNZaWjxg1zc2vNWCZA0sPmCIOKyg0VbUMCczWr6tRYzVeNwNNtkhL+
        XogZbLg7UzT000ry8MzKbJxwxmyou3QiL6deO2vXBoFPTER2T1H/bERp/kVdeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678897790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O5hu0wve15zl1g3iLoiwhMZMYA5i7YZFVzLNjsgX/Bk=;
        b=WlulaT4QFaLhzCce5iuTtzSFOBktxfLG1UwsU3Z5BJCG184UBRjhcCUZ0tBfr4bPdJnOps
        JIDJlqsGgc0UYjCQ==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] kbuild: deb-pkg: Build parallely with current dpkg-buildpackage
Date:   Wed, 15 Mar 2023 17:29:42 +0100
Message-Id: <20230315162944.39542-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of DEB_BUILD_OPTIONS' parallel option because that is the only
parallel build option that is set by default in current dpkg-buildpackage
versions.

v2:
 * Clarify that this is for current dpkg-buildpackage versions
 * Evaluate DEB_BUILD_OPTIONS in debian/rules.

Bastian Germann (1):
  kbuild: deb-pkg: Build parallely with current dpkg-buildpackage

 scripts/package/mkdebian | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.39.2

