Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A366CB052
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjC0VD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjC0VDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:03:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CE273B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:03:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-93075ee221bso38690466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdyEfmioMXlj8zaCBESKr5gB9JvQl1r0IW8/axbQUWk=;
        b=JSM7FINsXu+k0Q8FSg9PdASYMz0a426/lZY0A2yAmS56PUYmHT0ahCa6b269dEJ+3C
         zArw8BRovwRPPlRQtW45C87/+8uMPX1DKYVl7VXcU8DWwVyNPynHQPtirDmgKC3Fapl3
         eE8MKIs2uFYMu0FV5ZHch9YHm3spthPvmF7Rm9jcl8p2V99KdNbmeBBtnNdsZKOrPq6r
         XpfDqRmrKFGKnLMpy5xcAfitXmyJGp6LyrnGBarqGguIiEvNdvS/fTclm+QTYmWbT434
         lnwjYSpdYolTbH7r9UAu7pF66vQqEt/bu2qKzWZr5ZyT+jGaEq+Hzi97vYpwKrxzM68a
         pDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdyEfmioMXlj8zaCBESKr5gB9JvQl1r0IW8/axbQUWk=;
        b=ZVbSOtIMYB5qssJbfenopt6jTkMDoG78hbFDIeq9H8sxSHzHCSsfMMFAmJmdwlqyDQ
         VjJHsTCUfGw7UXlmiu8fuV0XmeR3JwtzPc2uD7sPyH1JmZVNB6mkR8EBRD0iENSIRrao
         NvbKhUNdzsIjzwGUL7+II8RVwK6ppXHWQ/Cc/FK/AUFI33+tBIipEVr5Q6s/p9N7zJfE
         j2u2nVoChK13IkyohoL9buHQn5FioPH/LIj5WNqQy5FhPAbUVYREcd75q+pzGXfGgdJW
         gQ1EO1fhlR2e0vuuo1acun1Dn5wG4bv+3rmKPDRXf5VgRAe8+9eLrmTMKv/boic9Gvg9
         /0Pw==
X-Gm-Message-State: AAQBX9cAd+3gLIzMIjqaWVKQ1AJBgAcERhHO71wRzbrJZ+kunmyKwJF/
        a4GlXNLjOshnlThSd2HqeQU=
X-Google-Smtp-Source: AKy350ZRWyOrbJwCctralYpHk1twvtMNFXbyP8Xd9seLJHuiF/qb1wy+2gyKvMBOiZE75LGlxkJ5/Q==
X-Received: by 2002:a17:906:51c9:b0:92f:27c2:13c0 with SMTP id v9-20020a17090651c900b0092f27c213c0mr11868755ejk.6.1679950986448;
        Mon, 27 Mar 2023 14:03:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id sd24-20020a170906ce3800b00931024e96c5sm14628338ejb.99.2023.03.27.14.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:02:59 -0700 (PDT)
Date:   Mon, 27 Mar 2023 23:02:45 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] staging: rtl8192e: Remove 5G wireless_mode in
 rtl92e_set_wireless_mode
Message-ID: <693a34b187f21d9d48accd3b0b953dff2f0795eb.1679949171.git.philipp.g.hortmann@gmail.com>
References: <cover.1679949171.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679949171.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove wireless_mode == WIRELESS_MODE_N_5G as 5G is not supported by
hardware and to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 12e5132fa788..c03978353a90 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -624,12 +624,11 @@ void rtl92e_set_wireless_mode(struct net_device *dev, u8 wireless_mode)
 
 	priv->rtllib->mode = wireless_mode;
 
-	if ((wireless_mode == WIRELESS_MODE_N_24G) ||
-	    (wireless_mode == WIRELESS_MODE_N_5G)) {
+	if (wireless_mode == WIRELESS_MODE_N_24G)
 		priv->rtllib->ht_info->enable_ht = 1;
-	} else {
+	else
 		priv->rtllib->ht_info->enable_ht = 0;
-	}
+
 	_rtl92e_refresh_support_rate(priv);
 }
 
-- 
2.39.2

