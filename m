Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A665B7A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjABW10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjABW1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:27:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA79C1B;
        Mon,  2 Jan 2023 14:27:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y8so27552830wrl.13;
        Mon, 02 Jan 2023 14:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wtP7E2/yHl02046h04PnnDHRMQAylX/VciI7feb4uc=;
        b=XYlFT3Q3gY1UCrytvXj2iKmGX3LlIliu5asqtmjrPwaXmHvtudON3zx4M+A28yNMvs
         dRHNCj/GtDG69GekRpiGhCLUNKom1z55XXESugsG5G50xQoOkRzMijKqwxZ811lFS2Aq
         nuz52UsvkiTUEBZt6dr8KHPJwWMGoCCzRap+ZXeOFvzDQWZRunGZ/DOAWJghLVdfN/KC
         AANSi+CdzSqyfU6+Rmf+uaoUhrhZu9O+lcBwAAvt9L7io5sdtS1ImqbvecObwVuFfzqs
         /8NwZ358JAO2VhODXhaOWi2wOKS2cELCLtn3HJNEVTROeWHdRS50HhRLlBH0KQ+sTtyr
         42KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wtP7E2/yHl02046h04PnnDHRMQAylX/VciI7feb4uc=;
        b=LD2G+z66zy4hp9qv9d/OyBXfzL0FvbsBGPhYaTemBt+ZPhFxbWFQhmdTRQbhJHhyN6
         EQnuIT4JZ0F5jciFoXz/Bgv2sW6PFGygqYlvBhwYqdeOmhtHFFwzilwIyIWPdQjWAR+C
         jzrn8j1v+aLDk8Rf9nMOkqA/QWDWbXvEjHXKWJnpc9WUVeOQnqB/NhWOXRgwyNmCoI6u
         OP9DK7xH+jAXDlZDNDGeDEv9myBXg4cNbT5JkOhW+VGKoKWULYhELliaAwGeqJwZDLP0
         icun9tEBase/C0YvtvIK8+RAXov+ZxUtVI/MMlCVrXIJ12VSjlb5oWeoCeMn5EjGjtV+
         a2Gg==
X-Gm-Message-State: AFqh2kpTjucj46hmoezp0RyIRiHAMlVWT2jQSIMbBRlywzxoHJry8Uet
        p8oeZ8WRlHkoZsfVgoHL83A=
X-Google-Smtp-Source: AMrXdXuAdYrxMskOHbOTNuRZtKsmI9gENs7lCNTVa9gUFGSdMVP1y8CGfWRhragy70StL+hWnqdgLw==
X-Received: by 2002:a5d:4687:0:b0:289:552f:ed13 with SMTP id u7-20020a5d4687000000b00289552fed13mr11682705wrq.25.1672698441013;
        Mon, 02 Jan 2023 14:27:21 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:8a7:e535:b020:566a])
        by smtp.gmail.com with ESMTPSA id h6-20020a056000000600b002423dc3b1a9sm28298184wrx.52.2023.01.02.14.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:27:20 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt support for ETH{0,1}
Date:   Mon,  2 Jan 2023 22:27:08 +0000
Message-Id: <20230102222708.274369-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

IRQC support for RZ/Five is still missing so drop the interrupts and
interrupt-parent properties from the PHY nodes of ETH{0,1}.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

This patch is to avoid build issues due to patch series [0]. This patch
applies on top of [1]

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221229230300.104524-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,Prabhakar
---
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index 73941a5f844d..d6f18754eb5d 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -24,10 +24,20 @@ &dmac {
 
 &eth0 {
 	status = "disabled";
+
+	phy0: ethernet-phy@7 {
+		/delete-property/ interrupt-parent;
+		/delete-property/ interrupts;
+	};
 };
 
 &eth1 {
 	status = "disabled";
+
+	phy1: ethernet-phy@7 {
+		/delete-property/ interrupt-parent;
+		/delete-property/ interrupts;
+	};
 };
 
 &sdhi0 {
-- 
2.25.1

