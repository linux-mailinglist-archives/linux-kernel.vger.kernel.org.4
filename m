Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14C16485DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiLIPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiLIPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E7D37F88;
        Fri,  9 Dec 2022 07:47:26 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITu4OWRFn+S5UYPrlPXpHbPjjMKCTQ8bHagXpCHoZmA=;
        b=0QNFZTXtVgWf+vJCTnNCH45saEie1CgRxDCZSDiU9XT9W/glHaolkQGAtPrLNl3ERL0ZpR
        tV9HCc5LSQ4/CzK/Kr03CJt+zZzLioZxNauiIgHE0g9HoQdzaRjtbZ0SdJOaW4VFG5vieX
        lnoIH2vk4sbVqQQQzbHpzw9L4Z1OkfcGuwlk0POgrBsJ6qAFRvA/uwRE5JIrodmB/YoWUq
        KZOez76K5XTGVdJJEc7s+K0thYtTB43IanVmLr/ezoTB9Pl/Bq48pczu5dVf+ly+tPyQ45
        hM0JWIT2SvrS8xKuOuvg+J/1lZrtbEJm9m71iTaUsg5vh1eRw/L2RhKUmykfpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITu4OWRFn+S5UYPrlPXpHbPjjMKCTQ8bHagXpCHoZmA=;
        b=Gz9dtpev15+JMfOuVHimVSShe0wPxytoqdhSCTwJT7aGRLQhky9/yWpj2kyV2O00b9JLeq
        T4kfNaWSBN6K/uCA==
From:   "tip-bot2 for Johan Jonker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: rockchip: Add rockchip,rk3128-timer
Cc:     Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0e57f38f-bace-8556-7258-aa0b3c0ac103@gmail.com>
References: <0e57f38f-bace-8556-7258-aa0b3c0ac103@gmail.com>
MIME-Version: 1.0
Message-ID: <167060084386.4906.16536323054669590157.tip-bot2@tip-bot2>
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

Commit-ID:     9ffa5e6b8f93ccf1a217dd12e204c1a5e211abef
Gitweb:        https://git.kernel.org/tip/9ffa5e6b8f93ccf1a217dd12e204c1a5e211abef
Author:        Johan Jonker <jbx6244@gmail.com>
AuthorDate:    Fri, 28 Oct 2022 16:41:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 02 Dec 2022 12:48:27 +01:00

dt-bindings: timer: rockchip: Add rockchip,rk3128-timer

Add rockchip,rk3128-timer compatible string.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://lore.kernel.org/r/0e57f38f-bace-8556-7258-aa0b3c0ac103@gmail.com
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index dc3bc1e..b61ed1a 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -18,6 +18,7 @@ properties:
           - enum:
               - rockchip,rv1108-timer
               - rockchip,rk3036-timer
+              - rockchip,rk3128-timer
               - rockchip,rk3188-timer
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
