Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06066CB04C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjC0VDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjC0VDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:03:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8069D170B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:02:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so41550123ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=see/tMyHGeTFgBe28oR3fGtGcVzBX17DM6QeEae9PEI=;
        b=BG69Ctf4CNtfGm8kdwx+9G6WIIW/befZ3ZVOM/QeD5hvSR3antuakGaqq2NTuVmJ8e
         d0Rmyp4K2k3jI6RZ2IHOmBfSPxEvKduNGj2DQw0jSBNdvdO1iOyrUpFA5XHs/U3UvU8D
         gwrsysopPs+742PPmU1wjOD5k2a3VL+DN85U0tVSPM22l5KhV0Kyd8CKfz0zv+2wPRLP
         K5iYQKDbxlijmyYdTEtVEEDIorFbmn1tpueO8Kl+yLxfC3mmpiNzz6HnZjkRfdwWJ7RT
         nEFBQreByWdb/lSYdhIxLkFC8MX2qIM9pCJuvJY4vkuMBMh0x28oqvW0M4Dq8a0Z6EYW
         dTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=see/tMyHGeTFgBe28oR3fGtGcVzBX17DM6QeEae9PEI=;
        b=F0u7AacJz4OiEOCI8nEYhmWjOE+K94CNcO/myIWq5zWkE4jZK0gI6IEim/BHyQIULj
         pg5lv0/8wNSgq5Co9xtMKgZOCb41SpglG75c9Zkm/UDvBg1CWbUb5nkX7Fsxbn1eKerU
         mb8qNiYwNEa5Gj0SSrpptP849O5brYY9aKA3rakbw/n4a75RzTX+wCfTlZr4teyzKsHu
         V9cCcN7XYVZZKNRHZmuwHIY2AM+eods+mG1aSNv+rut3YNNl/WKNb7qvEiGdWqoM6pkD
         RErNbUaChRmZOMSCPt6/BGNt5zh4K8qnpCvX7dCE+y+OYUzr+N2TuVf0Svlb4xsgXZ/4
         vSHA==
X-Gm-Message-State: AAQBX9chbB0aYmFSWuW99p1Ekrqs2v0nwiL10IKYTgV9vqYYIVJoHKBL
        Gmw+DithfD7h5c+nm72GeFc=
X-Google-Smtp-Source: AKy350ZavlmG7gd+4zStA4EziPmcCI0rvw37VH+lsJkeS+LrOMdkfot21hPRD1uMPmvzYytDFGwz6Q==
X-Received: by 2002:a05:6402:3490:b0:501:ea97:519c with SMTP id v16-20020a056402349000b00501ea97519cmr15032395edc.4.1679950976977;
        Mon, 27 Mar 2023 14:02:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id a18-20020a50c312000000b004c06f786602sm15085330edb.85.2023.03.27.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:02:49 -0700 (PDT)
Date:   Mon, 27 Mar 2023 23:02:37 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging: rtl8192e: Remove
 _rtl92e_get_supported_wireless_mode
Message-ID: <f8470fff23d5870cbcda3d6f4978ba17016a8fe8.1679949171.git.philipp.g.hortmann@gmail.com>
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

Remove _rtl92e_get_supported_wireless_mode to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ecc3f0c6c267..12e5132fa788 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -593,18 +593,10 @@ static void _rtl92e_refresh_support_rate(struct r8192_priv *priv)
 	}
 }
 
-static u8 _rtl92e_get_supported_wireless_mode(struct net_device *dev)
-{
-	u8 ret = 0;
-
-	ret = (WIRELESS_MODE_N_24G | WIRELESS_MODE_G | WIRELESS_MODE_B);
-	return ret;
-}
-
 void rtl92e_set_wireless_mode(struct net_device *dev, u8 wireless_mode)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	u8 support_mode = _rtl92e_get_supported_wireless_mode(dev);
+	u8 support_mode = (WIRELESS_MODE_N_24G | WIRELESS_MODE_G | WIRELESS_MODE_B);
 
 	if ((wireless_mode == WIRELESS_MODE_AUTO) ||
 	    ((wireless_mode & support_mode) == 0)) {
-- 
2.39.2

