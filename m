Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334EF6E359C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjDPHUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjDPHUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:20:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EBF30D8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:19:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f167d0cbb7so1330225e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629594; x=1684221594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwqobIGOuNNlDjWDqP0aoWUSzuDynHZFKSCMK2X1W5s=;
        b=MS/9uKs70i2Y0OM91fP96hPnooh51wKOYR5q7O5FvAeHvt655iTNAegCBM1Ui5KHEV
         +z94oAHtcUPe8k0yJ/pTt5aaHdfPIc4bjaVuVLUhAB/WiOK/VsLBZHdrH99eqL4XRDE5
         GVCrcc7QXkWpXNB3Io3SBgSxWQK907xsxRYcxt0XdfQSQZv5ZdBKoRd15y3/wuMnc4/G
         znizZcWO8/kEzdAt4qgSy/YB43NEqoJOZc5cYS3XhO8/Iz/dpD3/M15iyKBpB7YyalFD
         O+caYr2XaXzdpHMOHWfVvw/Z58cqsAqcYtzMEJIt8XAp9F+LY5trPSVCpLA6OYLmLRxi
         inVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629594; x=1684221594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwqobIGOuNNlDjWDqP0aoWUSzuDynHZFKSCMK2X1W5s=;
        b=Ead2baW1cKOpSLbJBuabwibMDm5cqx59v56yI6CCHXuY4kHASFH9llh16miezaAEB6
         BGUdEnFlUeVDaA0i0WSGBR2u2gPKK8mxaHdCmprT3mKqIvtAQd30Z+3aLazRebe7B/ko
         /gtJ4FETFoyUSulaJCP+bcPKSwLj5PG4+ZD+AXxT+tdEItTNiDHlejowY8PgV1iaujg1
         4NAtD5okN7dXMF8JxqhZa01U8lvZc60evg8JDQ5868XYD9E1wYUDRUUgSjUW8iZS3W7i
         oFiG34OZKsJr/1TncxIDQBMoa5OT1GwttGAGg31Kv8zrNSFqvMW1zlqUyKeopMr1yItg
         8+Yw==
X-Gm-Message-State: AAQBX9fyjrcOGstq26/MJ5Jnl318o1JRwzk37J+RSbzebTREjeZgkFmz
        e512lN83+2vYpZ57ueucrBXXihha9lw=
X-Google-Smtp-Source: AKy350Z/+ex1LitSfEe3lLjtUEoaf67Zo88uq8SYG3OMeuLLafoRZBqhesiGEu3AZyjPPElo2Y3O6A==
X-Received: by 2002:adf:fc8b:0:b0:2e4:ccb1:dba5 with SMTP id g11-20020adffc8b000000b002e4ccb1dba5mr4415020wrr.4.1681629594654;
        Sun, 16 Apr 2023 00:19:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y18-20020adff6d2000000b002daf0b52598sm7427281wrp.18.2023.04.16.00.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:19:54 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:19:52 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: rtl8192e: Remove unused macro RT_SET_PS_LEVEL
Message-ID: <0d397210830f77ad3231c3b4a0465ae89aacb962.1681627603.git.philipp.g.hortmann@gmail.com>
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

Remove unused macro RT_SET_PS_LEVEL to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1a0e7ae70ca6..6e665e866f1f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -100,7 +100,6 @@ static inline void *netdev_priv_rsl(struct net_device *dev)
 	((psc->CurPsLevel & _PS_FLAG) ? true : false)
 #define	RT_CLEAR_PS_LEVEL(psc, _PS_FLAG)	\
 	(psc->CurPsLevel &= (~(_PS_FLAG)))
-#define	RT_SET_PS_LEVEL(psc, _PS_FLAG)	(psc->CurPsLevel |= _PS_FLAG)
 
 /* defined for skb cb field */
 /* At most 28 byte */
-- 
2.40.0

