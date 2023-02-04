Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1BF68A869
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 06:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjBDFhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 00:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDFhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 00:37:40 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588FD13D56
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 21:37:38 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675489054;
        bh=YwJemHYy5fWmHkj/IBlHKz/bJFsFlc9kZaZMxZD/2Kc=;
        h=From:Date:Subject:To:Cc:From;
        b=pJyCZESvtTR1Ic9Cjc+Kaj87ZnPQ+FM7ycpOPYjorNGwu5qnoBWOISq49Ie4gLtV8
         LcWqM5ppLvLOZ/plZFjupD+4r/QGuJRqri3iiM85VOM3M5MWBdoqdtcAFkssS0/Z88
         i3n1DH4IzksGaZUW+L2ZFTe1TNYJsRdJUza+ny6Q=
Date:   Sat, 04 Feb 2023 05:37:23 +0000
Subject: [PATCH] MAINTAINERS: checkpatch: add const_structs.checkpatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230204-checkpatch-maintainers-const_structs-v1-1-7fbf9ada31c9@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABPv3WMC/x2NQQ6CQAxFr0K6dpIZYIFexRgz1OI0YiHtYEwId
 7dx8RfvL97bwUiZDC7NDkofNl7EIZ0awJLlSYEfztDGtott7AMWwteaK5bwzizVR2oBF7F6t6o
 bVqeU+iFOlM7dAK4as1EYNQsWl8k2z36uShN//+3r7Th+Tv80XosAAAA=
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675489044; l=801;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YwJemHYy5fWmHkj/IBlHKz/bJFsFlc9kZaZMxZD/2Kc=;
 b=Q2AlWh2G6ir7gSzQUogQvPWFAbwbTfJtYHT4IWUsKB8nwX2DxAn1P4lyhqJ+i0XXXQc8BPfEr
 8iT2hcrMeM0AozXYMlethq+NZN5eoB4MpN9q3f28OMP2/hYobGb2hf3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/const_structs.checkpatch is used by checkpatch.pl, it should be
maintained the same way.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e65f97d25b94..4c722fbf6e9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4938,6 +4938,7 @@ R:	Dwaipayan Ray <dwaipayanray1@gmail.com>
 R:	Lukas Bulwahn <lukas.bulwahn@gmail.com>
 S:	Maintained
 F:	scripts/checkpatch.pl
+F:	scripts/const_structs.checkpatch
 
 CHECKPATCH DOCUMENTATION
 M:	Dwaipayan Ray <dwaipayanray1@gmail.com>

---
base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
change-id: 20230204-checkpatch-maintainers-const_structs-c11480fe1938

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

