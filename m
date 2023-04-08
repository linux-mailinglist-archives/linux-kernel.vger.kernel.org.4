Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E236DB8FA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 07:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDHFDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 01:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDHFDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 01:03:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA3D308;
        Fri,  7 Apr 2023 22:03:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r21-20020a17090aa09500b0024663a79050so1933215pjp.4;
        Fri, 07 Apr 2023 22:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680930213; x=1683522213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+R/ILs7X2QW/RaV99o/bwUC9Aw8QyPL3GQ9e2y+a4WE=;
        b=BXp84ojiPYIkwMoCq9DKxH2191XSUOvi0Kc3tkQch0SRdrRK0mBZFzV5vTnIzMa6DU
         Ip46rTGa8l19fZBb1+0HvjDoaXozr5L8VvUK7+wu3pJ1lpBB+Taz5tZKmUDRBulb9zNv
         6nCIiWVIdrfnhMIZfDzSrIG1Ygvcg4vm9hZ1ZJ0hngNwBWgN2JlK617WrOrCnE5gY8Og
         CmvBMhteEyYKr5rPNrLn4Ep8qADOVAZhXZR0jSz8kcOw3MUAfQuUWJZ1LX3KlzjhRHYm
         V5gQCyJjZJdbyUPV2fk9ftr0oQiGpN3iZwTbz40JIS3kV+B/8iZnw4NN5+UAf56qpLUv
         cqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680930213; x=1683522213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+R/ILs7X2QW/RaV99o/bwUC9Aw8QyPL3GQ9e2y+a4WE=;
        b=XDRoU8SDqxAUa4ohMa5QsSCHVu4ptlJlO/Aiw2OjCYLm6loFsPZ8HcNAbNnTwoPySS
         w+SikUfeZjO7vGbIRBK2mN0GoOKLdYahv+Kf46X68D93dRytlwcMMNo6NctcDob7OuJl
         cWgTGQrEVJzraddV5Fj6b3oUcogVQcCB2ynohY55Q1+GOLVwKBnPQ0cAapcVndmRWwMZ
         bZSkuF1mU95TeJ5KuNTe1z6m3MKhhEsY/5Bv2PhZnpA4ftmU3+faSD8HsdbQFQB1bdRi
         SfDaYnwx2WvdUenmAscesZjKTQ4JzCtAm8h+hI7fweBrvAY9veL+bLUnb7gUnyfYyJST
         1/AQ==
X-Gm-Message-State: AAQBX9fOx+WpupxpykmrK5W59ZEqXPlkhSdYn34OX0uCgigVnh66Vegw
        3nadYOBp44jfxl3jPNtzqR8=
X-Google-Smtp-Source: AKy350biBnNtbUmjCCSsUo7ZnBDg5Xa0/r5u2lvsRMWOhCtDRJ0yncGgf3luzUAboVxyz4lKPpmVFA==
X-Received: by 2002:a05:6a20:b29d:b0:d9:a5e9:4b4a with SMTP id ei29-20020a056a20b29d00b000d9a5e94b4amr4033801pzb.62.1680930213590;
        Fri, 07 Apr 2023 22:03:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:8475:d375:707b:4600])
        by smtp.gmail.com with ESMTPSA id v22-20020aa78516000000b0062d19179ec6sm3831278pfn.87.2023.04.07.22.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 22:03:33 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] Staging: fbtft: fbtft-bus: fixed extra space and parenthesis issue
Date:   Sat,  8 Apr 2023 10:33:23 +0530
Message-Id: <20230408050323.70919-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding styling issue

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 3d422bc11641..02a16671f2a1 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.25.1

