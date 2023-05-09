Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D973B6FC145
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjEIIH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjEIIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:07:41 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF5A10A23
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:07:06 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-506b21104faso6376245a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683619623; x=1686211623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sefTIBuyPY1tklzs4eZt4f6X1hRT1gQo6nNE62cYqXw=;
        b=RAsdyPEVtcl1EExzGMYbQfdm5z+ZKoRFQ1f/kG7J4e8rJnMYer1P31mOW1C96Hc1MD
         xvQ1lBUrbVZjQPdDgWke++lW0s51PC8Cje+CBTwz+0lijAmKDThmd6z1F5M5LgNQwRQp
         Sa96nUO740TqCB6OsdVxs8z1J0i+i4/zfaKVNOv+w1i5qijNgN01QENvxjYt/5fDbIRu
         V65nwI1dm9D1w+oEf4GK03fMHS4d0uBm/ycFTMrsQGHJPlTL7HEfGIagMAcW5w9N8GKU
         +KTOmfAjngAqdrJw2J4uVvc4CtePTpu3Twnl/SdATYXPzGlg72rS3FfUmIkXXqawvBj+
         dszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683619623; x=1686211623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sefTIBuyPY1tklzs4eZt4f6X1hRT1gQo6nNE62cYqXw=;
        b=iE5iBlIWglsY9A5Zo+I169LFCZI00Vy48rISP4TD3h3sX5Ih5GSJL4gc/DF1OuKPYx
         bCTqQMUumDHJy5LkC4Y18uyclRsLSuDMXGILJhMRsnP4Jnbg8GssAZHTkUPAN3fpxExs
         Ghg7vpMXx2OD+gs7gHBSJeeYuwOdNZ9anXJNVDQg1eHhPZUi/Q4Rdpjd1TSgDvK/olDa
         6PHP2LLDtpKeVOC0nt4jKu2nW30NHIdpfGraN9TQKLsTspxu7IOL5+hrSeXEJd3bxvT1
         QPEPOZ8SQZ/a0I//875JKWotkwxEAZhdvvYonQIJkirmG8pne8xJZwP3dCgfWTRvjw24
         y+og==
X-Gm-Message-State: AC+VfDzMr57/sS1rY/FXHjxgewtTKgfQ7flTPTWdGIeb/PSDBtkLEgrv
        bOLpQtvdnm3GVXDWXemP6Nr51UGbFXY8U58=
X-Google-Smtp-Source: ACHHUZ5kqoAPjPokTiyAE943lxaftoydddV0k1qApv9fmVkqFVgkZfSBpWevHNlo7ES/Qb9HwMzmv+czd7rl34M=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:cd1a:0:b0:50b:c88a:f7cd with SMTP id
 z26-20020a50cd1a000000b0050bc88af7cdmr4762794edi.4.1683619623130; Tue, 09 May
 2023 01:07:03 -0700 (PDT)
Date:   Tue,  9 May 2023 08:07:00 +0000
In-Reply-To: <20230508124701.443ba331.gary@garyguo.net>
Mime-Version: 1.0
References: <20230508124701.443ba331.gary@garyguo.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230509080700.1608146-1-aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: error: add missing error codes
From:   Alice Ryhl <aliceryhl@google.com>
To:     gary@garyguo.net
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 12:47:01 +0100
Gary Guo <gary@garyguo.net> wrote:
> On Thu,  4 May 2023 06:48:54 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> > This adds the error codes from `include/linux/errno.h` to the list of
> > Rust error constants. These errors were not included originally, because
> > they are not supposed to be visible from userspace. However, they are
> > still a perfectly valid error to use when writing a kernel driver. For
> > example, you might want to return ERESTARTSYS if you receive a signal
> > during a call to `schedule`.
> 
> `include/linux/errno.h` also includes all of `asm/errno.h`,
> which defines EDEADLK - EHWPOISON, which is not included in this patch.
> I feel like these error codes should be added first?

It seems like there are a lot of asm/errno.h files:

$ find . -name errno.h
./arch/powerpc/include/uapi/asm/errno.h
./arch/mips/include/asm/errno.h
./arch/mips/include/uapi/asm/errno.h
./arch/alpha/include/uapi/asm/errno.h
./arch/parisc/include/uapi/asm/errno.h
./arch/sparc/include/uapi/asm/errno.h
./arch/x86/include/generated/uapi/asm/errno.h
./tools/arch/powerpc/include/uapi/asm/errno.h
./tools/arch/mips/include/asm/errno.h
./tools/arch/mips/include/uapi/asm/errno.h
./tools/arch/alpha/include/uapi/asm/errno.h
./tools/arch/parisc/include/uapi/asm/errno.h
./tools/arch/sparc/include/uapi/asm/errno.h
./tools/arch/x86/include/uapi/asm/errno.h
./tools/include/nolibc/errno.h
./tools/include/uapi/asm/errno.h
./tools/include/uapi/asm-generic/errno.h
./include/uapi/asm-generic/errno.h
./include/uapi/linux/errno.h
./include/linux/errno.h

How should I proceed with this? You mention EDEADLK - EHWPOISON, but its
not clear to me which asm/errno.h file I should base this on.
