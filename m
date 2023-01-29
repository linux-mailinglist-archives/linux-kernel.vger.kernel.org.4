Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF167FFA7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjA2O6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbjA2O6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:58:41 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01F18AA9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso6527365wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMDHyvlfs7O/f9b0aUY8Mk44RRiJoj0uuEZqCuWERA0=;
        b=U8qeYGmLBlCJYcOTVLISYohR2qxsDZ1bIGwMgo+ozYZisTCvdpTSOb+t/WMHoRR1xR
         CIu0lhxN1GyLL7Adix2Na+kt1XMA9UWCiplJwRRzK1eHOw4SDJZxltOzFu7nwTMF8JDg
         U/nY34BrQ9N4EQKCWyd0xYNUGK4DOoY2Mu0jwnROimBUWeGtEbde4p8e0RWkeSADfiOL
         j6ve/Q1cwndyr/rS3VI5Qe5GWqY31T0es+MlK2mTSsDjoGuqu4tNTsh8H9DnHWuUhaaL
         7FkJQyxSuTJUfTQFnrmcoPHlsQW2o78Od9icSoPJG6H7aMKfJcsUw6P8ydjUOAHmKfYK
         W+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMDHyvlfs7O/f9b0aUY8Mk44RRiJoj0uuEZqCuWERA0=;
        b=UbVCqNb4fBN7TnNqJKJEo1HurgQJx7/suI9TCYHYFIyAg8+VFzyn2Wz7ln2Op81KBs
         He4CTEiHvp59xDPlg/BUKk7bYDZ/wCoL0UWJzLQRWYmPT9R8BTYmsccsYmZUtmyPyEDO
         rhNZ992uuhBn0o2COY8ecZFZfQtsqT4BTyMZSWp7NMvbNvow7zK/YJMn6lKjivIdNNkK
         WoAAuhnoCZY0BZpZLYWBqUjiiFiTzx0FfeYqfiIZ/HNxSDC+rg9IMFgRhrUi0m7cxX1A
         uQhlt7RguNAxhSlxWvXE1LZXUN5LFPSxIxPBoksFLjNyZEIPt8SJBspOzWal+PhiNNHC
         xcew==
X-Gm-Message-State: AFqh2krPM1F7TRScJ82j1ZyfNObaxJBC0PzZxHguO8dy+AJfl07btaiu
        a3KR4B5aNRX94nQfmb978uaWcKhgqmw=
X-Google-Smtp-Source: AMrXdXvYTZTjqlLz3EJJYwiJBw9BoA6b3l1bQ66eqnoy1Om4WnKvjoucU/asJUo8sN+ZGPDRUKzO5A==
X-Received: by 2002:a05:600c:3b85:b0:3db:35e3:baf6 with SMTP id n5-20020a05600c3b8500b003db35e3baf6mr8664147wms.4.1675004303614;
        Sun, 29 Jan 2023 06:58:23 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c44c700b003d995a704fdsm10008658wmo.33.2023.01.29.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:58:23 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:58:21 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Remove unused constants from enum
 rt_customer_id
Message-ID: <108d80f0ae1006b716205dce0ca9a7ee597ba1dd.1675003608.git.philipp.g.hortmann@gmail.com>
References: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused constants from enum rt_customer_id. A part of the constants
would need to be renamed because of CamelCase.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 22 --------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index d0c88d68b60b..17fc69c839d3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -145,35 +145,13 @@ enum rt_rf_type_819xu {
 
 enum rt_customer_id {
 	RT_CID_DEFAULT	  = 0,
-	RT_CID_8187_ALPHA0      = 1,
-	RT_CID_8187_SERCOMM_PS  = 2,
-	RT_CID_8187_HW_LED      = 3,
-	RT_CID_8187_NETGEAR     = 4,
-	RT_CID_WHQL	     = 5,
 	RT_CID_819x_CAMEO       = 6,
 	RT_CID_819x_RUNTOP      = 7,
-	RT_CID_819x_Senao       = 8,
 	RT_CID_TOSHIBA	  = 9,
 	RT_CID_819X_NETCORE     = 10,
 	RT_CID_Nettronix	= 11,
 	RT_CID_DLINK	    = 12,
 	RT_CID_PRONET	   = 13,
-	RT_CID_COREGA	   = 14,
-	RT_CID_819x_ALPHA       = 15,
-	RT_CID_819x_Sitecom     = 16,
-	RT_CID_CCX	      = 17,
-	RT_CID_819x_Lenovo      = 18,
-	RT_CID_819x_QMI	 = 19,
-	RT_CID_819x_Edimax_Belkin = 20,
-	RT_CID_819x_Sercomm_Belkin = 21,
-	RT_CID_819x_CAMEO1 = 22,
-	RT_CID_819x_MSI = 23,
-	RT_CID_819x_Acer = 24,
-	RT_CID_819x_HP	= 27,
-	RT_CID_819x_CLEVO = 28,
-	RT_CID_819x_Arcadyan_Belkin = 29,
-	RT_CID_819x_SAMSUNG = 30,
-	RT_CID_819x_WNC_COREGA = 31,
 };
 
 enum reset_type {
-- 
2.39.1

