Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1056FE92A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbjEKBQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjEKBQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:16:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7E10CF;
        Wed, 10 May 2023 18:16:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso9033824e87.2;
        Wed, 10 May 2023 18:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683767802; x=1686359802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZX3gBpj+yVowR5nZi0Lljy6ylvdGKms7Iq3ArHA/fk=;
        b=hdO+lGi1gMkObZQ/7g9OhwH2V7dSNOhRaTPDAkQngKvMAi1Q7DDSc+zX9BhrFMvoKn
         irFEoI/Mgsw930Dppz5WXALao4vmBQd8g4tFVviP+nJb+6e1IfjGtZQ+gsBsS/zNEtZU
         Qm9OsxkQ9jxZawtN/qLi6qKk8Y8qcu5ilGxYDemuSzzaBkmX8VYgrYqxAQn6Fpb9ANHI
         zYfvLn2ccCwjDQtBg6DHHukZi3w8Cdpl8z6sQvH6dKaDd0SurYSeXwdpTOdiXMYdaX9F
         Sk8HNz6SnWGFcP1iRVcRv2kIJMn5bsSqbf31b/3++CWTKzKvWWuPo9awhqm1CGHioRbv
         Zmaw==
X-Gm-Message-State: AC+VfDwFpIKRGXdywagSXncvjnaNyCythF4e3tmk3ahliJEX9TZ8Ow6m
        yPZ5ZiOixzduvc3+xcC+xrsqb7A8WiUq7LD1
X-Google-Smtp-Source: ACHHUZ7PfJesGSVBHVyKaWM1ZJogQTQl0bO3v8WNLP3wXF9WJo+uC0BYEibRlAqz4bkoy0VNj3VHPg==
X-Received: by 2002:a05:6512:390c:b0:4db:2ab7:43e6 with SMTP id a12-20020a056512390c00b004db2ab743e6mr2342463lfu.44.1683767802595;
        Wed, 10 May 2023 18:16:42 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.246.252])
        by smtp.gmail.com with ESMTPSA id k4-20020ac24564000000b004edc3f06f5csm905972lfm.296.2023.05.10.18.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 18:16:42 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 714903B3; Thu, 11 May 2023 03:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1683767801; bh=9YKrOYnwOUN5w6yC/X1JkyB0eGmZBase1QavC726ui8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZ/o1MSRLegoY4FOQvQDLwikRnqhl8cwuIflPIzQu4HzREjshtzOCMjwn3w9MSDXG
         MuziwFL+VOCExnbHqJjno/7QGu7/5lk+9ujJ0HS7Zw1MfsTIhKzKcgOVxcfSiQKBq/
         qILY9ICN/ps4WMyBT0CafoK1eMAjXKJgphx0RGWE=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
Received: from x1-carbon.. (unknown [64.141.80.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id D4C9C3C7;
        Thu, 11 May 2023 03:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1683767685; bh=9YKrOYnwOUN5w6yC/X1JkyB0eGmZBase1QavC726ui8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oddCZUd+U9sGBIN2/0yRNxmbKsFKyOpc6BKGWTXp5BqrrxanbUxTjQbVzPpUgIBn5
         m0wCIptqZzaDe6C1u5LvlHaGw68mZSL3d4o4hJqwFIX6/Za4POa+pxBzZfg4t7g9tM
         5kLGeuLNHYOEuDO1JskQeePSQesRdyQlwGqzTDMc=
From:   Niklas Cassel <nks@flawful.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v7 02/19] block: introduce ioprio hints
Date:   Thu, 11 May 2023 03:13:35 +0200
Message-Id: <20230511011356.227789-3-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511011356.227789-1-nks@flawful.org>
References: <20230511011356.227789-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <dlemoal@kernel.org>

IO priorities currently only use 6-bits of the 16-bits ioprio value: the
3-upper bits are used to define up to 8 priority classes (4 of which are
valid) and the 3 lower bits of the value are used to define a priority
level for the real-time and best-effort class.

The remaining 10-bits between the IO priority class and level are
unused, and in fact, cannot be used by the user as doing so would
either result in the value being completely ignored, or in an error
returned by ioprio_check_cap().

Use these 10-bits of an ioprio value to allow a user to specify IO
hints. An IO hint is defined as a 10-bits value, allowing up to 1023
different hints to be specified, with the value 0 being reserved as the
"no hint" case. An IO hint can apply to any IO that specifies a valid
priority class other than NONE, regardless of the IO priority level
specified.

To do so, the macros IOPRIO_PRIO_HINT() and IOPRIO_PRIO_VALUE_HINT() are
introduced in include/uapi/linux/ioprio.h to respectively allow a user
to get and set a hint in an ioprio value.

To support the ATA and SCSI command duration limits feature, 7 hints
are defined: IOPRIO_HINT_DEV_DURATION_LIMIT_1 to
IOPRIO_HINT_DEV_DURATION_LIMIT_7, allowing a user to specify which
command duration limit descriptor should be applied to the commands
serving an IO. Specifying these hints has for now no effect whatsoever
if the target block devices do not support the command duration limits
feature. However, in the future, block IO schedulers can be modified to
optimize IO issuing order based on these hints, even for devices that
do not support the command duration limits feature.

Given that the 7 duration limits hints defined have no effect on any
block layer component, the actual definition of the duration limits
implied by these hints remains at the device level.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/uapi/linux/ioprio.h | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 4444b4e4fdad..607c7617b9d2 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -58,4 +58,53 @@ enum {
 #define IOPRIO_NORM	4
 #define IOPRIO_BE_NORM	IOPRIO_NORM
 
+/*
+ * The 10-bits between the priority class and the priority level are used to
+ * optionally define IO hints for any combination of IO priority class and
+ * level. Depending on the kernel configuration, IO scheduler being used and
+ * the target IO device being used, hints can influence how IOs are processed
+ * without affecting the IO scheduling ordering defined by the IO priority
+ * class and level.
+ */
+#define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
+#define IOPRIO_HINT_NR_BITS		10
+#define IOPRIO_NR_HINTS			(1 << IOPRIO_HINT_NR_BITS)
+#define IOPRIO_HINT_MASK		(IOPRIO_NR_HINTS - 1)
+#define IOPRIO_PRIO_HINT(ioprio)	\
+	(((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)
+
+/*
+ * Alternate macro for IOPRIO_PRIO_VALUE() to define an IO priority with
+ * a class, level and hint.
+ */
+#define IOPRIO_PRIO_VALUE_HINT(class, level, hint)		 \
+	((((class) & IOPRIO_CLASS_MASK) << IOPRIO_CLASS_SHIFT) | \
+	 (((hint) & IOPRIO_HINT_MASK) << IOPRIO_HINT_SHIFT) |	 \
+	 ((level) & IOPRIO_LEVEL_MASK))
+
+/*
+ * IO hints.
+ */
+enum {
+	/* No hint */
+	IOPRIO_HINT_NONE = 0,
+
+	/*
+	 * Device command duration limits: indicate to the device a desired
+	 * duration limit for the commands that will be used to process an IO.
+	 * These will currently only be effective for SCSI and ATA devices that
+	 * support the command duration limits feature. If this feature is
+	 * enabled, then the commands issued to the device to process an IO with
+	 * one of these hints set will have the duration limit index (dld field)
+	 * set to the value of the hint.
+	 */
+	IOPRIO_HINT_DEV_DURATION_LIMIT_1 = 1,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_2 = 2,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_3 = 3,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_4 = 4,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_5 = 5,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_6 = 6,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_7 = 7,
+};
+
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.40.1

