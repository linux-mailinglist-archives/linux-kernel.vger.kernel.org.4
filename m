Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2E6BBF52
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjCOVpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjCOVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:45:49 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB497FD0;
        Wed, 15 Mar 2023 14:45:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r4so11141170ila.2;
        Wed, 15 Mar 2023 14:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678916747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sCKgG+rjS0qruOZo3hjzG2lpfhG7a6+ZuOs9wue/0iQ=;
        b=ffnp4rZgxR/X+1FCGrFXzsH83QspJwmHUJ0dybY+guIRNGUmCQc2hwfbCpOc3SE/hk
         Vs70XTZmMFg1+DyWal1bgo2paQgPULEk6FQiORa5dauDNv++oX1esKpn1INEyYqJFQ6+
         2tPpqpuykQrGhPwEiF95xxtif7joEzAIdM95DA6WNZw0jyAIQKVOZo0BVhsMNGqWo/RH
         QHjjW7djECiu3WCrMtlaOTD75Rvm8UYvVKapz8NsByDqmhCgdnS8fVKWiFyBhZWVhYcn
         tPOEOETPog9ITDQmdLHoc4L80oFLDDdUghhzwmCy86uZ/lHmec/6jxauSMDOE2Eo/Kid
         9Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCKgG+rjS0qruOZo3hjzG2lpfhG7a6+ZuOs9wue/0iQ=;
        b=ZJliQ42T0XfNUGgrix7F5paHH40k5oIskCyI4bUn2/kpv7AJCKpaSCoGXLVkNY/fEw
         Elgave2YQWNRezGjblDnSGYw4sjhMnh37PHO4t1a1VDeTgvOW67Is1WQtPmHhdKIhFix
         VyfZUEj0fYrG2KQSoe6tWGgyeczgi0hGznJbhJ6Xff+qIAyJ8grOIix4EcQRAu7BmrQi
         zhPkm/IjJC0RGUXjCqhbHixWWHOu7lyJLd5dz9smdZABPKflpQAAp/0q6LUllFaUseMi
         hg2UT+0Oj8R/nBbj27CAMrlZGi911afB4imhIgxQutIkMj3zS+j9vTgQBA/NBqK2CMyg
         DDdg==
X-Gm-Message-State: AO0yUKVWbxhxsWSQETUubhHAYAX98BesePuw2wx9SkW6tiPEUvC3aT6v
        r/wnsLUJmxsNyMLc2V5ZxgOnftAAA9U=
X-Google-Smtp-Source: AK7set+KB5H2UT8an9zvVfAPHW2bzj4ICuwg5BgjGACg9vM18zMPpi4P01I+rK4NsvZjAK5ret06+w==
X-Received: by 2002:a92:c269:0:b0:318:1cff:5e18 with SMTP id h9-20020a92c269000000b003181cff5e18mr5220397ild.3.1678916747165;
        Wed, 15 Mar 2023 14:45:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4-20020a056638060400b003ffa2c6f598sm1967566jar.86.2023.03.15.14.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:45:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] Documentation/hwmon: Remove description of deprecated registration functions
Date:   Wed, 15 Mar 2023 14:45:43 -0700
Message-Id: <20230315214543.3966258-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove description of deprecated registration functions from the hardware
monitoring kernel API documentation to help ensure that no attempts are
made to use them in new drivers.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/hwmon-kernel-api.rst | 60 +++++++-----------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index 5451a6d4c874..dbd68d7b033a 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -19,20 +19,10 @@ also read Documentation/hwmon/submitting-patches.rst.
 
 The API
 -------
-Each hardware monitoring driver must #include <linux/hwmon.h> and, in most
+Each hardware monitoring driver must #include <linux/hwmon.h> and, in some
 cases, <linux/hwmon-sysfs.h>. linux/hwmon.h declares the following
 register/unregister functions::
 
