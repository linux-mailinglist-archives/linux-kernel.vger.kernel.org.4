Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87679681FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjA3Xn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjA3Xn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:43:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90F222DCE;
        Mon, 30 Jan 2023 15:43:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so9411308wms.2;
        Mon, 30 Jan 2023 15:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2jstaPI4y1XJ/gNFdxFKBz/qLiOGjBGxKWHNOfP69M=;
        b=q7mcSsHqEC3fFpT53TEvXIrKOhKgkzxxZh+Qo8k0Fk7rLMLKn/yLvOnnrpeemgpzOs
         9uYBjKTg7rnP2CDT41wNbCny0Io0qQtiXrA26+0f6KItly2Nbm3S9IYUK9PD1XybYDoj
         HW3LBh7oQdfUGacm6GObwevVEhahE2yLWR0DiTTUspWhrTHwn1HGVC8TIZifeYbJrQNL
         hq4nzCsk5tdeIsvIpNeSB97j4IxrR75TbmcbX9YDdZAvv5HxI/QyaugmKLIbwqxn/OUn
         UR03oA6YemUQCaOTLPYHr4/DxOyK3/NujnVTDya7ox2Y2mJsUif/+qcIQKQSE8ku3X5E
         QbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2jstaPI4y1XJ/gNFdxFKBz/qLiOGjBGxKWHNOfP69M=;
        b=7qCLbK0w7Mz9veXBw1Xu+VIaoK97RannR7Qih57IXRQBatVVuRGuDhOhTvspFC92+8
         6W7OhMMF3+9MxgM4y77bEFv32tw833IkIjnGvdhQR1++8IsWOgRTM5pUS3Zxpx8ToAAg
         FNZluRLLIMK8hAiUbZb6a9udH4iBkjHOSmgJ6I7AEvGJFKqo0S2uVFk8ige3FxMX+7Nd
         hddG8UP3+pImQRFCVg75tXeXeRKpWsK012dBqtB/AlxcJjjtgLX93RiKkTI+40Xbw3PJ
         2/jlysscvsCdI8CsYOwe4yqnvKu0EqKcC5ElPIsiSKg6vvI8yp1yDtpuxab7Gc0WyO6Y
         k/qg==
X-Gm-Message-State: AO0yUKX1tWSKI3KUw2YrIJGFDQFAD53K/HMNTOj+/tosMWLDdzA9+D5n
        FTrppaz7N0fqFpN4wGGv4nY=
X-Google-Smtp-Source: AK7set/yUJpbBV1OJgxzUM+TU61hf/xyJLpCwUwNaB5CfnuPavlpqLH+G3VM3L26HW9hwpHQ6hr5mw==
X-Received: by 2002:a05:600c:500d:b0:3dc:eaef:c1bb with SMTP id n13-20020a05600c500d00b003dceaefc1bbmr3074848wmr.35.1675122236131;
        Mon, 30 Jan 2023 15:43:56 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:6048:d643:15b:441a])
        by smtp.gmail.com with ESMTPSA id i27-20020a05600c4b1b00b003dc54d9aeeasm5712903wmp.36.2023.01.30.15.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:43:55 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] dt-bindings: interrupt-controller: arm,gic-v3: Fix typo in description of msi-controller property
Date:   Mon, 30 Jan 2023 23:43:35 +0000
Message-Id: <20230130234335.13952-1-prabhakar.csengg@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Fix typo functionnality -> functionality.

Signed-off-by: Lad Prabhakar <prabhakar.csengg@gmail.com>
---
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 9f7d3e11aacb..8449e14af9f3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -108,7 +108,7 @@ properties:
 
   msi-controller:
     description:
-      Only present if the Message Based Interrupt functionnality is
+      Only present if the Message Based Interrupt functionality is
       being exposed by the HW, and the mbi-ranges property present.
 
   mbi-ranges:
-- 
2.25.1

