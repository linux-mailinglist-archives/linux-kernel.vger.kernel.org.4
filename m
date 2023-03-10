Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA36B5425
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCJWTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjCJWS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:18:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5759B855A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:18:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so5284572wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678486687;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNL5tb1P3HVDygsPysD8xPwAJ0vtyz597vInjuBEdDE=;
        b=EolZ2GUxSxBNqUSHRcX6PIBE6bNo6syz8kES+5pER0SmCZatB7g2mSqteLxvKUF0Vp
         ak8AKBk96lIn4UtndtJt6x1MncJG+U2YhKvlCO6r93Q7zLjDlEdyvywJSTiJLF67y56C
         WqoMQX/hT4KkDwftrxegHivk0n6FxK9UDXf/z/DM66Hnk3o657V8zNK0yh5L9RMDftNN
         eFaulCaRaWJashCNGFT3L05ZWYxv+jIuDYrB2FwNPi0Wkn99CyKIJOxKk7kPpIQ45LLQ
         j9zk8rdyZhOcyNrtM+bCclUzsbhcppu2G074qZVRAwlbQdNrhG595+zJmTobQnRUiXUs
         E1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678486687;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNL5tb1P3HVDygsPysD8xPwAJ0vtyz597vInjuBEdDE=;
        b=zY9muNVg+u8lGeZG2XxH/A5gFGDb3Ch4FWv8DnZeHzqWwepXY/r7wsVkJ8RlBm1qen
         6aPAJQXMyi8Ipm1UaqZOu/L3UIlQtJPp+q549l1sFbOt2VWorEJuwXmJ12a+VThzdzxt
         i0YHBrFGiA6AExgFvrhXtwZrr3VCzoKJ24nPGjY57gyZmKollcIgt9IGrdK8vuhyjZxV
         1pnhi8/prz6c951h+OMFNtEJCi3Qy9cvFQbXqRkclIscQI8y8rZ3888+I9be/GoWskA3
         mNfXlT8Uhx2b/YRxSF8SheYhQ2HSPuW/V13PpeCf5zS0BekazDeDkQoawIQ6YbxiehDT
         vlqw==
X-Gm-Message-State: AO0yUKXgpPG9EtW1zTOLBFmbLgF2+lxQKsCK/ydRJWbfJj3AC8vcqo0o
        os31RnkNMTYQHd2ntXYi73kRzu2WXESF6Den
X-Google-Smtp-Source: AK7set/Ulh7uhrPNen1gDfIDPuRQqFNE+Hp0ld+Z0JAMHiM3u6WevTQQZ4mMtbs71khUslIDVK97Tw==
X-Received: by 2002:a05:600c:4453:b0:3eb:1432:a78c with SMTP id v19-20020a05600c445300b003eb1432a78cmr4046508wmn.37.1678486687338;
        Fri, 10 Mar 2023 14:18:07 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id t1-20020a05600c2f8100b003e896d953a8sm1126429wmn.17.2023.03.10.14.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:18:06 -0800 (PST)
Date:   Sat, 11 Mar 2023 03:18:04 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: greybus: remove tabs to fix line length and
 merge lines
Message-ID: <ZAusnKYVTGvO5zoi@khadija-virtual-machine>
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

In file drivers/staging/greybus/arche-platform.c,
- Length of line 181 exceeds 100 columns, fix by removing tabs from the
  line.
- If condition and spin_unlock_...() call is split into two lines, join
them to form a single line.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
Changes in v2:
 - Change the subject and log message
 - Merge if condition and spin_unlock...() from two lines to one 
 drivers/staging/greybus/arche-platform.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index fcbd5f71eff2..00ed5dfd7915 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -176,12 +176,10 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 				 * Check we are not in middle of irq thread
 				 * already
 				 */
-				if (arche_pdata->wake_detect_state !=
-						WD_STATE_COLDBOOT_START) {
+				if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
 					arche_platform_set_wake_detect_state(arche_pdata,
-									     WD_STATE_COLDBOOT_TRIG);
-					spin_unlock_irqrestore(&arche_pdata->wake_lock,
-							       flags);
+						WD_STATE_COLDBOOT_TRIG);
+					spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
 					return IRQ_WAKE_THREAD;
 				}
 			}
-- 
2.34.1

