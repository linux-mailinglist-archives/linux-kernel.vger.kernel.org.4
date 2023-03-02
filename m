Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5F6A8334
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCBNFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCBNFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:05:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7034F5E;
        Thu,  2 Mar 2023 05:05:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g3so11828060eda.1;
        Thu, 02 Mar 2023 05:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzkzX1RgURPfixBUIM5rPRAXQ0wme5cmqoYe05Kozgg=;
        b=hX/GniBWzMvBnDAlzovo5h0O8iQGQvHl6FYLmuQIxa8sqaI4bnF9VjcBmLWwWwsgnK
         R7quH4LaPShX3r1dtDB27Ph48mn+AV1Ow3rli3+e+56phry0hVtR2CoZ2BMKs69jMvpX
         O7isb1vGNbHm2bx3AhZ3Z0m2K9Q+uGd3LgvNIsdI704TN9puJpu3pM4gqyULxf5mhVXY
         R3XwWXc76l1A+RNhodVVAIwIhf9zdYHcbday/Pfap9EPcqnObntPxkYUwws4rfUBAwxW
         FQzhwhLWLdtEpkEjtw0JE1EwKAUojXempx06r2vUkEejzitrUlG0h9WuIt1MbyJawFQW
         yk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzkzX1RgURPfixBUIM5rPRAXQ0wme5cmqoYe05Kozgg=;
        b=wnDr97OcuULc6hhQh0q8V63F3/43aWG/MQYKHohOS9jfXo0y1edGcvFTA3/x7tk3n7
         00iITU56Qk2T/uWrPpIEr0fGQTFy5CncN/wbjudumdVrAKjyjR09s15t5Lahjqa7Elcy
         BIn7mCd5l5i1F3vBTpFpc0FmXkABQ+t9WDr3RG12mpwt4RfkSq5/Z2NzgOkwpUXSw6lL
         usSuJWvNCi+GmnAMmNVuHlVpbwpwXyYhXdGf50fQMT3ju8E7QwKfanrrveQRYXqqL3RU
         xPp/rbK3UPH34yek7zLM/rNF/8J0MylN7LKiuNRFkHRGqGd6zj9XhfKjCc4EbSun+aIG
         XyMQ==
X-Gm-Message-State: AO0yUKV9o0yQsoOUsVeCL0Q/hGqJ9Nll8/qPM4PZ4RxJrPiJYjuDCNn7
        hpZBPl/6Z5sI16Io99ieyac=
X-Google-Smtp-Source: AK7set/6aTLbuvbN2S1xCQqqBkeZvxgDIGSVy9lcvaQVb6wTJgWWU0BFGc38XjaMcrRq75tgXC79vA==
X-Received: by 2002:a17:906:2cd3:b0:878:5372:a34b with SMTP id r19-20020a1709062cd300b008785372a34bmr10359533ejr.45.1677762327784;
        Thu, 02 Mar 2023 05:05:27 -0800 (PST)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::dc02])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b004af759bc79asm6932903edi.7.2023.03.02.05.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:05:27 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v2 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Date:   Thu,  2 Mar 2023 14:04:35 +0100
Message-Id: <bd84fc17e9d22eab998bf48720297f9a77689f45.1677761379.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1677761379.git.mehdi.djait.k@gmail.com>
References: <cover.1677761379.git.mehdi.djait.k@gmail.com>
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

Move the kernel-doc of the function to industrialio-trigger.c
Add a note on the context where the function is expected to be called.

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v2:
- Changed the expected context of from interrupt to hard IRQ context

 drivers/iio/industrialio-trigger.c | 7 +++++++
 include/linux/iio/trigger.h        | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index a2f3cc2f65ef..bb0a44df8740 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -192,6 +192,13 @@ static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
 		schedule_work(&trig->reenable_work);
 }
 
+/**
+ * iio_trigger_poll() - Call the IRQ trigger handler of the consumers
+ * @trig: trigger which occurred
+ *
+ * This function needs to be called from a hard IRQ context.
+ *
+ */
 void iio_trigger_poll(struct iio_trigger *trig)
 {
 	int i;
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index f6360d9a492d..42da55dc3aa7 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -151,12 +151,6 @@ void iio_trigger_unregister(struct iio_trigger *trig_info);
  **/
 int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *trig);
 
-/**
- * iio_trigger_poll() - called on a trigger occurring
- * @trig:	trigger which occurred
- *
- * Typically called in relevant hardware interrupt handler.
- **/
 void iio_trigger_poll(struct iio_trigger *trig);
 void iio_trigger_poll_chained(struct iio_trigger *trig);
 
-- 
2.30.2

