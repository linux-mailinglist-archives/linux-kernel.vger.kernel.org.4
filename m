Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3836A8E0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCCAbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCCAaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:46 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5B5A6D2;
        Thu,  2 Mar 2023 16:30:27 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id by8so754504ljb.7;
        Thu, 02 Mar 2023 16:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBoLaLgAfnzJMOco92w0PZhMXyCzsUA5lEBWwlGN0ao=;
        b=EMMa4ni9zrDRspPU5ftf0JQipoI2u0POA5nbF+kc3oe/G6/TubCteI6IDoea0/5U22
         rn4SzkTNg6n9q/RXrtVKqGuLp0oOZrS/RpNUwn/oFvoJayTzhtzITB59+y7iTBlfhUEg
         cVxoVeII2eLERdm1jq+apPU7OMj7/EHk+rFWbG5lQ/aGJxhj/hBshvJXZPDLRjNMnz3u
         Cs8u/+ynlARvsccuFBSqmSyB2oH/mKdfY695iisL5D/YDPo1vxmvVk/DOeAw01Gpyj0S
         wj1KmpaJFE/VF2OLqXmiYGdId2+dkEZUdkb09ahg3SOk8GKk5v9TuOKaby8O6qIzxeaZ
         p8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBoLaLgAfnzJMOco92w0PZhMXyCzsUA5lEBWwlGN0ao=;
        b=DxY/jqAG+BDUEcXu7c57Cq/aRUPV8ZvgwXBk/r6CnubsNrO4LlFb87WKizqcdfP5UD
         4XQIgMn4h9HcVxlx45zVvleTdKSjPuW+s1zv+0WcQkpCFm5GX2FmNUJccOsGzadOi2fv
         iT4ixq/sv2ms4c6lw2NtpB30moayfor63aaEcglzegsUW1hCp4ayWD2Y3CDMfEdOTddq
         AtT7njKFo3f8kpcNN9CIsyazBH6hM1p1bg63Jkqo0U+2hMJ9TdR+hqXS4EfObbFyqhS/
         KpAyCIajn8WovSco6JqRkP/kaJZUDA1G4aNyIPnqgeLjk+KKJeZ6yf4QAz9ywrisNy2g
         9vlw==
X-Gm-Message-State: AO0yUKX+KD0X1/+keXc4CNZZmstiLzfjayoUk5r3eM/YbOcYscmfxyTC
        Z4xr0bcSSdDv20cgOmVl7Qc=
X-Google-Smtp-Source: AK7set8rNy4xiBupjJ/nm4xKxLpUCbesFNEMDh48vzYZKeWx12ce9ZufLJQp9c42xDcig2JNeIlaWw==
X-Received: by 2002:a2e:9255:0:b0:293:5f51:3d41 with SMTP id v21-20020a2e9255000000b002935f513d41mr918759ljg.11.1677803421888;
        Thu, 02 Mar 2023 16:30:21 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:21 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [PATCH 12/20] dt-bindings: pinctrl: mediatek: mt8192: rename to mediatek,mt8192-pinctrl
Date:   Fri,  3 Mar 2023 03:28:41 +0300
Message-Id: <20230303002850.51858-13-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Rename pinctrl-mt8192.yaml to mediatek,mt8192-pinctrl.yaml to be on par
with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../{pinctrl-mt8192.yaml => mediatek,mt8192-pinctrl.yaml}       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8192.yaml => mediatek,mt8192-pinctrl.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
index e0e943e5b874..e764cb0f8c1a 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/pinctrl-mt8192.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8192-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT8192 Pin Controller
-- 
2.37.2

