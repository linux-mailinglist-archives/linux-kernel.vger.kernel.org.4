Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD5639B0F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 14:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiK0NfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 08:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiK0NfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 08:35:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF8410066;
        Sun, 27 Nov 2022 05:34:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F17EB80937;
        Sun, 27 Nov 2022 13:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3AAC43147;
        Sun, 27 Nov 2022 13:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669556093;
        bh=/ZCJIapbhAFwGAPm2huWKEnvb+N3AThTq3C/dUcmpLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVjto4Nx62tTNObrQpJsOpuQqme64t/VpTSXAEPbc5ygHlmX4jWYSgiZ+tcOt8NvN
         Tkp8sB4Io4lw56KQg04oSl8oTPAhnbd5BgRRnJF/HMGOH2xPAYhc9KmnWDIP7y9f7f
         ZFczire6Ly+lC3rZQ2dr/dYfLmkMJ1YKWHTul7ZwJY4PNAhZp+5zqi42Ez9dFQGhL4
         TTYEhhqqHMn4K/dHQCftR0Qvv24FiSZlZ/1hXAdJ7N0gjgzWt4WJLB/5hSoNuVBSi5
         UgJZvHXRxjpJvNm+oJGJjWQoZJ32waIkdSHxxcinP1CcNdq5bn/LB0He6qyEy/qrdy
         3Yb0E62nyd3vg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 4/9] dt-bindings: vendor-prefixes: add bouffalolab
Date:   Sun, 27 Nov 2022 21:24:43 +0800
Message-Id: <20221127132448.4034-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221127132448.4034-1-jszhang@kernel.org>
References: <20221127132448.4034-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following commits, we will support bl808 SoC which is from
Bouffalo Lab Technology (Nanjing) Co., Ltd.

Add bouffalolab vendor prefix binding.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6e323a380294..81618f1dc01b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -194,6 +194,8 @@ patternProperties:
     description: BOE Technology Group Co., Ltd.
   "^bosch,.*":
     description: Bosch Sensortec GmbH
+  "^bouffalolab,.*":
+    description: Bouffalo Lab Technology (Nanjing) Co., Ltd.
   "^boundary,.*":
     description: Boundary Devices Inc.
   "^broadmobi,.*":
-- 
2.38.1

