Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC895BA4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIPCi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIPCi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:38:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C3696FE1;
        Thu, 15 Sep 2022 19:38:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w20so8075992ply.12;
        Thu, 15 Sep 2022 19:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dYL9wlLd/USNcoZdGQTOq8OEjfqINlLA5t7kFKr1hLU=;
        b=QOs9nlCwzQ4O0onMGYNUHEonyh2ChOvardFTCdDwwZarJZT5Pk3dwm0nItbHKIchel
         cYYMsG59a4UYPrYgbMjERQcbWu+WcwGIMPufaiRK9ImjIIBnXwM7tbXmqu+U+GWYbYrx
         HVkBOYhLZAFLf4o+kMlkBKuDSnvpWuuvtixIWCG3OgPLjpEd6Rz0ZcNVAq65T/95tAph
         sNcvKfTCumFIs+sQrkvmBuSwaN/YIlpRP1wkqWGOasIFzqcCCn46rUvzDqPgoen70m2Y
         wB3wCIgc+4NIVLAzI3x0yPPEh+GrF2Nk3m/hQZbZvzienBNNuqZtMgcS/LDlmqTWLsta
         B4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dYL9wlLd/USNcoZdGQTOq8OEjfqINlLA5t7kFKr1hLU=;
        b=1jNPZujHVf+Az8ExoakfDyhHtx4NUF78wQQuw6NtM1ZFxfbxRqkmtOEdzygxLNE5BB
         6f2nifiszb3FR0lD4ePN8Hj1kiupywcWBNmH2wr88zkJspnYD2ydIWoj6WfPnY6F3pcm
         F6jB50AHtok64Xds+PkCHJFY1p9GLs77usdQybWXHspTo//eiWjRSSzN65ZeXqZNrzn0
         a0/uW/EZVRK3esGJQ8PEM3TlM7KGjjFXC5CL02fzd60R35mkPDJ1aoW2/CnFrYNVO8iI
         KPtoks+oGnY3i/S3NuhfwYJsUbO5J79PTXyOmg+d8jZo7Uv5MG+f/9GbCnp9T5BbMc3a
         ES7Q==
X-Gm-Message-State: ACrzQf162wUSgPxAb7fTMxuP1xrqRo02zMoA0l7jjKWYAyWVhQZSSHIH
        7pTx5rHtncZYVMyFpSbOpik=
X-Google-Smtp-Source: AMsMyM7HH6nMrLQACZzZgcWn63QuPoiW0OKgwq8iD+IzfoinHYdc086atcyZrpUprByl58WLqVHMag==
X-Received: by 2002:a17:902:d54e:b0:178:2da7:1bea with SMTP id z14-20020a170902d54e00b001782da71beamr2539423plf.161.1663295936126;
        Thu, 15 Sep 2022 19:38:56 -0700 (PDT)
Received: from RD-1129-20047.rt.l ([2402:7500:578:40c5:44cb:7b1e:21e9:77e5])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d40900b0016bedcced2fsm13551480ple.35.2022.09.15.19.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Sep 2022 19:38:55 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: mfd: mt6370: fix the indentation in the example
Date:   Fri, 16 Sep 2022 10:38:49 +0800
Message-Id: <1663295929-9024-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix the indentation in the binding example. There're two redudant space
charactors need to be removed.

Acked-by: Rob Herring <robh@kernel.org>
Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
'Acked-by' must be added in v2. But I seen the reply after I sent patch v2.

Sorry to add 'Acked-by' only in v3 change.

Since v3:
- Add 'Acked-by' tag.

Since v2:
- Add Fixes tag in commit message

---
 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
index 410e2d4..250484d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
@@ -119,7 +119,7 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
-        pmic@34 {
+      pmic@34 {
         compatible = "mediatek,mt6370";
         reg = <0x34>;
         wakeup-source;
-- 
2.7.4

