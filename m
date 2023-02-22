Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6980069FA34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjBVRaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBVRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:30:16 -0500
Received: from fx303.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB630B30
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:30:14 -0800 (PST)
Received: from localhost (fx303.security-mail.net [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id A4FB330EE18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:30:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1677087012;
        bh=hvMHSNOcZ3wkrNvaq+KD/UxVGOPU3jQ1KwZs1+GUHhA=;
        h=From:To:Cc:Subject:Date;
        b=fiwVnfrpFIfbcLc75ZSAdQZYqC/PJU8OulQfxSXbYorlGwkYCoDWZhsRoekBMTVUc
         bAHdWTfH64hr+kLgvHdPN8QkaR6JvNN5mXxn/v6obYFzjTMHhOPHEa4JBPxBYAo5y+
         g97y8OTCr2vBmaR2Em9CuInqUU0m9TwasQEk/SxI=
Received: from fx303 (fx303.security-mail.net [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 6264030EF20;
        Wed, 22 Feb 2023 18:30:12 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <e4ac.63f65123.51269.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx303.security-mail.net (Postfix) with ESMTPS id 5559330ED31;
        Wed, 22 Feb 2023 18:30:11 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 25CD127E0540;
        Wed, 22 Feb 2023 18:30:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 0CAB227E0542;
        Wed, 22 Feb 2023 18:30:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 0CAB227E0542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1677087011;
        bh=FUlqQSuqsNRDjtlEMolaSOdEgIELsQ6R4GrRAZrZgUU=;
        h=From:To:Date:Message-Id;
        b=pbfBt0CjHK5+s9/YhhY38aTuA1J7Vw/ofqRzNpnxAmjTzYUmZqbEnSBmDE1+inTMm
         14xnTIyz+sH6KER7lY7jWiqhG+O+OhGkTBc4k3LwzZP0CgmFQWgv2YzWD60k84KyPf
         OhIdxvGMhFpZfeUsCpA40dNWDg7dkcOMbY9AUDms=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RB7bXPHl4yta; Wed, 22 Feb 2023 18:30:10 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id E1DAB27E0540;
        Wed, 22 Feb 2023 18:30:10 +0100 (CET)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Jules Maselbas <jmaselbas@kalray.eu>
Subject: [PATCH] tee: optee: Fix typo Unuspported -> Unsupported
Date:   Wed, 22 Feb 2023 18:30:09 +0100
Message-Id: <20230222173009.19874-1-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo Unuspported -> Unsupported

Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/tee/optee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 290b1bb0e9cd..df5fb5410b72 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -488,7 +488,7 @@ static bool is_normal_memory(pgprot_t p)
 #elif defined(CONFIG_ARM64)
 	return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
 #else
-#error "Unuspported architecture"
+#error "Unsupported architecture"
 #endif
 }
 
-- 
2.17.1

