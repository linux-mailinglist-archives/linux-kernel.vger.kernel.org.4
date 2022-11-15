Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38480629023
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiKOCyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiKOCye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:54:34 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BBD140B4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f27so32968006eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmhZo5VNLi5fyIfm0Ikx5I/XDPVkL1i6Xe0lCAE5Xe4=;
        b=lt1TeCblLWzyNRJWdCRnEDaMwgzWRq6ybvbwqFkB3mXXLuqk/kJ2j75Du6ojxhrGMy
         I9ERoqqLtoPzBzmrv8PTYKz/eqJkRxbezyNn57euaFpPpI+gxrU842m+dNHsHdTKwmuh
         wpfecPaE9/cE/0M2kedPIGnyg121YaLiipBtXDag0Iabo9n3pje2ce9PpYqaqohkK/1d
         nL4+4wMGlziEHc5GKkLNXQZGdIr/Z+KQByzdvBmiJFmHKigfYK82PZlSIOc78hJ82yZ0
         mJIvP/N4tmelIgqNt55sJij+Uh7ecdp07lHkL7oQjeeiU4xZ3A2ZHwN40sh8bxOFVtbC
         hgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmhZo5VNLi5fyIfm0Ikx5I/XDPVkL1i6Xe0lCAE5Xe4=;
        b=tmyBisKDl1onJBFSW6eGOvJb0HG/ojsjA5z41OAIDE3fDzS1FU27aDwsO48BLbSWCZ
         jkT3zwWoPsLL1PXDHCwQWZ7WSz6Mr4gC0tryEM+gJszVhSHnn55N3hr5tNxWpBRMQTrP
         tx2i6i+zGb/NWT4OAI3kd5wrd7MoPomvYaPRFHFMMTdw8rupV/oGRmaBAlyqBN/HfDbW
         iiM2dp8Ezj7M4t2C+iGp3M7s0vhtwBkigr1O/LI0VjsOqTUaeLj6Jk70FiMDlVsnmvuc
         jmtE/3RASDhqAUXXfLM/hs/JO6aoVkf1oEqwoFlud3l6vaGnfHZJV1GCK3k6OBF7wo8Y
         hFZg==
X-Gm-Message-State: ANoB5pkfxTgSOBY6UyWAMZeefiFdGeSZcwRpko+3dllH4OEvfmnKA4uw
        RhroraKhQNKeWSdnm5OIFUqvQQ==
X-Google-Smtp-Source: AA0mqf70M/ZlAtqMou5vdxsPpWOfSmgxc00ZXs/FLJ/+v6DQNDrithpPXRrKSjRJB+w29dS32pj+nQ==
X-Received: by 2002:a17:906:4f98:b0:79f:cd7c:e861 with SMTP id o24-20020a1709064f9800b0079fcd7ce861mr11911192eju.339.1668480873211;
        Mon, 14 Nov 2022 18:54:33 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d9a0d0cbcsm4861177ejf.72.2022.11.14.18.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:54:32 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Subject: [PATCH v2 05/15] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
Date:   Tue, 15 Nov 2022 03:54:11 +0100
Message-Id: <20221115025421.59847-6-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115025421.59847-1-bero@baylibre.com>
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
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

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index 80750b0f458a8..25934871a4d85 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -27,6 +27,7 @@ properties:
           - mediatek,mt8188-mtu3
           - mediatek,mt8192-mtu3
           - mediatek,mt8195-mtu3
+          - mediatek,mt8365-mtu3
       - const: mediatek,mtu3
 
   reg:
-- 
2.38.1

