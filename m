Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63C76393F6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 06:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiKZFKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 00:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKZFKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 00:10:30 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E0E30F43
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 21:10:29 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669439427;
        bh=XbTFOdNwEbWCIbMTsixNKHLPlvR9YwQ8MRhGh7pfdfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEDJviVmcGIoAZ29qGUwhmhoiEhAX4R99+RJOa0pX3LwziRnhS14JR7qWiRMhagC7
         RTbfctuyrS3IPQo/sVTKDw81mG+becR4zmDCNMYB9N3A1rBeX7DfUOjIcZZ8S/LfTH
         86xGSlJQ5wkJEljiuHPDwnUDFfi7aGL7tQWlpjH8=
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/3] powerpc/book3e: remove #include <generated/utsrelease.h>
Date:   Sat, 26 Nov 2022 06:10:00 +0100
Message-Id: <20221126051002.123199-2-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221126051002.123199-1-linux@weissschuh.net>
References: <20221126051002.123199-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669439380; l=805; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=XbTFOdNwEbWCIbMTsixNKHLPlvR9YwQ8MRhGh7pfdfU=; b=kQK8DpdAJ/pYABAEO/dZmoDkwDFnpINyHc1jyw1qTilCAmJpLLJRpKINy3k9dz5MqbyUr/+hYBKJ iTPoLnosAwMI6k89cxFEhMZxKlZHsRXKfsKe5Deam2d+h6WWLtiI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7ad4bd887d27 ("powerpc/book3e: get rid of #include <generated/compile.h>")
removed the usage of the define UTS_VERSION but forgot to drop the
include.

Fixes: 7ad4bd887d27 ("powerpc/book3e: get rid of #include <generated/compile.h>")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/mm/nohash/kaslr_booke.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 0d04f9d5da8d..2fb3edafe9ab 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -19,7 +19,6 @@
 #include <asm/cacheflush.h>
 #include <asm/kdump.h>
 #include <mm/mmu_decl.h>
-#include <generated/utsrelease.h>
 
 struct regions {
 	unsigned long pa_start;
-- 
2.38.1

