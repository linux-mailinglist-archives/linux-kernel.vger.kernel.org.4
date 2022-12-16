Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C607964F375
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLPVr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLPVrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:47:43 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4227F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 13:47:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so3607373plj.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 13:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6nVEs5xFKdjJrb7rw+tJ+EGskEE/XSoBaU5tE1Of2UM=;
        b=imch457wLU85EdPzcALjROdhazTLRL8lGUTPNwvtmi9e/Zx5tvC5qObvSwlPANkyp7
         IbI5E4saBVEEk8pKdB8uc9IxGwWPBvM9xjE8D9Opdg1/orL++y/vOMdMKASdhvX0/1mt
         cQ8ks02Vdm62J08IecNC24yv+sglbd382CWEybZDHpvlzWPAcR7m8k8CaYYL+7bY/Fsd
         U+wIMsGKUpqvjcTyRzT8D1vT+Yx/q0ViD/qBaWXyVKjK69WcKqRySzzK4a4iOaX60vWU
         tw1r1xQAEiAzoK/2AARS4tOiF/Uwf6la+eYVZNPyuaTrycHB9PtkJ9brVbyAreybaBbo
         Wi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nVEs5xFKdjJrb7rw+tJ+EGskEE/XSoBaU5tE1Of2UM=;
        b=Wvi0NPMbGNB93wT+7ihYgWVaKlEtyw8iryN+CVnyEOPd49WQWUzHZg3kobYBUpdaHC
         TsHyZhxYQY/PnYXduPgkwEXOQOuUyimQeOXfxvJGpvc7GbJZpQqpgiCoPVRtYjyL6Ot3
         ELj6x1PENLmWh1UAXLGJS2seKV+p5Bm8RHHwwdAXgabuNDSpkuBnLxHDD5Uvya8mt6hd
         jTsd5twpgd9asKiC0FZeT/pAR0g0Tmd4BrVUPlHXHmbPrVk/QDmYrfw5peV/o1h40Mui
         J2EQO8Dqn3LbgscIAex0e9ApsUF5upYdT+3uLOFinpE5cCVIkp8j95usCFFTQmNxyn/I
         S5Hg==
X-Gm-Message-State: AFqh2kqP3h44klmz8mSBw+7igFIzi7gljD32a4l7nKLny20/3rEgsPuo
        Iw30G15mFQHKGu6YnaUTBpmCnU+Z9chPG4Ddr6EOOw==
X-Google-Smtp-Source: AMrXdXujucDbis+jisu/8phFW07nKafYIDiwu/+Zr6WdeALYIoQUEtnKDq4oRFNwWnebww/zp5jU4JPy+wNaMFqJTKM=
X-Received: by 2002:a17:90a:4612:b0:219:a43b:1006 with SMTP id
 w18-20020a17090a461200b00219a43b1006mr1266289pjg.195.1671227255426; Fri, 16
 Dec 2022 13:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20221207154939.2532830-1-jeffxu@google.com> <20221207154939.2532830-4-jeffxu@google.com>
 <202212080821.5AE7EE99@keescook> <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
 <Y5yS8wCnuYGLHMj4@x1n> <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
 <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
 <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com> <202212161233.85C9783FB@keescook>
In-Reply-To: <202212161233.85C9783FB@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 16 Dec 2022 13:46:58 -0800
Message-ID: <CALmYWFuENPRvCAOF6of=Ufct5jjAbJ=iDyH7eODhdbm24uAK3Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, jeffxu@chromium.org,
        skhan@linuxfoundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 12:35 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Dec 16, 2022 at 10:11:44AM -0800, Jeff Xu wrote:
> > Once per boot seems too little, it would be nice if we can list all processes.
> > I agree ratelimited might be too much.
> > There is a feature gap here for logging.
> >
> > Kees, what do you think ?
>
> I agree once per boot is kind of frustrating "I fixed the one warning,
> oh, now it's coming from a different process". But ratelimit is, in
> retrospect, still too often.
>
> Let's go with per boot -- this should be noisy "enough" to get the
> changes in API into the callers without being too much of a hassle.
>
Agreed.  Let's go with per boot.

Hi Andrew, what is your preference ? I can send a patch  or you
directly fix it in mm-unstable ?

Thanks
-Jeff

> --
> Kees Cook
