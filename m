Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07DA6985AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBOUhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBOUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:37:36 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CF3B3E2;
        Wed, 15 Feb 2023 12:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H4m3RP9AkGa0lGoncGnuU5TSiDprpEx7CfW0CHNe6C4=; b=Xv/LX8xdfRA3IJXZUbMbjDLKxe
        xm7Pccqt4fjdnkBet05mvUTdubkfrMNdU7Pc/yemm12fkAV6oaKDC0Oe5Bbv1GaieZEEq5mQNh5kq
        piDNJuUhOr3DkHj2fiHoL3Sf8fbeGU9R8dnXnuCVI00JMPJFjZ3gV/CXgS91M3Eydsw7yK/C2Mzl4
        k+AY4TDj0rfniyHhswQhBhleKbrUBoZe8lo9/uWmT12QV+26pRQFNrmP6BPNp/aoa8WymGsB39hDD
        THFm5TpCo6c23+3vgVoP851fe1UA/UxtNZG/FkP7jDNjhBmQrRuxnus6bSg2pMF9nPIDZ2ivSueGq
        2sgA5x0g==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1pSOWi-002j5f-MJ; Wed, 15 Feb 2023 20:37:16 +0000
From:   Bastian Germann <bage@debian.org>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Bastian Germann <bage@debian.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 1/5] dt-bindings: hwlock: sun6i: Add missing #hwlock-cells
Date:   Wed, 15 Feb 2023 21:37:06 +0100
Message-Id: <20230215203711.6293-2-bage@debian.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215203711.6293-1-bage@debian.org>
References: <20230215203711.6293-1-bage@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allwinner,sun6i-a31-hwspinlock.yaml binding needs #hwlock-cells
which is required by the hwlock type.

Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
Signed-off-by: Bastian Germann <bage@debian.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230213231931.6546-2-bage@debian.org
---
 .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
index 10e5a53e447b..01b1bbb3061f 100644
--- a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
@@ -26,11 +26,15 @@ properties:
   resets:
     maxItems: 1
 
+  '#hwlock-cells':
+    const: 1
+
 required:
   - compatible
   - reg
   - clocks
   - resets
+  - "#hwlock-cells"
 
 additionalProperties: false
 
-- 
2.39.1

