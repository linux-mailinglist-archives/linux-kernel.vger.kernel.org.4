Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05A969B8EE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBRJIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 04:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBRJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:07:58 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB1E10425;
        Sat, 18 Feb 2023 01:07:56 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ch19-20020a17090af41300b00234463de251so211715pjb.3;
        Sat, 18 Feb 2023 01:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4heeYp3ATHaNUse72w/QrOIobMCPoeJh7FfGXf+M0M=;
        b=Zj64QmYs8DeJGym9eNMN2aNj9jGx4Oa2gbPMd9zDs2eF6cyGMvYezeIMQkwc5rok6Y
         9Kxubhp7u4gEusuOBTiWPN2xYziMbV4c3LmsYXXkrqnSQyEiid09Yv5PtazO77Jiuutf
         SA2fHTR2w6KSBrjNS3D50Mx7DipPUmO25QvVKD97rEtEMFg/FPwh91U8m23GbR4hC+mw
         nfnrACRvPoTqraFrmav1srP0wNuVPSXlakxotbGxe2UWvSpDIONw+Zt3JU0Mh+za1uj7
         OTguaaKMoG7lj45sPfB5O66Z9kFKaErn+SaWXNTC9UXuwMTnxdZSqfDF730h81x0MYV3
         bNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4heeYp3ATHaNUse72w/QrOIobMCPoeJh7FfGXf+M0M=;
        b=caWvbNWSiXkDV4GjoKRtdxjFOjCwWK0pN7MMYwpQ0uSreBovE8I+6YEq6f/FVGJpVD
         cbay4qY67KWDmfiEI/PWufpzaPX4zXPu0Xyw1mrrhVw9MQyJp48xmxaLGxQA+1e1yiBL
         mMLBJWLKkB0SPqPom9ZrVOAd94FMlMCam7JZ7nXotBpQTwOm9NtwpFWLy4B2Rc6q8yoL
         o4h++s+6+gKzawsYceuSSGgTItSk1h1nIFIVMm4V6P/pnd5Bq2gMIKSncV2msA5EN1WM
         JiYg6m1/hEuZB61vOEt+aonqnUEUHdKKTLWD4FkYjlEgQIeqw1xhOTV9eL4NeWT19IaZ
         jfXA==
X-Gm-Message-State: AO0yUKXmtreEM+ClCTLhZ3wtQxLcQN9ktaqGtshtPQ1AJd+7uhOqZbtb
        BDeQYcnlqHq8cbMf0Rxx1Q6lYzVuYJF1ZQ==
X-Google-Smtp-Source: AK7set81FU2L81JI1mJZJhGN1jeEDvPv/QUYGksrysuyySGEJQUX2yWO27WKXbiFQAwV1hJH1iPfYg==
X-Received: by 2002:a05:6a20:3d91:b0:c7:6f26:ca1 with SMTP id s17-20020a056a203d9100b000c76f260ca1mr6099018pzi.47.1676711276118;
        Sat, 18 Feb 2023 01:07:56 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id m192-20020a633fc9000000b004faf33e2758sm3945135pga.40.2023.02.18.01.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 01:07:55 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v4 1/2] Documentation: leds: standardise keyboard backlight led names
Date:   Sat, 18 Feb 2023 20:07:08 +1100
Message-Id: <20230218090709.7467-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218090709.7467-1-orlandoch.dev@gmail.com>
References: <20230218090709.7467-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advice use of either "input*:*:kbd_backlight" or ":*:kbd_backlight". We
don't want people using vendor or product name (e.g. "smc", "apple",
"asus") as this information is available from sysfs anyway, and it made the
folder names inconsistent.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 Documentation/leds/well-known-leds.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/leds/well-known-leds.txt b/Documentation/leds/well-known-leds.txt
index 2160382c86be..4e5429fce4d8 100644
--- a/Documentation/leds/well-known-leds.txt
+++ b/Documentation/leds/well-known-leds.txt
@@ -44,6 +44,14 @@ Legacy: "lp5523:kb{1,2,3,4,5,6}" (Nokia N900)
 
 Frontlight/backlight of main keyboard.
 
+Good: ":*:kbd_backlight"
+Good: "input*:*:kbd_backlight"
+Legacy: "*:*:kbd_backlight"
+
+Many drivers have the vendor or product name as the first field of the led name,
+this makes names inconsistent and is redundant as that information is already in
+sysfs.
+
 Legacy: "button-backlight" (Motorola Droid 4)
 
 Some phones have touch buttons below screen; it is different from main
-- 
2.39.1

