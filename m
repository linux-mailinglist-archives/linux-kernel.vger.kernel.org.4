Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59BC72527C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbjFGDnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjFGDng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:43:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F1819B7;
        Tue,  6 Jun 2023 20:43:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-65131e85be4so6922191b3a.1;
        Tue, 06 Jun 2023 20:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686109414; x=1688701414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IG9nOZCUv4yUauPuQq4zcNH7o7ub8jEFkawKImlrhhk=;
        b=qX3ZTWs1IRMqIvjqq7bqnABkYurX/9l4HNYJZ2i7tTq57fsvu+M9epZ/q0UEZOn/Ic
         4ZqsQZ1vMMD6GRJY++duyl6bRGikNkyup4l4TVii0ch/QXzZtgMnQTwrVllhDuznP96K
         6qIO1euPWBoG/1K86g0cU8qhu86f8aeKXLmf4lH4HHtpqqdaPPq5U/Q/eFSh2RKXR+YH
         2tPaxw9IED5MCocPPjkvaWFYj3StaWMMJ7LZBWKjGTH6gl+IzVV9ErDI+EROCin3qvZh
         U+ZajWgWT3Sob4nhDhl8mT/Bz6UQaNFoQAuO7kRIoJmK2UquREEaPiVD/ktGBnbr+HmM
         qjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686109414; x=1688701414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IG9nOZCUv4yUauPuQq4zcNH7o7ub8jEFkawKImlrhhk=;
        b=iDucgUTTUb2rQOybFoPpRkZAdTyVzScHWKSyaZ7m6dAOafkPqr9nvTMDUkrcGvGT/g
         WU3Df7R6vFzXySvLl0eHgq5LIknAq7UtClvHbioI+3eZoXhiOgPih0t4ai3c43uJNryF
         kPIpJEeXj2G+ONMw58qq0D/pwImCDV1tMwCOJ+59hm/TRLr2+OkyE8BWrWcY6FlJxHu5
         oM1cpLXTMfyl/C0hIacwU4d7rqbDqWbhyGPZQn4ew9yKfXnoipFGZ2LPCLuvPH1AQlCJ
         PppXvtOuXAmYEnBB7cf4CA658InqVDCXHSrurYn1UdenfxdYNne1/d9CWnSM5pq0Lu59
         le3Q==
X-Gm-Message-State: AC+VfDxuzZUadVTZOBgH/3dtC53FjeNjuGv350WcTutZxWJaPuj+9NKo
        CZf5Ruky/UPzw6PIgEPxRBw=
X-Google-Smtp-Source: ACHHUZ7ys5tjUtfp/gd9Iyq7DlsuiXxqiiSG3nW3E/spUJswTFZ7aPK5JdFNF2mO+OYCnCv5N6gzbg==
X-Received: by 2002:a05:6a00:896:b0:641:39cb:1716 with SMTP id q22-20020a056a00089600b0064139cb1716mr5784067pfj.20.1686109414251;
        Tue, 06 Jun 2023 20:43:34 -0700 (PDT)
Received: from localhost (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b006542462d040sm6233624pfo.206.2023.06.06.20.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 20:43:33 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-laptop: Add drm module soft dependency
Date:   Wed,  7 Jun 2023 11:43:31 +0800
Message-Id: <20230607034331.576623-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

dell_laptop is somethines loaded before nvidia driver, causing it to
create its own backlight interface before native backlight is set.
This results in the presence of 2 backlight interfaces in sysfs and
leads to the backlight can't be adjusted.
To work around this issue, delaying the loading of dell_laptop until
after drm module has been loaded.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/platform/x86/dell/dell-laptop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 1321687d923e..535e6c3df529 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -2316,6 +2316,7 @@ static void __exit dell_exit(void)
 late_initcall(dell_init);
 module_exit(dell_exit);
 
+MODULE_SOFTDEP("post: drm");
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
 MODULE_AUTHOR("Gabriele Mazzotta <gabriele.mzt@gmail.com>");
 MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
-- 
2.34.1

