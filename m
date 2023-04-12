Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A446DFEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDLTqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLTqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:46:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD41B7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t14so16009704lft.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681328769; x=1683920769;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMipdxD21+cTBwwjF9nIXWkP9aMovr2x6cJ12UzFBGQ=;
        b=ZUWzkEEhsAjbaZQgTj0rlwn/drPBU86OEIgej+DIOuQztUP30oyfgFyTzyzb8pnETi
         zE4HD2x7r78lOZujlDTv+Kw3pcJu2eNFrOllAx3REOoXwI6C102WK4BMhxNWvwTe3pS7
         pVLj0f9I354PlAOaXWCud94ORPNYywjFSPowjkp49I+2NzK60/5mvCo536L78mcxRiEt
         fZoyx/Q+m0ntizaAncNgvtEQnkaYJ6jdYohhwU0cRmWLzVanvjC8pPtZxazbMqrY2ndE
         zwok8WOXwTvbhtEr5RABBBxok5f3teVV4eU2igkZOYKxjlG2Z6EQ8J5XpOwIPjyznfIP
         nVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328769; x=1683920769;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMipdxD21+cTBwwjF9nIXWkP9aMovr2x6cJ12UzFBGQ=;
        b=QLIPk8Bb34LcjyEwYHCcY/UeXuQtZdo0BgzfnDloUzbgihcYcRDmLKSoM5zPGV3dcv
         mbo1NOTHfIRIPdVjLSJ1toGdmATuKM4wSYeMI3KkclNTpSoaoG5Woq+/XlFimxX4lKcn
         7JKE6A8oco4jE8bFoVkghx3LdHszx/WQz38iIHyOM5ztfgmSWpwm9YMYTNCaDWhtC/R5
         bnByQoPZ2mcpYNxm8QyFCe/+fahPS3Vgbu1fP/89SoU0TSN1nMAlg2ume8GWgoHdYGNQ
         fQaVd52HzziSRD9D+lcz0942FGwN7AF+nRHScKwIiPcVoJpU9TpNmJeOmBYd/3d0bzjo
         8wfQ==
X-Gm-Message-State: AAQBX9dzdwkiOXLyeZwMHpYNCTuHABLDktpFI3kEl7gW3/ouUMfxXUhM
        242DBtZ5sk3T16uKl2ru3ZoYBQ==
X-Google-Smtp-Source: AKy350b/GcDfUeo7sGLetepOSP0yU5RY//t78Kcc47q1fNwT7YY8CDV4bnc0kzUieVodM0Vf5Nky8Q==
X-Received: by 2002:ac2:5985:0:b0:4ec:8853:136 with SMTP id w5-20020ac25985000000b004ec88530136mr14965lfn.12.1681328769085;
        Wed, 12 Apr 2023 12:46:09 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ec8de8ab3fsm1205865lfq.132.2023.04.12.12.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:46:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/5] Lenovo Tab P11 panel
Date:   Wed, 12 Apr 2023 21:45:57 +0200
Message-Id: <20230412-topic-lenovopanel-v1-0-00b25df46824@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUKN2QC/x2N0QqDMAwAf0XyvEBtJ8J+ZfgQa9RASUvrZCD++
 8Ie7+C4CxpX4Qav7oLKpzTJatA/Oog76cYoizF454N79h6PXCRiYs1nLqSc0C2B3DByiD6AdTM
 1xrmSxt1K/aRkslRe5fsfvaf7/gEEzIP1eAAAAA==
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681328765; l=935;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kRg0hch6fi2xH37nEAUaLth9fudXwCTpRDD+mFHIEi4=;
 b=p9fFAxQHlWtrzOnMlWnUTK2o6ettidJSrzZB3UJBevjLz0bQ1QgEQ11kV9n6iT8HMHj0t19sIr4b
 u0wpt4HuBaMK56RyX0IUYlSq4PeKP3frYi2e/Z7cj3s0Z3bHwaD6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continuation of:
https://lore.kernel.org/lkml/20230217-topic-lenovo-panel-v2-0-2e2c64729330@linaro.org/

I rolled back the versioning, as this has been remade from scratch.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (5):
      dt-bindings: display: panel: nt36523: Allow 'port' instead of 'ports'
      dt-bindings: display: panel: nt36523: Add Lenovo J606F panel
      drm/panel: nt36523: Add DCS backlight support
      drm/panel: nt36523: Get orientation from OF
      drm/panel: nt36523: Add Lenovo J606F panel

 .../bindings/display/panel/novatek,nt36523.yaml    |  31 +-
 drivers/gpu/drm/panel/panel-novatek-nt36523.c      | 573 ++++++++++++++++++++-
 2 files changed, 594 insertions(+), 10 deletions(-)
---
base-commit: 7d8214bba44c1aa6a75921a09a691945d26a8d43
change-id: 20230412-topic-lenovopanel-0d3a057e3c23

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

