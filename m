Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6006A68A86C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 06:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjBDFlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 00:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDFlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 00:41:39 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278E923C7E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 21:41:38 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675489295;
        bh=mEjo8g7BzgcHSbCqYSqKFLV9Z03gvMFiaeztmkSF9x4=;
        h=From:Date:Subject:To:Cc:From;
        b=B7BATVQqe7BhT+Xtjsxz9NaSCJZvGWX2bHiUpU0qKLID/TLCY5SDN/L+FJqjRiNkP
         X2ETVSwQ8CajODczFUxilbLZUmzLiL637lQg3pdu38R8qNgAcX7tiw3xoy1OKWnICS
         LcWkrrwlU1h5tgh+nNQk8TNB/Mb8om/iK5R+KsRg=
Date:   Sat, 04 Feb 2023 05:41:26 +0000
Subject: [PATCH] const_structs.checkpatch.pl: add kobj_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230204-kobj_type-checkpatch-v1-1-9a94b04adbb2@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAbw3WMC/x2N0QrCMAwAf2Xk2UJXfXD+iogkMbNxoyvtJhtj/
 27w8Q6O26FKUalwa3Yo8tWqUzJoTw1wxPQWpy9jCD6cffAXN0z0ec5bFsdReMg4c3St9HIl6hC
 5A0sJqzgqmDhanJZxNJmL9Lr+X/fHcfwAdCIn2XsAAAA=
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675489289; l=793;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mEjo8g7BzgcHSbCqYSqKFLV9Z03gvMFiaeztmkSF9x4=;
 b=42DCz2cEDj204sQ2dUsE74HpvoxzTzlm3bPThE+CH1OK9j/u9eDbiQTSGiR9NNcYUgqVC8GFJ
 GZbehb1NP8oCNjRChN22JNSuFqCNRW2Ny+/TfxSV3PF3ZurOEMsAUBh
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

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 1eeb7b42c5b9..dc39d938ea77 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -35,6 +35,7 @@ iwl_ops
 kernel_param_ops
 kgdb_arch
 kgdb_io
+kobj_type
 kset_uevent_ops
 lock_manager_operations
 machine_desc

---
base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
change-id: 20230204-kobj_type-checkpatch-1efe8bb9aac9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

