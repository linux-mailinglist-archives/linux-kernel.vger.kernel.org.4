Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5E709E69
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjESRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjESRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:42:20 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4533FFA;
        Fri, 19 May 2023 10:42:19 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-759413d99afso53462385a.1;
        Fri, 19 May 2023 10:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518138; x=1687110138;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVBXORYA5fI/Y7ZPBzQO5l0Wm2EiovEm+KKQqG7za60=;
        b=G4gN9ZN+ovP33yjiR/vYliMLpmjjuBLfhXTMxYpLN+7GoOa8DdFe2rdEIA9y1Bwf8W
         OZHijvwy4zPFpbcE1dWlXA4yksk341FQoL7cbF7b6eCVM7FenvSuCTS9yyLAWHN8MlBX
         NW/uU/7mmbvb9mEU5C9vzEDtWzFNy9nn69Ev5np/phmVXpm1RothX3W9H6fP4Lf0kmPR
         hAKpeM0WmRDHxxpRXbhGS8FyjXQGII8f0+W46fg9Gd3Pt+tVVmvM0ZeSXaapcq/fVuBh
         AH1q951FnfeVXPaohMQKLjLD0P/PxmTFJB5djLPCevfd/yLNzjr0CQMVRIorZi2JxVCG
         qNPw==
X-Gm-Message-State: AC+VfDzL8wXCVtA8jccqc4bKRu67ob1UUoGRf4ThRVjf+Jd1SumtJ7lA
        3Wbkqraye1lPKZCLFGyqjWA=
X-Google-Smtp-Source: ACHHUZ57aYaLkvcxZAWErCGtmjwOeb/l4TV4esRxYZQRZFbcTv3wtC3AKblwR/M8FCpNJSwkvBfpag==
X-Received: by 2002:a05:6214:240c:b0:5ef:512d:2d47 with SMTP id fv12-20020a056214240c00b005ef512d2d47mr6116917qvb.19.1684518138069;
        Fri, 19 May 2023 10:42:18 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:311e])
        by smtp.gmail.com with ESMTPSA id s1-20020a05621412c100b006166d870243sm1475313qvv.43.2023.05.19.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:42:17 -0700 (PDT)
Date:   Fri, 19 May 2023 12:42:15 -0500
From:   David Vernet <void@manifault.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [tip: objtool/core] start_kernel: Add __no_stack_protector
 function attribute
Message-ID: <20230519174215.GA2158284@maniforge>
References: <20230412-no_stackp-v2-1-116f9fe4bbe7@google.com>
 <168440808395.404.16801982965854981978.tip-bot2@tip-bot2>
 <20230519171120.GA1939377@maniforge>
 <CAKwvOd=ywPnLS40HNUnXH1nqm3Ke3sMtomSgL+rVOoSjXvQB=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=ywPnLS40HNUnXH1nqm3Ke3sMtomSgL+rVOoSjXvQB=A@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:18:40AM -0700, Nick Desaulniers wrote:
> On Fri, May 19, 2023 at 10:11 AM David Vernet <void@manifault.com> wrote:
> >
> > On Thu, May 18, 2023 at 11:08:03AM -0000, tip-bot2 for ndesaulniers@google.com wrote:
> > > The following commit has been merged into the objtool/core branch of tip:
> > >
> > > Commit-ID:     514ca14ed5444b911de59ed3381dfd195d99fe4b
> > > Gitweb:        https://git.kernel.org/tip/514ca14ed5444b911de59ed3381dfd195d99fe4b
> > > Author:        ndesaulniers@google.com <ndesaulniers@google.com>
> > > AuthorDate:    Mon, 17 Apr 2023 15:00:05 -07:00
> > > Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
> >
> > Hi Nick, Josh, Peter,
> >
> > Do you have an ETA for when this will make its way to Linus' tree?
> > clang-17 built kernels have failed to boot since [0], so it would be
> > nice to get this in sooner rather than later if possible.
> 
> David,
> Can you confirm that your version of clang-17 is updated? clang-17 is
> unreleased; ToT will become clang-17.
>
> https://reviews.llvm.org/rGfc4494dffa5422b2be5442c235554e76bed79c8a
> should have fixed any boot failures related to stack protectors.  That
> is to say that Josh's series is irrelevant to anyone using either an
> existing release of clang, or something closer to ToT than April 13.

Thanks for the quick reply, Nick. The latest clang-17 does indeed fix
the issue. Apologies for not trying that first -- I was using the only
tagged verson of clang-17 (which admittedly is not a released version),
and figured it wasn't a compiler bug given that the assembly looked
sane, compilers are allowed to do all sorts of interesting things with
__noreturn, and that [1] removes -fstack-protector from start_kernel()
altogether.

[1]: https://lore.kernel.org/lkml/20230412-no_stackp-v1-1-46a69b507a4b@google.com/

> LLVM commit fc4494dffa54 ("[StackProtector] don't check stack
> protector before calling nounwind functions")
> landed April 13, so please check that your build of clang-17 is after that date.
> 
> Either way, thanks for testing with clang, and the report. You can
> always file a bug at our issue tracker:
> https://github.com/ClangBuiltLinux/linux/issues or see our page for
> more ways to get in touch:
> https://clangbuiltlinux.github.io/
> We're very active on our mailing list, and on IRC.

Ack, thanks for letting me know for next time.

- David
