Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157855EADED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiIZRRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIZRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:16:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B89F1B9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:30:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d15so4423647qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lHR+tLwLlFZVOsDGyGungIjdOIM304e5pqFsbgAIkjI=;
        b=JqZBAH6fgNGpjXq+1tnl70IuTY7um4rvV8A5ysl1W6zThnyECiNi0OJFOKXst3pS1r
         Yyh1Ybmxqqf9moyl8YQgP8lozfnluOEhRXSRdsK6A7vkPnyrSOjP0j+gXoT1pWWTw8GF
         hf3bhqd4zS8+1E72Ds5RjhN+kDzlzy72rQj7lX77EdpT56gSIgQ7k+YySD2xZ3sK/eRx
         YCCw7YSpb6quv8MvDFKVEJUvyO1roKjTeinlctmV8fn6JG5suRxtMxpYzAH4HYfNvXJL
         V9IQgDvbib8GxHT+gyJ9fu4CJh+GhywEdJrTce4JK+zqAggW5ck/YC9Bm5lo2y8FSIjn
         1OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lHR+tLwLlFZVOsDGyGungIjdOIM304e5pqFsbgAIkjI=;
        b=4x+HUjMWA7XCFsJMt/BFphJZZfHFkuiWKuOrQ6wwpNNSBPckR5O0KRYuNuLsQ9Px/z
         ouG6C52kmZFMri3V225iGZXBC+xUFI5+yY7ityDraQHqUcCV5lOP/UA6mIkd1cngL0Jb
         vBgosj5pCv8Gl+yDT/4TT9IeYyBhz8umRGEweQEgqDMWWtpqm7J6TtdECXsjW+aVPZsl
         cDhuAGMv6Ur9nPOw0HuxJVODKzYzI1jlywIz8fCCjKxSce18bRfC7Dmii28Em/y37TZD
         Nes13yKOv5K0Kl8P0y/orlR/szK7xd82irIDakP65xTJin5WK+AUqecbrCt8k11IFKQS
         Z4fA==
X-Gm-Message-State: ACrzQf1kKdGjArGou5TtB6eis/Y3ogv7/+TypTifKIZEoaWf9KTV26dT
        sKFWLGITqdiOpTN3bKJbckLdhQ==
X-Google-Smtp-Source: AMsMyM7oln4OquqSWQmSX0tsApjYTEvG0MeBsWWOXIfnP8ND2LkFIfxbM3lHEKA2b6zQP25Tpzbg8w==
X-Received: by 2002:a05:620a:2902:b0:6ce:7e0d:c233 with SMTP id m2-20020a05620a290200b006ce7e0dc233mr14461710qkp.205.1664209814158;
        Mon, 26 Sep 2022 09:30:14 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 139-20020a370a91000000b006ce60296f97sm11542146qkk.68.2022.09.26.09.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 09:30:13 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v6 1/5] counter: Introduce the Signal polarity component
Date:   Mon, 26 Sep 2022 11:16:34 -0400
Message-Id: <8f47d6e1db71a11bb1e2666f8e2a6e9d256d4131.1664204990.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664204990.git.william.gray@linaro.org>
References: <cover.1664204990.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Signal polarity component represents the active level of a
respective Signal. There are two possible states: positive (rising edge)
and negative (falling edge); enum counter_signal_polarity represents
these states. A convenience macro COUNTER_COMP_POLARITY() is provided
for driver authors to declare a Signal polarity component.

Cc: Julien Panis <jpanis@baylibre.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 14 ++++++++++++++
 drivers/counter/counter-chrdev.c            |  1 +
 drivers/counter/counter-sysfs.c             | 12 ++++++++++++
 include/linux/counter.h                     | 10 ++++++++++
 include/uapi/linux/counter.h                |  6 ++++++
 5 files changed, 43 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 06c2b3e27e0b..2a996deabe9e 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -217,6 +217,7 @@ What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
@@ -303,6 +304,19 @@ Description:
 		Discrete set of available values for the respective Signal Y
 		configuration are listed in this file.
 
