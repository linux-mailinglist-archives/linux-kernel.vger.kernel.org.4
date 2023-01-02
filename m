Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09DA65B7A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjABWWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjABWWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:22:50 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A611913E;
        Mon,  2 Jan 2023 14:22:49 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g10so7647212wmo.1;
        Mon, 02 Jan 2023 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzAhGjXaHPnQR3DC+YI7zHhPYNDOaj+LjnPkK+FZLFE=;
        b=j0ZQqW2uJDkWbhQ45/bqKldlVp4tBWD6gzWQPbPpR1V6AFZ5Ihrs4OZNBzpQgps/m4
         rTXaS/c0hFcCPZ4WfkHw/8Fqj/GQW3bwjF0yKbbdbo2f4nsXaGbw4firdjzZa6aHeiCq
         H0BUBRvG5b6LlzAwcmLoAOXuThD9YsZyLMnTEaIUqrKhc5bbDJy6jCSgD+z411j9YKZw
         eaVjDBNtWH27us9LIe1++zF0/urLoVxZYOsx/BNrxcXNyW2E3DWYJ1WZRyi6kR91zuXe
         yU1X4KVExp5RBj5pYF+QZPiIP5/Kz1guSKUYVWW6EFB+SWEAwa1qhY3K2NWgmlRhQvCw
         DiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzAhGjXaHPnQR3DC+YI7zHhPYNDOaj+LjnPkK+FZLFE=;
        b=t0lWQegmx4Fhts6VFmvmtSjcTspnD2YESLLuQTgxsfGuoGA6dRvDvNygIqnFm4ztj+
         KrEL6j0KlpROQ38owBKx5k7auj0W+b8vgxCxtdfKbXmsZSACwbCl9W29Vxr6g3Vtm7YC
         6V5PKfcHZwtM1kkZXuSQmjvU4/Z7zS1ynvQq6bsXghNuaD4o7g8r4equULk10VCTMWDN
         noYJ/vUd15J2KOVdj8ji56/R0NvJjlpNJj5Ps1U4SN4MYw5tSra/BPD1QKDydQfpndOj
         TthKU+9qN0sVf6T1G3NF4+e4uC12Uf9/RVwxBD7cCLe6lOIv+4tauPShqpwAgZXvPZXf
         Uz7A==
X-Gm-Message-State: AFqh2kqiGee8/LJ2ZKIu8/LEr4XQpPyOvMWFGxZp16/xY+i1+dy5lgf8
        RbUjCIWYxlyr+OOCBVxxTz4=
X-Google-Smtp-Source: AMrXdXvs149q2RLwB0ZezqErfp0NhNZDzNbvUCbH1XcRYTqw/I6EeHFpBoeR9KbtNh2ItGEhDMU+3Q==
X-Received: by 2002:a05:600c:510e:b0:3d3:5885:4d21 with SMTP id o14-20020a05600c510e00b003d358854d21mr29134502wms.17.1672698168250;
        Mon, 02 Jan 2023 14:22:48 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:8a7:e535:b020:566a])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003d35c845cbbsm50341636wmq.21.2023.01.02.14.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:22:47 -0800 (PST)
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
Subject: [PATCH v2] riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
Date:   Mon,  2 Jan 2023 22:22:33 +0000
Message-Id: <20230102222233.274021-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable OSTM{1,2} nodes on RZ/Five SMARC SoM.

Note, OSTM{1,2} nodes are enabled in the RZ/G2UL SMARC SoM DTSI [0] hence
deleting the disabled nodes from RZ/Five SMARC SoM DTSI enables it here
too as we include [0] in RZ/Five SMARC SoM DTSI.

[0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Rebased patch on top of [0]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log/?h=renesas-riscv-dt-for-v6.3
---
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index fdfd7cd2792b..73941a5f844d 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -30,14 +30,6 @@ &eth1 {
 	status = "disabled";
 };
 
-&ostm1 {
-	status = "disabled";
-};
-
-&ostm2 {
-	status = "disabled";
-};
-
 &sdhi0 {
 	status = "disabled";
 };
-- 
2.25.1

