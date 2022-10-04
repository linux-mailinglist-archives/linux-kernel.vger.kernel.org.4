Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9275F3FBE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiJDJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJDJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975F20F;
        Tue,  4 Oct 2022 02:27:10 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TyCQXvt06LyiwK7IosnA4d22ZMlnNW3vraRLQ3xqSA=;
        b=omkCUtTaudp12CHRXGZinqto1oFvw2DndsTbrCwJc8D3iaF/ophlcoifcivWHT8LuLT9UJ
        uS73O8oPhPbD4SDf5oCOkEXPLSRE/6RTSaqHx1HOzSvqbroxEBSQ2Z4ie05DZWpsSJqHTk
        i0KzIpjoCuHoyvqgV3lasauwwtfXHZqTJGU0P/w2rF9mJUHcWgQJSv5m9DkAWcHs39hB7R
        Ic2OoVCT1MjqYfQpHwY45tXkiwgKqowtqqFi/+M1QyRx0DJBLWafkD9bZu7qG5xQTgZ+m9
        ZvpPI9oMOTXWYqvQd+ymq9M8evVJX3QyyMg1ymvwWgdUXhFYZ58QtTF6hs2biw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TyCQXvt06LyiwK7IosnA4d22ZMlnNW3vraRLQ3xqSA=;
        b=oFLDxRp5tYuXMacQmTG/cjy59sMLOZk1DrLkrv6voEpJA9s92mr0WF80rxOcqg533jilPz
        Qs7X8Qu0eHAMZ2AQ==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: nxp,sysctr-timer: add
 nxp,no-divider property
Cc:     Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902111207.2902493-2-peng.fan@oss.nxp.com>
References: <20220902111207.2902493-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <166487562795.401.1639480223954751337.tip-bot2@tip-bot2>
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

Commit-ID:     061f42748d0639647636b7a48d71951e8d92720a
Gitweb:        https://git.kernel.org/tip/061f42748d0639647636b7a48d71951e8d92720a
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Fri, 02 Sep 2022 19:12:06 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:46 +02:00

dt-bindings: timer: nxp,sysctr-timer: add nxp,no-divider property

The base clock input to system counter is internally divided by 3 in
previous design, but there is change that no divider now. So add
a property to indicate that.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220902111207.2902493-2-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 830211c..2b9653d 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -32,6 +32,10 @@ properties:
   clock-names:
     const: per
 
+  nxp,no-divider:
+    description: if present, means there is no internal base clk divider.
+    type: boolean
+
 required:
   - compatible
   - reg