+What:		/sys/bus/counter/devices/counterX/signalY/polarity
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Active level of Signal Y. The following polarity values are
+		available:
+
+		positive:
+			Signal high state considered active level (rising edge).
+
+		negative:
+			Signal low state considered active level (falling edge).
+
 What:		/sys/bus/counter/devices/counterX/signalY/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 4e71a19d7e6a..120879ee2e87 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -487,6 +487,7 @@ static int counter_get_data(struct counter_device *const counter,
 	case COUNTER_COMP_ENUM:
 	case COUNTER_COMP_COUNT_DIRECTION:
 	case COUNTER_COMP_COUNT_MODE:
+	case COUNTER_COMP_SIGNAL_POLARITY:
 		switch (comp_node->component.scope) {
 		case COUNTER_SCOPE_DEVICE:
 			ret = comp->device_u32_read(counter, &value_u32);
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 04eac41dad33..e5dd36e1a45f 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -91,6 +91,11 @@ static const char *const counter_count_mode_str[] = {
 	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
 };
 
+static const char *const counter_signal_polarity_str[] = {
+	[COUNTER_SIGNAL_POLARITY_POSITIVE] = "positive",
+	[COUNTER_SIGNAL_POLARITY_NEGATIVE] = "negative"
+};
+
 static ssize_t counter_comp_u8_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -201,6 +206,8 @@ static ssize_t counter_comp_u32_show(struct device *dev,
 		return sysfs_emit(buf, "%s\n", counter_count_direction_str[data]);
 	case COUNTER_COMP_COUNT_MODE:
 		return sysfs_emit(buf, "%s\n", counter_count_mode_str[data]);
+	case COUNTER_COMP_SIGNAL_POLARITY:
+		return sysfs_emit(buf, "%s\n", counter_signal_polarity_str[data]);
 	default:
 		return sysfs_emit(buf, "%u\n", (unsigned int)data);
 	}
@@ -252,6 +259,10 @@ static ssize_t counter_comp_u32_store(struct device *dev,
 		err = counter_find_enum(&data, avail->enums, avail->num_items,
 					buf, counter_count_mode_str);
 		break;
+	case COUNTER_COMP_SIGNAL_POLARITY:
+		err = counter_find_enum(&data, avail->enums, avail->num_items,
+					buf, counter_signal_polarity_str);
+		break;
 	default:
 		err = kstrtou32(buf, 0, &data);
 		break;
@@ -469,6 +480,7 @@ static int counter_attr_create(struct device *const dev,
 	case COUNTER_COMP_ENUM:
 	case COUNTER_COMP_COUNT_DIRECTION:
 	case COUNTER_COMP_COUNT_MODE:
+	case COUNTER_COMP_SIGNAL_POLARITY:
 		if (comp->device_u32_read) {
 			dev_attr->attr.mode |= 0444;
 			dev_attr->show = counter_comp_u32_show;
diff --git a/include/linux/counter.h b/include/linux/counter.h
index a81234bc8ea8..b3fb6b68881a 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -31,6 +31,7 @@ enum counter_comp_type {
 	COUNTER_COMP_ENUM,
 	COUNTER_COMP_COUNT_DIRECTION,
 	COUNTER_COMP_COUNT_MODE,
+	COUNTER_COMP_SIGNAL_POLARITY,
 };
 
 /**
@@ -477,6 +478,15 @@ struct counter_available {
 #define COUNTER_COMP_FLOOR(_read, _write) \
 	COUNTER_COMP_COUNT_U64("floor", _read, _write)
 
+#define COUNTER_COMP_POLARITY(_read, _write, _available) \
+{ \
+	.type = COUNTER_COMP_SIGNAL_POLARITY, \
+	.name = "polarity", \
+	.signal_u32_read = (_read), \
+	.signal_u32_write = (_write), \
+	.priv = &(_available), \
+}
+
 #define COUNTER_COMP_PRESET(_read, _write) \
 	COUNTER_COMP_COUNT_U64("preset", _read, _write)
 
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 96c5ffd368ad..e9610e1944dc 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -153,4 +153,10 @@ enum counter_synapse_action {
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
 };
 
+/* Signal polarity values */
+enum counter_signal_polarity {
+	COUNTER_SIGNAL_POLARITY_POSITIVE,
+	COUNTER_SIGNAL_POLARITY_NEGATIVE,
+};
+
 #endif /* _UAPI_COUNTER_H_ */
-- 
2.37.3

