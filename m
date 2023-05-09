Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891046FC0B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjEIHsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjEIHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:48:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E62E49;
        Tue,  9 May 2023 00:48:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-956ff2399c9so1039951466b.3;
        Tue, 09 May 2023 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683618521; x=1686210521;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruBSrhAa2KCe3xFq+h2PyQJl3quIhNNbbuTeyicMoY0=;
        b=qCck0pvQnTHjF+mFNSS17wB49c/kbITc2B14Rdb/hl2R4GXApQ6flXgxiAjIf+3K4L
         GZFf7R/s/j4yyHAPd800Que5ia1XNbrzRocXBlgGSlVEdmWzIoloP+I0wNHSpMaore8H
         wC2AwGxii5uDjraRT6Q2qtWCgG+seZLzd8qUWv2zUgKxB1K3+ZrB/pfOsQDHd1WAcn7d
         lUXojHgxFwrRZUxcUaA5unSpy5W4juvU1N3siqbquUR6GDid5ELNSPzWpfnHaUyHvg1R
         HbV57mkcOewzLwcMgqryFo0GSxuhzqrUaA9mRJQBmFAJ7UkiGkhDY4MZnKA3ELCOwr6f
         xDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683618521; x=1686210521;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruBSrhAa2KCe3xFq+h2PyQJl3quIhNNbbuTeyicMoY0=;
        b=esKqWariAsWbGaNxekmdh+gBN5ZFDIJfekYf1seqWzlH8ruYtGXtxe38TZfUGLUHO9
         90oHZw4sQiXCJkuzQ+ZBLc//toR/piI6mgVSlZR/zL2U5eYChWH9A6jlMzS4xZY9cGH+
         uuILmg5Z8bNqtFs6qM87wj/LNcXGWovPkqj1ZC3Q9e3NLVpUDwaySCJiWSeRrjaesYWw
         1GFxC+nhSDNET+TnLodZubtJKysgrNYQAE9tGTpvd9RlLlCiUvvl2HxDKdjGhJ97bpXG
         BKJzIepWD52O32twRt/fxEo017lFq+4Sc7XJtb68eJy/WVB7bzqesCph5xO2I66vc99X
         Rk2g==
X-Gm-Message-State: AC+VfDxHokd0pi3k5xnVW4ps7KGB65Ztbr8l39LCfX+IyYihEKRMNCbX
        ffe/lh9k+aZ/Yzyb+g9IjHQ=
X-Google-Smtp-Source: ACHHUZ6w0fJfY4rQJX3oXSXo3rY6SmQgVX5Rs578thAo292MEFdNF9hZAsEo+j8ho+ZeAH7ROoubew==
X-Received: by 2002:a17:907:1c85:b0:94e:48ac:9a51 with SMTP id nb5-20020a1709071c8500b0094e48ac9a51mr12509959ejc.4.1683618520899;
        Tue, 09 May 2023 00:48:40 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:b892:8631:69c7:ec2c])
        by smtp.gmail.com with ESMTPSA id tc19-20020a1709078d1300b00969f2d5267asm397659ejc.114.2023.05.09.00.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 00:48:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Support Opensource <support.opensource@diasemi.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair pattern in DIALOG SEMICONDUCTOR DRIVERS
Date:   Tue,  9 May 2023 09:48:34 +0200
Message-Id: <20230509074834.21521-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 441613662db7 ("dt-bindings: mfd: Convert da9063 to yaml") converts
da9063.txt to dlg,da9063.yaml and adds a new file pattern in MAINTAINERS.
Unfortunately, the file pattern matches da90*.yaml, but the yaml file is
prefixed with dlg,da90.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken file pattern.

Repair this file pattern in DIALOG SEMICONDUCTOR DRIVERS.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Andrew, please pick this minor MAINTAINERS patch.


Note: The patch was sent three times to Lee Jones to be picked up, but it wasn't. 

v1: https://lore.kernel.org/all/20220623104456.27144-1-lukas.bulwahn@gmail.com/
v1-resend: https://lore.kernel.org/all/20230110154901.20223-1-lukas.bulwahn@gmail.com/
v1-resend2: https://lore.kernel.org/all/20230313050903.29416-1-lukas.bulwahn@gmail.com/

v1 to resend:
 - added the Acked-by from Conor Dooley.


 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 460f953f331b..c10dd7aa8ed9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6026,7 +6026,7 @@ W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
-F:	Documentation/devicetree/bindings/mfd/da90*.yaml
+F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
-- 
2.17.1

