Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E602773C707
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjFXGEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjFXGED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:04:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250CA297C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98dfd15aae1so888566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586631; x=1690178631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPxvnhxhJrxYQ+szNx981vwj+0UhmdrYLXnjA4eHd9w=;
        b=NW/V7+dkAZWNsRIB5v+CzAsjlEk+bOu5bPPqEvT75+wck6D67qrPfscAv9UsQLpMZX
         6dWnww48IaiSx2UBs9+0LxPbxyR28p3cXH70YyNpX7ow+iirF0FFubICIvdP0GiYAmbs
         yQYd55OVYJPsptiaFA3RUv97WqEBe9jMnsNaBlaioFc+sJEnJcuzmQ2ww1e0xLko5FR4
         aiNfQPVYu/I6ZZbB1Z36RlXDsYJb7F3cbRazmaC0QyWUkAesRHrSu9zTG2G8Djjh8Iuv
         O/n1gBXPEYvbVrJ7QW73wT1dTbk5T6zROpU9HxmD1+D5EQqRbpIEihcmY9bME0mruYAD
         ohLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586631; x=1690178631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPxvnhxhJrxYQ+szNx981vwj+0UhmdrYLXnjA4eHd9w=;
        b=j1rNRW3dDvIZaSbVhkTUb8BBTSQT5Gfxzeadz6nSAY0m+js57ak6i0HI3h0HJKbeYS
         DnIx1DaUrTjqev9nt0YcGTr3GA20FCac9OI8yDk8dRnE8SdbQfQ0F0LT4fYmBOW3QMsp
         oYUIaGm2v1AgoyLR/CoYVsHq6Rr/dmwHswYdOGw3mNuPQbKX8bfaqapkTcdy+9jGZqTK
         n4TF/XbBKc6+BBX0p+UjVDKV4eNSHr30dDZPGE8fsd99hFo/sjKX1sIIKopI4fY7TjZB
         nq2Ra1E6K4t0z6/Dp5z0R2FefyirhnrANf5V8UD4WXFhMzfMmD3EAhJtn8/LUQ5fJBSt
         8yiw==
X-Gm-Message-State: AC+VfDz2BBqqygaJqa89h+Cv07A/NAQBGiHts01kuvEyYneUKa/L3hSe
        q/EjbJh6wKOQKDn560twuFE=
X-Google-Smtp-Source: ACHHUZ5sI1TORPiu+bHb7Aa76JMJi1rjhMXe+VH3We2PdUY44KfBNsm99TOERTfZLeqbmMPZSLW1hA==
X-Received: by 2002:a17:906:779c:b0:988:815c:b9fa with SMTP id s28-20020a170906779c00b00988815cb9famr13169095ejm.3.1687586630810;
        Fri, 23 Jun 2023 23:03:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906841300b00988d0ad4477sm503594ejx.29.2023.06.23.23.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:03:49 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:03:45 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: rtl8192e: Remove unused timer InactTimer
Message-ID: <1a7acdd76037327602858a8634d502b46cdc8786.1687583718.git.philipp.g.hortmann@gmail.com>
References: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused timer InactTimer and all the resulting unused code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_TS.h     |  1 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 75ee2056d361..0e851d4221a7 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -19,7 +19,6 @@ enum tr_select {
 
 struct ts_common_info {
 	struct list_head		List;
-	struct timer_list		InactTimer;
 	u8				Addr[ETH_ALEN];
 	union tspec_body TSpec;
 	union qos_tclas TClass[TCLAS_NUM];
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index ed124f85c2b1..7fff20b185f0 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -8,10 +8,6 @@
 #include <linux/etherdevice.h>
 #include "rtl819x_TS.h"
 
-static void TsInactTimeout(struct timer_list *unused)
-{
-}
-
 static void RxPktPendingTimeout(struct timer_list *t)
 {
 	struct rx_ts_record *pRxTs = from_timer(pRxTs, t,
@@ -138,9 +134,6 @@ void TSInitialize(struct rtllib_device *ieee)
 
 	for (count = 0; count < TOTAL_TS_NUM; count++) {
 		pTxTS->num = count;
-		timer_setup(&pTxTS->TsCommonInfo.InactTimer, TsInactTimeout,
-			    0);
-
 		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
 
 		timer_setup(&pTxTS->TxPendingBARecord.timer, BaSetupTimeOut,
@@ -160,10 +153,6 @@ void TSInitialize(struct rtllib_device *ieee)
 	for (count = 0; count < TOTAL_TS_NUM; count++) {
 		pRxTS->num = count;
 		INIT_LIST_HEAD(&pRxTS->rx_pending_pkt_list);
-
-		timer_setup(&pRxTS->ts_common_info.InactTimer, TsInactTimeout,
-			    0);
-
 		timer_setup(&pRxTS->rx_admitted_ba_record.timer,
 			    RxBaInactTimeout, 0);
 
@@ -187,7 +176,6 @@ void TSInitialize(struct rtllib_device *ieee)
 static void AdmitTS(struct rtllib_device *ieee,
 		    struct ts_common_info *pTsCommonInfo, u32 InactTime)
 {
-	del_timer_sync(&pTsCommonInfo->InactTimer);
 }
 
 static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
@@ -379,7 +367,6 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 static void RemoveTsEntry(struct rtllib_device *ieee,
 			  struct ts_common_info *pTs, enum tr_select TxRxSelect)
 {
-	del_timer_sync(&pTs->InactTimer);
 	TsInitDelBA(ieee, pTs, TxRxSelect);
 
 	if (TxRxSelect == RX_DIR) {
-- 
2.41.0

