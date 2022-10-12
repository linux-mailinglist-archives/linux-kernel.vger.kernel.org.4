Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44C5FC057
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJLF6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJLF6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:58:01 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D555AD98E;
        Tue, 11 Oct 2022 22:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665554254; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jBLuFquyCsXC8VMq41RQBD+bckaKrE5lxZzp+d0lUgjHmcw8fjHFXYK6uYDKjsa0J5hl3JVMKNIZf2Xfv8+i5X9DlWWYEpnE8McQmEpbWZiKV/XdDmBDr7T/fv4EWSC8OCrsaFkm27EVgm4yTrAJRAPUcuhubH3cSGMDQY8avBg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665554254; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QnfEGFwbDyCGWVzFApIAb5B1UcZf3wmW9RZ5N/nCBFY=; 
        b=Ui3pI1X/zT/K1Vf3smlWxCk+en07pfAi/iXSqR3QkhBO3oO+OOkVPjwXT0tkzR/8PzpJfXSW8+ScE68c8XIYZqrK9VLXMRw7DWb6NKzj4JdkP0Sefy3Lu7dfEuthcw61RmmmzQzVwqSPQgmwSoJQ6f350bokK5ngf1tY6Am4Zpk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665554254;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=QnfEGFwbDyCGWVzFApIAb5B1UcZf3wmW9RZ5N/nCBFY=;
        b=IfRvGM8Vea87xLO165GY98vjEjuJEqFv47aimb7PirGuQucFZ/PwMh3/N+OCac1D
        0/hzT3yUW+DLHuQ2UpBUxHY6IEOWn09C2h1jyKc1damD2dp6Pd3eU9u5vITcthKxT+A
        b1rPaHVAewQRdZ0JGTGhn691LJ5PX2qD/ylUPBuk=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 1665554253074837.0327272542744; Tue, 11 Oct 2022 22:57:33 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 09/10] dt-binding: arm: sunxi: add compatible strings for PopStick v1.1
Date:   Wed, 12 Oct 2022 13:56:01 +0800
Message-Id: <20221012055602.1544944-10-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221012055602.1544944-1-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SourceParts PopStick is a F1C200s-based stick-shaped SBC.

Add a compatible string list for its v1.1 version (the first public
one).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
New patch introduced in v2.

 Documentation/devicetree/bindings/arm/sunxi.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 3ad1cd50e3fe..c6e0ad7f461d 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -807,6 +807,13 @@ properties:
           - const: sinlinx,sina33
           - const: allwinner,sun8i-a33
 
+      - description: SourceParts PopStick v1.1
+        items:
+          - const: sourceparts,popstick-v1.1
+          - const: sourceparts,popstick
+          - const: allwinner,suniv-f1c200s
+          - const: allwinner,suniv-f1c100s
+
       - description: SL631 Action Camera with IMX179
         items:
           - const: allwinner,sl631-imx179
-- 
2.37.1

