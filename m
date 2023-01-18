Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA32567235A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjARQb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjARQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:31:32 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 08:29:28 PST
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9F59541
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:29:27 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202301181628221e0356c8fdb985b8b3
        for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jan 2023 17:28:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kKCAFwGy2SwmmRR8xa0RRk8D8x4JK6IuQDlTLYzyD/I=;
 b=geJlaDMFR3dkdYgDZB/t/3vHbTsK+ekBYmKQoFxVY6FXa3EzNm3qSbTB1ssubOkquej+Ap
 8QZl1j2x1n6VMG31goMaYjKWkQu/sv3lrJLQpXwdA/S40OOVjVzwTmB9L58n6wY0ygRnqPPx
 kkHzLb6LAcJ0UzF6dNsE6MMGookXE=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH 2/3] dt-bindings: arm: ti: Add binding for Siemens IOT2050 M.2 variant
Date:   Wed, 18 Jan 2023 17:28:19 +0100
Message-Id: <3f825ff8853b1ffd8228d3283c7da0483ddf55d5.1674059300.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1674059300.git.jan.kiszka@siemens.com>
References: <cover.1674059300.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This new variant is derived from the Advanced PG2 board, replacing the
MiniPCI slot with B and E-keyed M.2 slots.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 203faab80142..7af813202f1f 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -43,6 +43,7 @@ properties:
           - enum:
               - siemens,iot2050-advanced
               - siemens,iot2050-advanced-pg2
+              - siemens,iot2050-advanced-m2
               - siemens,iot2050-basic
               - siemens,iot2050-basic-pg2
               - ti,am654-evm
-- 
2.35.3

