Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF69C708810
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjERS5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjERS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5B2E51;
        Thu, 18 May 2023 11:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9E77651B2;
        Thu, 18 May 2023 18:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F9BC433A0;
        Thu, 18 May 2023 18:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436218;
        bh=KmkRRVkb2zPg16/+5SP/TqktZEzO+CbiEGfvCZls0Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDdT7AyS81YPAnffSgoZvef1gPV9a5EzUleOkNdMKnOCnVW6oLa9L+jqaWFy1y6DM
         UNlmgX+OumKc4rqRDnunVnrjm2OM17/479A7ed75G1/7a1sZ1vFLoXuWSXO+Y+XcEl
         XpJbGdD2AxW6wM37rBW0ZdW59dydpuNwrglrUXdgk4N02oYas/6fKzdrsPoNnJNc5L
         YqNDGzEtWzCPv3b16VqmBOwnOTZkg9jVlBY7bl+v22GWuHTcj1vfmNzOmPG6LDv9wN
         7kOJAfN2ZztrUtISdoGBSD4x8QcMKKkdPxllRGE+tiJGb51EmK3trcDlt/5dHrG8cn
         XI6D2GSmacMsg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 2/9] dt-bindings: timer: Add T-HEAD TH1520 clint
Date:   Fri, 19 May 2023 02:45:34 +0800
Message-Id: <20230518184541.2627-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518184541.2627-1-jszhang@kernel.org>
References: <20230518184541.2627-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the T-HEAD TH1520 clint.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 94bef9424df1..388d3385d7eb 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -37,6 +37,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
+              - thead,th1520-clint
           - const: thead,c900-clint
       - items:
           - const: sifive,clint0
-- 
2.40.0

