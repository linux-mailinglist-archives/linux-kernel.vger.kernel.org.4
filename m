Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2745FE3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJMVDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJMVDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:03:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05A182C69
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:03:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r18so2570952pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Il2rGNYxjJhMHsk4sRcQXbmRvOqimaNvSUOoFHIkwzI=;
        b=Sucl3acqPxAh3PDJMN7H/QG54qu+L8Ldkn452tfm/zBPyu6xLwjH5VWQe65r1hjUGb
         Ovffl2ubmHUkygNdK5y/O7oubxLittCZ1Vrnl87UB8VFWZOoo7EJ5k5xNa9hOWOuHWId
         /d9l+ocLqICXDa5NJxBrEA7c6jfDCa8sMpRPWAXnSsXtIR3cr/V9iIiWaEPuUeyS25LS
         gBQ4q3jD6BbPFOE2UaXWT3F4HBeMj+KEg8uPeh5kw+fJosVAweLeF3+ItLolGcSP8TPH
         jHALUrqkTTnK7SVGDOsgmIk10MbmKjtSQq1HNZZ5mU6Lbr2MB9EVlcSB6FNU2PSqCC+m
         ypaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il2rGNYxjJhMHsk4sRcQXbmRvOqimaNvSUOoFHIkwzI=;
        b=uYWg/XyLAvd3XRPVYilRbcKq1LzQUohK0fhU/6x1x1NCvZUv6PkZJVL0UiiWTSclXI
         hsKQZ3wdSNePAfXYpBg5AXqLdAJOeW6l5MgFiPFJZLMFFDA1k0XCq4XoJPOYmblRghcs
         VPyznD0tNP1yVtUMZUY7T9vCLv6x9kMJL4L1YfWe1rpZ8CuKn0VpzO2gErv03NifTvB7
         f6hnL/f8RTjFNRpwB7RNzjegXOsyOkjAJbcHZzwvROv1QvnQbiHmzmgmnUv3FhuSJEfw
         RjZ5T4bfNmLZ7Gs1pMNsnNsrKvlHqodEOXcBYsliNkIh/cZl4uiUyneNC2YsAL3CjZzQ
         /OwQ==
X-Gm-Message-State: ACrzQf3OiJdfSkxrAe+KmT0kQ3oMTKDWUatf+g9L3shS6kxN2voJiIzf
        SRJ+umKA0XsPVSkhi3q1Li+2cKUACzt3nP64stQV7A==
X-Google-Smtp-Source: AMsMyM42YtJqYefQMBVHhnTMp0GFTbHFPOu1pCWOZPMJcZ97coTvBuJUTPCOTwN6f6MsKjIV4SvHzXL+2nB+RIFpJLw=
X-Received: by 2002:a63:2cd2:0:b0:41c:5901:67d8 with SMTP id
 s201-20020a632cd2000000b0041c590167d8mr1531488pgs.365.1665695022463; Thu, 13
 Oct 2022 14:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk> <Y0gteD0QYVlYxSZh@zx2c4.com> <87mt9zwotq.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87mt9zwotq.fsf@oldenburg.str.redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Oct 2022 14:03:30 -0700
Message-ID: <CAKwvOdnP=FTzhm1S-_ZyQaF+LGYkF1DWUekRzvEmxAr=u=FTCQ@mail.gmail.com>
Subject: Re: gcc 5 & 6 & others already out of date?
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Oct 13, 2022 at 11:44 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Jason A. Donenfeld:
>
> > It's also easy, nearly trivial, to download toolchains. Arnd provides a
> > bunch with his crosstool. "Must use a toolchain from your distro" is a
> > requirement that affects nobody.
>
> But not everything will be built with the cross-compiler.  For the
> kernel build tools and other userspace components, you'll need a native
> toolchain that can build programs that can actually run on the build
> host.

... when using GCC. We don't have this pain when using clang.

https://docs.kernel.org/kbuild/llvm.html#llvm-utilities

i.e.
$ make ARCH=arm LLVM=1

will build with one instance of a clang binary (and ld.lld and
llvm-objcopy etc.) for Target AND Host.  No need for multiple
toolchain binaries.
-- 
Thanks,
~Nick Desaulniers
