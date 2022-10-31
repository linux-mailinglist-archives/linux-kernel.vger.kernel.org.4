Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE26132C9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJaJeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJaJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:34:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB774D71
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:34:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so15105708wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f58UwhQpDHzczA+5QKtK6sm9tfcwbG82pZn1CGvlejc=;
        b=cLu03t97Aow5oHYipvaLKKPRdGvr6iO8PWNY+ymOA3JvW1h4iAwXc8QZkkfFCQmsKL
         XuoRS7hclJeAHZ3VlJdTltoGAzs2V+qSYxiYXynkp+A19G4LmnlfuxjtdSviPCjFInsN
         10dSgO622XoQYsMcIC9HS93qAv/Za+HZRYafRBO+n/STEaY8Edtj9rysHLgTcbblwQdE
         mpY1X3MkcWX2aXwycGPXmiD4PUNDSYMNwuJQPPMZ0LUhfRpk5OWGbHL4esNeu7MoidFv
         iQo6Ofw0G0QOw4P13KLLpk3mfI7cuKM0+oRfK8jR8GrW29C/ASRCN82j6CnXN5B7/ub/
         4liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f58UwhQpDHzczA+5QKtK6sm9tfcwbG82pZn1CGvlejc=;
        b=Er2uKq0lhENY1GHMDqvzbm04ntMP/CZDto+zCvmmkrPSh4HC0LSEn1CO13B3QVHR8e
         ZQbD4h7pIu6rccKi51TBe/pouaHyH6mB9IX+T0R6iLmS1dy48FCwimzXsPNIS7DTySDv
         D7f1uB21kuskQALto+8z9IJklIwumdFV0gcxaB76sNRHUqb+qOgMg1EasXubO9mHr0/u
         85b8109YXYdHp+9ywVTLXfiKEi+r95/XM+LnMEOHg7parWZUeFNyS87mxcthlTLjDWKl
         2XKbtygmtqQPi5RJpbV5m473orH/xiKVXv5uTAUPeb/qFQabHs7UmcFSsJbKrY5sctua
         JFtA==
X-Gm-Message-State: ACrzQf29rNX1T6L2QlIkFr0d/0k4ILSCTjSoM2NQObRuUpc4nFrVvsn0
        ZE9o3Gj/YDroTYTTIZsASgg3YQ==
X-Google-Smtp-Source: AMsMyM6pZk8bSEyO/Ya/5Vj7m9SXW6/Sj/biRPXj25tFFdwpGWc9kYXw5i5PoaJZpW2B7Hqo5LBO/g==
X-Received: by 2002:a5d:5610:0:b0:236:50d5:e6ec with SMTP id l16-20020a5d5610000000b0023650d5e6ecmr7391051wrv.13.1667208856455;
        Mon, 31 Oct 2022 02:34:16 -0700 (PDT)
Received: from fadwachiby.lan ([2001:861:3104:1980:6db3:63f:b30d:9361])
        by smtp.gmail.com with ESMTPSA id t16-20020adff610000000b0023538fb27c1sm6547566wrp.85.2022.10.31.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:34:15 -0700 (PDT)
From:   fchiby@baylibre.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong . Tao" <zhiyong.tao@mediatek.com>
Cc:     Fadwa CHIBY <fchiby@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/3] mediatek: pwrap: Add mt8365 pwrap support
Date:   Mon, 31 Oct 2022 10:33:55 +0100
Message-Id: <20221031093401.22916-1-fchiby@baylibre.com>
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

From: Fadwa CHIBY <fchiby@baylibre.com>

Hello,

MT8365 requires an extra 2 clocks to be enabled to behave correctly.
This series contains patches adding the support of mt8365 pwrap.

changes in v3:
- Modify "sys" and "tmr" descriptions to be more generic.
Changes in v2 :
- Rebase on top of linux-next/master
- Link to v1 "https://lore.kernel.org/linux-arm-kernel/20220530135522.762560-1-fparent@baylibre.com/"

Regards,
Fadwa CHIBY

Fabien Parent (3):
  dt-bindings: soc: mediatek: pwrap: add MT8365 SoC bindings
  soc: mediatek: pwrap: add support for sys & tmr clocks
  soc: mediatek: pwrap: add mt8365 SoC support

 .../bindings/soc/mediatek/pwrap.txt           |   3 +
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 114 +++++++++++++++++-
 2 files changed, 113 insertions(+), 4 deletions(-)

-- 
2.25.1

