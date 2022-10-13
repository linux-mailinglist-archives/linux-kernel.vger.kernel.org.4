Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB195FE464
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJMVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJMVtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A38194F86
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 78so2656347pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=OExRtkTx6PDkVBoaaPF3qpvu0x7NTQG8UGQpp1aWJ98=;
        b=N/laVNRZqsF6lCLDvy37h8I4nVDhDGrcOOx0WqKH2XB9Sprf2CfgyZ2SoWPKto/Hqb
         tlrcQ+gAKIw73OmGoOvvhUwmqou15cAJfsLKd+vduXgHeI+H2Twol8L6VAqfAHqFjmLZ
         RyJQaFZ9kB/zOcZKXO0FrqofA9cOx4Own4oCIG0m4pFmmsFDY5Vtg5/GZxp4NId0F4PZ
         8ls8Kp8gvNoI5x2AOZ655Sr0wJp0MqQ2Ok/bd+yjWCUkOE8wFrJuTk7HSJNgnm+Uarvn
         FfqzWZW63QjF/OnHVIQAKDEXUPxB45Pq0yBwoDcuFKkUwnAd/TZiq5ZViDgJFYZZ0e9R
         mEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OExRtkTx6PDkVBoaaPF3qpvu0x7NTQG8UGQpp1aWJ98=;
        b=OLwIRJGLLnAGD70G0JoXCR6vV5k09Y1DCjoVGkqzu5REtlSr61wGbcOsKnZtJgIT3I
         VJeIxmgemEzhjScJf2Xn2OHuRp8LaVnHh8k3NQ/7aaIaECFKF1nsg3MZzFk08aQ/z+DS
         LVg1wKE09l/xJrkuw3ctXBTPg+vVgZNBxWZBfFPGMqHY01aQQRKB/2FlMINFOr9zG+5p
         l6Xu3zDQTmvUmL63lb48GLSY+V1vldVmypWwMH9uesB5eH9GPMLUB80tQ2nr7V5DW0wf
         ZqNKg42bNWYhpcqSFwNJ57vpMmcVY3O8sVNmtFGWagkCY++Wkx454fGbS+5D5fVKy19D
         xUmw==
X-Gm-Message-State: ACrzQf0N4go+DCuIm++FTVio6Mx6Wl4NSdmh8jISYvHInSPChgmDrVL+
        GXRvIieWh1pppbweC6PEFAefJrrCrMeyVLTc
X-Google-Smtp-Source: AMsMyM7oTkO64j+0OpM2EQ5JET5EQt1gNaIOBJE7G+tXMXARVfKCK7K6+jZV2DdeWjdXpfH5JVXVpQ==
X-Received: by 2002:a05:6a00:1c99:b0:562:6292:9e4e with SMTP id y25-20020a056a001c9900b0056262929e4emr1826956pfw.22.1665697740305;
        Thu, 13 Oct 2022 14:49:00 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y27-20020aa793db000000b0056263bf7109sm184801pff.28.2022.10.13.14.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:48:59 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for czankel
Date:   Thu, 13 Oct 2022 14:46:37 -0700
Message-Id: <20221013214637.30782-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org
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
index 019cdb48e254..7c71b452a84d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20069,7 +20069,7 @@ M:	Chris Zankel <chris@zankel.net>
 M:	Max Filippov <jcmvbkbc@gmail.com>
 L:	linux-xtensa@linux-xtensa.org
 S:	Maintained
-T:	git git://github.com/czankel/xtensa-linux.git
+T:	git https://github.com/czankel/xtensa-linux.git
 F:	arch/xtensa/
 F:	drivers/irqchip/irq-xtensa-*
 
-- 
2.38.0

