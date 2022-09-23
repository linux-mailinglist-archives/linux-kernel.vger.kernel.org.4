Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA65E8613
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiIWWui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiIWWuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:50:35 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DA8DCCD1;
        Fri, 23 Sep 2022 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pS74WwurnFXgea5j4m9IeYCBGZWvGqaiJv/a7MKUJMY=; b=xr5wCoH0pl7kGbvh5DTkn3+BAm
        7UJXu2Pk0zMIJpTo4Rx4N68cyDd0KL6GANsHz/oC9z/qcDTs5UuiGV23ePrT1WUw90FmllLtHjEvS
        dIksjRKuFcQui+3+8PyI67cHHvJS+5UsIHBbR2HK4NHBnFqVfc7emdd9KJFoN679twkcroSF4/IoK
        VPcgDwx8JIsCk6YRE+2omEVMWJPkOn1qMoqaOmVKuZ6NYDgekxXtr5OC9h1v27mbJO6BV1Q24ocdc
        Pol/tDiRrp9GynMXfasBpaMcc5tH5D5RATnDnDFtk1HoTyIuobNbXDXNlSF5KVSrKuPvc9e7Mp1kC
        9txuyn9A==;
Received: from p200300ccff0974001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:7400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1obqtD-0004K6-Ef; Sat, 24 Sep 2022 00:11:19 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1obqtC-0070or-Vs; Sat, 24 Sep 2022 00:11:18 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marcel.ziswiler@toradex.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolecrivain@gmail.com,
        m.felsch@pengutronix.de
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: add compatible string for Kobo Aura 2
Date:   Sat, 24 Sep 2022 00:11:11 +0200
Message-Id: <20220923221112.1671392-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220923221112.1671392-1-andreas@kemnade.info>
References: <20220923221112.1671392-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a compatible string for the Kobo Aura 2 eBook reader.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7431579ab0e8..fd2a5732f755 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -520,6 +520,7 @@ properties:
         items:
           - enum:
               - fsl,imx6sl-evk            # i.MX6 SoloLite EVK Board
+              - kobo,aura2
               - kobo,tolino-shine2hd
               - kobo,tolino-shine3
               - kobo,tolino-vision5
-- 
2.30.2

