Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED6733203
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbjFPNSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345460AbjFPNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ACD2D76;
        Fri, 16 Jun 2023 06:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 968CD6235A;
        Fri, 16 Jun 2023 13:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FEFC433C9;
        Fri, 16 Jun 2023 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686921524;
        bh=ujXXaGv6G+SCDcJBNR1oC27N7OsXhgxvDcvu0PGLvgU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Q5kKRw8hDSeZUDVBNIokSNwKFeVea4ZWC67u5E1Nph4ljA01y1fRRkNH41gg/Slx5
         iKxKTkE5OmlrK0B6fxCBawWb0UZqD4J9YNaaxkVaN4M4RzG2D3mI7Gh9ueBq+nYBNq
         iQiAtykd3I+qcB03NtseR0tJvu+EwZdiGNjeRsjHoe5s+wSgIp2ledXq42e2bcNtwZ
         wrpQtWvqK/yTVs1OV+xg9CIuB8w0kZ1XgtSdmVaai7A8s14VrB5s1KMaLIV/Jjh9Dw
         ZnFVcUGmUZIElvq29PjrmP/CuDnIwN9ExiBbQYemrDJ7dU0VAfd2ymz0ab1+i3n0PK
         tbI8QTrlXQ2WA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 16 Jun 2023 15:18:39 +0200
Subject: [PATCH 1/3] ARM: dts: lan966x: kontron-d10: fix board reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-feature-d10-dt-cleanups-v1-1-50dd0452b8fe@kernel.org>
References: <20230616-feature-d10-dt-cleanups-v1-0-50dd0452b8fe@kernel.org>
In-Reply-To: <20230616-feature-d10-dt-cleanups-v1-0-50dd0452b8fe@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl node was missing which change the pin mux to GPIO mode. Add
it.

Fixes: 79d83b3a458e ("ARM: dts: lan966x: add basic Kontron KSwitch D10 support")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
index 0097e72e3fb2..f86e2e751403 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -17,6 +17,8 @@ chosen {
 	};
 
 	gpio-restart {
+		pinctrl-0 = <&reset_pins>;
+		pinctrl-names = "default";
 		compatible = "gpio-restart";
 		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
 		priority = <200>;
@@ -59,6 +61,12 @@ miim_c_pins: miim-c-pins {
 		function = "miim_c";
 	};
 
+	reset_pins: reset-pins {
+		/* SYS_RST# */
+		pins = "GPIO_56";
+		function = "gpio";
+	};
+
 	sgpio_a_pins: sgpio-a-pins {
 		/* SCK, D0, D1 */
 		pins = "GPIO_32", "GPIO_33", "GPIO_34";

-- 
2.30.2

