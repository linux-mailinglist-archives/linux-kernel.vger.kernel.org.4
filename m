Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF68E62B1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKPDq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPDq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:46:27 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7129712AB8;
        Tue, 15 Nov 2022 19:46:26 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CA9B85C018C;
        Tue, 15 Nov 2022 22:46:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 15 Nov 2022 22:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1668570383; x=1668656783; bh=98Wqu6kwTkpQx0diKFaT1wM6I
        4WeLKlWxy3HOKKiaiw=; b=f2dnLkFhJVUrqrjGX0/qdstmEFGgn+VxQmigbZZPB
        FnayAaZGHGOaoBv0ZxdmsdA92zKkBOreIe8TiuK2FK7J54QwcfbAPu/BBWmOukSi
        am6T93Vwl7m/EU3NwezMVyDyeO28vd0kSP1E5sXAAUPMnTmfJRQ+ZAOPbZY0eDWo
        uW6pbAeXdhmJYFMcoXH30Q47AR3eeMkCKcMNxwEPVCS/1tDETXHQyGCY+JXA/+Pt
        UumYQA4d6NEchsbfd7xmVlDadh/N9vV75IPbi5UsH8iIqBw/Rb3OuEjuPwDqHV3P
        spros1h6uO6TFd6AmRkuiojXaTJ696ywRZAFx3DFoiM7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668570383; x=1668656783; bh=98Wqu6kwTkpQx0diKFaT1wM6I4WeLKlWxy3
        HOKKiaiw=; b=kC8zSkhNKfuHZORd/Hu+Qa/racxzvBAmNX+Oz9VyIT0CoJUExfR
        cwOHzGgz/0OZgJQRjzRBJiM1D46IQ+n6eeD8nxOt8Xv0IeQQR02Vga1/WDCsNEs5
        v3l3hpyh3D5rxwZ6h16SJJs7vKE07iXVgw0G/1cVekRQLqzoYyLnI/qmtkLnWjzx
        wPb0y/XNs4A6ILifWLiZY7jK3pjQzM/QavGOj5zkfmB/r33Q1NYzQPxzTfU5dHaY
        uTHkeIdiHzorKhXTJbCGdwVS7C8aeuEvevwlIhJoV52A7r9NtjCcdiowPEVKvLOp
        hFOKbcC8BBwIyckGqlQFckZ5h4t9WLqLHhA==
X-ME-Sender: <xms:D110Yzp5saybWSvKd9XP3Ui_OCEOEZuEhtp6qYbDVIJ6te_XNC0piQ>
    <xme:D110Y9rV6E9Uhl-57QnRq2ALFkXWIZ_3Cl8aojjPTwht-NI2GpzMPRQD2-zeX5La2
    7TmJ69felIhi10-Hw>
X-ME-Received: <xmr:D110YwNCnV7hUClUYsSCSF2HDy-IZ8aOq1DqaqxHL1gaxhJyGfy27vajiysW0_A7J0MytOhoUkk4CpWxR73IN2Qd_sndY3swFxZ0R3wBTFoe1gLqnwODYtl4QVeImx7-oZWjPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeehgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:D110Y24560usaTLVIht-_dnsK5ZG8aLHjMX01d8JwBK8AE4eV4-fig>
    <xmx:D110Yy4MbDqv2BpA1rkX80wWEBtYkmOwEYYzVGhZz55Wj9q-iIeD_A>
    <xmx:D110Y-gfQZKz3-TJaMNZeSXJ4YijeyefH-K7u7Oep7MqGSp7SDfgCw>
    <xmx:D110Y6j8flhLVh8U5IinzOVINi9l5vaeA32U7GAjamV5-zhAHssuTg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 22:46:22 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Ban Tao <fengzheng923@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] ASoC: dt-bindings: sun50i-dmic: Add D1 compatible string
Date:   Tue, 15 Nov 2022 21:46:21 -0600
Message-Id: <20221116034621.37762-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner D1 SoC has a DMIC codec like the one in the H6. It appears
to be register-compatible with the H6 variant, and the existing Linux
driver has been tested on a D1-based board, the Lichee RV 86 Panel.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/sound/allwinner,sun50i-h6-dmic.yaml           | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
index 2f12cabe4c71..0920f2f81a1c 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
@@ -11,7 +11,12 @@ maintainers:
 
 properties:
   compatible:
-    const: allwinner,sun50i-h6-dmic
+    oneOf:
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-dmic
+          - const: allwinner,sun50i-h6-dmic
+      - const: allwinner,sun50i-h6-dmic
 
   "#sound-dai-cells":
     const: 0
-- 
2.37.3

