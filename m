Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F035631927
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKUETR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUESt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:18:49 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E0F2A942;
        Sun, 20 Nov 2022 20:18:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669004316; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=aixIFHpi3bHX4fgmZ3jw6KdRI02uqQHXp/1mFoKt6XzDRrFU3cndHsJbUCsF6ZgSstQWSWKq17+bux6kgZIlqZZdyVreWGrQqBuijAr3uiwAO5/kd2jBfDCy9NKFS+Vj/82TH4M/vAA1SBAuhQzoipTxzOFiQjit/q5i0wB6fUU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669004316; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1jvBArX5LMEqGndC/rqeiRHpRcDw256YhccTebGyEL8=; 
        b=DRkD33XgFDBpBkUfgL772kN8xlu2Q1JO4TuKnGVCn9Ct937mzlLI/gXomTplEfTizo7bJr1K/GtqSW54Q+ML9tLDzhXKL/pgFD2FA4SyBFKZOqfvmhZquB52J/YQ2GdI16dqYwVAPTQaa4QpNeGAyGt6e1E22ci34cchhJ31HJg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669004316;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=1jvBArX5LMEqGndC/rqeiRHpRcDw256YhccTebGyEL8=;
        b=WBLe4bVOKOeFkUgh+EGrCsx73wKCpTEBVPhaGux/W8pcJM+arJuhX32P4TKVapzM
        5bjyb3/M3WCPy+l7/Ii4/IYjfliXcHAU6bIrv9R4u40Cqp7fVomldgPNv/SZdElvgBp
        J1fPNdB+DNxtLGOWmNZInsRkwl+4V3Gg83dWjW8E=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 166900431506566.96637222919264; Sun, 20 Nov 2022 20:18:35 -0800 (PST)
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
Subject: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible for OpenC906
Date:   Mon, 21 Nov 2022 12:17:56 +0800
Message-Id: <20221121041757.418645-3-uwu@icenowy.me>
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

Add a compatible for the CLINT shipped as part of OpenC906, which should
just be ordinary C9xx CLINT.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index aada6957216c..86703e995e31 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -35,6 +35,7 @@ properties:
           - const: sifive,clint0
       - items:
           - enum:
+              - thead,openc906-clint
               - allwinner,sun20i-d1-clint
           - const: thead,c900-clint
       - items:
-- 
2.37.1

