Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9246A4920
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjB0SDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjB0SDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:03:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA130265AD;
        Mon, 27 Feb 2023 10:02:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ee7so29406733edb.2;
        Mon, 27 Feb 2023 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JhaV0ActfLH5erDNEfQE+rUVzC2hPS+1j+2NR6T2MI=;
        b=clC1Q8rIf42i8ybmFnQdwp7ZO9KmsH8TqTEr2aDnDXgFjW8sNJu76AtjEeQFJWYvDh
         VVgtP1p4hFI6vWvhSev9dnT1HwZ/Kb1LLVCcVwbJAzkCbG0iDkEB1xVAm2gq7Y1AQHYc
         8HnMm4GbkGqR4gHMaRDmjB0cXly4F94fPqe6KHvRW18lIKvaUugUIMwuE+kxVbSgag2t
         BuoC6wnv+GcdMTyx8x2iHe++upHhvJzU4iX5ICABIZOfvyU1ttt0OXl4yJRF+kYVEzTC
         L4A5EHWWsW91EsTiidGlEiplDgbg5iKVycqY7rhM1wWYj9U8aokfm0U+d51GpVt1nXYP
         Ds9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JhaV0ActfLH5erDNEfQE+rUVzC2hPS+1j+2NR6T2MI=;
        b=Z9lbv0lw7DKHwl4U5dVQKjKznteTiJ37B2GbUDNjFiOWuBw536qZ9XQA76TEMv/drD
         JmVSG7sSEogZOaEZKP7virkThKLmTugLWgUY5ISDDwBASK8SvZ3/nAIgmx/5dktiD2eK
         wslo1myPf7mK4r8psIyEL/L8E+xtpUPY62dfmPdP12kOzWnaoq2kVT5GBBPzLXZJkkO1
         FZ7GwQ3Cay3yukT9WZ5bEZVtXTgRbPcu/YonPlfAPnx63l+Zf1d1vpASkIdsTWC+SHEO
         0DHo27z7hQG/wMNnr9Yxt8udm585rNBpDwqDXCvVybLX0Y/GLNU0YLfKazcDreSSiiIf
         Jk6g==
X-Gm-Message-State: AO0yUKUcFjmV+guxv8jRmg+3dhJTFDUdw+HZoaIMNSIoPdNEsczCD99e
        9dIQ0i234rFxKKNZgvNJyqg=
X-Google-Smtp-Source: AK7set/yXGQiHEDrjF3qsEIyfWzMXagRlnQHibas1yJuIlZTAF04Ff1HWu4GkO85El/muVNUCPIK7g==
X-Received: by 2002:aa7:c646:0:b0:4ac:bd84:43d8 with SMTP id z6-20020aa7c646000000b004acbd8443d8mr460612edr.8.1677520861908;
        Mon, 27 Feb 2023 10:01:01 -0800 (PST)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::dc02])
        by smtp.gmail.com with ESMTPSA id n30-20020a50935e000000b004af640933desm3423578eda.78.2023.02.27.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:01:01 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Date:   Mon, 27 Feb 2023 19:00:38 +0100
Message-Id: <219496d4d21755937a40c2c7dfbeca64660c9258.1677520155.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1677520155.git.mehdi.djait.k@gmail.com>
References: <cover.1677520155.git.mehdi.djait.k@gmail.com>
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
 drivers/iio/industrialio-trigger.c | 7 +++++++
 include/linux/iio/trigger.h        | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index a2f3cc2f65ef..0ed3ff313c9b 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -192,6 +192,13 @@ static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
 		schedule_work(&trig->reenable_work);
 }
 
+/**
+ * iio_trigger_poll() - Call the IRQ trigger handler of the consumers
+ * @trig: trigger which occurred
+ *
+ * This function needs to be called from an interrupt context.
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

