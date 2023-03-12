Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633D16B6B85
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjCLUxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjCLUw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:52:58 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6CF7;
        Sun, 12 Mar 2023 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vlevqCiURsW178TvumjMuvflR7nEe2fWIJW6Lvp0uPM=; b=nzaloXY0q23xB6ECeTuRpLKrcr
        UkKwTSloXjKQuQcDtxfvj11lCzJGBR7CCSDcbvh7MIVjTYvMZY79pIHLF61qwnBUA+ChF9wAKaKnB
        5skwgYj9x10pDn4lld0xqbrV5iWDn7T0RmFHBs8u3PAGSQCeqN2TqWnWtMMoFK1V4xjotjwpFOElp
        XAe/tmFpNombd+b3BSI9v9voEn/VcShxrNqOqGAtSyGxRjGHxsvx3htn+oHwj8tq44/T8s4hKTpDr
        2eNlr3Jemj/6grgD8YG4wnjMuGScA9pZn2mgKtGiXfx5m48jB6gqfv/48xrnxGz5X3Gj4G/n5Hgb5
        N3SbPWEw==;
Received: from p200300ccff059e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff05:9e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pbSgL-0003yw-Uh; Sun, 12 Mar 2023 21:52:42 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pbSgL-009ZWk-ES; Sun, 12 Mar 2023 21:52:41 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, max.krummenacher@toradex.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: add compatible string for Tolino Vision
Date:   Sun, 12 Mar 2023 21:52:35 +0100
Message-Id: <20230312205236.2281466-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230312205236.2281466-1-andreas@kemnade.info>
References: <20230312205236.2281466-1-andreas@kemnade.info>
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

This adds a compatible string for the Tolino Vision eBook reader.

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

