Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B05FE47E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJMVvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiJMVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:50:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2D11003
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 10so3069215pli.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=8u7PKeeRZLQbVUCH1HL062I8pY0WhjJ+4wVP3TuYfOU=;
        b=Cv+TdAZxbXwSykebRQiihwsVYuy3W8VCeED10q1DKTNLZgYl9TGHXrAUbCM9xshwt0
         wXKPRR8b/axZAnH6tWruB25IDYSX4xucNTDernbhpCa8W1UwTbJQ4GVYd4KXOPyLUNkU
         1bvmjxasYHA+dHjvMtJmH7TaB8OK236CH0N34N6kNdPCH5LCocB4STEbboQMB6Jw0TyC
         7DKPIcBUxve/plZxQbwYfS193EzMDMuaIjUDSK0Kzl1dxawutAkAcKU1k0rY5PxiRecy
         okp/3BHkyW/TvblDleWfTGWhbNXHiX+p9aL/lolOzWksjMiPcJdnKrePUSbrmIHQdI93
         EUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8u7PKeeRZLQbVUCH1HL062I8pY0WhjJ+4wVP3TuYfOU=;
        b=bwquct4/48cfeLaGxpw4L9t0E0fiRXOvWcLD8ho1XVLw1PKXbtLz2ZeUc1Xpf4IRwU
         aXlLn0CfYeMwWHjxXNcu0G4Ag4VqGROb5CE0LTKwjmJnRoMKZ14d6mo9aVG4lWlD0vID
         F9NcgoJ5E3RCf9hnMMfE1raQTy/vhbvw77VQOfhldIpUUHD8944uY9FrePnwZCyQybsy
         jea9jsTddrO5k56OgDZxaN+4XcEibsJwBPws5E3LMWd6VbVhjCiaIDH3lr5xex5r+lZM
         qAhtTleNsfsF5kvvG8rZWqUhG29r1Lduh3GePfMvHtmxVrV+DZJmCNGbSe7psMmlWOQ0
         wInw==
X-Gm-Message-State: ACrzQf0dOcEEjVnT1BAfXtV85Axfr7TFJMCFHVqUc1hs9wRii7LYYw9D
        PH/K1SCCW7N5DOk2UItDhSKHDXeSZjDIV/A5
X-Google-Smtp-Source: AMsMyM4JubD/Xe7DWx1aUdHpRILa60JbvVDkgsmck5bMJzxWjp3wXUCAOqWfyIts+pd05gG2izJBBA==
X-Received: by 2002:a17:902:d711:b0:185:31b5:8087 with SMTP id w17-20020a170902d71100b0018531b58087mr1885913ply.121.1665697767580;
        Thu, 13 Oct 2022 14:49:27 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090322ce00b00185402cfee3sm219596plg.213.2022.10.13.14.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:27 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for ulli-kroll
Date:   Thu, 13 Oct 2022 14:46:40 -0700
Message-Id: <20221013214640.31214-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef3666ddc73b..cb5edaad8dbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2045,7 +2045,7 @@ M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/ulli-kroll/linux.git
+T:	git https://github.com/ulli-kroll/linux.git
 F:	Documentation/devicetree/bindings/arm/gemini.yaml
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
-- 
2.38.0

