Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE86E3598
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjDPHTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjDPHTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:19:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FB30F4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:19:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so7960985e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629580; x=1684221580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84NlWGtUMgf40JNxMvQY6Sfwnuh3njHwFcbtsfdQMSc=;
        b=baquszBwmPrlDFk14HOGoFLBYnJ8GutC9P6PTy9dNwrHXIOExXawgkl4+vt6botSZ+
         X3DRzeK/Nbcw6ipzV1cpix1CJ+NtxglQtYVg9C69KxGAtSQdT02w6ERn1HYd4ZUxZVJg
         6/EkfPjFWgdo6X8MHnAUj6WPfcbtt3gVWQLBGYVxRYTaxyFeQ5iqZhb7cTdngIJS1SL7
         yiF/gDWeHOBQ/fxOER/RiBqOCgDt21eFwjGq80ZXKEBWG4VrmvEm8cVrMmkarz2kKGVv
         Gi/2bf8z/aKRTIDNL44UYCyQX6z5VckAq0gIesHdaNyAGjKs7U8gplKpRqZdoJmDNByQ
         6adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629580; x=1684221580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84NlWGtUMgf40JNxMvQY6Sfwnuh3njHwFcbtsfdQMSc=;
        b=S0I/CzHgJeOiYOLY16HhVh+rtJPsm91hdDPpWVlePcr9KMPuu7zzE+I75GL1ffv+G4
         LGkrtlo1O1NV5DQH90zWsK6XfmvJEf5re6+OMEI+gzA2JTGoAmvHH3lBEVw2hRVISpEb
         6H7ufkn7BK30xO+mfS+8szIA4kqmabRAzm24QNX3ncwzJ93FP1R73bhM7xcOS0JwO2hy
         huykr2xQnWQOd+MNwDVO/bXFhnepPc/MXTPdm+fq1wVt1/nyfZBSOLSDMJH8HjQ4Sz42
         sf4WLL8naRidbTT3Kta8LPo19rlKXBxMc276tTtH0pV3HpNS3SD0iS9izqai3ONs559A
         2N1w==
X-Gm-Message-State: AAQBX9dllpYGnPm7g0JGQtsQswYmJiFdlUb9XwUlKKCEwZK+2jjk088G
        x1YU2m5KfhHK0Loun1s0zvSeiOXMtYA=
X-Google-Smtp-Source: AKy350ajWbbs61CS1wNRJpRYmnlvV7z8rtabuEracPKp0K7hShoagQm2PVqwvmDaM3zbY/BZGmto7A==
X-Received: by 2002:a5d:6281:0:b0:2ef:9699:f906 with SMTP id k1-20020a5d6281000000b002ef9699f906mr4633502wru.7.1681629579682;
        Sun, 16 Apr 2023 00:19:39 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003e91b9a92c9sm8567755wmk.24.2023.04.16.00.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:19:39 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:19:37 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: rtl8192e: Remove unchanged variable RegRfPsLevel
Message-ID: <49162b0041db33c6c43c4126839baed69c76cb89.1681627603.git.philipp.g.hortmann@gmail.com>
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

Remove unchanged variable RegRfPsLevel and equations that have always the
same result to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 9 +--------
 drivers/staging/rtl8192e/rtllib.h              | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index dd666701138e..4b0ebe96302e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1089,14 +1089,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 			if (i >= MAX_DOZE_WAITING_TIMES_9x)
 				break;
 		}
-		if (psc->RegRfPsLevel & RT_RF_OFF_LEVL_HALT_NIC &&
-		    !RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
-			rtl92e_disable_nic(dev);
-			RT_SET_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC);
-		} else if (!(psc->RegRfPsLevel &
-			   RT_RF_OFF_LEVL_HALT_NIC)) {
-			rtl92e_set_rf_off(dev);
-		}
+		rtl92e_set_rf_off(dev);
 		break;
 	default:
 		bResult = false;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b1729d65f67f..1a0e7ae70ca6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1237,7 +1237,6 @@ struct rt_pwr_save_ctrl {
 	u8				LPSAwakeIntvl;
 
 	u32				CurPsLevel;
-	u32				RegRfPsLevel;
 };
 
 #define RT_RF_CHANGE_SOURCE u32
-- 
2.40.0

