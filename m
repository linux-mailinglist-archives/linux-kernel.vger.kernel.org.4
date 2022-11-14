Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0E627678
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiKNHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiKNHhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:37:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3FDBE28
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:37:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d9so11824382wrm.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5XydbSVbm6G15xfG822OXZhfwZyfrjo3B5iYJUpD3U=;
        b=ED9u+luPQqIEKZcyGBaQidTGk2BNLtS8VmJTHpvnjIZfUzZwD3JHOEFwhOUe9U3qR7
         Ovtb713tD2Q9hqQR27sWYn3X8kBr38DBc3HQrxHqsA16zm6zEezkaRtQJZkYzbWYBYLp
         8cwT5YxUPX1mXM9/13SwveNeOW9ikxg60X8dF6gW1VT+wlVo/2/VSWfgliyWR+3YuKQF
         euj61rb0bsIVH1r/8op8ts8AKwgOjrtwtIsNtjvGjULZtqvrS1PWcMSECcG76uyZ7p34
         ezi3TpaUEiMlKEFLCP9qwJTT3xxumnvEDG1lmEHs8hJfSIh+tYjQg0bmMXWqso/3xdH5
         vgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5XydbSVbm6G15xfG822OXZhfwZyfrjo3B5iYJUpD3U=;
        b=Z1z28AoSwKxzkeKsYlH/O2n/NwSTa2bFjkX9p+Ay5a0Izwu9WNiCXjsdPq8BNQBnOF
         XusR9RsY4e9ZeyMjFxp8HkxKyfKJBHz7aBwO5+iPillXcO/d9N/hGsjaCbcUvv4x+7bx
         CO7NQdeJa7FtX0GZ/9HjCggASmqqybPzwdIrI2JAaiOxezuav145uI49FJCo1IGqh3S7
         0ZkCkHdQqGkya64v9Vb9vX0+F63pUarQOCZXkq2QKmPTsS8eR4X9vFmVyqGDnaNm6eFk
         WC6OEDZihECDlLkvSphtxC5f4YP/jLlUIIj4zAtkaZHeAgKMmdieKtmAV8kjlCWpZUng
         nrOw==
X-Gm-Message-State: ANoB5pmzz1NIXRBnkO5zHXpMioWmhkmymvUHQyT08clJlYQWyM8h3b/9
        fmodD6pKHnK5mXR2TCzsuBtblg==
X-Google-Smtp-Source: AA0mqf4FPbvODQcrLj9HXXvkkH6t21Gvh1sbiPaI++aIq1dDV1O8Fc32itI8LBWvNF1qApGHvumkhA==
X-Received: by 2002:adf:f10e:0:b0:238:3d85:9262 with SMTP id r14-20020adff10e000000b002383d859262mr6813308wro.413.1668411469762;
        Sun, 13 Nov 2022 23:37:49 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c314b00b003b4fe03c881sm18467775wmo.48.2022.11.13.23.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 23:37:49 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 2/2] usb: serial: add myself as maintainer of CH348
Date:   Mon, 14 Nov 2022 07:37:36 +0000
Message-Id: <20221114073736.672194-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114073736.672194-1-clabbe@baylibre.com>
References: <20221114073736.672194-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I did the driver and have hardware to test, set myself as
maintainer of it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c29914984ef2..622f646c6795 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4858,6 +4858,11 @@ S:	Maintained
 F:	drivers/auxdisplay/cfag12864bfb.c
 F:	include/linux/cfag12864b.h
 
+CH348 USB SERIAL ADAPTER
+M:	Corentin Labbe <clabbe@baylibre.com>
+S:	Maintained
+F:	drivers/usb/serial/ch348.c
+
 CHAR and MISC DRIVERS
 M:	Arnd Bergmann <arnd@arndb.de>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-- 
2.37.4

