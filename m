Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096A35BA0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiIOSSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIOSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9D084EEB;
        Thu, 15 Sep 2022 11:17:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg5-20020a05600c3c8500b003a7b6ae4eb2so18210965wmb.4;
        Thu, 15 Sep 2022 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=w/cmM+y2gxKg5jm8Bro5w4Q9rtvJS+fA1dYQeKasii4=;
        b=ADLKYQ+KHFkm21cgXoAe5QyUtuILHJ/XNR4JJ5k7vytPPsxRuFEK33s6bW5+JgXxM3
         W01KDKcsJogony9DNkb95goIwVkKUuhwJedzsQUXB/uFS1FcRpKa6t8v8ejDmAtswciW
         ZirWdPu5JqSabpGpfYOkrhGxxMfc1LY46xngiO6a7BmkuUB7VCMTGfYhQH94a/FRqVEi
         H8WJp7HCSxWutENhrbVvQq224oR7S5eM7sUij6FeMMWoxv5HOUcZWx4nA6dOBSNYGzvK
         36gL09GwADtU+GarM13IK7uFaBP0PDOUw0sTQkTj7y+0cxXuNgKxdup9ZYm10W2D1TQq
         khog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w/cmM+y2gxKg5jm8Bro5w4Q9rtvJS+fA1dYQeKasii4=;
        b=bKvBYJucSxLamy0kfmlGy62ZlGsSZuk1mZVUzOtxLKOUiIoU+JQS+M9asmgl9YRNgS
         EGWisJBwU9mYw5CERQ5/0zNZl8+kmfFCEJ0T4PChOf89cT18iPy+pq4O9KRBF7dg2m7n
         voqT9eyHTwtWTCwITH5hneswbfHTpWXH3d3bvQBulApSTtFi9xDDMVWl0bc+v6i//GUs
         RYfe6uddeAw4bGAh2I+FgXoZ1TMmJqa1fY2euoaHjrx1FfUERpoTXgok3jI7VFlXBnh/
         ggi6R7D4GJbK8s/vr9TANeQEgHpjKTypbzd8IArXzt/g9Lk1mBhyIpWImPrfs7xwhlah
         6Y3Q==
X-Gm-Message-State: ACgBeo1VCppUbUIg0sIIlr+NCC2i4eYtwtRO0Gh2rojUe8sh+Xw4I17e
        ZTow4CO73Ap6z0gtg00OI0g=
X-Google-Smtp-Source: AA6agR7an9/4uyQQO6F1vpBCBq8xCtvSqjGN8uRyktlX5udO0YulxTlFh0tTWfgxnMgn8ncFz0+4DQ==
X-Received: by 2002:a05:600c:594:b0:3b4:7637:9444 with SMTP id o20-20020a05600c059400b003b476379444mr7863290wmd.52.1663265853164;
        Thu, 15 Sep 2022 11:17:33 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4243151wmq.23.2022.09.15.11.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:17:32 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 05/10] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC kconfig option
Date:   Thu, 15 Sep 2022 19:15:53 +0100
Message-Id: <20220915181558.354737-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Introduce SOC_RENESAS_RZFIVE config option to enable Renesas RZ/Five
(R9A07G043) SoC, along side also add ARCH_RENESAS config option as most
of the Renesas drivers depend on this config option.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3
* Included RB tag from Geert

v1->v2
* No Change
---
 arch/riscv/Kconfig.socs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..91b7f38b77a8 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -80,4 +80,18 @@ config SOC_CANAAN_K210_DTB_SOURCE
 
 endif # SOC_CANAAN
 
+config ARCH_RENESAS
+	bool
+	select GPIOLIB
+	select PINCTRL
+	select SOC_BUS
+
+config SOC_RENESAS_RZFIVE
+	bool "Renesas RZ/Five SoC"
+	select ARCH_R9A07G043
+	select ARCH_RENESAS
+	select RESET_CONTROLLER
+	help
+	  This enables support for Renesas RZ/Five SoC.
+
 endmenu # "SoC selection"
-- 
2.25.1

