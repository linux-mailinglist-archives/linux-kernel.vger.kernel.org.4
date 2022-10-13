Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ADC5FE47F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJMVuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJMVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:50:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E72189C10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so6110207pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=EjxVWMcJMRpa6lAFzTRS4AcgS+QmtXBm8PCB8IQJ40U=;
        b=03p2FXnQEsZUNef/0SRFHBL+dYd5/Vzt7G17oGRv+7lJi9QJ/DrPkWpGfqNGqw19aK
         sC8sHZgAFIX92qwJOxoZ7eyFElLISQBYQ1EXCJ2CHn2oRphCkhCPSliC/l94rKXxDke0
         cciqKErfP1XG0p4S43vz0N8ZQobmX3fYY3kDMV6zdR4kn9NPud6XXEHb+86+Xk7i32g2
         11mTvyY/BiUGeUuYUZVAa6Qfx2fgFJZQUWEC8JjX/bD2HTgrF3dDVR1ubYkazDwra+Ph
         Sv5oKWWzvM67d/tF4aVpOCAjo24hpwF6HwTsRsYVMgGTfkhvSfyCMYsvVFBFj88IDuQU
         xTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjxVWMcJMRpa6lAFzTRS4AcgS+QmtXBm8PCB8IQJ40U=;
        b=YcL/2SZTbeL3h5YJEkxrDlUuXmuArzBhNytPsMn30slnKWpciZpuoRQaZyQucgvQPa
         EAZKlCwNoIXN3NgxybQf3HADL5bo28QChdABsAzojBkR6/pFczRsoCNZtD3Mn0zjIY6y
         nI2lGwYpa9ISQinkrgGwZbl5Nd0G8ISGFxNb9RTxB1XeXpY6tyvsKFRhZPvOaVtmNECk
         TAzva/A/0xgJ9IeIZ6rNVTwvqyZbpsnfuOxhqSPumZhuRPKpq3T0a2InZk4b2/rJLYN5
         jC9pFSeVyfJpKG/QvOb/4sHdmrJxjb5z4EbGxTXW5Lhkc2qJN1nY6L4PXj4qcXssEdJT
         FjZw==
X-Gm-Message-State: ACrzQf0+GBvvBzgN0uCPseQZd2XJUP3JT2TXsFL8rHzNF30sctAhEoHV
        X6kpggueBTAUm4U+dyiPBgmbt4+y5d+db+iM
X-Google-Smtp-Source: AMsMyM7R4FjXpo6WBnrtYQqCVMjoEuQ06HUTYPepgW2JFItYDeZ8LACkn5bp6AvZWXNaMaPBqvBaaw==
X-Received: by 2002:a17:90b:1e0d:b0:20d:bb8f:367b with SMTP id pg13-20020a17090b1e0d00b0020dbb8f367bmr823409pjb.60.1665697762782;
        Thu, 13 Oct 2022 14:49:22 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902be0b00b00179e1f08634sm287397pls.222.2022.10.13.14.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:22 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for linux-chenxing
Date:   Thu, 13 Oct 2022 14:46:39 -0700
Message-Id: <20221013214639.31134-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     daniel@thingy.jp, romain.perier@gmail.com,
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
index 3bc404b292d3..5a7194bd66d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2430,7 +2430,7 @@ M:	Romain Perier <romain.perier@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
-T:	git git://github.com/linux-chenxing/linux.git
+T:	git https://github.com/linux-chenxing/linux.git
 F:	Documentation/devicetree/bindings/arm/mstar/*
 F:	Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
-- 
2.38.0

