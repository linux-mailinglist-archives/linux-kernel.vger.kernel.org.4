Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53B7277D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjFHGwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjFHGwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:52:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73392198B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:52:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9786c0cbfdcso5393666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686207141; x=1688799141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FG5d29CrGVCy3fwMc6JWla5/4zbh1hMHL9JL7ITCxvY=;
        b=Z1REewAzAWNqwGy1u0+Mjb+fOCd85z11Q3TOJhkkjdpfZHb431yp0QYK8gguNeMJEq
         ZHgOmt3e+xrJeWxRRke3QlTMOPt8Si4qi8Gj4GNqRJErQ7+FXZ5puwXOwub3oulYUoaB
         mxDoVVqTALWIyo8UKFbK8WSN+Z4nAEPp8quJL6ChVLoaJGTbK59o5cf+0mtQLJxjQytm
         /8hJwtNtFHE5Cz1kwTI5HWokiDRyCTi0OvrzxuVG//cBZyE2R+07i9i2LKVCyVGY2ZvH
         NqoOzK9VZ26mEJlg0ba2VYiYbCRm4ql5F4nSuom9SCZXuHTDD2Yrf+D9omgEDwc4atGW
         YngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686207141; x=1688799141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG5d29CrGVCy3fwMc6JWla5/4zbh1hMHL9JL7ITCxvY=;
        b=eIzL82B4sIoD1kIHirKdJZNOBE5ByDbDNLPrqDgSpjQQHLZMYfqPPoQdfdPw/5ywmb
         SCwKX6rzhKjr1l75nuUZFYZdo/7MxTjMXwWeXxfz082Aa8adcE/0lwni0i96W6PgmaH5
         lE8nR6T1PzeD8RriTpqG+ctVwrP3nJUjNM2ek3wQpIZtEgwnU2or0L9gKZ6RX/5xx+ol
         RmZNHfQJuE9/PY6UDjR0ZbSJLQ0/3xVYkgpF/3Hr7jNlTxqrwEJeYb0LKnQQEm4p50vp
         M/qFgyHGZ56/1WoxNoqqXvnNJTWH09euDPiUxl2Od/puuYApwOiY0qnL92XFW8S38m/D
         1iJw==
X-Gm-Message-State: AC+VfDyG6qWLZjJ5x4rBHGixOvFAPTf2HDTOMxYKtXh/TowusHmqIEr/
        p2psRQra1xBQRI93QVrrpZ8=
X-Google-Smtp-Source: ACHHUZ6RuYcjwjN7cv5K/wAtu8Nflib2VSPcfswegxfDvNW2dWFqUe4GJOKa4jsmuFU+VEz8RQbgKQ==
X-Received: by 2002:a17:906:649b:b0:975:c046:dd34 with SMTP id e27-20020a170906649b00b00975c046dd34mr6680233ejm.1.1686207140631;
        Wed, 07 Jun 2023 23:52:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id r10-20020a170906548a00b009788d99244csm286858ejo.149.2023.06.07.23.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 23:52:20 -0700 (PDT)
Date:   Thu, 8 Jun 2023 08:52:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8192e: Use standard api to calculate
 frequency to channel
Message-ID: <fc332e81f6677965e9e51f1fcef9815997effcb5.1686166624.git.philipp.g.hortmann@gmail.com>
References: <cover.1686166624.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686166624.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ieee80211_freq_khz_to_channel() to calculate frequency to channel to
omit proprietary code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested this code with separate debug code as this part is usually unused.
---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 78a70e5f1974..6fd2e94d5f8a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -42,15 +42,8 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 	if (fwrq->e == 1) {
 		if ((fwrq->m >= (int)2.412e8 &&
 		     fwrq->m <= (int)2.487e8)) {
-			int f = fwrq->m / 100000;
-			int c = 0;
-
-			while ((c < 14) && (f != rtllib_wlan_frequencies[c]))
-				c++;
-
-			/* hack to fall through */
+			fwrq->m = ieee80211_freq_khz_to_channel(fwrq->m / 100);
 			fwrq->e = 0;
-			fwrq->m = c + 1;
 		}
 	}
 
-- 
2.40.1

