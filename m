Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A935BF883
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiIUIBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIUIBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:01:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581028688F;
        Wed, 21 Sep 2022 01:01:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l8so3852215wmi.2;
        Wed, 21 Sep 2022 01:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=P1brdYL05ONOqQ4UPTBlIuUKc3UGGvzkcC42vcfAOXE=;
        b=Tp4x8+lc/Y0D2Kel7La5a943urpZ+ieIGWh3yhiz3eDUFYePzoFJAP+2ndSSKxnJc5
         m0ZqC1mtwCT6x+pe9R3oHcQzEfozq5zeFVC34kNQr4FG6FiBOYlf9ypDV4QWUduETurm
         lShJkM84+xebPK4MDDXeqH4re1appi8FSIbj4Ee9v3gWWGJFj9Z8bl4dKMMeytNT7f07
         kWITGFlBX8XBTWO0wKsbXcpZWiofRHjNOd+jg3WK9bfCGPfVbCIIw94BeC6KX7579CZ5
         YId80/1v43hxBsyfMtCpvZaDEsCh5vHEUBCJO/JVo/wgrXV31E304zh5RvEY3wTTNK75
         X69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=P1brdYL05ONOqQ4UPTBlIuUKc3UGGvzkcC42vcfAOXE=;
        b=TuwxoGCB/cOLWmv6/Z8EiqJDSIOsa5OZ2gHxBjHZ2RmIdLMRiMwXlRVSGuujtKcoFD
         fjoEx7deOsPTYaLa5zBi4hwoqbxpj5q9yGbgdvc8q1IzuVTT4oH7rZlhnDvZtQnIWiMc
         Q/3RB7R2p2hGB7s+UbW017/UdY4mvVK01lUj2Mb54oK1l4jWK0tPMI3Gr8SqniklNDOi
         yfLUeJyOxl1RAfq757itj9/ZNpt3EjOr3mNs1ut/6ydVU26Dtde9m2tEtG1gn5Oejjd7
         1Pves7OsBuZFcvdQ/X5LNDiAK/plR56mi16LrpyjQD3MrhS4CxdxDav0Zvf9hBvBKDRB
         fGGQ==
X-Gm-Message-State: ACrzQf0hiLyj6eA8bZlKdGmYzHd000MCLM/o49SW4lWHowOik917VQpt
        sPQ4IqGzNlOBkKFEpKpNFFE=
X-Google-Smtp-Source: AMsMyM7T6I+upU/Mrkb86ceE1LroMuK/me1ZMw8e9uVVDpvwEa3joBeBaHLI5M5hUMpecZQvqzhOhA==
X-Received: by 2002:a05:600c:4e89:b0:3b4:8648:c4e1 with SMTP id f9-20020a05600c4e8900b003b48648c4e1mr4993677wmq.26.1663747266639;
        Wed, 21 Sep 2022 01:01:06 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:a137:83be:d4a3:8e44])
        by smtp.gmail.com with ESMTPSA id n24-20020a1c7218000000b003a8434530bbsm1968410wmc.13.2022.09.21.01.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:01:06 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clk: renesas: rzg2l: Fix typo in function name
Date:   Wed, 21 Sep 2022 09:00:51 +0100
Message-Id: <20220921080051.5604-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Fix typo, rzg2l_mod_clock__get_sibling -> rzg2l_mod_clock_get_sibling

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3ff6ecd61756..16beec2e3061 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1014,8 +1014,8 @@ static const struct clk_ops rzg2l_mod_clock_ops = {
 };
 
 static struct mstp_clock
-*rzg2l_mod_clock__get_sibling(struct mstp_clock *clock,
-			      struct rzg2l_cpg_priv *priv)
+*rzg2l_mod_clock_get_sibling(struct mstp_clock *clock,
+			     struct rzg2l_cpg_priv *priv)
 {
 	struct clk_hw *hw;
 	unsigned int i;
@@ -1101,7 +1101,7 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 		struct mstp_clock *sibling;
 
 		clock->enabled = rzg2l_mod_clock_is_enabled(&clock->hw);
-		sibling = rzg2l_mod_clock__get_sibling(clock, priv);
+		sibling = rzg2l_mod_clock_get_sibling(clock, priv);
 		if (sibling) {
 			clock->sibling = sibling;
 			sibling->sibling = clock;
-- 
2.25.1

