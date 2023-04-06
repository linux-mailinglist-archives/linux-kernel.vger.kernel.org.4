Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9276DA4B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbjDFVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjDFVbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:31:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931999749;
        Thu,  6 Apr 2023 14:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ECBE63D8C;
        Thu,  6 Apr 2023 21:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B66C4339B;
        Thu,  6 Apr 2023 21:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680816694;
        bh=HelVz4kZbXm+Rah9vhJsCLUNIR4bUm6nFIAmLLiqkbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYTjVd7ywbGnEhbcl/2fL2KfwQuymIsZ12J9dzXUJHlq2XaswYhR83+D5ASKktb3/
         1RlaEQyMvPpyMrgnCQTfuMEhat2SkkcDZ5rqGxtmshO5Qg92R0+DrE6uGRszPqz9KN
         iCI874zc0TPXflOIOAgvaTv9q2u/n7IPseMnVuoYp0KVWNIjYp+SfZo6hgxaloibjh
         cJHgr9ja/hY2Fd/7EwNWHt4iTji/qTjXuGd9YIvFyc4GDim43k8yWJX1YFRpS+DrVu
         Q49+reVSQKb6UxpQIQnzcb+LMJ9kkj3/G9BCxksEcD6R0T24Rf+OgBnW5TZRpRgvd+
         Q9Q68OaYKr/1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12E164052D; Thu,  6 Apr 2023 18:31:32 -0300 (-03)
Date:   Thu, 6 Apr 2023 18:31:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] tools: Rename __fallthrough to fallthrough
Message-ID: <ZC86NOtaBPi1lhtI@kernel.org>
References: <20221125154947.2163498-1-Liam.Howlett@oracle.com>
 <CANiq72ntFXb+ZhBqgBAMu2n8wcgJLZRZC1rmBVvL5m+K1Nhw2w@mail.gmail.com>
 <20230406195830.ieiozetmk7qjllol@revolver>
 <CANiq72=C4OCcbX4C-ap3YTm5Ni6RdskQ67rt4iWs0_1hTe1rkw@mail.gmail.com>
 <ZC81Z4p8WnYtVwFT@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZC81Z4p8WnYtVwFT@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 06, 2023 at 06:11:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 06, 2023 at 10:02:57PM +0200, Miguel Ojeda escreveu:
> > On Thu, Apr 6, 2023 at 9:58 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > > Any chance of this being accepted?  I'm looking to use this in the radix
> > > test suite and would rather not duplicate code.
> > 
> > That would be up to the `tools/perf/` maintainers.
> 
> Thanks, applied,

So, I noticed some missing conversions, fixed that, but then when trying
to test build it with:

	make -C tools/perf build-test

I stumbled on this:

             make_with_gtk2: cd . && make GTK2=1 -j32  DESTDIR=/tmp/tmp.5AP8tPJgiT
cd . && make GTK2=1 -j32 DESTDIR=/tmp/tmp.5AP8tPJgiT
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
<SNIP>
  CC      trace/beauty/ioctl.o
In file included from /usr/lib64/glib-2.0/include/glibconfig.h:9,
                 from /usr/include/glib-2.0/glib/gtypes.h:34,
                 from /usr/include/glib-2.0/glib/galloca.h:34,
                 from /usr/include/glib-2.0/glib.h:32,
                 from /usr/include/glib-2.0/gobject/gbinding.h:30,
                 from /usr/include/glib-2.0/glib-object.h:24,
                 from /usr/include/glib-2.0/gio/gioenums.h:30,
                 from /usr/include/glib-2.0/gio/giotypes.h:30,
                 from /usr/include/glib-2.0/gio/gio.h:28,
                 from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:30,
                 from /usr/include/gtk-2.0/gdk/gdk.h:32,
                 from /usr/include/gtk-2.0/gtk/gtk.h:32,
                 from ui/gtk/gtk.h:8,
                 from ui/gtk/helpline.c:6:
/usr/include/glib-2.0/glib/gmacros.h:637:28: error: missing ')' after "__has_attribute"
  637 | #if g_macro__has_attribute(fallthrough)
      |                            ^~~~~~~~~~~
In file included from /var/home/acme/git/perf-tools-next/tools/include/linux/compiler_types.h:36,
                 from /var/home/acme/git/perf-tools-next/tools/include/linux/compiler.h:5,
                 from /var/home/acme/git/perf-tools-next/tools/include/linux/build_bug.h:5,
                 from /var/home/acme/git/perf-tools-next/tools/include/linux/kernel.h:8,
                 from ui/gtk/helpline.c:4:
/var/home/acme/git/perf-tools-next/tools/include/linux/compiler-gcc.h:16:55: error: missing binary operator before token "("
   16 | # define fallthrough                    __attribute__((__fallthrough__))
      |                                                       ^
/usr/include/glib-2.0/glib/gmacros.h:637:28: note: in expansion of macro ‘fallthrough’
  637 | #if g_macro__has_attribute(fallthrough)
      |                            ^~~~~~~~~~~
  CC      trace/beauty/kcmp.o
  CC      bench/sched-messaging.o
  CC      trace/beauty/mount_flags.o


I'm trying to fix this now...

- Arnaldo
