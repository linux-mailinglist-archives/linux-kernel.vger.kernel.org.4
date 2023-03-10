Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085F86B4E18
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCJRKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCJRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:10:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9D16AF2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:09:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q16so5706791wrw.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678468190;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOiwuqcweU7+YHTRApQGtYui62Ok/Rws6N1HxOxsdlQ=;
        b=RdaB5Uqq59Xixi3DPF5AMfpPhk5fNLSJ/FglPJkO9jLtEajpmmlxzJqv/W9K6DLaK/
         VdWxCbx27GOEB1fRBtkFFCqkoXc0jaygnLu2f4dSQtqxhvV8NKZXibqSh9rpryXS8Ave
         Sa3jnLX4uDjoDjrz9yFXu4JuZh2FFSQDTs8oW3oX8YOFG2cGy7PYQoFcF8NGXnoaCz1A
         4SOIyKRWt5r0ra1NjuzKtkDJkd0tNxkvhyXEtO4RdrPU1ZYnhOC+yqZ9u1rhhKhGVLlu
         LiZvwq1xfsIjj32euc/aJ9wP8szSMCJ3VgNk3W+SsvN/8D914To8acxCJOtsfz3UUmBN
         37sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468190;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOiwuqcweU7+YHTRApQGtYui62Ok/Rws6N1HxOxsdlQ=;
        b=hILo4asayAegEjRc/XhpLWgPnSaCs+/rKMQY8NX1Gr9cB/+9i6HpCsOSensTvxGcAz
         igmTZRDpXpGA99PpivURQOG5p6hr6skcTViRWjLBT7UW03+uu6tdZXgJaJgbQovfyL+e
         D/rZw5xydBoun+rABTCYTejy3HS7HklLqWMbnXsx2OCauQYxQQHqQRdVLS7lQnTBtz9V
         PmCP+NWnFf2uPOmwYqyZjjvOY3qG3MLhAQoJB6VzLcRT/wKwPjbifJQ+zLF1SE2gH5Vl
         8ayrHosK3LEYmrF62K3WbWto2l6YCm8Zm9Vs8VF6wYO09h7pLGuwT8k8DZg0CkE+cUbx
         JJZQ==
X-Gm-Message-State: AO0yUKUetSxa62kwyMXHJLwfByPPFCw3Bf5gZNJUIQGTqVygp0R3WCWx
        uOgITmNCrR9S5lWEKPu9v83fxLjFUhav0DtN
X-Google-Smtp-Source: AK7set/qo9y995l0QcIe7XINy9Xw7krXxPILJgQz4xXeZK2SqGcv8FKDtcu7qBUOcBqEv/Q2ioVh7w==
X-Received: by 2002:a5d:452b:0:b0:2c7:56b:863 with SMTP id j11-20020a5d452b000000b002c7056b0863mr18430570wra.10.1678468190085;
        Fri, 10 Mar 2023 09:09:50 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b002c592535839sm294581wrr.17.2023.03.10.09.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:09:49 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:09:47 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: fix exceeds line length
Message-ID: <ZAtkW6g6DwPg/pDp@khadija-virtual-machine>
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

Length of line 182 exceeds 100 columns in file
drivers/staging/grebus/arche-platform.c, fix by removing tabs from the
line.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/greybus/arche-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index fcbd5f71eff2..0f0fbc263f8a 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -179,7 +179,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 				if (arche_pdata->wake_detect_state !=
 						WD_STATE_COLDBOOT_START) {
 					arche_platform_set_wake_detect_state(arche_pdata,
-									     WD_STATE_COLDBOOT_TRIG);
+						WD_STATE_COLDBOOT_TRIG);
 					spin_unlock_irqrestore(&arche_pdata->wake_lock,
 							       flags);
 					return IRQ_WAKE_THREAD;
-- 
2.34.1

