Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA36C033C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCSQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:45:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C1168BF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:45:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso13940286pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679244329;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmtLzAp7TAfFzU4Wal3aHOCAS9vHX2uOg0KnFqhgfOg=;
        b=LXs9nIjHeLGc4vvNlmA23A/cSABl8I0XqAC1aUqw4CUby9pvLsTuK+E/TA3D3Bz5a9
         3iBf1J/ArqNespEhEmmrBwb444AgD9APc8yDQD/YiU/+E7/9CqeSgSIpE2bb/pZPTp7B
         wOOh6SiAnC7qlePvsPYEk7H6nmZqnYJy/3vtJhd31RFDVkHgXhAptaQhgsLadb+W5IhE
         A8MNpfPa1HdDhAHNTK6BN6qKHHBc/L3qWrLpK8BVbtWJov/xFFcxWOihgu44cA736mo1
         5LeUWymaryZOHNVb6weW14aeEn+feYT7V4VMYlavnQB/0pEGMJ5jXxx6P6VpsU0zt3oo
         Lcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679244329;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmtLzAp7TAfFzU4Wal3aHOCAS9vHX2uOg0KnFqhgfOg=;
        b=GIDtux7ZlUsh9/zwaCJlLrF9vMKPDawjGrBKww3uIds+30i20sra2nq0TIQXlMWJg2
         JzFAJGHNNQuqscVqQIESee/IAvTEM44qVTHF6GGUnPf7RmZfCG2HEkDyTIyhmCm8NDXT
         9xQtn2dTbmz3Sv0MiFye0/2DkYdD0DVbkbVFjq/nKfOEgLOxqkyvKkhL9MBNnFHVJZik
         4NcvZ6F0tvQANf4C3ro7Xteut1PczchYUA0RCzhnZmAx1w4xZ6WW86DL7kdIzztB2mBS
         lw3WsnQ3LJ1yepQIGGKAhrjtlQI/UsG9Zlx9nIQKnAbYt5lsI8rr8Moa5xCn431Rycq7
         ziVQ==
X-Gm-Message-State: AO0yUKVDzvxBX8cwVjKuTP2Rbgx42b7joPb6UGixeEyOGY0AUzKFv3Gg
        kXHIPKDYys9cIHfnkJs965EmhcYawuKa4Q==
X-Google-Smtp-Source: AK7set89cJ4rq6OJEYq0Uljx9YEOr8CfmsGk8+Y5TyoZookPRhjaGAooHa6/vi5uZaiShmz6OVcAzQ==
X-Received: by 2002:a05:6a20:7aa2:b0:d9:1ec8:e9bb with SMTP id u34-20020a056a207aa200b000d91ec8e9bbmr2242327pzh.28.1679244329269;
        Sun, 19 Mar 2023 09:45:29 -0700 (PDT)
Received: from sumitra.com ([117.209.117.91])
        by smtp.gmail.com with ESMTPSA id m5-20020aa79005000000b00627f1efd470sm1091128pfo.135.2023.03.19.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:45:28 -0700 (PDT)
Date:   Sun, 19 Mar 2023 09:45:20 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     outreachy@lists.linux.dev
Subject: [PATCH] Staging: greybus: Fix lines ending with '('
Message-ID: <20230319164520.GA125117@sumitra.com>
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

The coding style used to limit lines to 80 characters,
which led to splitting of these function headers into multiple
lines and ends the first line with a '('.
Such splits causes checks reported by the checkpatch.

Place the function parameters of each function immediately after
'(' in a single line to align the function headers.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 .../staging/greybus/audio_manager_module.c    | 40 +++++++++----------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 0a0f0a394c84..81b4ba607a0e 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -70,9 +70,8 @@ static void gb_audio_module_release(struct kobject *kobj)
 	kfree(module);
 }
 
-static ssize_t gb_audio_module_name_show(
-	struct gb_audio_manager_module *module,
-	struct gb_audio_manager_module_attribute *attr, char *buf)
+static ssize_t gb_audio_module_name_show(struct gb_audio_manager_module *module,
+					 struct gb_audio_manager_module_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s", module->desc.name);
 }
