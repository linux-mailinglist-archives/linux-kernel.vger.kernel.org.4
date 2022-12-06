Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE27643CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiLFFyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiLFFx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:53:58 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873FB26AE9;
        Mon,  5 Dec 2022 21:53:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670306012; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=LWx241g1yaXXo7OSmi3pYAeuW0hkDLdcAxCpH0VLVKhDkStuog1CUccVUDNjbvloI3OsZUIgQ6oMMNOD+Ya7UZ+C6+hvzn6nicaLx1ao78Dm4ap1PKhd8vCoefuLFz2Tn6zxn9Cf676+ZxJxjIdPChai++Pv2uFnV5D11OSa12I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670306012; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=n9EsSsfTAb5w74KGhohbVO5OnW1OjaivOEPhHgU7AxQ=; 
        b=YFiG8ec/49RlIQYtyoOGHcniicxqqv0yOfKLmLG1GgZLPEijN0fKSOR7uR95ngk+28+g/wfxIWoPxIrEFJw9fbbwatlb/Tl4Yhlj6mUy0OX732SXBOnt15a1nvw2yfRyGTWxWsCouq8k3hqT1ukLt5SiGvD9D8ywJlnCSByIxzk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670306012;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=n9EsSsfTAb5w74KGhohbVO5OnW1OjaivOEPhHgU7AxQ=;
        b=DS+payvwpcoReSf2npVEVaqkxQrPO44CJ6379eAXj71V6DpXmdxmgiJMgF7pXpdp
        ubwdyIht6JEUBKtIfFmtu4og8jK7d90MIxK/ArPogO8MGDbCXaJAG0L4KQf/hniPR0r
        D1JeII/iM8enL0cLigmA0r2Nac7fIy29ptJfTh5I=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670306010110854.4400070958802; Mon, 5 Dec 2022 21:53:30 -0800 (PST)
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
Subject: [PATCH v3 4/6] vendor-prefixes: Add Shenzhen Rongpin Electronics Co., Ltd
Date:   Tue,  6 Dec 2022 13:52:26 +0800
Message-Id: <20221206055228.306074-5-uwu@icenowy.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206055228.306074-1-uwu@icenowy.me>
References: <20221206055228.306074-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
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
No changes in v3.
Changes in v2:
- Add Krzysztof's ACK.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 00493b962bd7..e9c31bc8f069 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1107,6 +1107,8 @@ patternProperties:
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

