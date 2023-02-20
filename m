Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB19B69CA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjBTLwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjBTLwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:52:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1A919F1C;
        Mon, 20 Feb 2023 03:52:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o16so1165728pjp.3;
        Mon, 20 Feb 2023 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdhwH29rm5lO9cGxhmUZLBcUk7H9Vq6of/A7Vv3tCBI=;
        b=PPyaNrxRmojTWBukVMO/2viZvncjUIiEYNUreR3dUYqlBZVEWRKeei8UKDT9ePTj2w
         RfNvn8iUCg+kPLhP4MkISA7nonEj7KhozwYYIyvg7HFEtD4uy3SxUKgbiqtd44sHaBA9
         gyGADMjkfVw0pitbWOwjDET81DA20zmKfNgOR1LeARybVU3/om7T9jdgQd+N3nEM9w54
         YyNBKyfdpP18tz6qvXVH4IEF6f8xTqYVTwaRAiKEau2CAJ5a5eoQrMWPLQuV2DfK1PLK
         1XFvxIKjYfdogat/E+Xi59FMqBZ45AQ0jZYsdYZQSywiQzYQeyYSGa/spVJh7conVA/8
         jgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdhwH29rm5lO9cGxhmUZLBcUk7H9Vq6of/A7Vv3tCBI=;
        b=XhCbW6UQ+k0fWpH8mA/CNnCPkYgNV0bOWj95jHPCevPIrfPzWihkoEmHkIegWpDjM1
         Hb3gUeYEksacx2DeMsv5mr3eqlgBJziwQCE4WNhLY6AKjbyu6zUXnaQR2b9nGXk+XCCU
         DBT5WF41ucAEzwUNIIVTasRh39RSMkUdOLEuYVwu/bz/Yio8JA43VXnaTsN2ShtHZ8Yh
         2eYXO+kvVw5WBIDpR4R+pScP+NTFi7jiH2nZNTn7VnxkSRGOr30ZlqRM8dW4NqjBIMHt
         MUMoiF2cg39n/CGUlXJbuxBsogV4M0UlcJ8ibKWnzMwwHqnP3x+DmQ5BZFfJk2HpKM1H
         CbZw==
X-Gm-Message-State: AO0yUKX1ojE3YBRbZq4kJx6/T2qpwg4W1AieEXNrkb4Lr+fxr0zMFzot
        uzRJbQmV4dZp/r+pUA2JAFsfrtroIEdzWA==
X-Google-Smtp-Source: AK7set8v1/kbl5CWIs88CN4Rj+oWcb4rNqRlVmeyscW4Y+fzzZpn3XIVV0Ihy0PdjJkI06dqVqqbHg==
X-Received: by 2002:a17:903:1384:b0:19a:a67f:4a02 with SMTP id jx4-20020a170903138400b0019aa67f4a02mr35308plb.8.1676893951834;
        Mon, 20 Feb 2023 03:52:31 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001962858f990sm955297plb.164.2023.02.20.03.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:52:31 -0800 (PST)
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
Subject: [PATCH v5 1/2] Documentation: leds: standardise keyboard backlight led names
Date:   Mon, 20 Feb 2023 22:52:02 +1100
Message-Id: <20230220115203.76154-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230220115203.76154-1-orlandoch.dev@gmail.com>
References: <20230220115203.76154-1-orlandoch.dev@gmail.com>
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
2.39.2

