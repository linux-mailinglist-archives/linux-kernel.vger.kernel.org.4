Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D446401FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiLBIU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiLBISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:18:44 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB860B73;
        Fri,  2 Dec 2022 00:18:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669969079; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BpIk+3PS27+rqhe8xeqTHXMatArygXvfrPQTgopGYzpHh+dYQZsHfa9Kp4MRxcn7ZzR6EdMBxmQETUjJ+y2JLaBuQ4MquPX78nRlD6foQFOcf9YwUsBJVr5OGff4z9ebnqHrsAa9Nrf1KKV9sjuZBt7sbFpmTxraZeuWBCT309M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669969079; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qIOjPPxRBJHg1FZr7N6ohN9vGSHFYL2Yc+prewJ9KUc=; 
        b=UHHHvvok6hp8Bd3U7t9giB/DIU9Wtl6FYOHmS5yf4RKE81wCHNHDt5yT3DD17JlmizfD7XTQGQwtH5lrBloQSArSnAYYedgYg2RWIWVips0plqGJVJRLiC4Puq46pcLJeKqwK7SkbHDjHIUtqnbGhVNuCQG/JJdF9nfOPTa/ki8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669969079;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=qIOjPPxRBJHg1FZr7N6ohN9vGSHFYL2Yc+prewJ9KUc=;
        b=SpCP7ass54C0rAG0PB/Tj7sXwUPXjXQdh8t++Y5g+H4UeeCBe0NYbXhSOh0lEKSV
        ScoFPYQDtOxUZpkYVKWx3GOYgE3V8oDM2gy5YqigYxbmbb8ubDy4unUpG8ZSRGGGMWr
        yzWCQYUfkLX/ruOus0CcJx8ajt1aAPfwwpuDPrns=
Received: from edelgard.fodlan.icenowy.me (120.85.99.229 [120.85.99.229]) by mx.zohomail.com
        with SMTPS id 1669969077180575.6488779211163; Fri, 2 Dec 2022 00:17:57 -0800 (PST)
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
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/6] vendor-prefixes: Add Shenzhen Rongpin Electronics Co., Ltd
Date:   Fri,  2 Dec 2022 16:16:45 +0800
Message-Id: <20221202081647.3183870-5-uwu@icenowy.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202081647.3183870-1-uwu@icenowy.me>
References: <20221202081647.3183870-1-uwu@icenowy.me>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
- Add Krzysztof's ACK.

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
2.38.1

