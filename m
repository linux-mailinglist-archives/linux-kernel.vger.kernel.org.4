Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4200701900
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbjEMSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjEMSJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:09:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BCCD1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:09:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9659dee48edso302725566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684001339; x=1686593339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcwlzjzKqkae2M3+WAsm07p04ignv4QKU8BX1mAajHU=;
        b=hgyUA8ODnif+kjj87+sm3sOz5g5PDVSp3MsBjq4/IbnDSykJGxf1CqK8Qz9W/MeIgb
         lVpA0Yk8kmzceEyW2bPsexqGuE53b9tfTd5O4njFbhn7ELXlbQMVnd19pH603ejPMCmK
         fnWmR9y3vga3KlRdqY89TrcAplzSJHflzTd2D9QppT6x3DEfKgXFJDvVKZMM0OKkrRmO
         pgvvxFnimulorLQHNdvsvp4IP8olb+moehwqDqjG2aIxAOyiQbJynKg5W+FGCHNKLZf/
         XQCGsTeYH/Hwv2q3u6yzsAEV1T97gbV4bcY5dHF3oUZuQtsKOVXJZlThOFfJbfkAaQAw
         UlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684001339; x=1686593339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcwlzjzKqkae2M3+WAsm07p04ignv4QKU8BX1mAajHU=;
        b=FXrr08z+qLgBMtLQAgN9fMsEDJeVKnOwwPLIxxA46lWX0024J//rYt/xFnFWH588+/
         1ETC/XnXnB0TMFecddX5iwqrpzz+9dCB9Fq32FtAsmJaLLlkHgOnk/8vQj8NgUXPzkxU
         hJnGveJTDsQnMZ1yWwqaaNMItq1FuBnLcVimrpAi5jg8vwyKWXpnO43hFT/ukd1goz0s
         Jwp62OJZsFznaFPVcDFB6wR9Vik3h6z+sNPKZgSyqWa4poqr5AjkIaZqg4UEnWEvLWC5
         fDYHuNOTnxKlna5KqHSloIcuhdmfYdXjyhqOpFIipB0Mys/rN5jt9gpoUtW7HFwBaMHo
         bBOQ==
X-Gm-Message-State: AC+VfDyNeQEUeK9N5RABgY6HfiqTPnNzXNaRZ5Ji872vWxRKkNZ5G9aD
        oz0AjNc1WoBBVxyoxn79STI=
X-Google-Smtp-Source: ACHHUZ4r2RFmZkxtfknvOyKXIHfIO7asWw+HWG/qoaFSt4TAG+YZEBJRk36LbrCdJ/zks7FSju4npg==
X-Received: by 2002:a17:906:7794:b0:965:9c7d:df96 with SMTP id s20-20020a170906779400b009659c7ddf96mr22113326ejm.1.1684001338815;
        Sat, 13 May 2023 11:08:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935e01.dip0.t-ipconnect.de. [87.147.94.1])
        by smtp.gmail.com with ESMTPSA id ka11-20020a170907990b00b0096602a5ab25sm7041150ejc.92.2023.05.13.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 11:08:58 -0700 (PDT)
Date:   Sat, 13 May 2023 20:08:56 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] staging: rtl8192e: Remove functions rtllib_start_hw_scan
 and stop
Message-ID: <868524470321b8936f63d3ea06ba86c34fc89bb7.1683960684.git.philipp.g.hortmann@gmail.com>
References: <cover.1683960684.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683960684.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove functions rtllib_start_hw_scan and rtllib_stop_hw_scan as they are
not defined.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h         |  3 ---
 drivers/staging/rtl8192e/rtllib_softmac.c | 21 +++------------------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9b49a15de889..aac71fda4541 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1688,9 +1688,6 @@ struct rtllib_device {
 	 */
 	void (*set_chan)(struct net_device *dev, short ch);
 
-	void (*rtllib_start_hw_scan)(struct net_device *dev);
-	void (*rtllib_stop_hw_scan)(struct net_device *dev);
-
 	/* indicate the driver that the link state is changed
 	 * for example it may indicate the card is associated now.
 	 * Driver might be interested in this to apply RX filter
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index fe36a52b4c91..bb28414b88bc 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -691,23 +691,15 @@ static void rtllib_softmac_stop_scan(struct rtllib_device *ieee)
 
 void rtllib_stop_scan(struct rtllib_device *ieee)
 {
-	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN) {
+	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN)
 		rtllib_softmac_stop_scan(ieee);
-	} else {
-		if (ieee->rtllib_stop_hw_scan)
-			ieee->rtllib_stop_hw_scan(ieee->dev);
-	}
 }
 EXPORT_SYMBOL(rtllib_stop_scan);
 
 void rtllib_stop_scan_syncro(struct rtllib_device *ieee)
 {
-	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN) {
+	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN)
 		ieee->sync_scan_hurryup = 1;
-	} else {
-		if (ieee->rtllib_stop_hw_scan)
-			ieee->rtllib_stop_hw_scan(ieee->dev);
-	}
 }
 EXPORT_SYMBOL(rtllib_stop_scan_syncro);
 
@@ -739,9 +731,6 @@ static void rtllib_start_scan(struct rtllib_device *ieee)
 			ieee->scanning_continue = 1;
 			schedule_delayed_work(&ieee->softmac_scan_wq, 0);
 		}
-	} else {
-		if (ieee->rtllib_start_hw_scan)
-			ieee->rtllib_start_hw_scan(ieee->dev);
 	}
 }
 
@@ -753,12 +742,8 @@ void rtllib_start_scan_syncro(struct rtllib_device *ieee, u8 is_mesh)
 			RESET_CIE_WATCHDOG(ieee);
 	}
 	ieee->sync_scan_hurryup = 0;
-	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN) {
+	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN)
 		rtllib_softmac_scan_syncro(ieee, is_mesh);
-	} else {
-		if (ieee->rtllib_start_hw_scan)
-			ieee->rtllib_start_hw_scan(ieee->dev);
-	}
 }
 EXPORT_SYMBOL(rtllib_start_scan_syncro);
 
-- 
2.40.1

