Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3CE6F301D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjEAKQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 06:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 06:16:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34AE6;
        Mon,  1 May 2023 03:16:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f161ee14fso78145966b.0;
        Mon, 01 May 2023 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682936198; x=1685528198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=93TBlzDzoT1wtp8An/95IHkU2ENlETSYZYDB2GGro8w=;
        b=sTjGdt9kxizaGq0cMEqXozsjwqpOak96bF/ispjSAjjx4TKex54FFHoU/aAjHUsfg6
         6pVl8lftP6u6eVu70MR+0R2D22wu+YgwMBnRranzfrwhmUAl1f5MKxdqUMivO8avT4Fe
         J419B8HhXlx5Gmazxy5Wd16J7qFfwYvarFpEXnPSy3JDndmi3LjdH/9uEFv23Io3d+3G
         9/2E++rzy5Q+mQNp7KOB1Lfriig1kocdJ7G9S8V/0QZdCbu/OJJloGXeMaAKr+gdIHTC
         9toKT170vXKOMzu8kpTz9gz60c9lyPxabrdBXojpy1q6g6P6WAOJzkRd/ekRX7Z/IGZu
         Sayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682936198; x=1685528198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93TBlzDzoT1wtp8An/95IHkU2ENlETSYZYDB2GGro8w=;
        b=EDrUSEx4MIOtKS8Lwz05HZsTKUlmxr3TSIo5yX3mNhUKGSu5ErZEsuRWiirUIsBhAw
         b6bVDWZpwYg56vBvlLzp1kNGT44T298KeHWiIH65aE+DgZ6e2it3Y1CS7z8OsZ6LtWCS
         oGUFSbf+laJLvaSHIn+DwNWbJc7KJhPdKALdR/noYBDoGg0kz7V+3t06FDD3cVgJNgl4
         +zEy5vTp7VcbxUyaN9VsMe8jp5PZn6FKlnHrIRIzBdOA5v1P16/NtD+a2tEbJHCLPbZO
         OcsFj7q2LdRqHHHXniA1envhwCNHn5gm8iGSgnz5akv5lXipgJsufl5hNgVfxJuVLt/5
         O7Fg==
X-Gm-Message-State: AC+VfDw6qyxv9RV0LXhnol/kB8zmdiAq/T5cr9jvoHGhPH2DIXNkZ9hD
        bmLGubgBQG45nfoiynBC8I0=
X-Google-Smtp-Source: ACHHUZ5JCVLg6Vd1xQS7WcqurRX9+ZHoyD7a601rkTEbwcCPZpjAT/5x0iwRqtZAY7lHlu7F9o6owA==
X-Received: by 2002:a17:906:5352:b0:94f:4ec3:f0e7 with SMTP id j18-20020a170906535200b0094f4ec3f0e7mr11395200ejo.2.1682936198106;
        Mon, 01 May 2023 03:16:38 -0700 (PDT)
Received: from ivan-B550MH.. ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id gq18-20020a170906e25200b0094eeda0df09sm14749458ejb.179.2023.05.01.03.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 03:16:37 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] ALSA: docs: Extend module parameters description
Date:   Mon,  1 May 2023 14:16:34 +0400
Message-Id: <20230501101634.476297-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common ALSA module parameters look a little bit confusing because of the
description lacking, and it took me a while to understand the purpose of
their existence. To figure it out I asked the question about them to the
"alsa-devel" mailing list, and Takashi Iwai answered me with the text I
appended to the ALSA documentation in this patch.

These common module parameters aren't used a lot nowadays, but as I
understand they are important for providing compatibility with some
existing user-space apps. So in my opinion it is a good idea to document
why we need them.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 Documentation/sound/alsa-configuration.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index af71c68f1e4e..829c672d9fe6 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -133,6 +133,19 @@ enable
     enable card;
     Default: enabled, for PCI and ISA PnP cards
 
+These options are used for either specifying the order of instances or
+controlling enabling and disabling of each one of the devices if there
+are multiple devices bound with the same driver. For example, there are
+many machines which have two HD-audio controllers (one for HDMI/DP
+audio and another for onboard analog). In most cases, the second one is
+in primary usage, and people would like to assign it as the first
+appearing card. They can do it by specifying "index=1,0" module
+parameter, which will swap the assignment slots.
+
+Today, with the sound backend like PulseAudio and PipeWire which
+supports dynamic configuration, it's of little use, but that was a
+help for static configuration in the past.
+
 Module snd-adlib
 ----------------
 
-- 
2.34.1

