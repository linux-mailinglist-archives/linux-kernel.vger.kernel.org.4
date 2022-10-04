Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84F55F3FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJDJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJDJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:28:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981D2BCA2;
        Tue,  4 Oct 2022 02:27:29 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvGsLzgnox4NNZrKIVbg0tFyzGC6ScasnE762wUF8gE=;
        b=owzb5NkuDP3DohVDw7vw7CjmggxVzMG8xDMzW9Jh1d81gW8Elq18qoCt1FXYZfjX8he0ib
        I/5C0TnqJkqO/bN6GvsxV3GReNY1ht+SczRdHsu1edX9f/jgxNhTsX0B7urxhDf81RdcJQ
        lUZD+b7UGlGOMH5fPGmE7fuw56LZoyAUMkhNqU34RbFIHHxF2L9Zxu76CDfC9Vkq4I3pCC
        F099NFuIxfJ2cQ6HKfXB1YYqIv2AOVoXDOncrb7nKOeqUHdx+NLaW2FXXgJA/aeOYcPLN6
        c5sMe3Y5RZywNZjD6g4QcH79KXP2qfzlOBUUQDpkItO8nOlIfQnli21pOhy4qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvGsLzgnox4NNZrKIVbg0tFyzGC6ScasnE762wUF8gE=;
        b=RtiOPkFWcLgHe3mTL17NG+7gofZ0uqkNOCOFlbgL1aP+Q07/5LWW/M6WuVqk7A3GyZWjQ+
        ZUho4SWtW9PAtNBw==
From:   "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,tmu: Add r8a779f0 support
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220726205858.1199-1-wsa+renesas@sang-engineering.com>
References: <20220726205858.1199-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <166487564694.401.8343516016334229764.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fa7fc5243f9e7d64ea7e73c247218f22499c3479
Gitweb:        https://git.kernel.org/tip/fa7fc5243f9e7d64ea7e73c247218f22499c3479
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Tue, 26 Jul 2022 22:58:57 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 19 Aug 2022 11:07:54 +02:00

dt-bindings: timer: renesas,tmu: Add r8a779f0 support

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220726205858.1199-1-wsa+renesas@sang-engineering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
index c571691..60f4c05 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -37,6 +37,7 @@ properties:
           - renesas,tmu-r8a77990 # R-Car E3
           - renesas,tmu-r8a77995 # R-Car D3
           - renesas,tmu-r8a779a0 # R-Car V3U
+          - renesas,tmu-r8a779f0 # R-Car S4-8
       - const: renesas,tmu
 
   reg:
