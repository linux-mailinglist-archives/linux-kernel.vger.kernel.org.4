Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F185BB543
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIQBQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIQBQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:16:34 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7945E22BF8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s18so14234962qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=zKW3vycHDAYSzOkMpIJKV1+gXuwPgKuVH+YJh8CZYUL/g3l17pCEnVKrJRfpjmSXGp
         tkPj9qEdpTSorQb+5GKBYbzxb46d1rSJU7mEvniRf2Y3SXtch97X+th7RYYhPCvLzd6Y
         Gp2MIfZi+Jt9clv7ObsJFD/NVfOgSaNBDnbs3wwCpqvYI654OIp0FWaeJaG5sSbp99Kt
         6Xciao3SA/VFdgnoQASCdP/2AeCe9GgszAipMf/a24KPnc6WOwLTpEURlIEPJNO6F6SQ
         CmViffUeMDPEh5ABy0XFt+Ae237qKK713CbAVa/6B/q3HyVCyM2qJguA9XZgyIVHPnm9
         +X9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=nKObxwU/otwTg1F1uvQcuGyEf+nS62g47oIp1eZj+xafIvlDVnhhypwryj+zb3KjZu
         rwURBPzDi9J1xcFUcTLvAU27vwsczyV3v9YtkcXvOC+stHI3GF9/2KFV7PjNHnQqNUQf
         KlNDmEAq7miNUicQtjsjl6V3HK/EmlfZ9WaKAqHKMzmXaKij/2Rqj1PhsHmL+SmlbEGF
         6CH78UKI827Y4+DMCxI7EC0FNflxBIXutITPb7uILv5dNlT7bmw/+qXZ5a37MYYTSLVA
         zR2Z/f6LXhI3wIrFITCNe5ig9MuZaf0PliuWqCVpBnRAvCPUPO5M6O8uxm9h4vIx13c9
         F2Hw==
X-Gm-Message-State: ACrzQf0VPKdt41I+pss+ENcybbNvSywPp/Htz6LUp/cPJ3O57flVnOeQ
        FPkObG6Qh3sGo6R+MMeGZXbs4A==
X-Google-Smtp-Source: AMsMyM6nIH8z4+OiRjabaE89EllLMSNNm9mCCWIcVTmLX4X2sleAmRHAvsKZ+nonIAjSY3x5Ufgd9g==
X-Received: by 2002:ac8:7d0a:0:b0:35c:be89:fd65 with SMTP id g10-20020ac87d0a000000b0035cbe89fd65mr6901226qtb.99.1663377392645;
        Fri, 16 Sep 2022 18:16:32 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v6-20020a05620a440600b006bb87c4833asm8085434qkp.109.2022.09.16.18.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:16:32 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 2/4] counter: 104-quad-8: Add Signal polarity component
Date:   Fri, 16 Sep 2022 20:39:26 -0400
Message-Id: <3611fef702da4255dfd050520c4623134b26ca68.1663372750.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663372750.git.william.gray@linaro.org>
References: <cover.1663372750.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-quad-8 driver provides support for Index signal polarity modes
via the "index_polarity" Signal component. This patch exposes the same
functionality through the more standard "polarity" Signal component.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 1323edfbe40c..2a9d8259ed4b 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -549,6 +549,32 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	return 0;
 }
 
+static int quad8_polarity_read(struct counter_device *counter,
+			       struct counter_signal *signal,
+			       enum counter_signal_polarity *polarity)
+{
+	int err;
+	u32 index_polarity;
+
+	err = quad8_index_polarity_get(counter, signal, &index_polarity);
+	if (err)
+		return err;
+
+	*polarity = (index_polarity) ? COUNTER_SIGNAL_POLARITY_POSITIVE :
+		COUNTER_SIGNAL_POLARITY_NEGATIVE;
+
+	return 0;
+}
+
+static int quad8_polarity_write(struct counter_device *counter,
+				struct counter_signal *signal,
+				enum counter_signal_polarity polarity)
+{
+	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ? 1 : 0;
+
+	return quad8_index_polarity_set(counter, signal, pol);
+}
+
 static const char *const quad8_synchronous_modes[] = {
 	"non-synchronous",
 	"synchronous"
@@ -977,6 +1003,13 @@ static struct counter_comp quad8_signal_ext[] = {
 			       quad8_signal_fck_prescaler_write)
 };
 
+static const enum counter_signal_polarity quad8_polarities[] = {
+	COUNTER_SIGNAL_POLARITY_POSITIVE,
+	COUNTER_SIGNAL_POLARITY_NEGATIVE,
+};
+
+static DEFINE_COUNTER_AVAILABLE(quad8_polarity_available, quad8_polarities);
+
 static DEFINE_COUNTER_ENUM(quad8_index_pol_enum, quad8_index_polarity_modes);
 static DEFINE_COUNTER_ENUM(quad8_synch_mode_enum, quad8_synchronous_modes);
 
@@ -984,6 +1017,8 @@ static struct counter_comp quad8_index_ext[] = {
 	COUNTER_COMP_SIGNAL_ENUM("index_polarity", quad8_index_polarity_get,
 				 quad8_index_polarity_set,
 				 quad8_index_pol_enum),
+	COUNTER_COMP_POLARITY(quad8_polarity_read, quad8_polarity_write,
+			      quad8_polarity_available),
 	COUNTER_COMP_SIGNAL_ENUM("synchronous_mode", quad8_synchronous_mode_get,
 				 quad8_synchronous_mode_set,
 				 quad8_synch_mode_enum),
-- 
2.37.3

