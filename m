Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091DF6E9B90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjDTSYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjDTSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:24:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098CF3C04
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:24:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so934475a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682015069; x=1684607069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W2Q4iIjOWvyJFTvXo6EByLNSHrXgPTMrz47UjuX1XFA=;
        b=sUMWeJdlD5N8oAZ/A+H12d36PuymhXNTfcZuFiOc3bkEZoUUn5D8kWzrNLArJuoMx5
         4fGCDfscE9dHjinDCPRShcQ/DiFNkedbv2Z4VrcE1rlcl5uRRg/rzrRIjZMStodRKfcz
         +01PoJaqtKjKqWWlDoiK/BNJImIBXhumAXww8O2jTFdi27urJ+qxyKRHgWU1DZ3Pde63
         W3hfkLOeIAqS4wS2XS+/KKxKuEMBGi0AIrnF8u4+GO85UEe8zwkm5fQTYXviYnElQ6m3
         uaM3fqtOaoNGLEJdSSMKAYASq+3CldQROUmwxB0bxBjwSdwN8jS9Vu/vYl43gkbHP6Fq
         1xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682015069; x=1684607069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2Q4iIjOWvyJFTvXo6EByLNSHrXgPTMrz47UjuX1XFA=;
        b=KtBzjoS9QKIro65hsY24lYSl092spytoazIFGXs5g3WqSRrnijMU6dBDDg/m5FhMBT
         wEmd3KdSjSL8oF+douONcHvMI5QLVwOZn1Uy2lCwPYZnFkgdf7+CYXJJpdGPu1duDqFh
         RVjcGhGpGgO/IJdcxe7g2ajRw8Wbf2H6GfNEYiDlTN8EyKp5STPI9XRUIFSAPIaCQ/fl
         rfaE5jt9TgB5t0zZ+krJHOk9++EQZaTUzrRg6ZTycauRlokKgot6e7cj5QCU8bovF52p
         sJO+gzJAvozbLOA0F75h2gJbd6HygxCzxWXtc4weeFuBfuZW8cfS7Y9y6viUdBsW1ifo
         OUPA==
X-Gm-Message-State: AAQBX9eJlOUkP/dOnrIFlVC0GHYytxYkoQqblegnc3DgFUFWBpa5P9ih
        G+Yz4SKJCNC9zbGT7sShWqbX4UTb0MnJvTvSswdxrQ==
X-Google-Smtp-Source: AKy350ZHDZutJ5uEYOl/hvKn3fUhSa6Fnj8CRgHHHC7sw+tjdv82826lI/F0qrx4LZOQ12NVlEu7a/2luSMwkds1O5E=
X-Received: by 2002:a17:90a:bf10:b0:23e:fc9c:930 with SMTP id
 c16-20020a17090abf1000b0023efc9c0930mr2569162pjs.36.1682015069459; Thu, 20
 Apr 2023 11:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230417122943.2155502-1-anders.roxell@linaro.org> <2023041848-basil-plop-145c@gregkh>
In-Reply-To: <2023041848-basil-plop-145c@gregkh>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 20 Apr 2023 20:24:18 +0200
Message-ID: <CADYN=9L40BxnPiMAnCr=Ha4PPt2dWDO+anE9ev0sQPjbJyvBSQ@mail.gmail.com>
Subject: Re: [backport PATCH 0/2] stable v5.15, v5.10 and v5.4: fix perf build errors
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, acme@redhat.com, andres@anarazel.de,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 at 11:04, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Apr 17, 2023 at 02:29:41PM +0200, Anders Roxell wrote:
> > Hi,
> >
> > I would like to see these patches backported. They are needed so perf
> > can be cross compiled with gcc on v5.15, v5.10 and v5.4.
> > I built it with tuxmake [1] here are two example commandlines:
> > tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12 --kconfig defconfig perf
> > tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12 --kconfig defconfig perf
> >
> > Tried to build perf with both gcc-11 and gcc-12.
> >
> > Patch 'tools perf: Fix compilation error with new binutils'
> > and 'tools build: Add feature test for init_disassemble_info API changes'
> > didn't apply cleanly, thats why I send these in a patchset.
> >
> > When apply 'tools build: Add feature test for
> > init_disassemble_info API changes' to 5.4 it will be a minor merge
> > conflict, do you want me to send this patch in two separate patches one
> > for 5.4 and another for v5.10?
> >
> > The sha for these two patches in mainline are.
> > cfd59ca91467 tools build: Add feature test for init_disassemble_info API changes
> > 83aa0120487e tools perf: Fix compilation error with new binutils
> >
> > The above patches solves these:
> > util/annotate.c: In function 'symbol__disassemble_bpf':
> > util/annotate.c:1729:9: error: too few arguments to function 'init_disassemble_info'
> >  1729 |         init_disassemble_info(&info, s,
> >       |         ^~~~~~~~~~~~~~~~~~~~~
> >
> >
> > Please apply these to v5.10 and v5.4
> > a45b3d692623 tools include: add dis-asm-compat.h to handle version differences
> > d08c84e01afa perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK>
> >
> > The above patches solves these:
> > /home/anders/src/kernel/stable-5.10/tools/include/linux/kernel.h:43:24: error: comparison of distinct pointer types lacks a cast [-Werror]
> >    43 |         (void) (&_max1 == &_max2);              \
> >       |                        ^~
> > builtin-sched.c:673:34: note: in expansion of macro 'max'
> >   673 |                         (size_t) max(16 * 1024, PTHREAD_STACK_MIN));
> >       |                                  ^~~
> >
> >
> > Please apply these to v5.15, v5.10 and v5.4
> > 8e8bf60a6754 perf build: Fixup disabling of -Wdeprecated-declarations for the python scripting engine
> > 4ee3c4da8b1b perf scripting python: Do not build fail on deprecation warnings
> > 63a4354ae75c perf scripting perl: Ignore some warnings to keep building with perl headers
>
> Can you please provide patch series of these upstream commits backported
> to the relevant branchs that you wish to see them in?  You have 2
> patches in this series without git commit ids, and I have no idea where
> to apply them, or not apply them...

Yes, apologies, I will get that fixed up.

>
> Or better yet, just use the latest version of perf as was pointed out,
> on these old kernel releases.

Makes sense, we can do this. Is this the preferred way going forward?

Cheers,
Anders
