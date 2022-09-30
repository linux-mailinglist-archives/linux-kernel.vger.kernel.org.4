Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23455F0EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiI3PbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI3PbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:31:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716919869C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:31:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f23so4277618plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=ilkTBHJLaLNkiyEAW/HtxRt8YPc4Ot3tixGATgnD0F4=;
        b=ayEWlMYDughrNKRnlS67WXVFRXkhABM+PZSGJsneE6fiLItiuVcJ4yDXxQ9+EkLnhg
         QPZ+cXd7Zo3pE9BgK3qoYubzr1TO9Rcpcp/mAN4CDXg4uHl4YEFyxIjH6xLJB+Ao2p/n
         bHdYDk/FO/IyKwsfyZUv+j381DEc0xuzOiJ9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ilkTBHJLaLNkiyEAW/HtxRt8YPc4Ot3tixGATgnD0F4=;
        b=mYqWQ9keiKw5+85OC5aCRP9LgN7FQP3ZuesB1mUmpRH/H/G2VQahmPCSYoK6DEQJ1a
         dXS4Y5eKGkdUsa8U78FSxMmO1zNBGOLR0vNo3qRizX+BbutWu67WPzU39O6V2ukYQoLY
         EvauK1vrBbrOf4MCJB6KUh2d65le5w6mgQaYskoMDbM4SnWFlNsfvU2KGersq62+k9O0
         NqYJC4uNUgQ09AkOX+ZHrLijgD9W4nvarOqRFr2ZHuwd7LErNKNjKyCOFWdgvxC7FQfG
         DRYXj3AZlC2SKHmfkQv8z15nmgows1UO0KxTIscBA/PrKgr3NyRiO+aGM8BA3cFmq+QR
         1eKA==
X-Gm-Message-State: ACrzQf2dQk9YisVOmlM9hAFAsUVU8p39rRNffFRlZJvu7kF+iHXbBC9a
        qUm5p/MZdehVPk18M4UnGDVgEENtrIQjCw==
X-Google-Smtp-Source: AMsMyM4SfhGs8DmrpAZ2ljxdhyW343kWCZK8zSDAqPYiHws1ReWqJG5V/gvQi7FH7+a3UcyZkyzpxw==
X-Received: by 2002:a17:90a:b10c:b0:203:6a73:8a93 with SMTP id z12-20020a17090ab10c00b002036a738a93mr22436020pjq.178.1664551872157;
        Fri, 30 Sep 2022 08:31:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79729000000b0053e56165f42sm1974423pfg.146.2022.09.30.08.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:31:11 -0700 (PDT)
Date:   Fri, 30 Sep 2022 08:31:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] pstore revert for v6.0-rc8
Message-ID: <202209300827.3E1707A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pstore revert for v6.0. A misbehavior with some
compression backends in pstore was just discovered due to the recent
crypto acomp migration. Since we're so close to release, it seems better
to just simply revert it, and we can figure out what's going on without
leaving it broken for a release.

Thanks!

-Kees

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.0-rc8

for you to fetch changes up to 40158dbf7eb2b13d8851fe0b875b4c3170ea15db:

  Revert "pstore: migrate to crypto acomp interface" (2022-09-30 08:16:06 -0700)

----------------------------------------------------------------
pstore revert for v6.0-rc8

- Revert crypto acomp migration (Guilherme G. Piccoli)

----------------------------------------------------------------
Guilherme G. Piccoli (1):
      Revert "pstore: migrate to crypto acomp interface"

 fs/pstore/platform.c | 63 ++++++++++------------------------------------------
 1 file changed, 12 insertions(+), 51 deletions(-)

-- 
Kees Cook
