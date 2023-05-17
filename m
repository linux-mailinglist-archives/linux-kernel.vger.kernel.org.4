Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA5706AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjEQOTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjEQOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4D3C3F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B754763B69
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7AFC4339B;
        Wed, 17 May 2023 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684333120;
        bh=F0AZ9gGUCWLqZou45V0C72APsERo8cXab7RBwb7n0S4=;
        h=From:To:Cc:Subject:Date:From;
        b=tnbWQgtR+ovpmbCYc6D2SPzL48cQT5eHh1tAhCnhv1gqk0GxKxv9CurHupSMRjeoS
         JZrqBmpPr74BAtIyhm5rC/LhWXYsyE4sPQPH+Acnyj1xHvdWEzs1nP/2h1/L53XNFT
         BB7hgMyfOqikuc3PChI/fBrIGrdiu8jJFv6chHnGwxVorLJKcH2Me+UkWJTgbTiG9v
         NrC/aH+U1aUMJ7saENasYVUUpgNyfRWa0mRbsRpiNT0JrnWH4ROufUCHkjY7Ys3xq9
         rxpWvS1WoTErpOz9ANLBz6s6mGly06rglm6RpvE0PWy6eAus4R6oc100lZlpxIaj4W
         xG54oO1xm8Iug==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mailmap: Add some mail mappings for Lee Jones
Date:   Wed, 17 May 2023 15:18:29 +0100
Message-ID: <20230517141833.360743-1-lee@kernel.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Prevent mails from being sent to old and unmonitored inboxes.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 71127b2608d20..728a25b7abfb8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -270,6 +270,10 @@ Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Krzysztof Kozlowski <krzk@kernel.org> <krzysztof.kozlowski@canonical.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 Kuogee Hsieh <quic_khsieh@quicinc.com> <khsieh@codeaurora.org>
+Lee Jones <lee@kernel.org> <joneslee@google.com>
+Lee Jones <lee@kernel.org> <lee.jones@canonical.com>
+Lee Jones <lee@kernel.org> <lee.jones@linaro.org>
+Lee Jones <lee@kernel.org> <lee@ubuntu.com>
 Leonard Crestez <leonard.crestez@nxp.com> Leonard Crestez <cdleonard@gmail.com>
 Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
 Leonard Göhrs <l.goehrs@pengutronix.de>
-- 
2.40.1.606.ga4b1b128d6-goog

