Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7B6989D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBPBbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPBbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:31:12 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251F1A487
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:31:08 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 7so328293pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcPqK3Lgh7toUISGGZAof+/agete+a/54Ojmx1YinU8=;
        b=qD2gbNO796o+loCjd2HIihecj2WOolx1k1qAQObBdJ2VKafCvSTg/NoD1B3bOOGWfa
         z1veKhXpURUGadlHtDgoOnxLwRoXP8zvg4GTPPBpAKKuJ7E0PKJ3U75X6h9uwjXcvT3O
         V9QH59quwslCjC4h2L5VZJH6rkuOH+LQJDYpRpdZditgxSX6Q74BRzYK4BL/NTU1iKf5
         m3uAnikVW27Ua8hM/guNjipiYG3bqcctgMTaiiQHLDsF3g7kpUl6S/7RArz2S7Qf1x2w
         diu3MzKd3AUUR6V6358bq42sXFX9EHuqUrMA0ap/ZA7aD66T0uv2aTgHXKEPRKSoyoYx
         chcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcPqK3Lgh7toUISGGZAof+/agete+a/54Ojmx1YinU8=;
        b=sd/SOXFs0CdUtSukz6SFaM6TzLKvngoIgWt04gCGRO/VuMQB89qYYpm0O2rnw79Xna
         DM839c3KhzctHv/DfVCkhwwJtUWejag20robh0eXmiLYO4ADvLrrJ4Spd5ujJ76+cpsj
         +aHTgXo/lHSZg7Br4KesMzM7ukwCh5EyLntFVH63csz2jKYQS2WKbRogb6CCa+vspLc0
         nAMLAjyCWQZ15ScwBqvhLQmT0feHAUS7O893gZO4hxJRrI6i14QQpOGCGcE7UPvhVbna
         713BgWGrtQpa6EVulwkRv8OAxS6SENxBNcUFVHEUADG9WteFspbXkE3GzG0VhITfPH9r
         gkRA==
X-Gm-Message-State: AO0yUKVzac+/VLq6j6nTleZprjRqrvJDRi2qs8k5MCLkhoIX/lfixJFq
        zO5vlkCmleS+PcU7SEkUN3I=
X-Google-Smtp-Source: AK7set+l5v1Tle+HAPilMSYH+wPJwlYGDHd30b5EoCRvvmMLzZu8JMEtGt6TmN5qQISyXZ04GzLitQ==
X-Received: by 2002:a62:1d58:0:b0:5a8:a250:bc16 with SMTP id d85-20020a621d58000000b005a8a250bc16mr3224007pfd.3.1676511067772;
        Wed, 15 Feb 2023 17:31:07 -0800 (PST)
Received: from localhost.localdomain (c-98-35-160-214.hsd1.ca.comcast.net. [98.35.160.214])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b005941ff79428sm5316pfn.90.2023.02.15.17.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:31:07 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Nick Terrell <nickrterrell@gmail.com>,
        Kernel Team <Kernel-team@fb.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 0/1] lib: zstd: Backport fix for in place decompression
Date:   Wed, 15 Feb 2023 17:39:27 -0800
Message-Id: <20230216013928.1784731-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.39.0
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

From: Nick Terrell <terrelln@fb.com>

Hi Linus and all,

I've attached a patch for a hot fix for zstd that may cause issues for x86 kernel
decompression, though I haven't recieved any reports of problems as of yet.

I've submitted it to my linux-next branch for testing, and the upstream commit is
well tested, but would also appreciate any testing that folks would be kind
enough to provide.

I'm sending this to you, Linus, to make sure that you're aware of my intent to
send you this hot fix. I intend to let it bake in linux-next for a day or two,
and get some community testing, then send you a pull request with this change.
Please let me know if there is anything else I should do, or if there is a
different process that I should be following.

Best,
Nick Terrell

Nick Terrell (1):
  lib: zstd: Backport fix for in-place decompression

 lib/zstd/decompress/zstd_decompress.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

--
2.39.0

