Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF26091D4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 10:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJWIxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 04:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 04:53:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADD8691B3;
        Sun, 23 Oct 2022 01:53:46 -0700 (PDT)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31C176602339;
        Sun, 23 Oct 2022 09:53:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666515224;
        bh=aJ+LP5ZHSfQrG2p0HuBnO/v4SrrZrqIly83JQj98tWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIl6XYqwNgGKmWbKY7Sf+eGnekyH/T08sjzJdSPcP/Pb3t+NwCE71DIw0L7mnrmz6
         SP4sggzS82fJ4kLeAB9wN+1tkr7NowRPugBwtE6CcbRnRDZgqalhWvoff2Y2rPotwX
         1bGaY/T+pdrAa+3YwZDmG4elvm1I9u9GqP9hEkO/VTIjwxOwd5YPX0vqPQMOPKubMx
         r9eI8iBvk146tn2mo6BaR7FcXcRvZAPDn50RY/6BlP/RD1ReYJwEMao5cVjpQieICt
         oOBbLpyqKIYTztm9LxN/LObFKgUazupLnRf8qx/KByAGpKUGCt7K2JD/aWZqkMXHYt
         dbFFw000NS6fw==
Date:   Sun, 23 Oct 2022 10:53:41 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com, nas.chung@chipsnmedia.com,
        hverkuil@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        linux-kernel@vger.kernel.org, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, dafna@fastmail.com
Subject: Re: [PATCH v10 6/7] dt-bindings: media: wave5: add yaml devicetree
 bindings
Message-ID: <20221023085341.s23qinjuw4qls3dn@basti-XPS-13-9310>
References: <20221022000506.221933-1-sebastian.fricke@collabora.com>
 <20221022000506.221933-7-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20221022000506.221933-7-sebastian.fricke@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I have noticed that I renamed the file incorrectly, in V11 it will be
called: "cnm,wave5.yml"

Greetings,
Sebastian

On 22.10.2022 02:05, Sebastian Fricke wrote:
>From: Robert Beckett <bob.beckett@collabora.com>
>
>Add bindings for the wave5 chips&media codec driver
>
>Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>---
> .../devicetree/bindings/media/wave5.yml       | 73 +++++++++++++++++++
> 1 file changed, 73 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/media/wave5.yml
>
>diff --git a/Documentation/devicetree/bindings/media/wave5.yml b/Documentation/devicetree/bindings/media/wave5.yml
>new file mode 100644
>index 000000000000..85dc3c744876
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/media/wave5.yml
>@@ -0,0 +1,73 @@
>+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>+%YAML 1.2
>+---
>+$id: http://devicetree.org/schemas/media/wave5.yaml#
>+$schema: http://devicetree.org/meta-schemas/core.yaml#
>+
>+title: Chips&Media Wave 5 Series multi-standard codec IP
>+
>+maintainers:
>+  - Nas Chung <nas.chung@chipsnmedia.com>
>+  - Robert Beckett <bob.beckett@collabora.com>
>+  - Sebastian Fricke <sebastian.fricke@collabora.com>
>+
>+description: |-
>+  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
>+
>+properties:
>+  compatible:
>+    anyOf:
>+      - items:
>+        - enum:
>+            - cnm,cm511-vpu
>+            - cnm,cm517-vpu
>+            - cnm,cm521-vpu
>+            - cnm,cm521c-vpu
>+            - cnm,cm521c-dual-vpu
>+            - cnm,cm521e1-vpu
>+            - cnm,cm537-vpu
>+  reg:
>+    maxItems: 1
>+
>+  clocks:
>+    minItems: 1
>+    maxItems: 4
>+
>+  clock-names:
>+    minItems: 1
>+    maxItems: 4
>+
>+  interrupts:
>+    maxItems: 1
>+
>+  power-domains:
>+    maxItems: 1
>+
>+  resets:
>+    maxItems: 1
>+
>+  sram:
>+    $ref: /schemas/types.yaml#/definitions/phandle
>+    description: phandle pointing to the SRAM device node
>+    maxItems: 1
>+
>+required:
>+  - compatible
>+  - reg
>+  - interrupts
>+  - clocks
>+  - clock-names
>+
>+additionalProperties: false
>+
>+examples:
>+  - |
>+    vpu: video-codec@12345678 {
>+        compatible = "cnm,cm521-vpu";
>+        reg = <0x12345678 0x1000>;
>+        interrupts = <42>;
>+        clocks = <&clks 42>;
>+        clock-names = "vcodec";
>+        sram = <&sram>;
>+    };
>+
>-- 
>2.25.1
>
