Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5F631929
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKUETb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiKUES7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:18:59 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C424BF0;
        Sun, 20 Nov 2022 20:18:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669004323; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fyshxFY9Mc/+iJ1znLlt674Lkas5pFte2C+XYQTgLN7twzB6oiciAGD71SWwdKJYSWu9U14IBwlUNSCSiEQh3l7TUKYWlrhN/nNXMLG+Mt+xd65yPGBlPRn9+5GsKbAfdhrvrwNXnAJ94K6lG3MRI01cKHD6VwrwhSqOmja/7TQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669004323; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=3mufr77oeRQMIDQ9BLCeK57+i5lF/oGGUHybbQbCGv0=; 
        b=SVO8XJ6yGlRfdKEtCycXw6K1MAX46QfAe8vf4WVf0/6apAEPkDzPKJ5PX8fVP714NYbxijEqQVOPq0l30Qzxwoer8d4M7Pgtzw6G+efKQY+mBWvk2JOSpAIImm/Aj24lOAi3NU9ZX3HKzD19kE47UJiQMAEU7npXXrTMwrdUGak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669004323;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=3mufr77oeRQMIDQ9BLCeK57+i5lF/oGGUHybbQbCGv0=;
        b=bgWiYmXimeGexCxx/i1ZdvkWwgnY8ctOaoF23X/GecU0aP0ozpndtbVvorG9XYuG
        jKJc4b90Y4mNnMsDYcjOYJp9RsKWkQ7RgvGnEJz2VHKIExV1WhLnh0DVOieKdrM8oPP
        yYVyQLcerP1Ib9tbj82kd2UHkIJQzgnsqraBpu94=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669004322259164.1933466310711; Sun, 20 Nov 2022 20:18:42 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 3/3] dt-bindings: interrupt-controller: sifive,plic: add OpenC906 compatible
Date:   Mon, 21 Nov 2022 12:17:57 +0800
Message-Id: <20221121041757.418645-4-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221121041757.418645-1-uwu@icenowy.me>
References: <20221121041757.418645-1-uwu@icenowy.me>
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

T-Head OpenC906 is a open-source-licensed fixed-configuration of C906,
which is now public and able to be integrated.

Add a compatible for the PLIC shipped as part of OpenC906, which should
just be ordinary C9xx PLIC.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 99e01f4d0a69..4d14c5f5c611 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -65,6 +65,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - thead,openc906-plic
           - const: thead,c900-plic
       - items:
           - const: sifive,plic-1.0.0
-- 
2.37.1

