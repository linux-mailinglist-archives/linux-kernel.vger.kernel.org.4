Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4EC5FE478
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJMVuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJMVtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:39 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A457194F96
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 129so2678144pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa6ranh9iRasjoS2Kj2d4o4SlgNu10NUJ0u0bZB5AJA=;
        b=z+ZeS+/L8+VqUgwiDIehsX9N9VLyDedAyAIe9dyZO68zr4geeyQgp/cSkSRkJ7WwTy
         DziaL0vIrHiVaFPHTreK5VNRZWuR2aWHC69R/vKHyrNOisAsULcaL0Uh4aCs/wYok1mc
         u1B6JmNNR5Y9t9pj0ZqrrOeg8M/To6gerZuwuwXsRRjZVUIfBPp2hkXP7UClELKm7DGD
         00+SVuuH/0fBpgk1/vxp9g1p5mdoDG1IZ1zuljO8iPzArMbQHJAZsvzUaRWpk9S1oZo3
         kp/5sRDM+D5NaRPngKdJeHu+DrdoGlBvnTHXGy/W2YTf7kHkTJWwuIV3nFDHk3aCibKX
         F6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aa6ranh9iRasjoS2Kj2d4o4SlgNu10NUJ0u0bZB5AJA=;
        b=vp7nKoxU1Z62m2s3KITGOOk7KlWK0HumGY7sSSC8VYLkGTMyP8gvbEXLPWjGFdLHZW
         HDyIuLPLXDpvJxVQ7hpc0vKTWXHiO6WoUoFtg6Z8BSs4+3kt+QTXJBqFViHJd+GeaM5i
         Py4URixmrAXPFwKmTu61TUo1coiYZuuMYmvk9iRjHf2U18Ut6eeoh/Q+4396RUqiG9yw
         b6Ry8HHuUfkU6idU4xeVfu/zP3tB0P62C2kwZJOJoATgcuPyP9A25axnZvavwo2mQRGf
         y24fKXffZPOUsGZClm0yAfZWXHvg+u3CTjEBv7aKdw4pJ2/i7FMZeKsoTTBMtGyAkvIU
         +Y0Q==
X-Gm-Message-State: ACrzQf2XKf5BX/QNG7Sn5hC72uLgaywSGA2DLN7kiovngKDNMF2TZp8V
        nSGBCnc6bYmeePaEDjkFKENgsyM5nzQaJqOi
X-Google-Smtp-Source: AMsMyM782X7VQKQ3S/uMDUknqfy6gLUd7HvQlOYTMdVueAFzZtFrRi+2avOl9MF8Li1JSC2vK1XZvw==
X-Received: by 2002:a63:c06:0:b0:439:9b18:8574 with SMTP id b6-20020a630c06000000b004399b188574mr1693470pgl.608.1665697749025;
        Thu, 13 Oct 2022 14:49:09 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b00562e9f636e0sm196610pfb.10.2022.10.13.14.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:08 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for konis
Date:   Thu, 13 Oct 2022 14:46:38 -0700
Message-Id: <20221013214638.30933-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     konishi.ryusuke@gmail.com, linux-nilfs@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index d118acdce8b8..c9c396e2d8a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14363,7 +14363,7 @@ L:	linux-nilfs@vger.kernel.org
 S:	Supported
 W:	https://nilfs.sourceforge.io/
 W:	https://nilfs.osdn.jp/
-T:	git git://github.com/konis/nilfs2.git
+T:	git https://github.com/konis/nilfs2.git
 F:	Documentation/filesystems/nilfs2.rst
 F:	fs/nilfs2/
 F:	include/trace/events/nilfs2.h
-- 
2.38.0

