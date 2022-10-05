Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D308E5F593A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiJERoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJERoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:44:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7937EFFC;
        Wed,  5 Oct 2022 10:44:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay36so11252069wmb.0;
        Wed, 05 Oct 2022 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=37hxz4e7MZTSus9DgCYcgdpnTvx3nmTcodX/mKNlM0U=;
        b=gJgcSlgc9UD7DCckOxia+yPqEKqLXHTyIXduivBZ0+CjGOBbDsNbTC9rrDhn5nJZ09
         t9jKCOba2V7nDw+B7pssKvHQmwhW4WrplzVQbPHKk+O7wINCniLHhglE72B2fWamCAMq
         LTAZfJPFqvUETC5EehzXjbjOBIFHPly7OqwU/Vye1gjQbVAAC4guhpIOVWeU1+J2fRzz
         wVtRsWa2yDa3QsKojXjiWFd3Y+78H6hiOUkbJKC26/lyV0YAaUvjcjjwxQGYkAVm/u72
         pgorn7YJtvKtUc2tmDlDoKiuIHqXwIydOATH3wkF7bCDdZS7igCCxD2PI6/9xf0c6t1B
         CPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=37hxz4e7MZTSus9DgCYcgdpnTvx3nmTcodX/mKNlM0U=;
        b=5uBRUHAjeEcbxZd1qslLj3XtybP0LKE0MkOVIhrFgf3avVxJKNAHHM9BbUaf1y9FcZ
         HSAl3fQwQOBvVMRhJnnF0STIDSZLxajncKihWN5J3rjqggbcVsZULO81bsUf+Qpl6NBu
         1XGiMEBdPZZ270z3Ptk/2Y/XFTfcTd68wvOo5MlwXU/81rhHjLQTHWHQVs9FHDYbLMMR
         5DfK7XqzAVvTanabhTG2T+rgCkFDViV01yBSbnLNBMKbm/ZdcwMWxoyTcf10bhuta9u1
         RHuLY3FiFIlwW6tbcfCqzeDGyFcKBhenpbK7Dn4zM5c+C271hp1pRN4j48EMSn/I+QO5
         EbOw==
X-Gm-Message-State: ACrzQf3xdh5KjwquoCNkXN5AlL2uf+V1iVINwk8T8v65G3H3C5DWG7+4
        nQihDkHjQtGyuRq1vDr6Fi6uVrhuMg3LcQ==
X-Google-Smtp-Source: AMsMyM7Zu9Qhq56CkvYbcjimwNpc6IeE5Q0+iaHY4uiTqFUh8hTy2KFZeo9ruEIIOAWerocVKz6kSQ==
X-Received: by 2002:a05:600c:4e94:b0:3b4:baf8:cf18 with SMTP id f20-20020a05600c4e9400b003b4baf8cf18mr4208439wmq.170.1664991858108;
        Wed, 05 Oct 2022 10:44:18 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4146000000b0022a403954c3sm16075491wrq.42.2022.10.05.10.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:44:17 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Improve description
Date:   Wed,  5 Oct 2022 20:43:35 +0300
Message-Id: <20221005174343.24240-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221005174343.24240-1-y.oudjana@protonmail.com>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The current description mentions having to put the pin controller
node under a syscon node, but this is not the case in the current
MT6779 device tree. It seems that this is not actually needed, so
replace the current description with something more generic that
describes the use of the hardware block.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml          | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 8c79fcef7c52..c6290bcdded6 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -9,10 +9,9 @@ title: Mediatek MT6779 Pin Controller
 maintainers:
   - Andy Teng <andy.teng@mediatek.com>
 
-description: |+
-  The pin controller node should be the child of a syscon node with the
-  required property:
-  - compatible: "syscon"
+description:
+  The MediaTek pin controller on MT6779 is used to control pin
+  functions, pull up/down resistance and drive strength options.
 
 properties:
   compatible:
-- 
2.38.0

