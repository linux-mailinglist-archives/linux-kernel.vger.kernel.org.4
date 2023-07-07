Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FEF74AF8B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGGLNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:13:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A43A183;
        Fri,  7 Jul 2023 04:13:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53482b44007so1007225a12.2;
        Fri, 07 Jul 2023 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688728384; x=1691320384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVlSSoX7oZtWLsOXtBM8B7Pp7IwbRCVkoUJqEvV7cGA=;
        b=kjiK41Uqthjwvmk2YOkvns2DUg9bY1lmn9yAZrCzdmmmthg9Ut0rABwvlsslWHp3pf
         xqpxzBpL6KllTE42/3NjBTcnBd/fyjjnjEwV9nXbK/SfrCgueF1RDTLi1vknQoBI+2Zr
         Mm5gC8qlcId95wjbxHsn0AxM3vmcQAMcKSAph6YvepLxK42MGUtAWmOAMxPaX1PxAOCX
         UKsFF6+xYxcYfRDorin1/IYtBe+igNu5VxNryBhU3Jnmt5RYNIGZCSd5QZZ7BdwkOoLT
         dhcpdN4ngyLeg5YRE5CSug1bdNZWbd6mwPzxKeKtQ3wPvxcvDC2+caRI+8VY1dd6+LVV
         cbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688728384; x=1691320384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVlSSoX7oZtWLsOXtBM8B7Pp7IwbRCVkoUJqEvV7cGA=;
        b=YXPyO9Y7RntD7KvEl2kkh3pYf50M996AUx6a8yuj65UhqI8Ns64tNycJGE/leWVrLT
         pXgpCFp2KU/HoWmXO4tku0RUpH+zHsBnNwdmRaVmL+yqNxPWKnuyDw1LpTUYqLzp5vOF
         mWixalUV1MId2ITjixY8g6O6dSDe4eTNdC/WFUQRdZD3+hv1WtBjL4Of4epqHQ5UaN85
         15bzpbK5FptTzxzhS9puQ4t5b2TQtiYUGBXpxy14uzFN48p2U9Hf5tzNzmSiBqsTioVt
         4i/IfBXqzwY+Cij5JHgFP0dbgBd6HpnxoJlfwUZwOP1ovh4QBRueF962xxVxA1alMnjK
         KK6g==
X-Gm-Message-State: ABy/qLbxcquo8x+mn00aPYFC9r69mizruLlCsBEzFj8FGXTV50gTpUjr
        CLOESFTPkYzqSUi8SWfodYx2rvg4XhtKVw==
X-Google-Smtp-Source: APBJJlF5P0fGxBWVXUYKhfzRzuZ5NJV2U+fR8gbwDglB+1rgmn6tlyFKXjcgyVCAd4CtVRoOjNQ2jA==
X-Received: by 2002:a05:6a21:9983:b0:12d:cf28:3bc7 with SMTP id ve3-20020a056a21998300b0012dcf283bc7mr4205764pzb.11.1688728384271;
        Fri, 07 Jul 2023 04:13:04 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902744c00b001b8c8d06285sm1985639plt.122.2023.07.07.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:13:03 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 0/2] MIPS: loongson32: Remove obsolete header files
Date:   Fri,  7 Jul 2023 19:11:49 +0800
Message-Id: <20230707111151.461373-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one is using regs-clk.h and regs-rtc.h.
Therefore, remove these obsolete header files.

Keguang Zhang (2):
  MIPS: loongson32: Remove regs-clk.h
  MIPS: loongson32: Remove regs-rtc.h

 .../include/asm/mach-loongson32/loongson1.h   |  2 -
 .../include/asm/mach-loongson32/regs-clk.h    | 81 -------------------
 .../include/asm/mach-loongson32/regs-rtc.h    | 19 -----
 3 files changed, 102 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-clk.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h


base-commit: 826eeaf68b03e5b96bdbc11e3e796f8b562bc0e3
prerequisite-patch-id: 6e96bdeb437dde42fff19ffe564c1ed47e95788d
-- 
2.39.2

