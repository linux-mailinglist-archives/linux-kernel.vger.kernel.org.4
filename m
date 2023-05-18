Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06727084FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjERPeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjERPeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4005B12C;
        Thu, 18 May 2023 08:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7451165032;
        Thu, 18 May 2023 15:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D3FC433A1;
        Thu, 18 May 2023 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684424040;
        bh=8o3w2PNumfMmW1nsxUiJwSK+1Wm7LHqx/wBqf4PFRQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUPCod8nmuFnBbgzwj18nPIcjTiXQu7I1k69OCF5REnqW7VzJIiOiHKg/4CwGx5Gz
         C086refVmixdfnGDGUXEccsOtrGlLURjLOe02aMuDMNmeZdAu999a0k0EeLYb++Ro0
         Fh4BCqA7yo9rbf0O0INt0BRGWTdqM1bZy7yu0cabzvXog4JDImknRCe5jHnzt4lytZ
         KanHpnCUPmbfWFXf2hav/+kZ51HIGuOSRDW9HgKAtLzTHU3kxRBUr0AAOvSqlaKk6G
         wEa2xAdvIdoyYZ3Idna2IhUQVsKogjGrgkGtXx7MWOMVW/7zVvJB75fHeUthntzb4P
         avLs2VGEGiJaQ==
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
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 01/10] dt-bindings: vendor-prefixes: add bouffalolab
Date:   Thu, 18 May 2023 23:22:35 +0800
Message-Id: <20230518152244.2178-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518152244.2178-1-jszhang@kernel.org>
References: <20230518152244.2178-1-jszhang@kernel.org>
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

