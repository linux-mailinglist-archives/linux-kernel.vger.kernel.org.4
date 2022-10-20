Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68060555B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJTCOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJTCOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:14:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938639127
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:14:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g28so18950326pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOPnQVDm1uAKZaYosB1mytuxMV4Sy6PQL9rIuuTadMA=;
        b=Tkq2h0XXIBtZb4SLlY3CjWI51sPYHo+Rnbpus2JveFpIvBGXGJFM1YSiUfVEWQuV+X
         6XAVgmZujVpxUqNgVAcwxf5VXKfuoJONR5/VixMSUSakRjR1jE3gKDnfC9nLgFPkEvSM
         //OqJAXlXcrDxBvQ1lrFnadFYbohDN+SjRL6x5cxTTDCKiaY4+si58LGvs4imHLG74io
         ItiwnVHuk5fiSIkpj5INWTGPhJn/yxeH8KJUFWZot12gqC/AoDazE+7TBsIH2fWoYpGP
         CAycea1c9+9+0hVnLq0QnY61+frH9ZRqoFN+Brl933Jd6w94bqsbUuOQFPsDMSZbRPmb
         SuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOPnQVDm1uAKZaYosB1mytuxMV4Sy6PQL9rIuuTadMA=;
        b=RT1uAFc62rxgGHZwMsgCVyJHM/Oe6r6WIaJaP7+XSH9gTxq4ChrkmOjkzWPtY4YHfE
         Q/AGYHfoqFgw9K9pTolLEBknEubXjWVCV5s107Etiwr39siv52oRCpbr7NNRkCTBLt2u
         2D3OTiwQkezHgTtQpdo1WgMKINPZ1VRP6TL2znUIcsR5WehFWn5FTIi3ZYpQ3Pr9CPqA
         6BNGhfZzC0T2085F3Syi4EQVH5U411uGcQB8nt+yeOPSl5mSq7qnkT436A3NVgxNyOVQ
         OpCAYDuRZENB8fPApybBlxX/TvJZOirHiiUs4abD/OtkkHp7mAd3Eao7DHMPKH9ugP7W
         mFyw==
X-Gm-Message-State: ACrzQf0NNEbJAaF7m6q/48gUUiVWcTRR+KCYGnPP0/wo3OlVDNrvfwfV
        rCPmVwwnw5g+mxNan7Mj9hc2UJwEeNO5ZA==
X-Google-Smtp-Source: AMsMyM5Dr2TlH0gGTxnHEEsVWzmYNvyXTdzJ3oQXUX6XiAwO4DtVcVZ8C43jQNliO9NUCUYiJ47wnQ==
X-Received: by 2002:a63:2b4b:0:b0:440:2963:5863 with SMTP id r72-20020a632b4b000000b0044029635863mr9568549pgr.28.1666232079822;
        Wed, 19 Oct 2022 19:14:39 -0700 (PDT)
Received: from localhost.localdomain (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79852000000b005631af4ece2sm11942936pfq.182.2022.10.19.19.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 19:14:39 -0700 (PDT)
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Emily Peri <eperi1024@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: align block comment stars
Date:   Wed, 19 Oct 2022 19:10:52 -0700
Message-Id: <3d9738edd0992b72bf8fc8a05706a490772b5317.1666230736.git.eperi1024@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666230736.git.eperi1024@gmail.com>
References: <cover.1666230736.git.eperi1024@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align '*' on each line of block comment in rtw_ioctl_set.
Issue found by checkpatch.

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 354e61a8f2bd..ac957035bf1a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -463,11 +463,11 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 }
 
 /*
-* rtw_get_cur_max_rate -
-* @adapter: pointer to struct adapter structure
-*
-* Return 0 or 100Kbps
-*/
+ * rtw_get_cur_max_rate -
+ * @adapter: pointer to struct adapter structure
+ *
+ * Return 0 or 100Kbps
+ */
 u16 rtw_get_cur_max_rate(struct adapter *adapter)
 {
 	int	i = 0;
-- 
2.34.1

