Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623C073B0E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFWGtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:49:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3586E6D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 23:49:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-988c495f35fso26356866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687502949; x=1690094949;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vjmvjxhnNaI0Yluhjoa/ZS3+/Po3RuAfjAFA/HF9CDc=;
        b=YMsTLPxNkj0lXiRjaRm7ABVWnS/oxM7WrLRG3gM2rL1vVLg/5lzIB4DbYq4zHZ3Vb3
         ZgXkem5khk4MshitB7qsW6jo2tBQLd/X1jKIk5Drt6w+4ufHX6NzzKi9W3F+coYOheR/
         yBQDZi71YuCWN/j66AOwsJYCdbEcCD74W4zssXGvTWhs3rMRSeVaaMo+0rINj9igBqrz
         xZE361i4UWXxziMGnGtEm32O7RlfGCCzWywUw7NA14M8igPn0GFeB/kkK8OH9bt5+qTe
         1i2JqaduBzxZx69zJKVNTwz+BMmbPuHVFchHnCmpWJCCJbHLYibLSfZoaGMt/TT/+rmZ
         SCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687502949; x=1690094949;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjmvjxhnNaI0Yluhjoa/ZS3+/Po3RuAfjAFA/HF9CDc=;
        b=TBFzJNroHc+K968eRBEKcPXNICjiVEBcBTe58XMukAdLGD5XyaPgow8XKUCnBwNlHp
         2SE2FmHDGDn4vh424+auY2vMCCE9Zm+tH25GpMnjon/KkIJNwMnxwAiT1iodlkNt1WR1
         dkjKDGaPob/C6k0bLYXA0IlWwT+335qYb2FFpMNnoDOHUnSRJ5rRXeyAUYC9AgosBL//
         e/Nz6nvbu8OumjwHzFI5x8e09d1jSgJTj+TdbEn1fr29m0Jh1LN1cZRJA44CoBhyRI5G
         BApgFAvhDwrAhseN9j1hma/9KoRJhD9pcJcsPBKfiAbW1KgGqT/MX/IhgmZGb5K1fQ2p
         OVOA==
X-Gm-Message-State: AC+VfDwJQHCp1fRL5oaD4CWiV9j6ur9newa/ceww0kAWhyJQKpvjPxwA
        OUakyYhjDkc9x0cHN+/kQisYMkvJaMFZFfwBC2mGpT3WDuS7uQ==
X-Google-Smtp-Source: ACHHUZ56w/y9lGFMIMkJAnm7tvWQwK9zFXhdBPrNaz+Lkyk6ygciwjIC46SxpEuDOBpegdSvYW9T5uiji00GdV4jRgk=
X-Received: by 2002:a17:907:628c:b0:96a:63d4:24c5 with SMTP id
 nd12-20020a170907628c00b0096a63d424c5mr16581811ejc.77.1687502948843; Thu, 22
 Jun 2023 23:49:08 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 23 Jun 2023 16:48:56 +1000
Message-ID: <CAPM=9twXadK-V1qttzJV3ks8hZu7jY3Nswzw6EgGADnJZF2+fA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.4 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

very quiet last week, just two misc fixes, one dp-mst and one qaic.

Should be all ready for the merge window next week.

Dave.

drm-fixes-2023-06-23:
drm fixes for 6.4 final

qaic:
- dma-buf import fix

dp-mst:
- fix NULL ptr deref
The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-23

for you to fetch changes up to 9bd9be5cbaf8a8faa175ef4fba04a5623281debe:

  Merge tag 'drm-misc-fixes-2023-06-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2023-06-23
12:16:48 +1000)

----------------------------------------------------------------
drm fixes for 6.4 final

qaic:
- dma-buf import fix

dp-mst:
- fix NULL ptr deref

----------------------------------------------------------------
Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2023-06-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Jeff Layton (1):
      drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Call DRM helper function to destroy prime GEM

 drivers/accel/qaic/qaic_data.c                | 4 ++--
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
