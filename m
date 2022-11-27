Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC13639996
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 08:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiK0Hc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 02:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiK0Hcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 02:32:47 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4455111C33;
        Sat, 26 Nov 2022 23:32:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669534350; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VWPX9rTrJaOJnNVu5xmGxa0PFtsJjSFfYa4HkfNURw6sYHzLP3EphT+pmz3Fp73iI4CuuFPDn/MS5hK2yIyib3fNtqX3yBgWgVRB+Wc/ycgtwMWZ7HiDu6zu2bHS2QStxGsfZThtvDg1TrfVAeIl2RWF0HK0fY3spnbPK2LEVsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669534350; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xi4djBRWGKO32BgCJFsyU3GWSFCZRI2GQNuB7KuOeCs=; 
        b=Q7REXLwUUz/rzl4tQsYhjID20+Kv2CO6FcsWgopctds0mzGg/iXVY3adQ6/WL1iXatf1kbEpu1saGuEur6zp7sOfbIP3PkOccSFdIHfUNe+Mitz/gDG6W352FjOF5hu03CnyLoPHHdIUYTIAoaNpth2Y3YHB4Wf6fqIV09rg3mU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669534350;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=xi4djBRWGKO32BgCJFsyU3GWSFCZRI2GQNuB7KuOeCs=;
        b=L1sU0Zoip8rUNv6rmQ8YFovJvIB7NCfx2kdrv/PuIjcCBGUFQ6CKBHjhmO7jhzjv
        yVkQGPzDn+XwcP8ZKdSYRsuwJhBpuMUSeRytcH9O3u32HkGgygGXBxcdNY2uTPtgG+/
        TFH22BN4VUi0xCB1p+N41vSDXSNxN3E2bJgeYpEM=
Received: from edelgard.fodlan.icenowy.me (112.94.100.108 [112.94.100.108]) by mx.zohomail.com
        with SMTPS id 166953434883810.636624385828554; Sat, 26 Nov 2022 23:32:28 -0800 (PST)
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
Subject: [PATCH 4/6] vendor-prefixes: Add Shenzhen Rongpin Electronics Co., Ltd
Date:   Sun, 27 Nov 2022 15:31:38 +0800
Message-Id: <20221127073140.2093897-5-uwu@icenowy.me>
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

Add the vendor prefix for Shenzhen Rongpin Electronics Co., Ltd, which
specializes in ARM SoMs and EVBs.

Website: http://www.rpdzkj.com/

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 43359c0ccaf5..952ddeed4b4a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1091,6 +1091,8 @@ patternProperties:
     description: ROHM Semiconductor Co., Ltd
   "^ronbo,.*":
     description: Ronbo Electronics
+  "^rongpin,.*":
+    description: Shenzhen Rongpin Electronics Co., Ltd
   "^roofull,.*":
     description: Shenzhen Roofull Technology Co, Ltd
   "^roseapplepi,.*":
-- 
2.37.1

