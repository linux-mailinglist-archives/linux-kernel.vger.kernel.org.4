Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A275FC044
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJLF5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJLF5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:57:18 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96637ABD4F;
        Tue, 11 Oct 2022 22:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665554212; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bGr+KPscsRAzIXQ1nTBT9pWxnIPPZWPDnNMt3ryxBXhfVAbq8XoSvhaGX/dkQHWK7g/m7bzitQPk5+dwpzWUwh5/t4P3Sjv76XGvXXTrdRV+xwR9NAHi9DvIyJ20SCvukyjl2AA1G3Fwuwj8foL1jDP//SQMDqV3rGiL90EptuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665554212; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BLIMUTj+mMReZpkBK2+4owJIZrq7A2Y+0iF7wCkupeg=; 
        b=Y+Jfc2y0OZmubMM/enfLWFaRkqwL2+btl31J4bT5WkqPnYGECWshm8drSMp1XmIfUJr6aWrNnSBVbTsKPvi+olsXvLYmgGhgqMhW7CJssph3PbT+e8VVOJcZNn0yGnV2p3PrTjBdshX/wYX9aKgYq3Ix1Pvv8toccZfoqvKDwn4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665554212;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=BLIMUTj+mMReZpkBK2+4owJIZrq7A2Y+0iF7wCkupeg=;
        b=NKCMpmnYtG9OA2as2d9S3Col20Zzon76Sao3P/424D9sILGyF2zYnDqaTwAoZrK4
        AJw/orDF2BzjWWMGuBM/uz7p9DDNbww8tiRkJVKh7r62jeoLiiGGoAdz+z/+ZOEPIFF
        wCS3dNMaLTG+nUX/nzwEsPI7Iw3bLsxQMRy5IuWM=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 1665554211125647.5240842007678; Tue, 11 Oct 2022 22:56:51 -0700 (PDT)
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
Subject: [PATCH v2 03/10] dt-bindings: usb: sunxi-musb: add F1C100s MUSB compatible string
Date:   Wed, 12 Oct 2022 13:55:55 +0800
Message-Id: <20221012055602.1544944-4-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221012055602.1544944-1-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner F1C100s has a hybrid MUSB controller between the A10 one and
the A33 one.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes since v1.

 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
index 8992eff6ce38..9ae634280bf4 100644
--- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
@@ -17,6 +17,7 @@ properties:
       - const: allwinner,sun6i-a31-musb
       - const: allwinner,sun8i-a33-musb
       - const: allwinner,sun8i-h3-musb
+      - const: allwinner,suniv-f1c100s-musb
       - items:
           - enum:
               - allwinner,sun8i-a83t-musb
-- 
2.37.1

