Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C46F3075
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjEALbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjEALbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 07:31:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50827172A;
        Mon,  1 May 2023 04:31:02 -0700 (PDT)
Received: from koko.localdomain ([213.196.213.13]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MfHIZ-1qTuDu0fvf-00grO3; Mon, 01 May 2023 13:30:53 +0200
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 3/6] dt-bindings: input: cypress,tt21000 - fix interrupt type in dts example
Date:   Mon,  1 May 2023 13:30:07 +0200
Message-Id: <20230501113010.891786-4-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501113010.891786-1-mweigand@mweigand.net>
References: <20230501113010.891786-1-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4skmoJaGKcxINrXaVpa0550kK2r50u4dFgDEnFRnenh8PTS0fl0
 pHOOokYa8UhpVMfVhZbaRDjMH/oSyuzqfiLnnyvs4/xVI8b/qxnEv/Tym3UyY9PI63nKWz7
 LihlEyDqqn5yrU1IPIi+ycppxUV2U13g1JXLsAt0iQrjLuwwHD8+m+WCTVHp/kR1XrBmjT8
 Qc7Bwj3Ei09ECmT45ScFg==
UI-OutboundReport: notjunk:1;M01:P0:BpfJcb7jkiw=;F6cKvf2fjVbXv9lF6nBsQsW1wtt
 P2a+QeD5BIVxesm073QbzQgwnNOWJ6S1b/ijblvaBhFq3tfCUZcp8T+s29FEMAErwV8JMBzdv
 T4amjDFC3MboQboY0CxVE7DFqxp+nGsXRtGPmzkSZWM2A4PxG49mb1LiENZ3gpTj7EVfXCjrr
 FHIyqwvhOrMHobJIRz5uR5uJHDsTvRsCV7sS3b3GlUGDQb2rC8pLIOaMqCD+1e7gBMpBqHkB7
 Q8suPxb7GZuTBddRsDhsQpGmghI9h1CnL6CDyWX15kySLf34MOt/ltcp2E+2ik1UGWGAcMe0f
 iaY2IJS8GVqrVGm9PUfgviNf+SKW32gogD5EnBmwfHr44WE373OlZUhiFYSKptqexHxiiv4yF
 r/4LY8hEYiUUAYHTgGJdhjqumuLx2JbraF7K74vt0UmqrRkWCjWdWNE4kdB9pRUXUQcSVmQVr
 xK7TIqwmmc2MF7TPWYf6sxsAFrCSK+e14ey2muP/nfZ1rkGppVhAbiOimxb6Mkww/2yaKAg3b
 +VJ2o9ao9qsIJwFiosqOrB/MjTGI0tbmuf7FJOdwSSpk/Fq9PfsU325Q+YjMtdnEZsJ/fClLr
 Ekh/3ZJ0Ihq4CAgL7ELDCK95MZo0PrsJDdKQd3yZBQAYuSfjMe2gflMG5zmWtV4+MDZA13L7N
 YhXWv2LVt/CcnX43dx9niQl8nB4KdRXCaD3ZQyah5Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Triggering the interrupt of the IRQ_TYPE_LEVEL_LOW type can lead to
probing issues with the device for the current driver (encountered on
the Pine64 PineNote). Basically the interrupt would be triggered before
certain commands were sent to the device, leading to a race between the
device responding fast enough and the irq handler fetching a data frame
from it. Actually all devices currently using the driver already use a
falling edge trigger.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/input/touchscreen/cypress,tt21000.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
index 1959ec394768..a77203c78d6e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
@@ -83,7 +83,7 @@ examples:
             pinctrl-names = "default";
             pinctrl-0 = <&tp_reset_ds203>;
             interrupt-parent = <&pio>;
-            interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
+            interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>;
             reset-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
             vdd-supply = <&reg_touch>;
 
-- 
2.39.2

