Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBE57406EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjF0XnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0XnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:43:06 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E1199E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:43:04 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a0457d6b77so4624326b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687909384; x=1690501384;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpEHJ42Y+FRkYOYbSx5GF+my4XDRGnA4ioHtgi4/qRI=;
        b=T7KqYKw8mjlhn/x2K+5YzbAKlMeEIRO5ppq1fModJiFzzSNmseOPT1AFAIsrL0Ts/V
         AmDbtlD7VMrP/gg1AIn3+T3Kix1bg3L/xEZSB2vqYtw8eDhju+PHRzrnUuJfY+kgnnKX
         ZpYkw+piG2Rpwp9IalR3BgDyjOw5z7cxdHfoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687909384; x=1690501384;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpEHJ42Y+FRkYOYbSx5GF+my4XDRGnA4ioHtgi4/qRI=;
        b=QmRmhYvuRNcHgB75CeNypi270rVInNTDiviAhzmaKsZU3+EJpwbDfNwoP9a5ehqJ2e
         5h1qSMiGfMtu2sH6M9/eMWKREkqJrCntxJ1mlGSM/qsvXIO8nXkTPfaqFWD4FcY5Fr9T
         PS/RdCK++dT6cMBTnc5n/8sDhT9iOR5z002u6lYK7Pzuw+vNd8OBe9raTNPQ54aYeDeT
         Mf+UZZx0HLCnK9iGFTDEGCRXdJWoao0ZggWwrlxDcMlyiwPaVoDAECTcn50/NmlhGh50
         MP7209UFIKAMkh7X8EXm4byN6NB3zkVmVbGBVdlOCxSirWC3KAJEpwM9ELOZ0uIeKq5w
         NRuA==
X-Gm-Message-State: AC+VfDwYGg8L3iAgd0viqi/pVGxjlLiqb+W/T1/Og7YMjvw8hltGgoLa
        D2YgYVRoJ1FMPHZlnRXl1wyWUw==
X-Google-Smtp-Source: ACHHUZ6hyvjqvfvkAjqCPC6wK6bSa+mhPwzs0dhXh+FswznfWRQHgfbQ0DlGlj6GdOqDNsSsXqM3RQ==
X-Received: by 2002:a05:6808:1210:b0:3a0:5cd6:8773 with SMTP id a16-20020a056808121000b003a05cd68773mr22185539oil.54.1687909384207;
        Tue, 27 Jun 2023 16:43:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b0025b83c6227asm7127880pjf.3.2023.06.27.16.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 16:43:03 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:43:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] execve updates for v6.5-rc1
Message-ID: <202306271642.ED8D48AC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Please pull these execve updates for v6.5-rc1.

Thanks!

-Kees

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.5-rc1

for you to fetch changes up to aa88054b70905069d1cf706aa5e9a3418d1d341d:

  binfmt_elf: fix comment typo s/reset/regset/ (2023-06-23 09:36:30 -0700)

----------------------------------------------------------------
execve updates for v6.5-rc1

- Fix a few comments for correctness and typos (Baruch Siach)

- Small simplifications for binfmt (Christophe JAILLET)

- Set p_align to 4 for PT_NOTE in core dump (Fangrui Song)

----------------------------------------------------------------
Baruch Siach (2):
      elf: correct note name comment
      binfmt_elf: fix comment typo s/reset/regset/

Christophe JAILLET (2):
      binfmt: Use struct_size()
      binfmt: Slightly simplify elf_fdpic_map_file()

Fangrui Song (1):
      coredump, vmcore: Set p_align to 4 for PT_NOTE

 fs/binfmt_elf.c          |  4 ++--
 fs/binfmt_elf_fdpic.c    | 12 ++++--------
 fs/proc/vmcore.c         |  4 ++--
 include/uapi/linux/elf.h |  3 ++-
 4 files changed, 10 insertions(+), 13 deletions(-)

-- 
Kees Cook
