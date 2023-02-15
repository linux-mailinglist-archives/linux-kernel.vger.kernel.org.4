Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08174697D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjBON31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjBON3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:29:18 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C738D39CC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:29:04 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PGzR3741lz9snF;
        Wed, 15 Feb 2023 14:27:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xrvRqk6p8gt2; Wed, 15 Feb 2023 14:27:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PGzNR6bWGz9sqb;
        Wed, 15 Feb 2023 14:25:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EDE78B7D1;
        Wed, 15 Feb 2023 13:53:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XI3jl6npJPAf; Wed, 15 Feb 2023 13:53:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D6C68B7C1;
        Wed, 15 Feb 2023 13:53:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31FCrrV3217589
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 13:53:53 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31FCrr0P217588;
        Wed, 15 Feb 2023 13:53:53 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 4/9] powerpc/gamecube|wii : Use machine_device_initcall()
Date:   Wed, 15 Feb 2023 13:53:33 +0100
Message-Id: <931134f9ec156f267338e7feedd736ea1d33aaf2.1676465585.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
References: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676465615; l=1550; s=20211009; h=from:subject:message-id; bh=bp8JdY3HFIOyXcrtwHLjajTlIRxJfQDwElw/vik7hZI=; b=E4J+wYcRl4UeX06HK+pCEPTHSKcKzgZKRh6WTTtYBH6IZ1a757MLy9TveEktRsvpHQUCjNExEAUg NVf6PHUwCOo8jSRsw6rB5J0l30RcCbBi4tlfp/xyE2c5DsG8ocXN
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checking machine type in the function,
use machine_device_initcall().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/embedded6xx/gamecube.c | 5 +----
 arch/powerpc/platforms/embedded6xx/wii.c      | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/gamecube.c b/arch/powerpc/platforms/embedded6xx/gamecube.c
index 4fc84ff95b5e..60cdc2852c7a 100644
--- a/arch/powerpc/platforms/embedded6xx/gamecube.c
+++ b/arch/powerpc/platforms/embedded6xx/gamecube.c
@@ -83,11 +83,8 @@ static const struct of_device_id gamecube_of_bus[] = {
 
 static int __init gamecube_device_probe(void)
 {
-	if (!machine_is(gamecube))
-		return 0;
-
 	of_platform_bus_probe(NULL, gamecube_of_bus, NULL);
 	return 0;
 }
-device_initcall(gamecube_device_probe);
+machine_device_initcall(gamecube, gamecube_device_probe);
 
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index f2cc00e6f12f..635c393d307a 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -161,13 +161,10 @@ static const struct of_device_id wii_of_bus[] = {
 
 static int __init wii_device_probe(void)
 {
-	if (!machine_is(wii))
-		return 0;
-
 	of_platform_populate(NULL, wii_of_bus, NULL, NULL);
 	return 0;
 }
-device_initcall(wii_device_probe);
+machine_device_initcall(wii, wii_device_probe);
 
 define_machine(wii) {
 	.name			= "wii",
-- 
2.39.1

