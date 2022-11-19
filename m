Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD3630EAB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 13:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKSMUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 07:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiKSMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 07:20:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B207D50B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:20:03 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t4so5428630wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cLJgdJggOziMXi6IiE8SX5FvNKSVl5DqzDodf2L/iU4=;
        b=5weTQjMpYyZLArzWcRVDHDNeUr+uiPvvXTjT171sM4KriNuICh+iUAIMXotJJwvgTs
         UJiwX3dF6unJuA4NKAkfMhCvxGMkksmGbgIZB5XzUYM6UC23nLXrisYGgkfM0Grl+vCS
         T659ljWNaNx/nyuJ/35boLRWbZ/CnAv+D6uUw7NZp7m694rSUiO1owRz3ikS7M9NjNGf
         fxgm+KsD5SfMcLm9yc0rf04AJDAb6z+J7v2SMnXLTknEwUKhHZJ7NmB5FPa8IhdMOHJy
         EQJgC9PUw4fb7wc7LBia+bK+5AssCAE5FK/geOjGUpwmcMFcGWlI6XaCcQHiQy5jeEA3
         Q0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLJgdJggOziMXi6IiE8SX5FvNKSVl5DqzDodf2L/iU4=;
        b=J1f/W65H46BWg4O9p3oiIYBpuBanurrtWNrySTicTEYbcMygnDeq+F5y+g1FKtP437
         Plh+Bo3ZVFMlr020bd+MU0twqe8NvFsNkng6dV1u3mb8jHdYSEDMkMOZB0rV7VdAE8vN
         rmDsoKDRY1OOLxkvX7h9J49Yke2cfeFfTPIE+IJPQfqrvCMcd8Gw+woOOiQG7nMryNgU
         /hHBCY6/LA/gWO0GOxESOrWagbk2BdtsH/Yx2zAdnKaBm1Yp5MWHYWppJZ26+FdbNERg
         tlmpwm7NjmpnqIoC1hEtjpkR5gNHCKPanaIc89JXbXjnx1GN2L5hHAfWmHkmUC/r25X1
         gYvA==
X-Gm-Message-State: ANoB5pm/6BkPyZLUcehb5xHE6VphZqQvm4LTiOJBZvnM9EkptJztx7Hz
        fdIeHNnYDCe6rvEbjyvyPuWmJMd6AR8Wqg==
X-Google-Smtp-Source: AA0mqf4LFyOrePUIgycRqEuPm5CQq7mnhuFsGijBchwH5J/bxA8LXECYVDFvOCYvKfiuK/RBk9UuAQ==
X-Received: by 2002:a7b:c00f:0:b0:3cf:7066:cf53 with SMTP id c15-20020a7bc00f000000b003cf7066cf53mr11014926wmb.135.1668860401970;
        Sat, 19 Nov 2022 04:20:01 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z3-20020a5d6543000000b002356c051b9csm6007440wrv.66.2022.11.19.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:20:01 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] riscv: defconfig: add SERIAL_8250_DW
Date:   Sat, 19 Nov 2022 12:19:53 +0000
Message-Id: <20221119121953.3897171-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jh7100-starfive-visionfive-v1 DTB was recently added, but all my try to
boot it in kernelCI failed.
This is due to a missing serial driver in defconfig.
So let's add CONFIG_SERIAL_8250_DW which is needed.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f7f32448f160..9a35ff88bec2 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -123,6 +123,7 @@ CONFIG_MICROSEMI_PHY=y
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_VIRTIO_CONSOLE=y
-- 
2.37.4

