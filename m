Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246B073071A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjFNSKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbjFNSJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:09:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBAE3593;
        Wed, 14 Jun 2023 11:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBB26458E;
        Wed, 14 Jun 2023 18:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB21C433C0;
        Wed, 14 Jun 2023 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686766077;
        bh=Uf4sTtIWxAwykiAlD6TKOwJqAz2NJsqgiC/LwUbwvjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XARG4ZSJAarJrHn5Jaf0ASt3Qx98VTQJUyDOPFK/JIwyuJ8QaEDeZ8PGuZrUBtisz
         3ED4S9NC1ACVqmzp3/ty8A+idvmRDWIBqrSZMXRll+zkBP6ljDFcFB6mi+Ta5+licX
         1OcAz3WCcnxwQ2fheuT7UiUVkmeonyIXDjSHcYOZ+pYmaNIL3lflczmuDcTmSj8k72
         uDnOUpYpMEUDSyl/Cwe06zLy4riwAwrtiqCsVBawufzl/hM7K7/NhIKNMhDby/vQwQ
         5TKwBPlbBOxk/I/DCclB6r7JEpj8Zve0EQXeqhXt//rL/jGTzQEUCCFWOPZpQt949z
         c5VFlJRoPnEtw==
Date:   Wed, 14 Jun 2023 11:07:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: clang: Powerpc: =?utf-8?Q?clang-nightl?=
 =?utf-8?B?eS1tYXBsZV9kZWZjb25maWcg4oCU?= FAIL
Message-ID: <20230614180755.GA2035364@dev-arch.thelio-3990X>
References: <CA+G9fYsJq0sPC+q6vLNKUgBqCGmmjDrfeP4R1-95Eu28FJRY_A@mail.gmail.com>
 <20230612185424.GA2891387@dev-arch.thelio-3990X>
 <CA+G9fYtX6YNqmz9vxJxa5cA5Uf2rr=RNM0nkoTzRpg79Azp2tA@mail.gmail.com>
 <CA+G9fYvmqz3nQ=Cgs=7J6vtRj=OhbNzgkLPmxxN+vOBTU=9zVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvmqz3nQ=Cgs=7J6vtRj=OhbNzgkLPmxxN+vOBTU=9zVA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 07:43:45PM +0530, Naresh Kamboju wrote:
> Hi Nathan,
> 
> On Tue, 13 Jun 2023 at 09:57, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > Hi Nathan,
> >
> > On Tue, 13 Jun 2023 at 00:24, Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Hi Naresh,
> > >
> > > On Tue, Jun 13, 2023 at 12:10:30AM +0530, Naresh Kamboju wrote:
> > > > [Please ignore if it is already reported]
> > > >
> > > > Following two builds failed on stable-rc 6.1.34-rc1.
> > > >
> > > >   - Powerpc: clang-nightly-maple_defconfig — FAIL
> > > >   - Powerpc: clang-nightly-cell_defconfig — FAIL
> > > >
> 
> > > As always, thanks for the report. This is an LLVM regression/change in
> > > behavior caused by [1], which can break as-option and as-instr on
> > > releases prior to commit d5c8d6e0fa61 ("kbuild: Update assembler calls
> > > to use proper flags and language target"), as unsupported flags for the
> > > current target ('-x') may be present (KBUILD_CFLAGS is used for these
> > > tests instead of KBUILD_AFLAGS). Inside try-run, the macro behind
> > > as-instr and as-option, I see
> > >
> > >   clang-17: error: unsupported option '-mno-prefixed' for target 'powerpc64le-linux-gnu'
> > >   clang-17: error: unsupported option '-mno-pcrel' for target 'powerpc64le-linux-gnu'
> > >   clang-17: error: unsupported option '-mno-altivec' for target 'powerpc64le-linux-gnu'
> > >   clang-17: error: unsupported option '-mno-vsx' for target 'powerpc64le-linux-gnu'
> > >   clang-17: error: unsupported option '-mno-mma' for target 'powerpc64le-linux-gnu'
> > >   clang-17: error: unsupported option '-mno-spe' for target 'powerpc64le-linux-gnu'
> > >
> > > This has come up recently elsewhere in PowerPC, see
> > > commit 2b694fc96fe3 ("powerpc/boot: Disable power10 features after
> > > BOOTAFLAGS assignment"). While I think it is dubious that clang errors
> > > on these flags for the assembler target, this is already fixed on the
> > > Linux side by using KBUILD_AFLAGS for these make macros.
> > >
> > > I am preparing a series of d5c8d6e0fa61 and its dependencies for 6.1 but
> > > I want to do sufficient build testing first, which is currently running
> > > for me. Would you be able to point your matrix to [2] to make sure
> > > everything works properly with both GCC and LLVM? It is a work in
> > > progress as the second patch in the stack needs a proper commit message
> > > but it is the diff I expect to ship so that it all that matters.
> >
> > We'll start building [2] with GCC and LLVM by using tuxplans and
> > get back to you.
> 
> LKFT has been configured to run GCC and LLVM in total 205 builds
> and all the builds have passed on your tree / branch [2]. You can find
> the list of builds including kselftest, perf, rcutorture, kunit, kmemleak
> and many more combinations and architectures.
> 
> I request you to review the list of builds results and test results on
> projects page [3] [4]. I do not find any regressions compared with
> mainline master as sanity testing.

Thanks a lot for testing!

> Do you think LKFT should build your tree / branch often ?
> We are happy to test anytime.

No, this is an exceptional circumstance, not the norm. If I need wider
testing done in the future, I will keep you all in mind :)

> Thanks Daniel and Anders for your work.
> 
> build_names: that got tested and all have passed.
> 

<snip>

Great! I sent along the 6.1 backports now:

https://lore.kernel.org/20230612-6-1-asssembler-target-llvm-17-v1-0-75605d553401@kernel.org/

Thanks again for testing and the report, cheers!
Nathan
