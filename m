Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9D6553AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiLWSiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiLWSiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:38:18 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F2C1572D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:38:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 6so1080692pfz.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CW9ynGpyjmuCezhF9Kq7f7NKurQgILbHoK/L47Sljak=;
        b=Tg+yTmrUOpub9jPzeOSe/knrEZ6RY3m9OQ5CK6BDl4jQKCl6Q+hnVuatiSQPkW3rPp
         48SrWGvZK6bcFcbAM0V1l5XeI+vADV5TFkpscYA4JxxWNVmi1d4Yq3MMRlFhA4fhdnIR
         2TTXWuQyrnThJzg2nf/7WyB4vXTi9I157zx7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CW9ynGpyjmuCezhF9Kq7f7NKurQgILbHoK/L47Sljak=;
        b=F97mnlJZCs0p+xkGCkLlLz+WU1+Uymhdnn39is8jdFiFzHxgMK/faaAl+wR/knUCEH
         /+6VuJGCbc0fRDvmiePtDzAh9tdf1TKQApf11Re7P0MdgvWuv//4Gh/b4REcaNnikBi4
         EcYIgC+jIfVGzhgJrIXqJT2QGGfc7UGxs6r3oiKC046eXuiCkCoNQOCgYcQcSIHe8oCI
         a+uUEGxxi5J9y/LJgr5EX4DWlJpfPPYWQVRAP2vVFzgGyEB/11a7JP6bm4UufpSdy7Om
         ObPqQ0lf+8MtIZF4RG9izKeHx7pRzZFtfGN9fZQPIXRXFrD9X71+BXMIATdZ9HuX9ZFF
         AH9Q==
X-Gm-Message-State: AFqh2kql7NImtgiqrCILhdG6QbLL7V9kX5B4tO57eMZI21D0ejffRiVq
        sbTaC/mGDHbjFj7C+1qfq8sdrA==
X-Google-Smtp-Source: AMrXdXvg+F4zX2N/Y03oI5smbzuOJ1581f+Z24O3HjAcj5Wmm6vQviICCBZxy1Uta+SaHSPUV+2JcA==
X-Received: by 2002:a62:1c52:0:b0:577:ac84:cf8f with SMTP id c79-20020a621c52000000b00577ac84cf8fmr11560802pfc.34.1671820696951;
        Fri, 23 Dec 2022 10:38:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i184-20020a6287c1000000b00574ee8d8779sm2843186pfe.65.2022.12.23.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:38:16 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:38:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Connor O'Brien <connoro@google.com>,
        John Stultz <jstultz@google.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        kernel test robot <lkp@intel.com>,
        Luca Stefani <luca@osomprivacy.com>,
        Midas Chien <midaschieh@google.com>,
        Tony Luck <tony.luck@intel.com>, Wei Wang <wvw@google.com>
Subject: [GIT PULL] pstore updates for v6.2-rc1-fixes
Message-ID: <202212231038.955181AC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore fixes for v6.2-rc1.

Thanks!

-Kees

The following changes since commit e6b842741b4f39007215fd7e545cb55aa3d358a2:

  pstore: Avoid kcore oops by vmap()ing with VM_IOREMAP (2022-12-05 16:15:09 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.2-rc1-fixes

for you to fetch changes up to beca3e311a49cd3c55a056096531737d7afa4361:

  pstore: Properly assign mem_type property (2022-12-23 10:34:25 -0800)

----------------------------------------------------------------
pstore updates for v6.2-rc1-fixes

- Switch pmsg_lock to an rt_mutex to avoid priority inversion (John Stultz)

- Correctly assign mem_type property (Luca Stefani)

----------------------------------------------------------------
John Stultz (2):
      pstore: Switch pmsg_lock to an rt_mutex to avoid priority inversion
      pstore: Make sure CONFIG_PSTORE_PMSG selects CONFIG_RT_MUTEXES

Luca Stefani (1):
      pstore: Properly assign mem_type property

 fs/pstore/Kconfig | 1 +
 fs/pstore/pmsg.c  | 7 ++++---
 fs/pstore/ram.c   | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
Kees Cook