@@ -80,9 +79,8 @@ static ssize_t gb_audio_module_name_show(
 static struct gb_audio_manager_module_attribute gb_audio_module_name_attribute =
 	__ATTR(name, 0664, gb_audio_module_name_show, NULL);
 
-static ssize_t gb_audio_module_vid_show(
-	struct gb_audio_manager_module *module,
-	struct gb_audio_manager_module_attribute *attr, char *buf)
+static ssize_t gb_audio_module_vid_show(struct gb_audio_manager_module *module,
+					struct gb_audio_manager_module_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d", module->desc.vid);
 }
@@ -90,9 +88,8 @@ static ssize_t gb_audio_module_vid_show(
 static struct gb_audio_manager_module_attribute gb_audio_module_vid_attribute =
 	__ATTR(vid, 0664, gb_audio_module_vid_show, NULL);
 
-static ssize_t gb_audio_module_pid_show(
-	struct gb_audio_manager_module *module,
-	struct gb_audio_manager_module_attribute *attr, char *buf)
+static ssize_t gb_audio_module_pid_show(struct gb_audio_manager_module *module,
+					struct gb_audio_manager_module_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d", module->desc.pid);
 }
@@ -100,9 +97,9 @@ static ssize_t gb_audio_module_pid_show(
 static struct gb_audio_manager_module_attribute gb_audio_module_pid_attribute =
 	__ATTR(pid, 0664, gb_audio_module_pid_show, NULL);
 
-static ssize_t gb_audio_module_intf_id_show(
-	struct gb_audio_manager_module *module,
-	struct gb_audio_manager_module_attribute *attr, char *buf)
+static ssize_t gb_audio_module_intf_id_show(struct gb_audio_manager_module *module,
+					    struct gb_audio_manager_module_attribute *attr,
+					    char *buf)
 {
 	return sprintf(buf, "%d", module->desc.intf_id);
 }
@@ -111,9 +108,9 @@ static struct gb_audio_manager_module_attribute
 					gb_audio_module_intf_id_attribute =
 	__ATTR(intf_id, 0664, gb_audio_module_intf_id_show, NULL);
 
-static ssize_t gb_audio_module_ip_devices_show(
-	struct gb_audio_manager_module *module,
-	struct gb_audio_manager_module_attribute *attr, char *buf)
+static ssize_t gb_audio_module_ip_devices_show(struct gb_audio_manager_module *module,
+					       struct gb_audio_manager_module_attribute *attr,
+					       char *buf)
 {
 	return sprintf(buf, "0x%X", module->desc.ip_devices);
 }
@@ -122,9 +119,9 @@ static struct gb_audio_manager_module_attribute
 					gb_audio_module_ip_devices_attribute =
 	__ATTR(ip_devices, 0664, gb_audio_module_ip_devices_show, NULL);
 
-static ssize_t gb_audio_module_op_devices_show(
-	struct gb_audio_manager_module *module,
-	struct gb_audio_manager_module_attribute *attr, char *buf)
+static ssize_t gb_audio_module_op_devices_show(struct gb_audio_manager_module *module,
+					       struct gb_audio_manager_module_attribute *attr,
+					       char *buf)
 {
 	return sprintf(buf, "0x%X", module->desc.op_devices);
 }
@@ -181,10 +178,9 @@ static void send_add_uevent(struct gb_audio_manager_module *module)
 	kobject_uevent_env(&module->kobj, KOBJ_ADD, envp);
 }
 
-int gb_audio_manager_module_create(
-	struct gb_audio_manager_module **module,
-	struct kset *manager_kset,
-	int id, struct gb_audio_manager_module_descriptor *desc)
+int gb_audio_manager_module_create(struct gb_audio_manager_module **module,
+				   struct kset *manager_kset,
+				   int id, struct gb_audio_manager_module_descriptor *desc)
 {
 	int err;
 	struct gb_audio_manager_module *m;
-- 
2.25.1

