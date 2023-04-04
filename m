Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E76D6C18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjDDSbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbjDDSal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:30:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE25588;
        Tue,  4 Apr 2023 11:27:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z42so34834428ljq.13;
        Tue, 04 Apr 2023 11:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bti8eJLltyo1mqrSI8i502Bwxb9uKtmIuJYoUhM+oGI=;
        b=2GxU0KggcEJBrIRqT1b0+mcCizSdsW7O6/NxHo2xvL8VRWUm109UEravYMZr9ffFT7
         4yGYPaTOq7iHclz1VZbMt7McucXARc3rSktLn5RFqBce+3YWmtIDlCltYf7piWmWmcHO
         sbrLj8XuceLtAEe6ZEzFiNX+AXK9VPBoAC8PeXLbAHyZnJX2rdkK5eoqZk2/n3O6ssEm
         lsHmfF7D+JhB79nRugHlA+7l+TqS7d47lhj98q3337xfhlaGqbA/8Ie5/ALEYfdolQ5F
         0zaLEuR7zSYm/rIGET+jRwe4gHJ3FzDujFL5fampntqB6gg/miTq5nJfZMBLzhUSJrh6
         JeuA==
X-Gm-Message-State: AAQBX9fkFwu5acuR3j8dUR8knpu9yisaAJMf7Kos5HX0m6VUMLof08g4
        vJi5f6n7it8fTdD0zVZ2domkRLdCFpPSjQ==
X-Google-Smtp-Source: AKy350agqMj/mGaZryslBgOa2I42PdLFUE4fhqrnaZGP1GtVX+5ddhRXGF4bn3Gbf4qYj2bE/Syjyw==
X-Received: by 2002:a2e:9d0e:0:b0:2a6:3161:6eed with SMTP id t14-20020a2e9d0e000000b002a631616eedmr967251lji.32.1680632855594;
        Tue, 04 Apr 2023 11:27:35 -0700 (PDT)
Received: from flawful.org (c-a3f5e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.245.163])
        by smtp.gmail.com with ESMTPSA id t8-20020ac25488000000b004d5813386fdsm2406576lfk.139.2023.04.04.11.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:27:35 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 6787D2C0; Tue,  4 Apr 2023 20:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1680632854; bh=FHO3iDOGQC1PtH6j/1w7cXF0Z0P1HSJgVq8t6FkMnTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRyljA7q/ImC7nDLDTKjzP21VSxJi23ABtk0mBsbqcwrQbwU//CvNUAYY4ppPwsN8
         U3EotOCaCwOKjEukFj+FAg7bzFfyAS0Ml2G5RexH10TAcC4gZL/yGXpJjW8R0YAzTH
         dtREYacrTffGSEIeiIsxrKsg88HYaoNhm2iGuYKA=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 26BCA895;
        Tue,  4 Apr 2023 20:25:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1680632732; bh=FHO3iDOGQC1PtH6j/1w7cXF0Z0P1HSJgVq8t6FkMnTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXj8YQYvd7oIUmIR5b0SoJvUSLp9iUldMB4rjttvpdQKNSY5JgUbMRkFrJijQY86j
         KhUscay+jum3ZWMWkY7+yYcY9qir1X+AwoEQBUmVOKZ+BU9IbIt83AijDv/bfx3Bas
         D2kjmA49RGq6+vJs/Iy1yoxiEadTn7rIAtxyChuk=
From:   Niklas Cassel <nks@flawful.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v5 02/19] block: introduce ioprio hints
Date:   Tue,  4 Apr 2023 20:24:07 +0200
Message-Id: <20230404182428.715140-3-nks@flawful.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404182428.715140-1-nks@flawful.org>
References: <20230404182428.715140-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

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

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
2.39.2

