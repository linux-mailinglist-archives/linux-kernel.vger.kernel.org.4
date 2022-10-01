Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791405F1B80
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJAJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJAJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:41:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDB45F109
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:41:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a41so8793604edf.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=Mm6M11oSPXoaRRBYLI9i9vIPcpu5jQ8WX2bWiDMVzWQ=;
        b=G6PsKa4ofVBU3Bq+tnNmvkdK9/erY1cQM7aH2RPCn4yP7Mr49qv3teuO0LdlxTnK5V
         76cgq0XIWdyC2wO5nxYU8iJGQKKlzsrvCnaWZt67t+79e8WQ9zeOuIQq3ppnQRFSOslY
         3EsrJJWbiLficXEFgCv5k+I3/K3DwtCaAKiqM2B6f6levAu/b0R2PxSLNsTq7yghS95Z
         uCtnU8kliF7MiDcxEN/vanp8ZY1u0KeWeuDy6BMcXWWYBuSsK1kqmkDDlnVtS+BHelGt
         ViivfjrtFbLZxJ6Jl7Pizt22cKpDcLKtgx8FvusAE4baNLThQF0053vuAwn2Pr1+tbka
         B69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Mm6M11oSPXoaRRBYLI9i9vIPcpu5jQ8WX2bWiDMVzWQ=;
        b=14ZU9T07soAyL+7zh2ro4eocsrmptAwFJxBZXRqmKZFKlbcM2FVcTciBp4lMNyEt+L
         cybaflVNq11S6xikdModCOmYoIMgTxDMgDErDMINHR5YDzQuBKdOa82F7445QAT9UC5A
         2tYbWsphGfeFj/G4Lmxafs7CuzZJ/wXuds7Rfqa5uEK2yPJyutwPPYqTMzaKs6YK7L6Z
         RHbHopeBZeUrQW/xuTBpKmWEexW+HaUup17bkKYk3Mvs3p6335scCjaRyb0mPzRLmjOR
         kgFIvX6CpJx0GwmxuThO7P2R4XvgWvviblIk1xdBSbbJhpXoo3bWSUtYVNkYWeKugEPn
         rCXg==
X-Gm-Message-State: ACrzQf3gnCXvw2Edorf5dKs2gTYAZuH16M627nTZfIYpS5hUkDvz7qXE
        vXR/fwKv/wdUNCyMxGs70go=
X-Google-Smtp-Source: AMsMyM5p1maCVgENB6nH5wHfBkXxPAXAtRBr083llPSO5WVjpKYjH0TltyQADQ/CPwYwEwEibpad/g==
X-Received: by 2002:a05:6402:4402:b0:453:6a9:ef8a with SMTP id y2-20020a056402440200b0045306a9ef8amr10594494eda.85.1664617266496;
        Sat, 01 Oct 2022 02:41:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id ky22-20020a170907779600b0074ae59d85a4sm2456884ejc.20.2022.10.01.02.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:41:06 -0700 (PDT)
Date:   Sat, 1 Oct 2022 11:41:04 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Remove unused variable isRFOff
Message-ID: <53242638126775f6698fdcfc49ac552a4e08578b.1664616227.git.philipp.g.hortmann@gmail.com>
References: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isRFOff is just once initialized and changed but never evaluated. Remove
resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index db55b9b65192..3cddc9a86f28 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -880,7 +880,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->wx_set_enc = 0;
 	priv->hw_radio_off = false;
 	priv->RegRfOff = false;
-	priv->isRFOff = false;
 	priv->rtllib->rf_off_reason = 0;
 	priv->rf_change_in_progress = false;
 	priv->bHwRfOffAction = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 28733dc2038b..23dccd6079ea 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -474,7 +474,6 @@ struct r8192_priv {
 	u16 ChannelPlan;
 
 	bool RegRfOff;
-	bool isRFOff;
 	u8 bHwRfOffAction;
 
 	bool rf_change_in_progress;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 1ced5bcebdab..1501f7be8eee 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -121,7 +121,6 @@ void rtl92e_ips_enter(struct net_device *dev)
 		(priv->rtllib->state != RTLLIB_LINKED) &&
 		(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
 		pPSC->eInactivePowerState = rf_off;
-		priv->isRFOff = true;
 		_rtl92e_ps_update_rf_state(dev);
 	}
 }
-- 
2.37.3

