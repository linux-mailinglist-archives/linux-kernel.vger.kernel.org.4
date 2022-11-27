Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FF63998D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 08:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiK0HcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 02:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiK0HcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 02:32:19 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC8113D6F;
        Sat, 26 Nov 2022 23:32:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669534324; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Qotv6GeqOj0Ab/YYD1KPPJkeY5CFlrbtIL1sg6Jw/J8H9NNcayAATwXciWAPlSVczPUe9fm5Q08utNBzqBWUO16tasQ4nV/jhAjYhih6jgqDWUeYdALgKVME9ps7cwp0Y0XP/HI4eDEWHZccxu4OVZ9zCqWaab4CtJ5uu1BCAaw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669534324; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZIRgyJGgqD7T8i4Lu5EQRdpocsyZYGD68z5C8293zsY=; 
        b=V5Nyn9QD+cCXn97nh568e2CFl8ORNTLKDLHFfjY1OGFLPY+iTJ2XTTCLjO7S3tuceX+3EO+G+9WP0As/1jalhmIVgAbt1Kbq3oenQ+N1NlzMZG93zcYaG6XWNBs5SfDFSfN+WO5VR78zKAIZ8CuJuSueQMTECW7R+Wc4Kw0alFg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669534324;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=ZIRgyJGgqD7T8i4Lu5EQRdpocsyZYGD68z5C8293zsY=;
        b=dKcCOQtS0Y4nUtfWwXO+KIBMFPpoFZ6AUov5VO/vd8za7ieJD+9wq/igenSY/sS/
        CenKFyWSQBAAbxgtZc2YYYVLC4WjTP3wIff5eTKwNHUZWcmfkjvfpwVhQaObzFvQN4y
        CFw/M77wuwmKXXKI+sD0br8UN6uDh0Emk3lOdjnk=
Received: from edelgard.fodlan.icenowy.me (112.94.100.108 [112.94.100.108]) by mx.zohomail.com
        with SMTPS id 1669534322585494.052994322819; Sat, 26 Nov 2022 23:32:02 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/6] dt-bindings: vendor-prefixes: add Genesys Logic
Date:   Sun, 27 Nov 2022 15:31:35 +0800
Message-Id: <20221127073140.2093897-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221127073140.2093897-1-uwu@icenowy.me>
References: <20221127073140.2093897-1-uwu@icenowy.me>
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

Genesys Logic, Inc. is a manufacturer for interface chips, especially
USB hubs.

https://www.genesyslogic.com.tw/

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6e323a380294..43359c0ccaf5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -488,6 +488,8 @@ patternProperties:
     description: GE Fanuc Intelligent Platforms Embedded Systems, Inc.
   "^gemei,.*":
     description: Gemei Digital Technology Co., Ltd.
+  "^genesys,.*":
+    description: Genesys Logic, Inc.
   "^geniatech,.*":
     description: Geniatech, Inc.
   "^giantec,.*":
-- 
2.37.1

