Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0B6F2619
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjD2Tso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2Tsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:48:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D5E19AC
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 12:48:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b7b54642cso869975b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682797720; x=1685389720;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8xJIhfAmBebYnbahg0bpFD4DMd494RsecF0TgLD/p0=;
        b=Doyc93mM3AnjFpPb7gpeQnhTZLSB8LYtEOTkT+8UvUCTXTpzdv72gJ8x/qntRWW9er
         7qtRU3IPhr66KAGZEuGXxsL3Qbk2JB4BSVJ9Wh+Bl/Jd6TMiMNzLoVHO9pNN50b9oL2x
         ZbBMEtjMHbTcKVuHE7ox8F3dh1QyXBmvf7hhIJxels3TAh+8/bWPKSes+pI7HoMHYxPm
         ZM52kHnLWS+2s3ku+jbetBh0kVkG3WFO92Wst9khTKdve0/TZ1Ula1KqXQEtYmgQ6lB+
         O/tUPqVkRPLdD0//bzGqIMjzmqwtJnHrqAttmGnw2TR9rtklD7ou1hRrrJh7PMrNPqFB
         NBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682797720; x=1685389720;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8xJIhfAmBebYnbahg0bpFD4DMd494RsecF0TgLD/p0=;
        b=X+c9fYIC1k+sPlRBX82CvKhKB04clkB+7Cc90VE4daInhywv/5Uv+6fd16dl9a06gA
         6K3EKBw9ewaksfPF8x3GQFZT2RGhk9EbMf9bQYBC2x6Q9V/o7UN6jxQ4VRHPDaLa1EGs
         TNoC58sxXG4nJItJL9DFe63NNRdUlPkHZTiPCwnDePxAnWbv9xFSIOuEIM5zjOGyNPtZ
         lDkYdPoWTSw4+jWDZD7Zjz1R25vmTgk3wPJyKNh+yB+4cQG9UIVMdWBAELckzlxX/nfj
         XmxrijdL9hXMFaKlvsGkMZSv2VUgLxUignwbfk+9lRWE8tWP7lsLfC6ec9j1WTFCduq4
         McpQ==
X-Gm-Message-State: AC+VfDwSaV8Tj7BfaB7cBuo/c37V+HDi+sssTXRGey398T0GHc2KaDTv
        2li93kGQzUnqeynpWCJ9/dG2G2bTIryi002fYQQ=
X-Google-Smtp-Source: ACHHUZ6rL9+YorT4U00gKrGITqTvNqPLHeZoI2n1PiWZBmsw87UJit7ourhmHGifgfBHTHVSWmkC8w==
X-Received: by 2002:a05:6a00:2392:b0:641:4e80:a7c0 with SMTP id f18-20020a056a00239200b006414e80a7c0mr1003018pfc.22.1682797719812;
        Sat, 29 Apr 2023 12:48:39 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a001a8600b0063b7a0b9cc5sm17265602pfv.186.2023.04.29.12.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 12:48:39 -0700 (PDT)
Date:   Sat, 29 Apr 2023 12:48:39 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 12:48:22 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 6.4 Merge Window, Part 1
In-Reply-To: <CAHk-=wivud6jefN+UKa4zkAf4dkapyh4iRazyUVgXTzqRntOMg@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-c9879e1f-4d38-41b9-8082-7c463fbed66c@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 17:08:53 PDT (-0700), Linus Torvalds wrote:
> On Fri, Apr 28, 2023 at 9:09 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-mw1
>
> Ugh, so this conflicted pretty nastily in arch/riscv/mm/init.c between commits
>
>   ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap region")
>   8589e346bbb6 ("riscv: Move the linear mapping creation in its own function")
>
> and while I did try to make sense of it all, and generated what looks
> like a sane resolution to me, I did *not* do some kind of build check,
> much less can I test anything.
>
> So.. Caveat emptor. I may or may not have gotten that conflict right,
> and you should most definitely double-check it very carefully.

Thanks.  I'm not sure why I didn't see that locally, it'd had shown up 
in linux-next but I'd figured something else was going on.  I'll go take 
a look, the post-merge stuff is testing already on my end and nothing 
has failed yet.
