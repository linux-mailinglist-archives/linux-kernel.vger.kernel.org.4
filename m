Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F746A8E05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCCAap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCCAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:39 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC559E5C;
        Thu,  2 Mar 2023 16:30:19 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h9so776979ljq.2;
        Thu, 02 Mar 2023 16:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT6hzu0DmgFDhxzzLNhQjlkkdnwsxET9D8SPDLbHKjA=;
        b=FUCkHFzYk6uA1qpDe0K69On13PRuhL+cHZ03RX2YCH+418wxuPSORlL521C5p3W3lR
         T3A2nlspl0f4MC1Blmfs5VUHKEQgJcOAYD/KCiaL/SheRk9HKod3lXkO3KbE3r79o4Ye
         0HWcugVUcIR1x80xH+QW1/YtU8+VAAdc+/zoDnpHdfJzv+BxSvGbpLG/wYvmwFTZ/7ru
         tRKp4b3YuYWrdYgSVzXKVYgu/r2ObnKGwyVUMsHj0ngFBtgiwR6vAapRoiuyiYqw/I9O
         nU5zCt9CDd9YYwfOBkb34MXJAkNr6B4Ndg60T6orug/zJ821MkVmDUZ0MXxIW+ySeHwp
         Gn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT6hzu0DmgFDhxzzLNhQjlkkdnwsxET9D8SPDLbHKjA=;
        b=yxTLhwW3c4vCPqZFri3pxJJz5hS09dWMWJLRI1q92uv0uH2KcUCrtfeL/UDMt7/QoP
         LSmdGN6pSkogbsaleBm1Uy66bone/+zfXBWlzo1aFM9ngIHq9r613KMhCpfXVZ7p0C9t
         83TFUyFrR/lsEMXOvSmnSMcqgBQhstq8yP8jfe8t/ZsOonQhv7vj1X/yWeIy+cRAfqZY
         sorwObDBdW+9QNkITQMu3Tb1GmXhHhnuSMMA/eqAogGUtxMAyERyBnp7T4l3PCqhBqoE
         2i6+PJ7gvFercV50l5cRH/HAQK68XHvPzQsvQ8jUUbgfn7mTfs/Uoydx3sXTKZJxSIhp
         3qQA==
X-Gm-Message-State: AO0yUKVgH8seALs0Ia6MGH5snW3iYmeuA1JjKM9gzy9Gf9O8QsDoYJ+X
        XDTsvhM34G5evUNn5nocCiE=
X-Google-Smtp-Source: AK7set/7b3ronXMGDdX5jtEOBuC1OZlspMiNXDaIFPdv0MAWmDGsS4nx/Dsm3gop63oqDdwkrf++rQ==
X-Received: by 2002:a2e:bc0c:0:b0:292:f882:95ee with SMTP id b12-20020a2ebc0c000000b00292f88295eemr1301300ljf.9.1677803416604;
        Thu, 02 Mar 2023 16:30:16 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:16 -0800 (PST)
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
Subject: [PATCH 10/20] dt-bindings: pinctrl: mediatek: mt6795: rename to mediatek,mt6795-pinctrl
Date:   Fri,  3 Mar 2023 03:28:39 +0300
Message-Id: <20230303002850.51858-11-arinc.unal@arinc9.com>
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

Rename mediatek,pinctrl-mt6795.yaml to mediatek,mt6795-pinctrl.yaml to be
on par with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 ...ediatek,pinctrl-mt6795.yaml => mediatek,mt6795-pinctrl.yaml} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pinctrl/{mediatek,pinctrl-mt6795.yaml => mediatek,mt6795-pinctrl.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
index 9399e0215526..c5131f053b61 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/mediatek,pinctrl-mt6795.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt6795-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT6795 Pin Controller
-- 
2.37.2

