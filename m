Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0167A558
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjAXWEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjAXWEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:04:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E159360A0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so58148wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMf09+fC4QI99DmXPRyQuRL+tFfoSe44zXEcxxr3d1Q=;
        b=IEgYNIvNCC9mddSqNfaCCAz0oUCnF7np9L8WKM+zB3789lBGkDNb9niMNvK9QHJ1+h
         ImSB5ok4C9Hu2t3IGHmEc5lH9BC7SIN/CrBtaM4cKBuRFswjHrcr5Slew7e/VBEQ49+C
         SRJFX8/J07sByHNIZYD1cuH3TNsIbmhBRK64eR2FKk7B7jYW2R/kpvAqSQT+J+OzVOWZ
         jM9wZZV8Ad/Ljy1qQZV2HfIAfz2zLAE5aFYX+CnkJHNAhlforaQv1xLqoNH8Q0CviLmz
         QSZn3rol5PqQdvSu9RWkEX06cEfkwtFK1yhhpeSQnG/GuEcAWu3P3F7XPxZcs0AkQoxV
         yWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMf09+fC4QI99DmXPRyQuRL+tFfoSe44zXEcxxr3d1Q=;
        b=M+EK0QGH/NMo6/yvm9L/0KpiWmCn/kS74Tmh0dahcdE8ZCC+Fu+aqKvj9OqrxHhPb+
         DJOs4d7ceFFV/AsMvZ+F94OrtBsR+c3fWhlJWlZhPuDS6JMS9ncvEZEo+qLfC/B/Us7O
         eW/GvDyfy85VOHTnGScgbYmvEtrVFWFeAoXHqeD+1+FgQoCVfeUpMtorRZsFGLfSF0XE
         kvtWTdgZeSEDW/Mh1pojMkF3Yu2HoLqwyAiIAp+jkiu15GVQlWLgZ8QbRtAmWLTyft+x
         efOqZfDVTBswaWHZJgI5Lc/Sql0kqnrZxCSCaIbQzxTmKgUAwyd9AuCC0jmOxtVBT1zG
         4kLA==
X-Gm-Message-State: AFqh2kq4xkKSdqWDwcyuVniH1/hlvqaqvFUNgxjowBUGLDuccKM2CsDn
        q0O8NMsepnGZKxtDvlIP96M=
X-Google-Smtp-Source: AMrXdXsnj6kmeablVOb7yN/mrc+AkioXK5nvirlDwTX8g+li8SL1iwUQaxj6RRvIlKTm8qgxNF+50g==
X-Received: by 2002:a05:600c:3b8c:b0:3c6:c5d9:dad3 with SMTP id n12-20020a05600c3b8c00b003c6c5d9dad3mr7996420wms.0.1674597865822;
        Tue, 24 Jan 2023 14:04:25 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id y4-20020adfd084000000b0028e55b44a99sm2735451wrh.17.2023.01.24.14.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:04:25 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:04:23 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] staging: rtl8192e: Remove unused variables txviok..,
 txvook.. and txbea..
Message-ID: <1500a146bd4f46e8c49ff35f71c21def978fe9d6.1674596722.git.philipp.g.hortmann@gmail.com>
References: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

txviokint, txvookint and txbeaconokint are initialized and increased but
never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 5 -----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 768324cbe253..4cc90425fa4c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2139,9 +2139,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		goto done;
 	}
 
-	if (inta & IMR_TBDOK)
-		priv->stats.txbeaconokint++;
-
 	if (inta & IMR_TBDER)
 		priv->stats.txbeaconerr++;
 
@@ -2192,13 +2189,11 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 	}
 
 	if (inta & IMR_VIDOK) {
-		priv->stats.txviokint++;
 		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, VI_QUEUE);
 	}
 
 	if (inta & IMR_VODOK) {
-		priv->stats.txvookint++;
 		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, VO_QUEUE);
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 96d340f686e9..f8b2201ea288 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,9 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long txviokint;
-	unsigned long txvookint;
-	unsigned long txbeaconokint;
 	unsigned long txbeaconerr;
 	unsigned long txmanageokint;
 	unsigned long txcmdpktokint;
-- 
2.39.1

