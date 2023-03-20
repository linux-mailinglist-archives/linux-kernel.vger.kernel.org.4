Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197B56C0C33
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCTI0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCTI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:26:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58EC1F5F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:26:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eh3so43318204edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679300789;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLz3hRBfX2H9kEvnXukqy9ngVwHdXnfaWeWONnLje10=;
        b=VwD/cTCpK2eod5z/7muOl6+J7Tq9jX8bgEJzMWuM6UWdUmscthpSF17CqC/LzichUE
         SnhGfHT3d9QJyGIwg6NbGJREF+XzogXguXf3m4V43gTbbQktn8vI7sfgR0TG0wVa0wHj
         8n1mI24Uwvcrq2flFXFJVIWpz6D7BM6UMlpgi8JyzIeDYq3CkpO5SsPCtqB9NiVmx0v9
         BnznADdg7QWsC9s5wJLQAeJ3wFST5xoFhEfxr9scPqIje/qO5mjWKT9SHp3zO1GAxVkh
         lhphJpVsfuTfdvSxHNiAu7Y6xtYuza+RgWWMmdvMLn/a4C1Qn0jKnBcRl5XpkLNp5UQy
         uzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679300789;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLz3hRBfX2H9kEvnXukqy9ngVwHdXnfaWeWONnLje10=;
        b=Twqxtu1j2PgDYwgWdVgrnOia6DBiGUsl0xApechQo+uuA2nBuZ19gFKEpfYo1Lpkte
         HmgVTQmciYBoASEskTo4eGN5sBfB9YQ+oF97e1bCQR/44QIGymPKUxaqxzcxHjjPgKvV
         5s4mynxeWqreAGMn4JMJpbU6nuvnrymEKMJrXHOhfz/sJmwpV+Kq15zs+HT6eN+5DJTk
         jfyaCeWmenDuhHMHSkMDQUD+gDI3gZnwTm2R88uEFqPc8+T3ZVo3ifZmGe3X/FKZL5H6
         k1xDVh93Ptu8EarsEO8hG22vzhQGDSBkgYoZ73u709eMSU60g/9lANvo9s7Pq+S35XI3
         hdRw==
X-Gm-Message-State: AO0yUKVsa1Jgjpuk6Ij0/0VuvSv4iEqlsVJGZIdF2E7FgHHOlwVjLOdb
        OtXlHwE5Fnl+bA5GqP7N0G0JldQOqs9bWlikYC0=
X-Google-Smtp-Source: AK7set8d9sgILfZHW+akuoOmIEj/S+YtcQwxysXg+R+z+yF04NSZlFIinm9t2bQRA4dZlz+2IKBR3A==
X-Received: by 2002:a17:906:3c4b:b0:886:7e24:82eb with SMTP id i11-20020a1709063c4b00b008867e2482ebmr7155552ejg.21.1679300789202;
        Mon, 20 Mar 2023 01:26:29 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id hf8-20020a1709072c4800b0092b65c54379sm4100679ejc.104.2023.03.20.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:26:28 -0700 (PDT)
Date:   Mon, 20 Mar 2023 13:26:26 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: greybus: merge split lines
Message-ID: <ZBgYsqkpdYpGQniB@khadija-virtual-machine>
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

If condition and spin_unlock_...() call is split into two lines, merge
them to form a single line.

Suggested-by: Deepak R Varma drv@mailo.com
Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---

Changes in v3:
 - Removing tab to fix line length results in a new checkpatch warning,
   so let the fix length be as it is.
Changes in v2:
 - Rephrased he subject and description
 - Merged if_condition() and spin_unlock...() into one line
 - Link to patch:
 https://lore.kernel.org/outreachy/ZAusnKYVTGvO5zoi@khadija-virtual-machine/

Link to first patch:
https://lore.kernel.org/outreachy/ZAtkW6g6DwPg%2FpDp@khadija-virtual-machine/

 drivers/staging/greybus/arche-platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index fcbd5f71eff2..6890710afdfc 100644
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
 									     WD_STATE_COLDBOOT_TRIG);
-					spin_unlock_irqrestore(&arche_pdata->wake_lock,
-							       flags);
+					spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
 					return IRQ_WAKE_THREAD;
 				}
 			}
--
2.34.1

