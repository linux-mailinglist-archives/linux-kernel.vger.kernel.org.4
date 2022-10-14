Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1A5FE8F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJNGiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJNGiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C890817FD45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 23:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665729481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RoJELZz+x5LeDD7tOYxw1KCc4ujCDiWMWLzIpNsWuQc=;
        b=ai0lyKo6T10HLudneLxcs3hRU5p0+WELJIJ0RxpI1FjTKR97UCTqkuXZYJZdwI5jAbHisK
        6E8nDFhJPQRx9yoqKRe5UTfcAo4Iza7u+k9mq7qBEGFbFZNVlpIWuPEPdBSqCL5MjbBdm4
        t0KDn8yb6PzKSgsIobzF1BLqFq6XSG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-5vDBHopnMZe7Y0H0KO491A-1; Fri, 14 Oct 2022 02:37:55 -0400
X-MC-Unique: 5vDBHopnMZe7Y0H0KO491A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FE8F803D4A;
        Fri, 14 Oct 2022 06:37:55 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDF2784427;
        Fri, 14 Oct 2022 06:37:53 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
        <Y0gLyLbdOCetX5LN@sirena.org.uk> <Y0gteD0QYVlYxSZh@zx2c4.com>
        <87mt9zwotq.fsf@oldenburg.str.redhat.com>
        <CAKwvOdnP=FTzhm1S-_ZyQaF+LGYkF1DWUekRzvEmxAr=u=FTCQ@mail.gmail.com>
Date:   Fri, 14 Oct 2022 08:37:52 +0200
In-Reply-To: <CAKwvOdnP=FTzhm1S-_ZyQaF+LGYkF1DWUekRzvEmxAr=u=FTCQ@mail.gmail.com>
        (Nick Desaulniers's message of "Thu, 13 Oct 2022 14:03:30 -0700")
Message-ID: <87k052q5a7.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Desaulniers:

> On Thu, Oct 13, 2022 at 11:44 AM Florian Weimer <fweimer@redhat.com> wrote:
>>
>> * Jason A. Donenfeld:
>>
>> > It's also easy, nearly trivial, to download toolchains. Arnd provides a
>> > bunch with his crosstool. "Must use a toolchain from your distro" is a
>> > requirement that affects nobody.
>>
>> But not everything will be built with the cross-compiler.  For the
>> kernel build tools and other userspace components, you'll need a native
>> toolchain that can build programs that can actually run on the build
>> host.
>
> ... when using GCC. We don't have this pain when using clang.
>
> https://docs.kernel.org/kbuild/llvm.html#llvm-utilities
>
> i.e.
> $ make ARCH=arm LLVM=1
>
> will build with one instance of a clang binary (and ld.lld and
> llvm-objcopy etc.) for Target AND Host.  No need for multiple
> toolchain binaries.

I'm sure it's nice if it works.  But someone has to do the distribution
integration work.  If that has already happened upstream, that's great.
(There are many little details which may or may not matter for kernel
builds, e.g., static libraries have to be PIC or PIE because Clang now
defaults to PIE links.)

But it's also sort of irrelevant in the context of this thread.
<https://llvm.org/docs/GettingStarted.html#software> says GCC 7 is
required, and this:

| LLVM is very demanding of the host C++ compiler, and as such tends to
| expose bugs in the compiler. We also attempt to follow improvements
| and developments in the C++ language and library reasonably
| closely. As such, we require a modern host C++ toolchain, both
| compiler and standard library, in order to build LLVM.

So a LLVM build from upstream sources won't be an easy escape hatch if
the kernel bumps toolchain version requirements.

Historically, GCC has been much more conservative when it comes to host
toolchain requirements.  But there are other traps (fixincludes can have
nasty side effects, for example).

I'm not saying the kernel shouldn't change version requirements.  But I
do think it's unreasonable to expect that people will be able to build
their own newer toolchains from upstream sources as a workaround.

Thanks,
Florian

