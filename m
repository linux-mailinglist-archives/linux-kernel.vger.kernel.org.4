Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365946C393F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCUSfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCUSfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:35:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4383E1C2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:35:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eh3so63389196edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679423701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0AYUnT0/KW1zTFkWuQVJ616wax7LB1pNkItFnW63oA=;
        b=Y5PVDuLgSexCXggBndd5IVvHrqQ8Ii0KndS1uA5hsJVRdGEFLk09/RXu7Y8rwPZ1UX
         +FhFNqSr6iXQ1SiE7ha2gn81WcqYJMC4jLGHusTE00npGJpnvGPgEEsQHh21KSS0bEE9
         sj6Y7r0V122u0fJOUEXAlRYXUb7v3Tq7GcsYWJ5Kfx4gkpSZIELP+kqg9Tu9Oiy0cJtc
         On0UdAWYvCsuRwX6FNwj+3TVPZGtfD1Awj/POZsPHyoGEz+H4jw8guwbf59loBv4ZKlT
         xYhD63sCyESWu6lYA1h8tyb9d8tvn6IKqrolfDqoeH88D/wjMYjAWiP/7YJqKhOhVeMe
         KPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0AYUnT0/KW1zTFkWuQVJ616wax7LB1pNkItFnW63oA=;
        b=BZTae5snODsz3TWG0RssEeD1d5q+6ekFzl2XhWtRSmN4e7NkusO9TsAUnPlvCH9LSl
         QMrqNEohYCeo0R+EPdNEc3va6h5Q28lUyjjBny/8sWbx4ZE75oGGCa34RR6Q5wIjrx4F
         7mhkhFY8TrVmmDmulHk1kXlfJOAFcwA6nEQz/87S+yIcpIczVAyuYkjaGyEKuZz4mTV/
         7ejBEotIWbLLEgADndVeQqlYJpXsnZpo8UWd0CDphUgXQ8GyM7wyw/Mf0P/630IMuo3P
         /adQ8s8gTYV+gs6Zm3/IFS7R8RUhEyNxjT+IU/pgMzQjM0xKOmGsdT5FpUa6rN+HOwQy
         ap1g==
X-Gm-Message-State: AO0yUKVHV6pv/EL2UBxwSwSSFwuiyL+nXKjBGDdGk4vk4KoHceyyRzSx
        8bAm36B6UN+vhMsazLRCwt6k7RImWac=
X-Google-Smtp-Source: AK7set9x7EzaUpWev+yfVdYQZs4/VetrJQSk64rd89ldBRD4zNng7APaNzY9p+fBZRaaVopAjd3KAA==
X-Received: by 2002:a17:906:344d:b0:932:83fa:d2fe with SMTP id d13-20020a170906344d00b0093283fad2femr3913646ejb.12.1679423701474;
        Tue, 21 Mar 2023 11:35:01 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id bm7-20020a170906c04700b0093332993b1bsm4670919ejb.137.2023.03.21.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:35:00 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com, Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2] staging: greybus: use inline function for macros
Date:   Tue, 21 Mar 2023 20:34:56 +0200
Message-Id: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
static inline function.

It is not great to have macros that use the `container_of` macro,
because from looking at the definition one cannot tell what type
it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
changes in v2:
	-send patch as a single patch.
	-edit the name of struct object.
	-edit commit message.
---
 drivers/staging/greybus/gbphy.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index d4a225b76338..e7ba232bada1 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -15,7 +15,10 @@ struct gbphy_device {
 	struct list_head list;
 	struct device dev;
 };
-#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
+static inline struct gbphy_device *to_gbphy_dev(const struct device *_dev)
+{
+	return container_of(_dev, struct gbphy_device, dev);
+}
 
 static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
 {
@@ -43,7 +46,10 @@ struct gbphy_driver {
 
 	struct device_driver driver;
 };
-#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
+static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *drv)
+{
+	return container_of(drv, struct gbphy_driver, driver);
+}
 
 int gb_gbphy_register_driver(struct gbphy_driver *driver,
 			     struct module *owner, const char *mod_name);
-- 
2.34.1

