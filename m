Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2465B3F6A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIITWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiIITVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:21:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43264142DA0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:21:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nc14so6285236ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=kL+H2Xx37KBsv/0YEDfff/qZ7CrxxnzF1gZ71iKSCzs=;
        b=l6c/qvEOw1VPDxsGk/clbSnTu12ZcudT4eqSRKYO8F6wu3/8uW9aqgczXFxE6LCAUK
         C/BQN9fMSO8uBu8vcnkP8WYgrUy8WsFhN6V6C9QtWmDUoFweF+K+jIwoc7PozFjGrJnE
         ep2y2XePXR+0vTY3SOPZZBXAJ6ng0719TvtzZ3Zs55rjyjwIeDRhIsYwwTmONHUJke0I
         /CnLZsVI8ldJC1eC2vSsw+x+fsppNo3SF93zoBcdH00gxd2ee4yWr6aXllthAM+xoMmJ
         C49iLvocpCXQsrAof/HyektkMb2lEs0cbOh20p/ksXUIAdWgTJe1lGOvYDAbWaBrUwUe
         4e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kL+H2Xx37KBsv/0YEDfff/qZ7CrxxnzF1gZ71iKSCzs=;
        b=vlnLtn0XtMWaP6d7PpK+ruMG0Sd4HDiugVf0jICrXvEP8mvsRpi4XYOofa/2iQQ9oG
         e9xoFi+yJvHZ3ppVzEocT3aXdIZjUAbUCvrAxrJlfbcc20J+ggsT21jWa4HsCBDocU6L
         GiBBEdatL/LM3bopvrpu+3c3Y7u5pI9eqXSc9TRWAcIfRHOXdoyUSPYY/vqnI6DJU8oi
         8bYtznXASNaA7D5At2EX/sa3Uz/LInNtM+i8PRu80W5KpXNrYb+PigssfAIW4AVEj4LN
         WIJt8Z/Ir80MhNcgpNcXK1JmJAlqUOxeSRu4F7ve9bT9VypMZvbisHy4g8jhSHMH7tKv
         D+EQ==
X-Gm-Message-State: ACgBeo1L0edS4Icu9Fi1cmXRUmBrQjB/Gob0KtalTPrzWhCgZCBwhyNL
        6v4xHuWS4KRrq17W4KckKV8=
X-Google-Smtp-Source: AA6agR6lXJibGMBpJFhzJDeTbRXCyULx1MLdO5/d5lJZYIh7yDCqMFBgfnnR9OEwzBu3f1A3qXHrnQ==
X-Received: by 2002:a17:906:9b96:b0:779:dcbe:3a9b with SMTP id dd22-20020a1709069b9600b00779dcbe3a9bmr2952202ejc.607.1662751308851;
        Fri, 09 Sep 2022 12:21:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906069000b007414152ec4asm632549ejb.163.2022.09.09.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:21:48 -0700 (PDT)
Date:   Fri, 9 Sep 2022 21:21:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: rtl8192e: Rename RFWaitCounter
Message-ID: <11acf28a0b9f56dde4fa4fbd74a085cf2fa1c20d.1662402870.git.philipp.g.hortmann@gmail.com>
References: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable RFWaitCounter to rf_wait_counter to avoid CamelCase which
is not accepted by checkpatch.pl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index bc8aca808e99..ee3d0f243463 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -140,7 +140,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	bool action_allowed = false;
 	bool connect_by_ssid = false;
 	enum rt_rf_power_state rt_state;
-	u16			RFWaitCounter = 0;
+	u16 rf_wait_counter = 0;
 	unsigned long flag;
 
 	while (true) {
@@ -149,10 +149,10 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 			spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
 
 			while (priv->RFChangeInProgress) {
-				RFWaitCounter++;
+				rf_wait_counter++;
 				mdelay(1);
 
-				if (RFWaitCounter > 100) {
+				if (rf_wait_counter > 100) {
 					netdev_warn(dev,
 						    "%s(): Timeout waiting for RF change.\n",
 						    __func__);
-- 
2.37.2

