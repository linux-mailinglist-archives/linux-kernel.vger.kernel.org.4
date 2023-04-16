Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA06E35A2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjDPHUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjDPHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:20:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8B30D8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:20:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f44739a2afso407251f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629628; x=1684221628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8k9nO2fKVUUnwg/PlGeQfjbj4jMnL8QuYn9ONfwhXe4=;
        b=sNI+KFfcbiffyf/EojEIoeeerwb5EobglE7DpjCOkmAa3g0CQ+eysVPTAHBhgG8ztK
         AxIpWSVoKAkW5WMzFvz2ERsWrlDub+4d8ut8NKFTwa4eqc3juDJuHWrxeZ4CjOl3NIUj
         NxTS8tFIPAbkL9gpf3/mKn5hqzLkZCiBl9TqJpUMXXO3Fty5Q+20iTS19A2EVWfx62hg
         MKIMOqqcYocgRxy0oNJqw3HheaHOJNiou7SNplPGqTGdjui/kHmxhnWlsXYhqNb0t0AZ
         TFG17W6y/pOz6lJPHzGGyaAUDDga50KIDSb0VI/3w12h74WCoj8b0Ur1tju4aK+GW04i
         gduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629628; x=1684221628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k9nO2fKVUUnwg/PlGeQfjbj4jMnL8QuYn9ONfwhXe4=;
        b=jf3fs8rSETlXljO/0n1b6LlDb4GzqQP9NVPvnqgjQCMa/IBCahM4spMGzS7g9Jpoq1
         yTP/TRVEhye9032sX0Axgfm7mvBCHQqd2P/WtMafQeo510wkv+o2pLZUthIaVk/hrFZS
         OzjzyJGJE1NmncB00gaOmeJIzdEu5Sn4te8dx4xwxuQYVMm0bgr+8kyi9jVYcvv+RVH5
         dKfHn8qvUyCqdbQ/oSt6Isw9Ud6ujJNQpfeGPA48j7Y0WeGlK+DYSAi5hWNCgPbhaO0D
         JwYoAsnes8nEhxxwgF8JoerKwMaLRa08+g+gt/GnRQ6HQl8hUUCavBD6N3nLUcRd+Cxx
         ZWlg==
X-Gm-Message-State: AAQBX9eZj5eK5xRtXc4QJnNjoOWFqlzju4uErBV8zQXWOAtFNgT49ppl
        HCiYxH/fP6GhUGIxP8quPfW44gJeO6M=
X-Google-Smtp-Source: AKy350btAN4DW4CTH6qT6sz3xd8RKmz9VH32cpkb6NnPX0LeUxjcUaGl8ZGZzJGvd9Sq5U24p8uI9g==
X-Received: by 2002:a05:600c:1d11:b0:3f1:7138:91ee with SMTP id l17-20020a05600c1d1100b003f1713891eemr899513wms.2.1681629628131;
        Sun, 16 Apr 2023 00:20:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id f20-20020a1c6a14000000b003f17329f7f2sm291552wmc.38.2023.04.16.00.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:20:27 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:20:25 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: rtl8192e: Remove unchanged variables
 bfsync_processing and more
Message-ID: <cb609f904d988febaa579526514586877b1dabf7.1681627603.git.philipp.g.hortmann@gmail.com>
References: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unchanged variable bfsync_processing and
rfc_txpowertrackingindex_real to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 88ff54173a1f..27040d1e3230 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -786,7 +786,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->short_slot = 1;
 	priv->promisc = (dev->flags & IFF_PROMISC) ? 1 : 0;
 	priv->bcck_in_ch14 = false;
-	priv->bfsync_processing  = false;
 	priv->cck_present_attn = 0;
 	priv->rfa_txpowertrackingindex = 0;
 	priv->rfc_txpowertrackingindex = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index c97e315a9091..285dac32c074 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -357,7 +357,6 @@ struct r8192_priv {
 	u8		rfa_txpowertrackingindex_real;
 	u8		rfa_txpowertracking_default;
 	u8		rfc_txpowertrackingindex;
-	u8		rfc_txpowertrackingindex_real;
 	bool		btxpower_tracking;
 	bool		bcck_in_ch14;
 
@@ -376,7 +375,6 @@ struct r8192_priv {
 	bool		bcurrent_turbo_EDCA;
 	bool		bis_cur_rdlstate;
 
-	bool		bfsync_processing;
 	u32		rate_record;
 	u32		rate_count_diff_rec;
 	u32		continue_diff_count;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 43e335ab0733..56a8ec517c06 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -998,7 +998,6 @@ void rtl92e_dm_backup_state(struct net_device *dev)
 	u32 bit_mask = bMaskByte0;
 
 	priv->bswitch_fsync  = false;
-	priv->bfsync_processing = false;
 
 	if (dm_digtable.dig_algorithm == DIG_ALGO_BY_RSSI)
 		return;
-- 
2.40.0

