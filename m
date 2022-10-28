Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF88610AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJ1HFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJ1HFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:05:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F33638ED
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:05:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v1so5738273wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4A+DB3MMGxIRPCuM9r59RYr1Fl7TwCHgwudqyCCvsC0=;
        b=X294my3GunzaICmgTrsU5fOQP4WGX6lg1uHXMpulNUGBlU11/LtC8FNRtLxr3Y3Zv7
         9aN70wl6eX+0Mudq38kmx4VGAh3AsTniBCfoYNjOUxXUNwGV6HX6bphNBpQCAAywPE8w
         hyOd8KlFCbkdd9zetRvsEVqyc4PDtLleWAWhMQorQhbNbfH8jjL7wi9Hx6YmatDQ2I20
         eTmuDGvCYkcJJYGVl53k/cYGcyKE94Zkw0Iw3eY9OJkaGqy0kj4+3coc55mUeZqYGlIF
         JuRnX6cxoBpZt+ekJhL/meC7aE3GoEw4UfSYq4mUihWrQuHjZNjtW3ggymJHvrYQuFKa
         c24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4A+DB3MMGxIRPCuM9r59RYr1Fl7TwCHgwudqyCCvsC0=;
        b=s3UVPf7Vv7ODpwV8gXiuNlauqZVTEVwMwobbb6OAJgB05WyE64QvC1qj0SQGUFrzES
         /d1f4aJba08p3IgXw9r1ujs5+ERtAopnEdyPEuHRqHEKHfYCj4W+ZVVoEqkliLXkge0H
         BK6MdAsjQlV2nXST/04JGgI7ETUZDbkoy1oAruOdYdzYCHgInsXpOgtasrGg71uyoZFS
         8QElTyKc+7wAXgIRHDXD27T6mlgnUU/Qi1EiBvwTbwP7qMVGHvw/NVVIJkNOoYgstWFT
         MZWuPoLWSSUsLi0dRVnJuaDzUAlOjqZ0imZU27KxXJ6YcKY56eVHpFFdXFrgn2SF9UZN
         Uyag==
X-Gm-Message-State: ACrzQf0wqkBVHaDOD9ghG0te8GkCNNGhrbfZXHUygS98YSM3r87THHbA
        QmbscxSrgC6otcL7ET+Tx3WtWyCvIXHShM6H
X-Google-Smtp-Source: AMsMyM7UGZA91JzoSF05iHuaTCKh+QIJKxv0cwKNvK5gR/1Hrxi0tkKCuXObjb2uQQBw4MZwuxDz5w==
X-Received: by 2002:adf:f342:0:b0:236:9035:31b6 with SMTP id e2-20020adff342000000b00236903531b6mr6210790wrp.200.1666940689054;
        Fri, 28 Oct 2022 00:04:49 -0700 (PDT)
Received: from rdm ([41.75.189.203])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4a4b000000b0023662d97130sm2914757wrs.20.2022.10.28.00.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:04:48 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:04:39 +0300
From:   UMWARI JOVIAL <umwarijovial@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH]  Possible repeated word: 'very'
Message-ID: <20221028070439.GA36889@rdm>
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

Reported By checkpatch.pl script

WARNING: Possible repeated word: 'very'

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

