Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E39631925
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKUESs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKUESj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:18:39 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744DD1A3B7;
        Sun, 20 Nov 2022 20:18:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669004306; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dwATXG8k/51p7QFxP3OE4q2a4JGoVJ9MNI59UQkdx0xlU2T9kN9NGsFqH2iB6a33tSv2Hg1dyhS0Bj5AN9+TqCHbJ+I/HfI2JK6arJfDH39qUWv5GsKFzcoWZ33vgEQNeinXHdDIO9zOxerJi6mgZNABPYPyvQL7GAmFBm3trSs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669004306; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=yswQKN/NwiMTTVeDwWejovNA0LCHs9YyUSqdR/PYtho=; 
        b=dJl3LuNi2k+AP04WqKijzFHYPG6yEo3hgNXUWSw4mV03TeBXA4Rhv432Jzcg+sjCFAdMG5BK2c4Sv7z24O4QnEfisC8rOQ9hlIDAtuC4+9MnsuEhhlDd7P95UC+U3bxokRBZhSwzTgWqgSECtbz66d5ismYlRVqiQr+l7fG+OnE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669004306;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=yswQKN/NwiMTTVeDwWejovNA0LCHs9YyUSqdR/PYtho=;
        b=aYn+JLu0d/dP+2Ij+Wou35VkIDBSj1pT2SbuZ/Ez30kO1xbBADT8WtFCUWsT+itU
        KKyGlYVn8+48jqRupqiVQKF6borkKkfmklZsIAUwa8vVzooAb0gNtfPlKOFMdHnw/RL
        lUxipWYWFm7j6dJMXY2VKxkePJHyAi+rZgtpJnqk=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669004306146990.0421850975872; Sun, 20 Nov 2022 20:18:26 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: timer: sifive,clint: add comaptibles for T-Head's C9xx
Date:   Mon, 21 Nov 2022 12:17:55 +0800
Message-Id: <20221121041757.418645-2-uwu@icenowy.me>
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

T-Head C906/C910 CLINT is not compliant to SiFive ones (and even not
compliant to the newcoming ACLINT spec) because of lack of mtime
register.

Add a compatible string formatted like the C9xx-specific PLIC
compatible, and do not allow a SiFive one as fallback because they're
not really compliant.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index bbad24165837..aada6957216c 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -20,6 +20,10 @@ description:
   property of "/cpus" DT node. The "timebase-frequency" DT property is
   described in Documentation/devicetree/bindings/riscv/cpus.yaml
 
+  T-Head C906/C910 CPU cores include an implementation of CLINT too, however
+  their implementation lacks a memory-mapped MTIME register, thus not
+  compatible with SiFive ones.
+
 properties:
   compatible:
     oneOf:
@@ -29,6 +33,10 @@ properties:
               - starfive,jh7100-clint
               - canaan,k210-clint
           - const: sifive,clint0
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-clint
+          - const: thead,c900-clint
       - items:
           - const: sifive,clint0
           - const: riscv,clint0
-- 
2.37.1

