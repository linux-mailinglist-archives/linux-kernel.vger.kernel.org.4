Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DD06AAFE0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCENU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCENUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:20:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C4C11655;
        Sun,  5 Mar 2023 05:20:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h11so6323326wrm.5;
        Sun, 05 Mar 2023 05:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEtPGpczGTI7rRRRNUVfOdyAV4EBveumy0ZU46zBcAA=;
        b=LCG/C4hBL/FQpGSn0I651WRXvfwuKsA4JNvOm38weOv/eV+iRBznk5jaSGS4+ziSha
         DjzOeYMphCFeNwAJ8rYkCMZJRo0eYKPsw6HMaJEZmlNaCYR5CURYDFHBQDOW+hEnT/SI
         4TO/geIf2Q5DO5I0zD/fsUAOAb2VClbg5cAD/BCSaejNkde3saHSXAOc/8EQCBCUgTUX
         tvOSmYoXF2UnjaYSn/teNyNc4idokllTzOYIvgmJz/hv31tgGXazs16UM0qk/FLbRBnC
         kbDRDet4CZV5w09fr4r6+/1qqviRcgqecxQhK8lPjwoL+Cbq2cRrD8tAEEorCvidymGz
         N9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEtPGpczGTI7rRRRNUVfOdyAV4EBveumy0ZU46zBcAA=;
        b=IsYGke1REBeInJIQ/3jiA+MBVi6HrP5Dbj1NAU3Z+HMSNEvF00IEW3kB3w2obbLW9b
         tIhLQBkVDZaji83DXWJnE6ztnUcrfqHjGN3WPAu8zFQiVb9LkhWyoBdfR8CBFsACIq0x
         Dza3gCKyQK5CLkwh5Dxrhhs/aFjd/eKTAJjXR/6lqfRmKQRLpn1jJbRzxtzN8/FEB+6x
         FDomY2bUfOk+4PcpKP9YZIG02+8jI+PlckmPgf8FmgDts1mYbfj9bqKllIeA+WgenCdo
         IG4niVy+jnvngZDVIdwFubfsJJqCMF3KZL0HXeYzDGwvDZ+AyBHIxtNAevi3SG9uE7Bq
         EbTw==
X-Gm-Message-State: AO0yUKWGjaufAP6uqkhgio4lwBE7M8ZK0LwlrYK4ciOpeAwom0pIS+ch
        B8NF1TZH5eKcrdxeAqMNONk=
X-Google-Smtp-Source: AK7set8zXTM8eQu7UzmjQT+pTdmZoDItAanNFD57k5xmtBXo2nD57UtvDjve2s/aYMoRBzZNIPefJg==
X-Received: by 2002:adf:e6c9:0:b0:2cb:2775:6e6 with SMTP id y9-20020adfe6c9000000b002cb277506e6mr4747193wrm.45.1678022452170;
        Sun, 05 Mar 2023 05:20:52 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d6087000000b002c567b58e9asm7496851wrt.56.2023.03.05.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 05:20:51 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add support for BananaPi M2S variants
Date:   Sun,  5 Mar 2023 13:20:43 +0000
Message-Id: <20230305132044.1596320-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305132044.1596320-1-christianshewitt@gmail.com>
References: <20230305132044.1596320-1-christianshewitt@gmail.com>
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

BananaPi M2S ships in two variants with Amlogic S922X or A311D chips.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b634d5b04e15..799a4bfff854 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -153,6 +153,7 @@ properties:
       - description: Boards with the Amlogic Meson G12B A311D SoC
         items:
           - enum:
+              - bananapi,bpi-m2s
               - khadas,vim3
               - radxa,zero2
           - const: amlogic,a311d
@@ -164,6 +165,7 @@ properties:
               - azw,gsking-x
               - azw,gtking
               - azw,gtking-pro
+              - bananapi,bpi-m2s
               - hardkernel,odroid-go-ultra
               - hardkernel,odroid-n2
               - hardkernel,odroid-n2l
-- 
2.34.1

