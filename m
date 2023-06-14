Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3013672F2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbjFNDJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjFNDJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:09:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159A6CA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:09:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgr441y0qzBJL98
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:09:08 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686712148; x=1689304149; bh=PwxsVOAzDDB8Ivc12dEAldwl7Yl
        B/uooNnvQoX6R+iY=; b=kUxljA41uAdGJMMUiWBePOjN/b+HHAezKTVq9ep205+
        sLxrXCmc+Z6J4E5hou87nSPcypYJFzsd5YSSohZSI1QGlwZMEncmmvBfuScxgLOK
        NIx6XvkGdf+HGIoMnkMj2qMaqEkGUUbVLlwV8DytsHIkhpSGiOAsZYOBYxd4AoOc
        z7s7v8sxHFwMQX1k/ePtTaGkBaxJnxgHOw7Xl2uoRG0zwtgyFg1h+nTrSUtbVVVh
        A5YkHcb1VONQTRVz/PZJ8wIYDRW6CB01hZt/q70EDVyt6DKQxWlRutDu3stXEBpI
        TtEgGdGJDt59mIqAr2pwYzFL4xf0Ha2g5P9CKyjfRlg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bucrvi3a5p7V for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 11:09:08 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgr435LQkzBJ9pH;
        Wed, 14 Jun 2023 11:09:07 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 11:09:07 +0800
From:   baomingtong001@208suo.com
To:     toke@toke.dk, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath: Remove unneeded variable
In-Reply-To: <b41c50989125dec782e1fbd2793d0ecf@208suo.com>
References: <20230613093757.5380-1-luojianhong@cdjrlc.com>
 <b41c50989125dec782e1fbd2793d0ecf@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <209fbe59213d89c3e7e3a5fe6030e19e@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/net/wireless/ath/ath9k/gpio.c:501:5-8: Unneeded variable: "len".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/net/wireless/ath/ath9k/gpio.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/gpio.c 
b/drivers/net/wireless/ath/ath9k/gpio.c
index b457e52dd365..f3d1bc02e633 100644
--- a/drivers/net/wireless/ath/ath9k/gpio.c
+++ b/drivers/net/wireless/ath/ath9k/gpio.c
@@ -498,14 +498,13 @@ static int ath9k_dump_legacy_btcoex(struct 
ath_softc *sc, u8 *buf, u32 size)
  {

      struct ath_btcoex *btcoex = &sc->btcoex;
-    u32 len = 0;

      ATH_DUMP_BTCOEX("Stomp Type", btcoex->bt_stomp_type);
      ATH_DUMP_BTCOEX("BTCoex Period (msec)", btcoex->btcoex_period);
      ATH_DUMP_BTCOEX("Duty Cycle", btcoex->duty_cycle);
      ATH_DUMP_BTCOEX("BT Wait time", btcoex->bt_wait_time);

-    return len;
+    return 0;
  }

  int ath9k_dump_btcoex(struct ath_softc *sc, u8 *buf, u32 size)
