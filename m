Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01326B839E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCMVCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjCMVBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:01:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488401A64C;
        Mon, 13 Mar 2023 14:00:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so10270353ede.8;
        Mon, 13 Mar 2023 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT2oLy5xFYDKklrDL9H1QV3B6NDWG41BsEllERkvJLQ=;
        b=b4L/dI6UxOp+1xOw7wipdCZycTsIXOTyl5TihDRA83a/wKmp9RKXdDkiE1PudpDk7i
         Ljud0fu2w/Qj78cXewlHVf+Sj4KOi0lhqHEftssS2wgKgW+aBuj3F90K8VF0inLC2AFc
         Bu2aWFIeBJqdyhY2Ep1j4AX/i/ZWBJvy6WlPCB88YeDp4LjCrdQAtU/X7jMZphCqYnAN
         1xWrW8dYdR9aZt8mgNEk5X7c31C8qfghmu/x0mwteYUQICLsG2LkYDgS+eJ9hD9/h31z
         Hquk2vM/YuS2QsC6ztC7UKXabU+j+cPUlHZXxRHpfaAlOrGO+1qV1kV3M+DqUoXH8jCs
         ZjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FT2oLy5xFYDKklrDL9H1QV3B6NDWG41BsEllERkvJLQ=;
        b=hJyiLrcTKu507nD6aOdCxphRWg9sBiXErY27uQK3D0Zy+tJU3An9FqMdVmYpRLewjq
         5Yw5UDvv/6v01DiNerWf0ihwAJUFK0hWIBoCDsyBCakyIn9dt/f/WyfpQFUcV8CqHgRn
         sLfRZf8/f1PhZtqAfVW6iRT45iP2/T9DgIN80k1GbWwRrNYvWIznY2M+78BDUC3O27Tt
         ofSEi6q+MMHzPyxJ/9AFLnkk9m7qLRYvI34tSXhU73iNP9AnhtEKAoBc9wrb55smOOi7
         qm040wqj1hX9owyToCCe2zhrJyUDnJjaJxxl7aekOJxPLZKYmxNOZPjKQjXnV/W3HcHQ
         PsBw==
X-Gm-Message-State: AO0yUKXz1PydS0w0v7Z5MCdz59pNzPXsSqxQdMZhf+k98iv/jJtcA6xI
        yPg5NsSc4wI42Ia+mcnGUTo=
X-Google-Smtp-Source: AK7set/Bk179OhlZ6F2sRo2tcyDbF2gPTQblGFOVfe7U4X5Cp4w3TtAL2B8dAeJbMQhD9VTjihbOMw==
X-Received: by 2002:a17:907:6da3:b0:878:50f7:a35a with SMTP id sb35-20020a1709076da300b0087850f7a35amr44708274ejc.72.1678741237136;
        Mon, 13 Mar 2023 14:00:37 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:36 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
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
Subject: [PATCH v2 18/21] dt-bindings: pinctrl: mediatek: mt7986: fix patternProperties regex
Date:   Mon, 13 Mar 2023 23:59:18 +0300
Message-Id: <20230313205921.35342-19-arinc.unal@arinc9.com>
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

Set second level patternProperties to '^.*mux.*$' and '^.*conf.*$' on
mediatek,mt7986-pinctrl.yaml to be on par with other schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 31c36689438c..0f615ada290a 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -72,7 +72,7 @@ patternProperties:
     additionalProperties: false
 
     patternProperties:
-      '.*mux.*':
+      '^.*mux.*$':
         type: object
         additionalProperties: false
         description: |
@@ -256,7 +256,7 @@ patternProperties:
                   items:
                     enum: [wf_2g, wf_5g, wf_dbdc]
                   maxItems: 3
-      '.*conf.*':
+      '^.*conf.*$':
         type: object
         additionalProperties: false
         description:
-- 
2.37.2

