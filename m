Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6156B837C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCMVBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCMVA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:00:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342C6F4BA;
        Mon, 13 Mar 2023 14:00:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cy23so53931782edb.12;
        Mon, 13 Mar 2023 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8438bEydUlrPZrkVMSwHAqPRPD9BxspbjMsnayfq+s=;
        b=SDpynhQ/UCtA9/qj8iY/pJ+sVXXXZFzaUBTIcLYIMsShiMxY7aFSJ0w5L6ieuTwO5I
         Zu4GH8glMJhRm3g3J7mCh1iUIq0Ntp2JmLYnWjWRnjipLwP2CuBpbuMF7GFhcTIila5X
         1kvy5JQlRO/9Wa8p9wuaw+eaZTu6HrFu8vhdDMvCZf3yRx/ASzDHN9Vqa304tiMl35F0
         xwzSxInBvVRwYesYEimPNyxXOotdB/kooSUqZBtpUAPGWcFBpn1mdh6N4L6F6E09NY2U
         Dy6yqqb4DiDMaRfBn5iiBkAMN1/OvhXY32GLWZYFtMJiMfGLz/WscCT1cK/jj3Tuw6Jj
         6aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8438bEydUlrPZrkVMSwHAqPRPD9BxspbjMsnayfq+s=;
        b=yBAKrtHUOvgsHnpTqFTQb4mU9djje5GLtnZmxzQccVjYtN7PqYP8ixGptap+5s2/+P
         ztUcdJy+u1nJlFM9Lkjjd7NJzPZo12WaE/LF+ktvhWLwv4wF6wC3C/FQF5LlMDI/FfLD
         uioA9KTJM+JMgvCAGGU48X7L2u6idUar5T8yqG0RtmonfthJHw0KmBYVgPOv/qnaQa7M
         VDiEOTaDgQRp9X5avPiJjgW2g8yjt+gYH/8XYaM7LtVZxLUqKH8D3p++P8PgNvhZOEyH
         81y5OOsjmCTw3suLzifX7SRnO3ZsfhvKfNrC9nUu1dciigT8+qgobPpZ9wsWFWIH1Uur
         44/w==
X-Gm-Message-State: AO0yUKXQLOFdzsApeUr1OHiYsz6HwjqBGo5adQG5k9GCmwXcDDu2BDE5
        RIXQeCUS0+XJ6LZ1b+rWq+o=
X-Google-Smtp-Source: AK7set/hHrdJdiC0TWwhv5WD+UmIkyFQQvKuFVP4Bt/3CFM0wO22DTqWLgGgT9JNw024LMvYaWbYHg==
X-Received: by 2002:a05:6402:74e:b0:4fd:23c9:11ed with SMTP id p14-20020a056402074e00b004fd23c911edmr2163161edy.17.1678741219353;
        Mon, 13 Mar 2023 14:00:19 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:19 -0700 (PDT)
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
Subject: [PATCH v2 11/21] dt-bindings: pinctrl: mediatek: mt8186: rename to mediatek,mt8186-pinctrl
Date:   Mon, 13 Mar 2023 23:59:11 +0300
Message-Id: <20230313205921.35342-12-arinc.unal@arinc9.com>
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

Rename pinctrl-mt8186.yaml to mediatek,mt8186-pinctrl.yaml to be on par
with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../{pinctrl-mt8186.yaml => mediatek,mt8186-pinctrl.yaml}       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8186.yaml => mediatek,mt8186-pinctrl.yaml} (99%)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
index 26573a793b57..32d64416eb16 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/pinctrl-mt8186.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8186-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT8186 Pin Controller
-- 
2.37.2

