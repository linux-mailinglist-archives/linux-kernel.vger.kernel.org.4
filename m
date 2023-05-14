Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE6701E7B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjENRIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjENRIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876E3C07;
        Sun, 14 May 2023 10:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5BC5618B0;
        Sun, 14 May 2023 17:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B860BC4339B;
        Sun, 14 May 2023 17:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084086;
        bh=8o3w2PNumfMmW1nsxUiJwSK+1Wm7LHqx/wBqf4PFRQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5ZZbKnsIlXkTLOeI1QacOmEvmEyixkY9kbZWpuTdNWmf4NoMEGTv2jeC1Ps1LjuZ
         IGdUqraKi0wMpt2OxQI5ohFHgmsRgXqyiJA13e/uwut8x2xMHeFUOobW9+/o5DHP2q
         ykJLa8RhFZjDFQsXf/7INdH1OsFOGfXnapeBowxXdTEUvQBwRcyIMtMOmgH1IfMyW4
         wtVEgtYnOBvuxQyvQpgJgqaeeneMKq1U89uNtE0wa3M1M8t/kc3pS2if+R1HuYb6NP
         yFdTL6QcBBMAwsSc0PLPyXyAR8xWoeuNPE1FmunEAgZ96Q3kvsuPflFpF9Ti5VDFpT
         ZehySqUGPS9+g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 01/10] dt-bindings: vendor-prefixes: add bouffalolab
Date:   Mon, 15 May 2023 00:56:42 +0800
Message-Id: <20230514165651.2199-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514165651.2199-1-jszhang@kernel.org>
References: <20230514165651.2199-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following commits, we will support bl808 SoC which is from
Bouffalo Lab Technology (Nanjing) Co., Ltd.

Add bouffalolab vendor prefix binding.

Link: https://en.bouffalolab.com/
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..3566346f2f9e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -200,6 +200,8 @@ patternProperties:
     description: BOE Technology Group Co., Ltd.
   "^bosch,.*":
     description: Bosch Sensortec GmbH
+  "^bouffalolab,.*":
+    description: Bouffalo Lab Technology (Nanjing) Co., Ltd.
   "^boundary,.*":
     description: Boundary Devices Inc.
   "^brcm,.*":
-- 
2.40.0

