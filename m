Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FB969A90C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBQKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBQKYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:24:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84263BDD;
        Fri, 17 Feb 2023 02:24:09 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q5-20020a17090a1b0500b00229ca6a4636so929570pjq.0;
        Fri, 17 Feb 2023 02:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4heeYp3ATHaNUse72w/QrOIobMCPoeJh7FfGXf+M0M=;
        b=ErSR7rtauE2hnfna5a9Jwh7d/y3lVdpK0zifdsIv8/54A9LyHV/rRWz7195cCgLSSU
         R2fmAjSbjvRM1AZfIpRm/BWZmcOjJ+z5wmldmpHDB1N5GmP0iPofU8F4/KbLpRuKCnVl
         Vg8VPMUl7PpBF7XeH9OSoP65knatR+Gxx/kuCLTwr4bfJtRC+z4k4/TE/PstYSTqOcbP
         5vO9MzYJjb2MizmB1iQg5WEs78tH9fJh/kDyCeF8wfhP1gNAqxLOj/iFqpQPvSc9Ot6k
         ubToKy8108KRi9WbOb4XpKGCZUsPLUB5fufrh3XP+RuaG1WPE5vDromwV/TisFpEI2tC
         vKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4heeYp3ATHaNUse72w/QrOIobMCPoeJh7FfGXf+M0M=;
        b=Qbc6yDYMuHkrKsySidYiCD6lMd35/gdks8JC9UACip8RwNGS+gjabtH9i/Qjx9+kZ7
         z8TIVMmxTWL41KO5fL2TrLV6IMB1D0d9XcaEpkM/wr2pn0m5CwnWa/tcnOBeBlphZCd6
         8L7TYPV0CtthSJBjcD2SRKlIsac+wZgymtb7mfqY3cpKl+q8lk/+xykTFHYDZHAPOsyB
         hgUyzja516GmN/Z5LgkZeoBdudhnHswIQpSlf2xc27hj/8cB+IBTkH3cLZ7HeQh5ULHP
         fPfd7TaCSdA8NP5IfczuoDDfCOOElx2o7IG2eSqrO0p5BIjrYeO754usIT0CLS94JvVv
         TD8Q==
X-Gm-Message-State: AO0yUKV4qFx9LSYZPPU6cCohgsRw+0FWsxJIwuh0BdPh1VaGe3IrmT4n
        iSO1HK4Ag8vystzH0QjuuxxlD7YDs6G+wg==
X-Google-Smtp-Source: AK7set/yOj2Zx0HywegU+8uP7ki/FRetd5zPi5yymEdATyATiCZOTdOxqlR6+GuQnW2akrvvNmE4uw==
X-Received: by 2002:a17:903:1106:b0:19a:906a:e052 with SMTP id n6-20020a170903110600b0019a906ae052mr144494plh.64.1676629448754;
        Fri, 17 Feb 2023 02:24:08 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b0019aaba5c90bsm2832538plp.84.2023.02.17.02.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:24:08 -0800 (PST)
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
Subject: [PATCH v3 1/2] Documentation: leds: standardise keyboard backlight led names
Date:   Fri, 17 Feb 2023 21:23:19 +1100
Message-Id: <20230217102319.3419-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217102319.3419-1-orlandoch.dev@gmail.com>
References: <20230217102319.3419-1-orlandoch.dev@gmail.com>
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

