Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF747406FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjF0XzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjF0XzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:55:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CFD1B2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:55:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2632336f75fso800185a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687910119; x=1690502119;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IYPcjHoEDd4tmLGtYzA/TrxXQKf+cNcE2N7tQMFmLY=;
        b=Co6dHkgFLrUNgPuGuq5lRqhHqX92ONwxU/zud/hT5f8OqzWSqxgyN/b/ZIIrTMnAWr
         PBhGrR6Dty+f0kjYEQUc0c/EKbsvIenzTP0xxbTBogCaaNvno7SNvSERQskH2p2IHV9o
         lV3eKT0XhRbpWv2GMhKZfiDc/yVEtMrZA9l/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687910119; x=1690502119;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IYPcjHoEDd4tmLGtYzA/TrxXQKf+cNcE2N7tQMFmLY=;
        b=O1+c0T1uDnvPTyK9eB+23NTT9M/4kgeYir37UgXwtg+llJF4DNE9cjRuO7QGbttJhE
         cEKbepSZ4P6CQizMLOqU+HQqHIghejZwk8DT5XW46TRLE/MORoGY58ElG4gkCahQNRT6
         l5/kVLe4Eyku+s6oRRaWssw9ADu+r/V+uRQG20YSyHGXUbJ1fMeFEDmFtOudZqkml2rr
         9Ky5Vx5Cqqd3NrU9V2jI46roaPli4Si3Kal1TrdW4lQaNUCV0pZmcoSGxEPiv5OjJMmR
         brc/Dz8kofQ9clVXA/dlgmWSVXH1iVRhm5Ztq04XK1be1jNIIbL3f0zHk+JfShzya/ux
         nQwQ==
X-Gm-Message-State: AC+VfDzn1AHitmJ9IdGw3VSixFSEvzYUP4tcgOEFY/ykIodnCtbB7BbH
        O5e17n7+VTTCdfAxgXmXf0dOrQ==
X-Google-Smtp-Source: ACHHUZ6lG109LmbzTwHjsPJyNgQsti0iT/eNiY3sCA5HoTyjbDzKUPvHqWZZuVRU7ef43nbVSGnWPQ==
X-Received: by 2002:a17:90b:1648:b0:262:d661:75e4 with SMTP id il8-20020a17090b164800b00262d66175e4mr9641292pjb.0.1687910119690;
        Tue, 27 Jun 2023 16:55:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a800100b002599ef80ab9sm8375196pjn.3.2023.06.27.16.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 16:55:18 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:55:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kees Cook <keescook@chromium.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [GIT PULL] pstore updates for v6.5-rc1
Message-ID: <202306271655.F397BDF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull these tiny pstore updates for v6.5-rc1.

Thanks!

-Kees

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.5-rc1

for you to fetch changes up to d97038d5ec2062733c1e016caf9baaf68cf64ea1:

  pstore/ram: Add check for kstrdup (2023-06-14 11:52:10 -0700)

----------------------------------------------------------------
pstore updates for v6.5-rc1

- Check for out-of-memory condition (Jiasheng Jiang)

- Convert to platform remove callback returning void (Uwe Kleine-König)

----------------------------------------------------------------
Jiasheng Jiang (1):
      pstore/ram: Add check for kstrdup

Uwe Kleine-König (1):
      pstore/ram: Convert to platform remove callback returning void

 fs/pstore/ram.c      | 6 ++----
 fs/pstore/ram_core.c | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
Kees Cook
