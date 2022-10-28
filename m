Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96386109A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ1FOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ1FOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:14:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD46BCA1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:14:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so2892885wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8Cl50GxiFHirgjeWPOfiswX2gs4Kajn64w85/PEn9Q=;
        b=aNZyiFu8QyAiNdVys2tpGzR/2lt6NUhGjCrNITFwiS+dPB5Gn1gx+YNA5KyZ/qOmYR
         Wq2uUP33O6D5zmrCGfYuRXnySKEucM1rAyvYMAkkxnKLXujmSwgSu0U80zwzAV8FsVYM
         A/5Y8maP6T+c4mcNrd55u+0xiUjtDrfIIASSnjSHmRT+YsNGCAn2w3zSqDqqJh5UDxNE
         kAm6FhaWx7DKLbR46mya/kdBgj9HSjpzNODjfuVRAAvEcqetMRym80Dfns/svvHJkKcv
         Cni4dCzTzXQ+T2+34lOGMlprcXyOUX6WcM4bcPdKM6lrgC0KKD1sKfj3KfI9nVzOhFDt
         I2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8Cl50GxiFHirgjeWPOfiswX2gs4Kajn64w85/PEn9Q=;
        b=GjSefIE1Gxq1BZE1w1i4M75VpUTqydBLnDJn5dQd90I/tw0ZY2DRFn9YotYJG2dBZI
         yehW5B7t8Ud0SmA1TeZF9/bqU8GcpP8et+DjaaDlMUvFBv3AkEyW0Zigxk3w7DKmyp3w
         VtWz2Ta7QzTqt4N6++4IeBlZUriKgqkVRnMkWbIwWnLYEW3BhnwWRzDC30iRt8UK+vi0
         mkJ3+TOHsyCtE0zmxjVlE0IuA/Ti3hYkYNsj7oKySarZn6VB21vubdKS6RQTmZiU8HIG
         e+u6wD41ROWYC6W6jstceqdjXQZHXUOMR6aCaCALSxT8JxO87P1jag8DDyiWBBkyREpE
         59ZA==
X-Gm-Message-State: ACrzQf2MILsJ6zVSOxlgpxeIcgAh3fVfgaTjTmW4coe3bsbKLO87Rc5O
        w3xOIDMokfTE5X/z5zOTU+M=
X-Google-Smtp-Source: AMsMyM622kSlxG/TIpcADNn/5SRSeYeEfF7kG7yWa7pmhzooVofXyimagOAy9qY+BBWtZxDlj97SRQ==
X-Received: by 2002:a05:600c:46c7:b0:3c6:f3e6:1f13 with SMTP id q7-20020a05600c46c700b003c6f3e61f13mr8040409wmo.62.1666934070110;
        Thu, 27 Oct 2022 22:14:30 -0700 (PDT)
Received: from rdm ([41.75.189.203])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c5457000000b003a601a1c2f7sm6357483wmi.19.2022.10.27.22.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 22:14:29 -0700 (PDT)
Date:   Fri, 28 Oct 2022 08:14:20 +0300
From:   UMWARI JOVIAL <umwarijovial@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH] WARNING: Possible repeated word: 'very'
Message-ID: <20221028051420.GA30073@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i used checkpatch.pl script to identify the above
Repetition of the same word in one sentence same line

Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 090345bad223..30a0276b8b58 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -766,7 +766,7 @@ void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
  * If we turn on USE_RXTHREAD, then, no need for critical section.
  * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
  *
- * Must be very very cautious...
+ * Must be very cautious...
  *
  */
 struct xmit_frame *r8712_alloc_xmitframe(struct xmit_priv *pxmitpriv)
-- 
2.25.1