-  struct device *
-  hwmon_device_register_with_groups(struct device *dev, const char *name,
-				    void *drvdata,
-				    const struct attribute_group **groups);
-
-  struct device *
-  devm_hwmon_device_register_with_groups(struct device *dev,
-					 const char *name, void *drvdata,
-					 const struct attribute_group **groups);
-
   struct device *
   hwmon_device_register_with_info(struct device *dev,
 				  const char *name, void *drvdata,
@@ -54,46 +44,30 @@ register/unregister functions::
 
   char *devm_hwmon_sanitize_name(struct device *dev, const char *name);
 
-hwmon_device_register_with_groups registers a hardware monitoring device.
-The first parameter of this function is a pointer to the parent device.
-The name parameter is a pointer to the hwmon device name. The registration
-function will create a name sysfs attribute pointing to this name.
-The drvdata parameter is the pointer to the local driver data.
-hwmon_device_register_with_groups will attach this pointer to the newly
-allocated hwmon device. The pointer can be retrieved by the driver using
-dev_get_drvdata() on the hwmon device pointer. The groups parameter is
-a pointer to a list of sysfs attribute groups. The list must be NULL terminated.
-hwmon_device_register_with_groups creates the hwmon device with name attribute
-as well as all sysfs attributes attached to the hwmon device.
-This function returns a pointer to the newly created hardware monitoring device
-or PTR_ERR for failure.
-
-devm_hwmon_device_register_with_groups is similar to
-hwmon_device_register_with_groups. However, it is device managed, meaning the
-hwmon device does not have to be removed explicitly by the removal function.
-
-hwmon_device_register_with_info is the most comprehensive and preferred means
-to register a hardware monitoring device. It creates the standard sysfs
-attributes in the hardware monitoring core, letting the driver focus on reading
-from and writing to the chip instead of having to bother with sysfs attributes.
-The parent device parameter as well as the chip parameter must not be NULL. Its
-parameters are described in more detail below.
+hwmon_device_register_with_info registers a hardware monitoring device.
+It creates the standard sysfs attributes in the hardware monitoring core,
+letting the driver focus on reading from and writing to the chip instead
+of having to bother with sysfs attributes. The parent device parameter
+as well as the chip parameter must not be NULL. Its parameters are described
+in more detail below.
 
 devm_hwmon_device_register_with_info is similar to
 hwmon_device_register_with_info. However, it is device managed, meaning the
 hwmon device does not have to be removed explicitly by the removal function.
 
+All other hardware monitoring device registration functions are deprecated
+and must not be used in new drivers.
+
 hwmon_device_unregister deregisters a registered hardware monitoring device.
 The parameter of this function is the pointer to the registered hardware
 monitoring device structure. This function must be called from the driver
 remove function if the hardware monitoring device was registered with
-hwmon_device_register_with_groups or hwmon_device_register_with_info.
+hwmon_device_register_with_info.
 
 devm_hwmon_device_unregister does not normally have to be called. It is only
 needed for error handling, and only needed if the driver probe fails after
-the call to devm_hwmon_device_register_with_groups or
-hwmon_device_register_with_info and if the automatic (device managed)
-removal would be too late.
+the call to hwmon_device_register_with_info and if the automatic (device
+managed) removal would be too late.
 
 All supported hwmon device registration functions only accept valid device
 names. Device names including invalid characters (whitespace, '*', or '-')
@@ -351,11 +325,9 @@ Return value:
 Driver-provided sysfs attributes
 --------------------------------
 
-If the hardware monitoring device is registered with
-hwmon_device_register_with_info or devm_hwmon_device_register_with_info,
-it is most likely not necessary to provide sysfs attributes. Only additional
-non-standard sysfs attributes need to be provided when one of those registration
-functions is used.
+In most situations it should not be necessary for a driver to provide sysfs
+attributes since the hardware monitoring core creates those internally.
+Only additional non-standard sysfs attributes need to be provided.
 
 The header file linux/hwmon-sysfs.h provides a number of useful macros to
 declare and use hardware monitoring sysfs attributes.
-- 
2.39.2

