Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DEF6142BE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKABPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKABPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:15:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AEB167DD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:15:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so17472400pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqIE/LapQHrEfxANUi03hwjnlAbgryHwG0hnnbnZenU=;
        b=mgeTVaCdrR/wrpGGCIDBFDYvg8HmbhLV6BxKQqYjECEOnStWq2kfF3RP6wmo+TF/UR
         aq+0lT6Vw08HjG0b4yvBCOXBBqWFeqRa9IybIOUNm+PuN8lGR1LlVVgwVGoe+gApW/Z6
         dP7+aA7lLlYgmKWuIEuj7cva32xnkHbH1iuLEW6B1aDyWbDmK7Yx33683dpjzjQ3FfVU
         gsXALUuEZ9Ko7DYkWdVV/qIh29U5Tk9vVMYhkNzcQ4wq6oWbW3pY8bPbtV/6t3DTd/Ul
         was8c5dwzkq5zaXiYYTES7oYV5WCU5qI959u5Gk8Xr7B2/eeHkm0EPV6Kj1rMqCMXdGV
         Gkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqIE/LapQHrEfxANUi03hwjnlAbgryHwG0hnnbnZenU=;
        b=q34FIHSyAbv530TRgYSlz5py5hNYt/oxmGut4bEWUneiah13vvqEFUaV0LrK+3//nL
         s6O+As+ZZwO0teungXpXzzj1/T2X46GyzqW1H8SEKQRc5r6ctSxtpiUTrHzvpQ72Er+J
         xX5apnO0eQDpm2Ih55SFEKSbr0lJrtomEhRlUiT0lwZbsFPat9MeXrgTDl2cXT5VhL/K
         3hsFjscm0WlsjZGcFRJ1JuhMYxR6k5zlarK8WYi7yZJAArebkB+jQAuXyPzzs225lWwm
         6Ju8LAEhHNVst7zs7kguJ+EeS74FNRO83220pqIII2dZFSmZAwFxJnLVvXjXV/JVawfQ
         UjKg==
X-Gm-Message-State: ACrzQf2iLHYcuYZ6O2YTcFBgvXqGAQPzfMPq84gxxxnCpIjdp3/iHstp
        Jn05rdWsJomaeCZub2DAtqYOVnwdo+U=
X-Google-Smtp-Source: AMsMyM7rq08U7eoxNrl6Hloc9s/M/xa6SXit7USWaJgsmkOW/AzwK+WyVekuw5c13OlGQOQYdaUyvw==
X-Received: by 2002:a17:902:db0b:b0:185:51cc:811a with SMTP id m11-20020a170902db0b00b0018551cc811amr17187034plx.85.1667265312674;
        Mon, 31 Oct 2022 18:15:12 -0700 (PDT)
Received: from ubuntu ([218.237.158.230])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902dad200b00178143a728esm5031463plx.275.2022.10.31.18.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:15:12 -0700 (PDT)
Date:   Tue, 1 Nov 2022 10:15:07 +0900
From:   Gabhyun Kim <kimgaby415@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Remove line breaks to match coding style
Message-ID: <20221101011507.GA3802@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant line breaks between function definitions to correct the coding style

Signed-off-by: Gabhyun Kim <kimgaby415@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 1a3ca3e57623..78828ecac28a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -22,7 +22,6 @@
 
 static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl);
 
-
 static short rtllib_is_54g(struct rtllib_network *net)
 {
 	return (net->rates_ex_len > 0) || (net->rates_len > 4);
@@ -147,9 +146,7 @@ static void init_mgmt_queue(struct rtllib_device *ieee)
 	ieee->mgmt_queue_tail = ieee->mgmt_queue_head = 0;
 }
 
-
-u8
-MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
+u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
 {
 	u16	i;
 	u8	QueryRate = 0;
-- 
2.25.1

