Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7388C6B8386
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCMVB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjCMVBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:01:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26425CEF9;
        Mon, 13 Mar 2023 14:00:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn21so23867294edb.0;
        Mon, 13 Mar 2023 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBoLaLgAfnzJMOco92w0PZhMXyCzsUA5lEBWwlGN0ao=;
        b=VNfvqJIbDAFzUx9F7DycqfH8zfRpONT1Ihmmg/fyvFUfxFgFAX/cFztP6SvhnJqwJ4
         sBT4tLa+r9HVfxbnZHOPY+sQ1CSJAmpbT6h2McS1ROw3st/F2r91QxXLD4XbfjjRcOA2
         VZzNxFdLdEgM/aXYoAvBPlghjmEp3SFgafqCsiBNBYEZLtbVqCecYjC7w03SWfDcbdzI
         PCJp3DuKJxnGeiT9GxoOhLihYKQZrfMVXNbIgOHMmzIOrZyGTInH2AkensX+P5M3Afpe
         qLxS/NPZLaZt19/K+Bf+/OwCDB9T3fvagwHyKY1k24zlRJK8O1JlXxvj4N80ossdbypr
         lR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBoLaLgAfnzJMOco92w0PZhMXyCzsUA5lEBWwlGN0ao=;
        b=NcYQNLWrPddhlkdCd4Zc6ToIKx5VGo0Mikzzumi3XKey2YyPBQ09h2f2urhHJlj6lT
         nX23+2sOXlvNAd26Sa8T8byLZPkrCagfYH6N5x7nizFlM3p2vp4dqS+CxiePfz0oJ8K3
         lqRk30opevI+ODb+TB7HvsnaUwSI0tcgABB9GUXQ0NfkQmn+aF8O9ZblfYiUuIDHxmwu
         tMxFzex8T0qP2bZHul5nHxLzHNQsmXPZAegM8639MZnEspLV0Y3Rf0HXnCE5jfUGkryD
         b5Seb3iNxtlHWUrJohUQcMoBOTSRfp2eN+onG/T4pmdEQE+Pal2AOsWWppMMRgcOyUyb
         3YQg==
X-Gm-Message-State: AO0yUKXdOm4CTIbXnwLTzuKXL3j7nDF6YA8l88XmfTa2BgNqvhTzxyKh
        vZFhAuSeB0EXdwxB8zDjS70=
X-Google-Smtp-Source: AK7set/feasWEvok6GrjaSQ0x83hDxm7wz1LX07+/57jv2yOZVXy32aq/L4br0QtJEjm//Y7YH5NnQ==
X-Received: by 2002:a17:907:7d9f:b0:8b1:781d:f9a4 with SMTP id oz31-20020a1709077d9f00b008b1781df9a4mr44496356ejc.21.1678741221832;
        Mon, 13 Mar 2023 14:00:21 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:21 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 12/21] dt-bindings: pinctrl: mediatek: mt8192: rename to mediatek,mt8192-pinctrl
Date:   Mon, 13 Mar 2023 23:59:12 +0300
Message-Id: <20230313205921.35342-13-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313205921.35342-1-arinc.unal@arinc9.com>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
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

