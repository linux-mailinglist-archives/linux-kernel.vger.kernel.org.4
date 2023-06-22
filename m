Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660CA739A42
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjFVIlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFVIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:41:14 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B6F1FE1;
        Thu, 22 Jun 2023 01:40:52 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b47354c658so69201721fa.1;
        Thu, 22 Jun 2023 01:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423250; x=1690015250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPGC/fa96zpj/HytqXk9DRYd8LBRyi1oOZrs0uuR4lg=;
        b=WFF/OFeGDxsFHoYuAcSpj2Hrt7Ie1fKo0IJtHD/wzgohYpmqSPpNa+vrf8NK1Wksed
         iqAfM0cQWwxHjQsJrXL2eotThvKSVH6aysg5DicZx2qG9xbKDiNvR37uiqpJmSXTk4r6
         Rse/bstk63j8DOyHGZhwxsOcf75feVjv81WwEYspe6Sd67tVNyr3vq/uaKMXQPS21gf1
         QEI5Uk0W48CRy19DkvDvG1uuMfmmC7clfoZmIQwHt+EQeiuTopPSscoYs8o+muqIgTkk
         vwp/v+jtP/ZPqglhyEDu//TGPwsVarkbz/qStCG0ckWmj/jVu5zve6DasPXwE7CxHFfT
         Cv2w==
X-Gm-Message-State: AC+VfDy9EIyQZbYlbfG6qtbrVvrAXyulFe103lfriwnSno+cpOja4SjX
        wdZcm2HKecnSpDkpDD4GFNU=
X-Google-Smtp-Source: ACHHUZ4CsQDAtaDUVYpXXH32nzrpu6oIZfHh3G0dqM9Yi5mNLJB+oZefiGZ46baSV19/Gg3e9Ni4sA==
X-Received: by 2002:a2e:9b83:0:b0:2b5:89f0:bcc2 with SMTP id z3-20020a2e9b83000000b002b589f0bcc2mr2296652lji.19.1687423249668;
        Thu, 22 Jun 2023 01:40:49 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f7f87ba116sm15441277wml.19.2023.06.22.01.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:40:49 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Tanure <tanure@linux.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: serial: amlogic,meson-uart: Add compatible string for T7
Date:   Thu, 22 Jun 2023 09:40:44 +0100
Message-ID: <20230622084045.519203-3-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622084045.519203-1-tanure@linux.com>
References: <20230622084045.519203-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
There is no need for an extra compatible line in the driver, but
add T7 compatible line for documentation.

Co-developed-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 01ec45b3b406..4ca4673169aa 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -46,6 +46,12 @@ properties:
           - amlogic,meson8b-uart
           - amlogic,meson-gx-uart
           - amlogic,meson-s4-uart
+      - description: Everything-Else power domain UART controller on G12A compatible SoCs
+        items:
+          - enum:
+              - amlogic,meson-t7-uart
+          - const: amlogic,meson-g12a-uart
+          - const: amlogic,meson-ao-uart
       - description: Everything-Else power domain UART controller on G12A SoCs
         items:
           - const: amlogic,meson-g12a-uart
-- 
2.41.0

