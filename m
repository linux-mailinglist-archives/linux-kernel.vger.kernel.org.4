Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5B5BA354
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 01:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIOXjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 19:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIOXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 19:39:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC71180D;
        Thu, 15 Sep 2022 16:39:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z6so807161wrq.1;
        Thu, 15 Sep 2022 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=hEjzd+p4D5uEZGkAUMlWi2auDcn9TWiOqvQ6ysuAhjs=;
        b=ALeu6p6DNj/MUFpvV+HQSYbR90S8H14wR3zUb6yBM1eNuFfKy5VC56EnugiLHowe7B
         GbvzPiMcNnUtWoqOReK0TxWFIeOz3JPAa6FnFkfamU658NMGUQ1B3dwnD7XdygVu1DrP
         Qn4zhYhHvphhIjAUH8L/Zr2v/GKC6t6OusQ6551YXUuQVa9oUEOPD55BYucZ2ajW5oB7
         P/smXpz6lEvxB8EhIAahOFGfK4il8CQ44hmJGqN/++D2WfJX/e064zvAuuQyJKc/gRxW
         sxOlR28m7Y3DZnNcOhOn9VwfyR5EK3Hj6+hl3j+B+i/8sR58F+BPiM9JKxTCPJVrjkBX
         RuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hEjzd+p4D5uEZGkAUMlWi2auDcn9TWiOqvQ6ysuAhjs=;
        b=z/4AmoPXwKL4yqH7lHH4oxQ/QA38pe5RFF9E4Iz2I22TY7Ne+4GZ2qNdnZyWBJ9lo+
         5qtcuFjEDUv7vPK4LqBCIhp5hG3p+VSwkOP/8VOY3nGg1CKqc1dXNBMSHcNnHcr8usrp
         Z92tBLJ/eAuztEV1VWpi+F/A92hbOwrJ01XYBfx1fLHUefQfDzmyo8siDMhjW5vPbKjB
         emkoNxlyuqcEOGgnXWBjnZOCXwd8HIxqNnvvtxKi1tQmuvKQMXDrx0QJ5gJwUDcaZDf4
         Fql7s6chyTU56xS3up/PZXjyUEAxL8j8kTt6cvN8YKuGAgiGTFrL9qPocdkjJP/CrkP1
         g1QQ==
X-Gm-Message-State: ACrzQf2unpqTfvEKlqxSPgDjZS/WdPwEZ6RiqQ1oNYISsbwJLFoVipzA
        RSVe+WYPXqlgXhkF1qPU11ji/q2EaU5LsQ==
X-Google-Smtp-Source: AMsMyM63BHkNlUpPha+RlRnekZgMfRlSz8f//7rV3uvwk5CMYdoWLiN6FMEDd2RKNB5fIHPy2zFT9A==
X-Received: by 2002:adf:fa88:0:b0:228:6237:d46c with SMTP id h8-20020adffa88000000b002286237d46cmr1197827wrr.571.1663285144252;
        Thu, 15 Sep 2022 16:39:04 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b002252ec781f7sm3742720wrs.8.2022.09.15.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 16:39:03 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] ARM: shmobile: Kconfig: Drop selecting SOC_BUS
Date:   Fri, 16 Sep 2022 00:38:52 +0100
Message-Id: <20220915233852.415407-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Don't automatically select the SOC_BUS config option as we already have
automatically selected it as part of the SOC_RENESAS config option [0]
as renesas-soc.c [1] uses the APIs provided by SOC_BUS config option.

[0] drivers/soc/renesas/Kconfig
[1] drivers/soc/renesas/renesas-soc.c

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 50909c4b95b2..37f862f13c8d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -6,5 +6,4 @@ menuconfig ARCH_RENESAS
 	select GPIOLIB
 	select NO_IOPORT_MAP
 	select PINCTRL
-	select SOC_BUS
 	select ZONE_DMA if ARM_LPAE
-- 
2.25.1

