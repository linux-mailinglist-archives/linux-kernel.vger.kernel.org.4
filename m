Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EC8717881
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjEaHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjEaHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:44:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C49C0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:44:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2566f66190dso3021858a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685519067; x=1688111067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4nc3W4SI7d/HcZGsXX157wdAbHs0EiK5je8w50UqyQ=;
        b=NTvt2q5xE99luFijzCiaKdgrJpfmjmv65/TgTQck8seI3zdcz2O0+d9d53gBoulgmj
         Q8azOkszB+GhpKVJetOCb7uT9OpHB9aVghwW3gzcvys8enS9ICkccqD40EXLgB+d38pR
         jxLv1bnFxJGe4RkAm8TUbfUH1kXV4ms5fTYDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519067; x=1688111067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4nc3W4SI7d/HcZGsXX157wdAbHs0EiK5je8w50UqyQ=;
        b=QG8t+s8yh75iPOfC90iBcnIfw0JaQbaLz86JGN53wOCME2+P+0diCGm6GmguRP4wDT
         buizlOSbhrx+F+K6qwmXdyuK9D6+a//NR+ZEPkUtO91qLie6e2WpsKfDKwRd3YVXIkrX
         Eat2qJb/uKuXyePSrF9aUdFHgVOVDoVNDkwqJRcrF68qg9vUT1qQl9tGnIstoA5HmdEm
         OSUJCZ3XN09bNexIiGPA8uzXBBY7QEiFqtbrINquTl3xDE8XkGKJUXtDrZZYyC5s+hm+
         L9M7Q22Szn9HSrZvt5UySyOoOjhwxXQPUhWhjCvT5SB7sHsTKNhE/ZkI+x15eS4iesR+
         vDcw==
X-Gm-Message-State: AC+VfDxdzG81c5m9mpZBuEtt2p/AjeOLNhUHmdqaRoaOARgtfASYWASM
        g5vzSQ7LKIW02JKrO8lopoOjOQ==
X-Google-Smtp-Source: ACHHUZ5zzqgCNrh8XTUiFC/pDJbMydQ/sOdQ8Cgd8+eUrRvEpiSm6wVHUrcKlPo0bdwkNGNG4NPCUA==
X-Received: by 2002:a17:902:ecc2:b0:1a6:a405:f714 with SMTP id a2-20020a170902ecc200b001a6a405f714mr5385355plh.63.1685519067154;
        Wed, 31 May 2023 00:44:27 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:fbde:7ab0:3462:1188])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b001b050db1894sm647616plg.36.2023.05.31.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 00:44:26 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH stable 6.3] arm64: dts: mediatek: mt8183: kukui: Add scp firmware-name
Date:   Wed, 31 May 2023 15:42:44 +0800
Message-ID: <20230531074421.888652-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upstream SCP firmware path is /lib/firmware/mediatek/mt8183/scp.img

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 63952c1251dfd..7b2b175370443 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -822,6 +822,8 @@ &pwm0 {
 
 &scp {
 	status = "okay";
+
+	firmware-name = "mediatek/mt8183/scp.img";
 	pinctrl-names = "default";
 	pinctrl-0 = <&scp_pins>;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

