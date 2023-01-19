Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13326731E6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjASGmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:41:59 -0500
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 22:41:55 PST
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0A3656C3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:41:51 -0800 (PST)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230119064043e1a9ba0aa920b92518
        for <linux-kernel@vger.kernel.org>;
        Thu, 19 Jan 2023 07:40:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Uz8plPgBqNBgdN6ehW26Ppifew0Lvajs1xVbwR3IZxo=;
 b=IpTCs0+3SvoLBfda96eiS+sY+ShzKN1wVzniZxHVoRbQ+aW710eUeobIoX678/wcL4ybB4
 sJFkuTTiOb6RZvNp9jKoMUA9fCtYJLAK0w7iA3oVbsdAz9HJScOcAdsVlVMtFWiuneaO1TUP
 Auib/feDIb0rXGv3RCKtvhAVaCdgA=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: arm: ti: Add binding for Siemens IOT2050 M.2 variant
Date:   Thu, 19 Jan 2023 07:40:41 +0100
Message-Id: <e49b4451b6c85ba28bdbbe42b25d9eeecebbe2d7.1674110442.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1674110442.git.jan.kiszka@siemens.com>
References: <cover.1674110442.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This new variant is derived from the Advanced PG2 board, replacing the
MiniPCI slot with B and E-keyed M.2 slots.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 203faab80142..0ed4e973753f 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -42,6 +42,7 @@ properties:
         items:
           - enum:
               - siemens,iot2050-advanced
+              - siemens,iot2050-advanced-m2
               - siemens,iot2050-advanced-pg2
               - siemens,iot2050-basic
               - siemens,iot2050-basic-pg2
-- 
2.35.3

