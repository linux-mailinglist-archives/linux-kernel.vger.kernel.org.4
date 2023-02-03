Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E768A20E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjBCSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjBCScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:32:25 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BF29F9F9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:32:22 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 5so283136pgd.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t/r/tdNtEio5pHrqHpsU4GhzJOAAFbwX4UQBhIfUYzI=;
        b=BPc+jTuImdUl6i7YWuZHIWyt8a1HiIwHNYvH4DnNyaxF/2b0RbjXhV4qvfa0UZvnA+
         W52SQBnapfjReD3T6jWA8Oz1cULeRoBAbXxXgiu2HGpNI/5EbQHkyWC12vYw3tGK5eaL
         b3Nd+CqbI4BQYp6yfakXYnAVoI4qHzHwz0NQJKP8dlIlFZNv+148qm+UQuKJu2ZAm6qQ
         /w7bIELzUPIvmSf7/tp0OIladc8tq34OHXSe+mxN3nEZatp8U8NbBShnxL4UdajzDWnl
         o5XhxblUPlKOZJqyaozGKvcKDsliLd5lrEfzzgDZmbiKTyAaEqe27VgPiJpI9942OXun
         5Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/r/tdNtEio5pHrqHpsU4GhzJOAAFbwX4UQBhIfUYzI=;
        b=lgXuqnRhoGLhKRjJ5RnP33Tm0SE89+/+ywn2fUgUmU69p9VVVSKFYOptjmdba1h4Uq
         r6lRzbsPsnEBDm+zCz2iLT22dfy6hK7P20XLdC0s1Wd6kYmWywS6lgK6LGB7A2HXFwVb
         uAL1vX7slMEhmKppUCKFeSMwGHPGYJA4sXQxV1CFBubTeagf7Fu4IU2rPyfg/WVAUa1f
         2zmmo82EDHsgKATCZ1akg+gEtcp9QfeUeWJBjdiggG5lJTjQrBV5qqfu2nZxfq0Ke0R/
         /TikhkT2A6FGKEKE/DBXOzekHcinRO+OYFp2JI72EWnfaqTNt6osgB/388oDsLyIzl2m
         D4iQ==
X-Gm-Message-State: AO0yUKUgQM+rRdqlwWeSFGelEO1eyXC4gPf5MJkpti7YLGpPqONAztiJ
        hJV3YmjG/AKynkaO7ymdz2YqFzf3JGq5fKnf5ovvV9f6VcUZVg==
X-Google-Smtp-Source: AK7set9EGu94D5bmmCGWT1d/a1xhQEgVm5Yu24YKiu9vf54MDu0QbmrepOdLl7Ewfc2TeoxBL5s8hn2kI4Kd5Or3Xkw=
X-Received: by 2002:a05:6a00:1254:b0:593:9627:d117 with SMTP id
 u20-20020a056a00125400b005939627d117mr2585879pfi.6.1675449142390; Fri, 03 Feb
 2023 10:32:22 -0800 (PST)
MIME-Version: 1.0
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Fri, 3 Feb 2023 18:32:11 +0000
Message-ID: <CAMxBKG1RwbRJMG0cKcnbyKgznXeZLL+Zp1zXeOnxpYU0NkOO8A@mail.gmail.com>
Subject: drm: panel-orientation-quirks: Add quirk for Lenovo IdeaPad Duet 3 10IGL5
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is another Lenovo with detachable keyboard and 1200x1920 screen
mounted sideways.

The following has been tested with 6.2.0-rc6.

Thanks,
Darrell

index 3659f04..590bb7b 100644
--- a/kernel/drm_panel_orientation
_quirks.c
+++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_data[] = {
                  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad
D330-10IGM"),
                },
                .driver_data = (void *)&lcd1200x1920_rightside_up,
+       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
+               .matches = {
+                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
+               },
+               .driver_data = (void *)&lcd1200x1920_rightside_up,
        }, {    /* Lenovo Ideapad D330-10IGL (HD) */
                .matches = {
                  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
