Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309985BA0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiIOSSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiIOSRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9332B9F758;
        Thu, 15 Sep 2022 11:17:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso5021016wms.5;
        Thu, 15 Sep 2022 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ibdgAaqnlyBKPF0wq9BnsIa+piapHma/lJGXO+/rxrk=;
        b=htNR2PheEpPZDb/m7LbNTBE/5djFhHgvXryqym2grtgXZHZqGi87Ptq4mVShCcPv+e
         LMsLyDEM75fbD02+ZeElWdQwBvmXweC4re3Suw+my3IsUsWB8xT8DhBfa5aEC3ia+sjP
         /9Q33VI7m+j4lQMIsB9q//IaaOrQkB+enEgymjGTMhwXEV6kZ0PAhTBrMBQAz1KsHI/z
         fqadXca/qLz0QxUGu6C8Kp4rtLbhw/7u6TT2GmHqU52+CQ8bqo+0zvSuxUDGsJFaS6sj
         Nl/w0EIo+EaRxJV/94FHU4YNwGmU8DsWCKhjUosfgfzjdt7QjK2u22YnFn0KxM8P08OA
         Qr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ibdgAaqnlyBKPF0wq9BnsIa+piapHma/lJGXO+/rxrk=;
        b=IrFtOXt9pdFwjkQdFpbxY21U6I/RgBY8ek9Q91YxScHc5eff/K1GQMK0n/bTGv8FIf
         DJRZmbaXWjQiRccVgrEnIP30yAib9u1QnXSm0r80WTGvg30m4/nuJ7VD196zAInksK3Q
         41tQA5PCukhm1XuY15svgILuvH4I8Po4waBvkJYEFvr69ryGMzK5J6Jn+vvseupQrYri
         ZNOIr6Viboempoej37Rs5Fzv/qBXEMkzj+iBG6VTQlVuAKenEGkQfwp47TuweDyeDt8f
         tkRgeclPdbrA0Bd5MVgTNggaWx6Lk4YCeVDgrKa+JYaFOcp86+1qExwOvy4f/VPVVGvD
         bliw==
X-Gm-Message-State: ACrzQf3HITIofH1jmJGIXSlLMZTP56BxrNPij/zlo05QSCFktavseZzv
        Y8mXvVPHNETB3tPrFSVAVSI=
X-Google-Smtp-Source: AMsMyM7LsZh4q53nxahSfi9XCqj48tZH3611Kuzalqx0HPgh+d8lUYmiPnHsYWuHQxJDKhgXMEiPmw==
X-Received: by 2002:a05:600c:26d2:b0:3b4:7572:4317 with SMTP id 18-20020a05600c26d200b003b475724317mr797937wmv.134.1663265859875;
        Thu, 15 Sep 2022 11:17:39 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4243151wmq.23.2022.09.15.11.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:17:38 -0700 (PDT)
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
Subject: [PATCH v3 09/10] MAINTAINERS: Add entry for Renesas RISC-V architecture
Date:   Thu, 15 Sep 2022 19:15:57 +0100
Message-Id: <20220915181558.354737-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add RISC-V architecture as part of ARM/Renesas architecture, as they have
the same maintainers, use the same development collaboration
infrastructure, and share many files.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
* Merged as part of ARM

v1->v2
* New patch
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5f17c50dac3..99483c13b91c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2665,7 +2665,7 @@ F:	arch/arm/boot/dts/rtd*
 F:	arch/arm/mach-realtek/
 F:	arch/arm64/boot/dts/realtek/
 
-ARM/RENESAS ARCHITECTURE
+ARM/RISC-V/RENESAS ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
 M:	Magnus Damm <magnus.damm@gmail.com>
 L:	linux-renesas-soc@vger.kernel.org
@@ -2686,6 +2686,7 @@ F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	arch/arm64/boot/dts/renesas/
+F:	arch/riscv/boot/dts/renesas/
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
-- 
2.25.1

