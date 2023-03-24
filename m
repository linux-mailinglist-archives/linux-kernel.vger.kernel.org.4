Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54306C78E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCXHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCXHdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:33:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3C40C0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:33:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id kq3so1064414plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679643198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFqGuLOjRab6Iw0/SrS988UhB5baV+MAIu0DYUhVDv8=;
        b=TbYYunfAKu2D1sw2lxqSPDFgQq4QxB+C6KjrzoaYoQYJvFSh0LNCsqjKiCCBwW8BrP
         rk4reQW4vq5tKm4rrPB80RQvjxvUG/AaHRLKhgsHpM7L1cV/MZw/iroBWlF4F6VYXt9t
         6a7u+Tk3RzBMl3L82gu3xu/B9ieFWV5IwnkU7rnS3FEalfbAiVwxZMP0k1sT6cWn+7cm
         cy9NzMtALZfOnXCmtCfiE+qxHRMfF0DsmmOG8YrZcLrkS5tzTZcmXzd4LWfmnwxpzmsa
         BMBl0cZkLNcPFz12Cc03ppXMt2WRhC1bLEW4pGj/FMc7OwKYL4cnTqvT3ZA8ZHNr52Fm
         MxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFqGuLOjRab6Iw0/SrS988UhB5baV+MAIu0DYUhVDv8=;
        b=HDW/C8jBk/+7LvKiTBPtq3xcnPWGAfYmbzgrnDCdV3HLjSQHms0OTjgOfK8QgJ+dzM
         MxyNAV/qRhk8Rt+JMR7D59oImIKDFjPIl7kqi3+8GN3GadTQpbI53ozU/rnQlKHfQOKn
         5OfAdc/zXPV7KH5P3fUSqClX2/VRvIl6PCHZaRLlKm941cERBIvPLq8ynU0pqrWBlG0+
         ReLCAZIQDWRxws13MnL9ijm+uLJLnWwB1rM/cqMjd9rZuIyA34IJJbNzgX7mjtMiwMLg
         heJ6JBYGaCjwaaGhoX1C+Yt+Z48OTiMX9Q7Nb3Hu6ecHKV/UTjz12U64Z5tOEmap6/p2
         a7RQ==
X-Gm-Message-State: AAQBX9ekSoqJW6hk9RqOjanOTaImmtEvJIDo0jo+SX/nwAQTT049eyOJ
        /miSL7YKPX6Vl5Dj1Swe9L6mHv8ofjbVYQ==
X-Google-Smtp-Source: AKy350ZmLpoEtnDFhblQhO36/Gw2rsyoAihKSYf9RxCSZz16qfqGjrCblTnYSoqo8UcH1lMfy5MJkA==
X-Received: by 2002:a17:902:e84d:b0:1a1:b528:9bea with SMTP id t13-20020a170902e84d00b001a1b5289beamr2028314plg.50.1679643197759;
        Fri, 24 Mar 2023 00:33:17 -0700 (PDT)
Received: from ubuntu.localdomain ([59.89.175.90])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0019a75ea08e5sm13511604plp.33.2023.03.24.00.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:33:17 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v2 2/3] Staging: greybus: Use inline function for gb_audio_manager_module
Date:   Fri, 24 Mar 2023 00:30:00 -0700
Message-Id: <f200046cde9d205904f3050718a3936ed813974f.1679642024.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679642024.git.sumitraartsy@gmail.com>
References: <cover.1679642024.git.sumitraartsy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 'gb_audio_manager_module' from a macro to a static
inline function, to make the relevant types apparent in the
definition and to benefit from the type checking performed by
the compiler at call sites.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
v2: Change patch subject, noted by Alison Schofield 
<alison.schofield@intel.com>

 drivers/staging/greybus/audio_manager_module.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 81b4ba607a0e..5f9dcbdbc191 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -12,8 +12,11 @@
 
 #define to_gb_audio_module_attr(x)	\
 		container_of(x, struct gb_audio_manager_module_attribute, attr)
-#define to_gb_audio_module(x)		\
-		container_of(x, struct gb_audio_manager_module, kobj)
+
+static inline struct gb_audio_manager_module *to_gb_audio_module(struct kobject *kobj)
+{
+	return container_of(kobj, struct gb_audio_manager_module, kobj);
+}
 
 struct gb_audio_manager_module_attribute {
 	struct attribute attr;
-- 
2.25.1

