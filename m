Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF87E6BE2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCQIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCQIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:17:11 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D10D7C38;
        Fri, 17 Mar 2023 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4IuyNtpJI6BF3NLMqSotHmaejiL5zlvW2Pv5rd5IX1U=; b=g++679NI2ha6seLH1jXwKZVfRE
        XH8p1LQmhapAtAmiU+/ttC6kIEoy/n0B6O4GwlkNZtZ5gE51/x8TghiaLTnz71Cv+jtghvWhwnr2v
        /PnZZUChtPOckwgz19Ec8ujAtyDmBWtxCjHCcQgu8Eak3zHFQHcQ7AqVCUCACzqcvFyKwA5qjtccc
        oywHU9MtjyoeUAjWvMDqwl4/VHLoZN63g6gQBju5S0BDZSu0x68Nzybosukl+lTExBAHSB8VfwOHL
        hkLOrXh8zCj9TqjhqvVvWeYvbEfzTbNIFShLAFNmVQ/NivkUl6KdYRU2gu7/fObg4Tue2nd606CxA
        XQCvExFg==;
Received: from p200300ccff1235001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:3500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pd5GC-00073U-0C; Fri, 17 Mar 2023 09:16:24 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pd5GB-00A15S-EJ; Fri, 17 Mar 2023 09:16:23 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, max.krummenacher@toradex.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: add compatible string for Tolino Vision
Date:   Fri, 17 Mar 2023 09:16:17 +0100
Message-Id: <20230317081618.2387407-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230317081618.2387407-1-andreas@kemnade.info>
References: <20230317081618.2387407-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the Tolino Vision eBook reader.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 442ce8f4d675..b78b7fc285e6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -581,6 +581,7 @@ properties:
               - kobo,aura2
               - kobo,tolino-shine2hd
               - kobo,tolino-shine3
+              - kobo,tolino-vision
               - kobo,tolino-vision5
               - revotics,imx6sl-warp      # Revotics WaRP Board
           - const: fsl,imx6sl
-- 
2.30.2

