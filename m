Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5E760BDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiJXWzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiJXWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:54:49 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F381F812E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:16:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E7435C0134;
        Mon, 24 Oct 2022 15:52:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 24 Oct 2022 15:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1666641130; x=1666727530; bh=twRoZ2KpBnvB6wrQLeM2uyyTg
        jNvfcSP6xQ7nW7TV8Q=; b=AZtaBxHoaQ3HD2AgvGP+yfeYyN4z2M7Fs8qrjTikC
        5jUoIcMCYsCmYraTxoMFVGiYIJSVaktBNY+rI/FlTF/AQ+EedWEoi3kyJ7FruGMO
        a0N1Et/Va9Oy6t8hbUrD+lJk7+AeMddcolgiE+DVSzuutFbg7c0riO6aTKyJmdj1
        s1B5n2zwm3U/jfwcwZQUrrx1KRSGIRwzbr2oYlqixf1MiI6U9kn6HZieXwkkVypb
        i/zWJ3N9aOCEpvV4peUDRSN9qNwp6wAFzepgGyWs2ApIYt12IDdiWOwx4ZgyIXi8
        W0F4YEjLjrbtG8YSQtOLEzkTEuiuv8cwEKcekIllYxnpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1666641130; x=1666727530; bh=twRoZ2KpBnvB6wrQLeM2uyyTgjNvfcSP6xQ
        7nW7TV8Q=; b=XgMjUmcxiVD/upZDJ/21JxmEuTeUcKmLNaieVDS7D6l26yL/6VQ
        bXgnHhcGwiCu+XWVPAjXozAI+RS+dN7WVy/duPjbBbmVNbzU+ehHnAAOF5SzoLtg
        5+5enBl/5LK6ja5QAvCdsw2G3ZCERtpv2r2GFl7WO9H47bhgfBCBVdJh/KXsRStA
        UzAJVItzjVpf2xQJUdu6HTdCxOAm6KMNYUWEr1PecwkkgVquDTS7u2tOxxKSmWr9
        cewvGK1RykzeBd0ziHQPW0ZwPnWZDk5GQP1iUdGSxAMO+mHpuhWWMyLeZLxrWFUK
        NA6QrCUA9W0tdT3ehH1o3ybTJ7Fpk5Z591A==
X-ME-Sender: <xms:6exWY7Rcj2FZcZPmtHEZK-CiTn3GwJqeMT_J9b49lJSHAQ3AZZx17A>
    <xme:6exWY8xMOi3ueJHI5qWBLyBvrFisrFUsJESb0NiWdqJh6IdzxgxmdMYPHImSQ1hEz
    wciIQyVSpDYdkC_I9k>
X-ME-Received: <xmr:6exWYw1TQk54hi-z-7_c9YdxBtUCdXxPmr6iQp2eN_5v5lC-IFt2_dK-_w5IIbM94PszTiUOPBv5nla_VJ4N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhihlvghr
    ucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtthgvrh
    hnpeejteetjedvfeelkedutdfgleegjedufeeigeefkeejheetvdeggfefffdvgedukeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    esthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:6exWY7B2ugMUNfPaMD62N01CmHBxTvxmejzpgd-xuj34WH8_k3h3vg>
    <xmx:6exWY0htimNCu-YVzHoyh0CLLkYqsa4Hk4Th6kT5wgHaifxOKxVHMQ>
    <xmx:6exWY_rTZW8uEdVb76-Ogh_yvuxLFvRK86HyzryYVZ5RP-_F9-3DSA>
    <xmx:6uxWYwiiQC9sNadlJ2OMYqS042aD96O2oq1TuDEWkub-Cnl_a1GJLA>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 15:52:09 -0400 (EDT)
From:   Tyler Hicks <code@tyhicks.com>
To:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Fix event stream param in Kconfig
Date:   Mon, 24 Oct 2022 14:51:18 -0500
Message-Id: <20221024195118.871907-1-code@tyhicks.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tyler Hicks (Microsoft)" <code@tyhicks.com>

Fix the event stream timer command line parameter name that's documented
in the Kconfig description for CONFIG_ARM_ARCH_TIMER_EVTSTREAM. It
didn't match the command line parameter name that's actually honored in
the source code.

Reported-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Fixes: 46fd5c6b3059 ("clocksource/drivers/arm_arch_timer: Control the evtstrm via the cmdline")
Cc: stable@vger.kernel.org
Signed-off-by: Tyler Hicks (Microsoft) <code@tyhicks.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4469e7f555e9..dcc274460973 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -315,7 +315,7 @@ config ARM_ARCH_TIMER_EVTSTREAM
 	  executing the wfe instruction at a frequency represented as a
 	  power-of-2 divisor of the clock rate. The behaviour can also be
 	  overridden on the command line using the
-	  clocksource.arm_arch_timer.evtstream parameter.
+	  clocksource.arm_arch_timer.evtstrm parameter.
 	  The main use of the event stream is wfe-based timeouts of userspace
 	  locking implementations. It might also be useful for imposing timeout
 	  on wfe to safeguard against any programming errors in case an expected
-- 
2.34.1

