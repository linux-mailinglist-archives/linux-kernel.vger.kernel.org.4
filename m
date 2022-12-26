Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743676562FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiLZOFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiLZOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:05:05 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399E75FCC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:05:04 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id 3so10298739vsq.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T6vaOrJ+SYkJ1gOWpjtkMrcHRqcXhXKFAtMHBJoyLlM=;
        b=KL57D7JhzP4KwDaRqYK1Mn6eDS+2yPPqFGBf/6gKCRI81Uqu6Skw3QMY+jUzSoMwMY
         083E53dGdrtNmqsPjrTkKWXX/1R6lzQXcnGtf/xRGmkdm8P2gwYRSCRFbF1KasgMkzsX
         mW9WKwpxmMNlIJwpfSY9oh0Su6DUF6G/iLUVYtuoQ7gdOCPhDDf8mC0gXqQNIIj2XkVO
         nBgGchnLDOL7bfN8vLa7ILGr2Dgm2QgHVOZU7NLPxYItgZpEOjKAd196RXIMbEybThfH
         m6qcJytVD9zEaBu9aSptIR41Op3NwdZSXiUHL8e4ciYpJAzPldF8jPh+tnvLDmRtsGA0
         s+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6vaOrJ+SYkJ1gOWpjtkMrcHRqcXhXKFAtMHBJoyLlM=;
        b=NK08Vuh5/Zlgq7t8gw4i+xtwaorLhWCTpnH7VZf+VzZ49zRuehSa1hFBhkaMeCEXl4
         uwDskoGSTR6fHgq5ilepd1xlxVlNSAEgJlLjJS1k8xHv6FHFl1l4kuARmJMOjcbKwyc1
         hKoGeemIHhaIpeT5Uto3N5YaBBKqCwgbosBNHgYeQD42HxJK0CwbkC4YWG4Etr1Suzo3
         RzZQrEWLC3rrDucNI4ID2ijDBrV7R95ef/xa8biHOklYUiPl439KjJByizUTL6mW7sN+
         f4zuKIP+LM+XQ+9nul6J9NZNzY0+SkJkrWbHEkDdx7Bit1ILAJbky1CAtmoITUvu+Ytx
         D55Q==
X-Gm-Message-State: AFqh2kpZdAMiyCIb18sUBM008e4w6sJxrpix9JJ23lMsQ3sM5YeBKKzH
        Cdl52SuMR7WUsF+MBo96fex+00RTLnD3R2CHbSQc2rwGYfB3cqW8
X-Google-Smtp-Source: AMrXdXsSf/T0QqbQ64gTi+sMf70r1YtmlTja9w1ffmA5vr4+z5jtrGd5rGEoP/BpN0kAD88ZjcPqxLy5dDjpBvADz28=
X-Received: by 2002:a67:ec94:0:b0:3b5:32d0:edcc with SMTP id
 h20-20020a67ec94000000b003b532d0edccmr2008099vsp.24.1672063503138; Mon, 26
 Dec 2022 06:05:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671221596.git.josef@toxicpanda.com> <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
 <Y6kgR4qnb23UdAEX@dev-arch.thelio-3990X>
In-Reply-To: <Y6kgR4qnb23UdAEX@dev-arch.thelio-3990X>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 26 Dec 2022 19:34:51 +0530
Message-ID: <CA+G9fYuhZzVfxXnVRMog_yv8F17NY4vHe_iafwgxpYCGfuaJqQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
To:     Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, llvm@lists.linux.dev,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2022 at 09:47, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
> > We had a recent bug that would have been caught by a newer compiler with
> > -Wmaybe-uninitialized and would have saved us a month of failing tests
> > that I didn't have time to investigate.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> This needs to be moved to the condflags section, as
> -Wmaybe-uninitialized is a GCC only flag, so this breaks our builds with
> clang on next-20221226:
>
>   error: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Werror,-Wunknown-warning-option]

LKFT test farm also noticed these build breaks with clang on next-20221226.

Regressions found on arm64, riscv, s390 and powerpc

    - build/clang-lkftconfig
    - build/clang-15-lkftconfig
    - build/clang-15-defconfig-40bc7ee5
    - build/clang-15-defconfig
    - build/clang-nightly-defconfig
    - build/clang-15-lkftconfig-compat
    - build/clang-nightly-defconfig-40bc7ee5
    - build/clang-nightly-lkftconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang'
'CC=sccache clang'

error: unknown warning option '-Wmaybe-uninitialized'; did you mean
'-Wuninitialized'? [-Werror,-Wunknown-warning-option]
make[4]: *** [/builds/linux/scripts/Makefile.build:252:
fs/btrfs/super.o] Error 1


> I can send a patch on Tuesday unless the original commit can be amended.


ref:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221226/testrun/13818773/suite/build/test/clang-15-defconfig/details/

- Naresh
