Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0868A806
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 04:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjBDDur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 22:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBDDup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 22:50:45 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A7474A69
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 19:50:44 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id me3so20463904ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 19:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCWkM6WQTItTheVs3lg/M+RkOdpCXGfWQTV10D4Rk+k=;
        b=UApwxAZ+cuT4pN/IKFYYh5OC4XNNytOB4QQxcPzrDa75oM/D31Tc8mxi9C18A2I9pZ
         9GnndYNfldX+EMdsInch8WFdULuVxBz6v/d/KaCvPrtmuz/VyjR661X3oJkNhNdkU8c2
         sz0YYlyn1GOQPAZItr3ZJv/y0WPigNk1K0FFa4Efu+S94lOpNrY8rZzJZggA5x3h9VxT
         qA3a/g/8znsBneJlskOx3XUnixXuGLnKoI6Ch49zesJXxeDloOreWNkU9ZJwD8EN1Qm1
         jCPfuF+0UhosEdr2Tkx3ACqrqadzhcKGrCt7NVJoroovgFsO7EeDjyqHYC9TwsUZ/l5g
         BBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCWkM6WQTItTheVs3lg/M+RkOdpCXGfWQTV10D4Rk+k=;
        b=ZmUAk1oRwl2jC00f07DUXd2hvl1f8+mkPFhxL33/mgl1CSive5cgrXTu01TGQH6jRU
         8u0lwNJ5KFf3If3otQTTaz0ZqhfuUW0HXs660W2sVXMVT23pG7y0QrZt/BTCZcWq54XD
         PjGV2q3hMxRFNcghFuCk3NjjFgwb55hrVyFb8TG+UGVoNAlxcwYQjRowSlKh5K9f8AHK
         L1sYp1hVrxFnV/12FIUxLjeV/UNj45Wwsp7dZZEjI2jJA0XCBJiRvXJS/JLxkJ0BSTql
         0ry1FFS/3DdXuoHYIzrJz1rY6Jk6QRgLguuet+qm+yrlRjxgHSX6Veapc2OImU0Yrp/Z
         xV+A==
X-Gm-Message-State: AO0yUKWpdas/i1/RS9q84Tdv2NPCIFa0rT3zgAM8Bf5I7tUNpcG8zQpK
        4IOINuewRcJcq8Lqw8cdvRr7W3fXZEY=
X-Google-Smtp-Source: AK7set+hnkWy8CQB1d0V+34c61bcsuBElVL636DqNUNI6ozBHF2Fxu0b5XfvUPBK68u70HEvE3c5+A==
X-Received: by 2002:a17:907:9724:b0:88d:d76d:8527 with SMTP id jg36-20020a170907972400b0088dd76d8527mr16254813ejc.47.1675482643334;
        Fri, 03 Feb 2023 19:50:43 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906688a00b00889db195470sm2237241ejr.82.2023.02.03.19.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 19:50:42 -0800 (PST)
Date:   Sat, 4 Feb 2023 04:50:41 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Add braces to macro parameter 'iobase'
Message-ID: <Y93WEZGlT5Vmeb50@combine-ThinkPad-S1-Yoga>
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

This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
as '(iobase)' to avoid precedence issues.

Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
---
 drivers/staging/vt6655/mac.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index acf931c3f5fd..a33af2852227 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,9 +537,9 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, iobase + MAC_REG_PAGE1SEL)
+#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, (iobase) + MAC_REG_PAGE1SEL)
 
-#define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, iobase + MAC_REG_PAGE1SEL)
+#define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, (iobase) + MAC_REG_PAGE1SEL)
 
 #define MAKEWORD(lb, hb) \
 	((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned char)(hb))) << 8)))
-- 
2.34.1


-- 
Thanks & Regards,
Guru
