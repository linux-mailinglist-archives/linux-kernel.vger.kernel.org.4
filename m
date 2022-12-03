Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D246418DD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiLCUYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiLCUYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9021EC4E;
        Sat,  3 Dec 2022 12:23:36 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o5so12987522wrm.1;
        Sat, 03 Dec 2022 12:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pDWp63PbdIYjJSQxa/qhYkSramqYTisTS1SAhurdo4=;
        b=IlJ+ktpV7qNnMumlM75EIonXDjPQR8Zn826taQ3VOUBreblqQPg4gUT+bhpyWfY5Bb
         8T8RXl7v3KbJlVC+WFTDaYykz3iH7stwITW5BM7Unl7An2KkR0Pru/K5OEpjphHp9Jnk
         FmdSTWSLxcWxImR97hjRdkmpU18npm9uMrDxq8m4spYaKobkRmFGFJQS0EVuYsbf70LK
         qiaTuk8kXRfQe5LxB+fK9oulDhtHbohV8uQxw8D7KwRx4FjGHS4vx96MzisRO617KmnF
         oxjPWBydQzTIpreYRv9JAyH3zk9N4ageHkcHxOEoZaur6Dfp37SP0fj/T/JvXvS6ELD+
         lhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pDWp63PbdIYjJSQxa/qhYkSramqYTisTS1SAhurdo4=;
        b=f/1u5vmdASuj8NLN3FqCw73lCLcFbv/nQuX8NlelmPrhe3lz4HqhIZigoCdiUPLl3A
         F4YZlDnMQYq78djGtfn38n69DPJnZTQ8Ma9BENviAdnMGRlqqiUYOejAyNBDOqK12JN5
         7Y/MDIJw2NQ9Psl34YAaD+29EVUQrEYKLgDXQdy1t1LVcuv5ItPhT2r3OGAvSO5h/i/w
         XZJBxPHe62O9IHZ3BWJxyi+CGheK0veWV8zkyelksRbNrhx0dkYDLbIiNb0rYPeQF3Va
         tKGYxImNyJjOgJst+fGfyQdYJpWObmQuo8p5gLtommIe3yIFBgObk1+BXs2YG+otbexK
         MIgg==
X-Gm-Message-State: ANoB5pmQvX3ygW/vyRXMODP+PuZGQxaRQRQpyPPy6dFMIJb6/GQls/l5
        n9KYVwsbs40CdvAa/VG7rCoMAh3+tIE=
X-Google-Smtp-Source: AA0mqf5qlzyB71V5U12xQYxPgaLwkWefiKTx3cy+IEtzsTsju6tNNqZIp+T5FcoNNgXKdFTRv0c5RA==
X-Received: by 2002:a5d:59c5:0:b0:241:e4cf:30d9 with SMTP id v5-20020a5d59c5000000b00241e4cf30d9mr19665951wry.186.1670099015315;
        Sat, 03 Dec 2022 12:23:35 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:35 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/41] poll.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:57 +0100
Message-Id: <20221203202317.252789-22-alx@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203202317.252789-1-alx@kernel.org>
References: <20221203202317.252789-1-alx@kernel.org>
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

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man2/poll.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/poll.2 b/man2/poll.2
index 0d67a6add..fa22e2002 100644
--- a/man2/poll.2
+++ b/man2/poll.2
@@ -23,7 +23,8 @@ .SH SYNOPSIS
 .B #include <poll.h>
 .PP
 .BI "int ppoll(struct pollfd *" fds ", nfds_t " nfds ,
-.BI "          const struct timespec *" tmo_p ", const sigset_t *" sigmask );
+.BI "          const struct timespec *_Nullable " tmo_p ,
+.BI "          const sigset_t *_Nullable " sigmask );
 .fi
 .SH DESCRIPTION
 .BR poll ()
-- 
2.38.1

