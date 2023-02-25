Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1486A2B47
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 19:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBYSUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 13:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 13:20:35 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC414EC43
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:20:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so4454465wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677349228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnW67Brym0rTte3s6ZMNuvgQG+ROp2tdxsefdMGNTV8=;
        b=NZhcDZDfytB893Ktd/pgFJyS5ahFaO1+D8YiuVboSS1NRtFIFqvC7NbTVO26Poy9vh
         aKJsl3ZroXTJW48lFFMibRguc0s5hXa3w9361UGaKcAvq9UeijVYp4biKlP20EzyIMLn
         erVJYuvHniXd+e22QumfXwggItsIJYK1GN+Nl6esitBjv/F8Zl00uUFIPPopAmXQYN9g
         OUFysrssZYjk+GJHqVLUJ1VcspDApi0OyubNVRgkW4EeOWj1nqmY/UVp6tIm1zRrJvPf
         0opy3U6HIPCBLS52fQErc4Gs8axo/XkaNj9LkdhU0jz6pJor5xu98i3eSPwUquE0DhrH
         cDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677349228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnW67Brym0rTte3s6ZMNuvgQG+ROp2tdxsefdMGNTV8=;
        b=GU+CUUp//HEcUgYrk0HCf2c2yENociHmlR+RlSRKvOYXScZDmbitmzfAYXB505u6r2
         idaHXibRUF2hw8tv9/wsiZ/sxVa06qTKBtUmYkVrkul01YjHqmmuvqTsqFMdzeAJhOf0
         vftkUsudDYeh0wP8ESiSfMc5asQJve6+6enyu5IMM5Hoxwy9GjrFtsVQKxgMcFRZCo+y
         KDmSsJXTUZSHHbD/xZDwVhz9Oca1+1OeERBMWsYudbEYejzDYDhb6aLKxr2D3AJrucs8
         tGdgkOktnIjPSRCvO+bXJ8du8BFfwFf8BxNVg3gAnL4dIMRXi38VmA05pXMQpoaKepqC
         LTdg==
X-Gm-Message-State: AO0yUKXJLudpJH+8TOMe+r0GbccTBNOhrcP+IM1pI+wCCckRRCguu3zi
        xX1FjUbwGzkdcQ6UCDtrkSw=
X-Google-Smtp-Source: AK7set//DJNiYuqmzRGc0wVCg3vVA36d1USP3IqRtTSm1hu14l4IsefYh2k1ElXOxwCD08PiWjeFtg==
X-Received: by 2002:a05:600c:4f4e:b0:3d2:231a:cb30 with SMTP id m14-20020a05600c4f4e00b003d2231acb30mr18386165wmq.3.1677349228365;
        Sat, 25 Feb 2023 10:20:28 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ja6-20020a05600c556600b003dfefe115b9sm3486834wmb.0.2023.02.25.10.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 10:20:27 -0800 (PST)
Date:   Sat, 25 Feb 2023 19:20:26 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: rtl8192e: Remove checks of pointer to
 handle_a.. and handle_b..
Message-ID: <5c0fd114c24616bc03271ccb0a72a6bc68e45d61.1677345331.git.philipp.g.hortmann@gmail.com>
References: <cover.1677345331.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677345331.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function pointers of handle_assoc_response and handle_beacon is set while
executing the probe function. Therefore a NULL pointer check is not
required. Remove checks as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c      | 4 +---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 669e74a67190..35b36f7c0f28 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2689,9 +2689,7 @@ static inline void rtllib_process_probe_response(
 	    is_same_network(&ieee->current_network, network,
 	    (network->ssid_len ? 1 : 0)) &&
 	    (ieee->state == RTLLIB_LINKED)) {
-		if (ieee->handle_beacon != NULL)
-			ieee->handle_beacon(ieee->dev, beacon,
-					    &ieee->current_network);
+		ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
 	}
 free_network:
 	kfree(network);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 2552aa089700..d697089e0cad 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2241,10 +2241,8 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 				memcpy(ieee->ht_info->PeerHTInfoBuf,
 				       network->bssht.bd_ht_info_buf,
 				       network->bssht.bd_ht_info_len);
-				if (ieee->handle_assoc_response != NULL)
-					ieee->handle_assoc_response(ieee->dev,
-						 (struct rtllib_assoc_response_frame *)header,
-						 network);
+				ieee->handle_assoc_response(ieee->dev,
+					(struct rtllib_assoc_response_frame *)header, network);
 			}
 			kfree(network);
 
-- 
2.39.2

