Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455BC5EAE3B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiIZRdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIZRdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:33:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE71BBEEE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:50:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so13034245pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Bl87DRbRfnOrhkUE5L4BbxEL4c2GAjYQ7M0EHLwAVuA=;
        b=k/Pf0oq2RVLH59XKlNnE8OZcXuU2wB6wDhvFwqWSj3y9rA+jlLYk4QbMK/tPTWbvO1
         0d5A4HA9wdnUH5Ev0SEIYfZkGYq/BljVAO8dkLzDDNsKZGUVLO3lviV0bNiMy0LJMLd1
         veNpu+I4hph+ffxou0iC4hyD0ERsBh+zhJNw4FGd+pX+k+X0d/xV3ivVgZpCfjX1r032
         +uHPc8WH/6FSve1xuIUM08I6J5yNtwJh6aHAFjaBVmR04nmf2/HUmWgA17QOJlnNA4Qe
         dQTic43Y6j4XcePNeZcE+8JeOm4B3Gi80vSVMdQ5nOYDXbmejsOOUh8lrrwvwI1apwnG
         QB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Bl87DRbRfnOrhkUE5L4BbxEL4c2GAjYQ7M0EHLwAVuA=;
        b=4XCgE/tZ6JaeMS9tO5h8GPNECxor7z4Pwd9ZfBwId4j0ikbagUREgoSpwRcF+JwyF6
         kFPiwtGdDE5O6Y4uQhh4MM7WWPivQXR8ow86+ybIyMQSUc7aq4SO2T3Bif1d2kHJz1UO
         SKh6otUJgnBqXIOodGCcPoDAgZAB0GlfER8wmIRCZVoZO/S4wBqOF+QLilRkFUZry/iT
         HdgRaKwXb/9id1K2gW2cJ5OlY5Mx65DgzwYtSGh+0VFjNGaCRl//ZAVHy+LAiSj7Uplp
         AmtpDWc6Z00oJjSzN15wseIGdc2JZYlhZTwzwPwQoDuI5nratWQLswLqKI4gFUiUDuEr
         gdAQ==
X-Gm-Message-State: ACrzQf1IiS0ZWbb3+EyDLHmSLz9NEZDlzqPJTTtcCjnku1umbQC9VhF2
        pmBxv5wwVZFRbxuAP1DDLaW+m8+TAO2Hhcm58XtbuQ==
X-Google-Smtp-Source: AMsMyM6UtWDkGZCZhsx0tR8KOdU6VH24mPotdsbYjkmgnCJx3SgsEdxYwV7yH+J2PwjnOeIoSN/qmkoCqhJi30Jpci0=
X-Received: by 2002:a17:902:a411:b0:178:9e4c:2ef8 with SMTP id
 p17-20020a170902a41100b001789e4c2ef8mr22896380plq.95.1664211056559; Mon, 26
 Sep 2022 09:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <YzFo/+uF1jJ7gMIN@debian> <YzHHz0S8/Nq1QivU@dev-arch.thelio-3990X>
In-Reply-To: <YzHHz0S8/Nq1QivU@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 09:50:44 -0700
Message-ID: <CAKwvOd=rLna-=3eR=6WMTnVHaBiBR4+Gc99oHOHUEvY34e0hhg@mail.gmail.com>
Subject: Re: mainline build failure for x86_64 and arm64 with clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 8:40 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Thanks for testing and the report! I noticed this over the weekend, it
> comes from a new warning in clang:
>
> https://github.com/llvm/llvm-project/commit/e07ead85a368173a56e96a21d6841aa497ad80f8
>
> It was brought up on GitHub as well:
>
> https://github.com/ClangBuiltLinux/linux/issues/1720
>
> I have reported this to the clang developers upstream to see if there is
> any way that the diagnostic could be improved:
>
> https://reviews.llvm.org/D134461#3815298
>
> Otherwise, we will just have to disable it, which I will send a patch
> for later if the warning is not going to be adjusted in any way.
>
> If you wanted to continue testing with upstream LLVM, you can either
> just revert that commit or explicitly disable -Wvoid-ptr-dereference in
> the main Makefile like so, which is ultimately what I will send if I
> need to.
>
> Cheers,
> Nathan

Thanks for the reports.  It sounds like the Clang developers will pare
back the warning for unevaluated contexts (sizeof, typeof).  If it
takes longer than a few days for that to land, let's send your below
patch to help keep CI systems green.

Consider putting the below into
scripts/Makefile.extrawarn

>
> diff --git a/Makefile b/Makefile
> index 647a42a1f800..0bf60134f13c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -967,6 +967,9 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
>  # Another good warning that we'll want to enable eventually
>  KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
>
> +# New warning from clang that is quite noisy due to '__is_constexpr'
> +KBUILD_CFLAGS += $(call cc-disable-warning, void-ptr-dereference)
> +
>  # Enabled with W=2, disabled by default as noisy
>  ifdef CONFIG_CC_IS_GCC
>  KBUILD_CFLAGS += -Wno-maybe-uninitialized



-- 
Thanks,
~Nick Desaulniers
