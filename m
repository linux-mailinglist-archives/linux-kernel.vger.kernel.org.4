Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E06E60E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjDRMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjDRMMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:12:01 -0400
X-Greylist: delayed 1171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 05:11:56 PDT
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829E1F0;
        Tue, 18 Apr 2023 05:11:56 -0700 (PDT)
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
        (envelope-from <ada@thorsis.com>)
        id 1pojb0-000n1K-HF; Tue, 18 Apr 2023 13:34:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
        t=1681817701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=58ms7/okwJXKsuNO79X1bSKGgHUauO/LsUGYVyTun4g=;
        b=KTImcDeqQrl8npJhreOf0KKYuGeY6ctB5hN/8kC95LQaVz3JNxMqVTL+nmXBnGZP+qlhb/
        LTvhg/yOpF80/qold+fqd6UZHUwQdoscP1jhou145nwDdYA1d0rGkDHZpFc4z9kGi10/SI
        acOy7JVIsInnb6dFHRr14DgYvVXiIAFxpfSm1Sqf1mF+pqzvcjS3TT0P19UFhh3bzgesJg
        xNL2xsN27sY76muPE6WfmVrjkNcu9xBEi+TxI1NEuSJxapD0lHflnJ0MByIXA4TxQWvTHa
        vXeVAOGVN0TkQ/fHXnm4R0cAwDdSTn06gUGscCBycNng1E0PTEYvVg+SsiRAIA==
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-doc@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: [PATCH] docs: leds: ledtrig-oneshot: Fix spelling mistake
Date:   Tue, 18 Apr 2023 13:34:02 +0200
Message-Id: <20230418113402.188391-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's no comparision, but a "first this, then that" situation.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 Documentation/leds/ledtrig-oneshot.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/leds/ledtrig-oneshot.rst b/Documentation/leds/ledtrig-oneshot.rst
index 69fa3ea1d554..e044d69e9c0f 100644
--- a/Documentation/leds/ledtrig-oneshot.rst
+++ b/Documentation/leds/ledtrig-oneshot.rst
@@ -5,7 +5,7 @@ One-shot LED Trigger
 This is a LED trigger useful for signaling the user of an event where there are
 no clear trap points to put standard led-on and led-off settings.  Using this
 trigger, the application needs only to signal the trigger when an event has
-happened, than the trigger turns the LED on and than keeps it off for a
+happened, then the trigger turns the LED on and then keeps it off for a
 specified amount of time.
 
 This trigger is meant to be usable both for sporadic and dense events.  In the

base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
-- 
2.30.2

