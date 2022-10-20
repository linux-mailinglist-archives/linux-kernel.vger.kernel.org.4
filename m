Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E0B606886
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJTS5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJTS5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:57:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0898316A4DB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:57:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g28so397054pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFG8oe8zjIP3HtrEYf8FZ1cCVncWHGDhPegdRUm6pSk=;
        b=JH10v71f9cO/zrGHhWXMzQx4+lZEXvmFPiD6f82j66NBiYRArMO6WA87v5WRzOFdmJ
         vFAhDRdieYSaEwIMaX4NLT7dRZsmxrRodnE3B2inGJhsPNES+Wrq+P3EMm9m7qfLm7+X
         VDQRrM3G4guBVWiBNXcjYnt5uMWuXxdXqgHv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFG8oe8zjIP3HtrEYf8FZ1cCVncWHGDhPegdRUm6pSk=;
        b=2p8/mWiJeNXojWD5XF9p/NOcMCv4Z9HvoKLKHN5S7R57Pagp1YpVd6Lly8TfySU3bj
         KftHRIfxHu628re/8zXwRDxNxadNCpgDBoS4IKHoYh+2Tmk5UCSfJEcNelnftDcKjSpM
         5wrazwvuuaushKO9xkY9VY5ONBVaUWuvjTlO7Fq74r6F7qzGIgvsH3jh+IhczcDvViZg
         V1PZmy5Ohf12ZcPwkhNpRFRX4zf6kojfzR1I/sBSEtBUYBoJun1Eu59+js0LP87LzkZE
         KW0pA4yLYJX1bQqzX3YbyP+yEt71Iq3a1iOedbW+84EquRr06ZoGBJxIHkAOf3/ivZMe
         wRzQ==
X-Gm-Message-State: ACrzQf1Ycpcg/jkgAFGx3dDLSRODbbbL2tidFXR++J4Dl+ep6tTytksx
        ewBQZTuu7ome8I9IlzcZ08RzwQ==
X-Google-Smtp-Source: AMsMyM5LsHsFEMX8I6dkcpYhAJP8fLYRo6gtf8HpJpwWxcUentkixVPXvC3hRVRGYAOeDT0aPDAVFw==
X-Received: by 2002:a05:6a00:1707:b0:563:235:769b with SMTP id h7-20020a056a00170700b005630235769bmr15374927pfc.19.1666292234509;
        Thu, 20 Oct 2022 11:57:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c28-20020aa7953c000000b0053725e331a1sm13669135pfp.82.2022.10.20.11.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:57:13 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:57:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Message-ID: <202210201151.ECC19BC97A@keescook>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:42:25AM -0700, Linus Torvalds wrote:
> On Thu, Oct 20, 2022 at 10:33 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Or sometimes with objdump, I've had more success by keeping debug
> > symbols, and then trimming offsets from jmps.
> 
> objdump is what I'm using, and it actually seems ok on individual object files.
> 
> Now I just need to script the "do all the object files" and see how
> massive the end result is.

For the a/b build, I start with all*config, then:

# Stop painful noise
CONFIG_KCOV=n
CONFIG_GCOV_KERNEL=n
CONFIG_GCC_PLUGINS=n
CONFIG_IKHEADERS=n
CONFIG_KASAN=n
CONFIG_UBSAN=n
CONFIG_KCSAN=n
CONFIG_KMSAN=n
# Get us source/line details
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
CONFIG_DEBUG_INFO_REDUCED=n CONFIG_DEBUG_INFO_COMPRESSED=n
CONFIG_DEBUG_INFO_SPLIT=n

And to keep other build-time junk stabilized[1], I build with these make
options:

KBUILD_BUILD_TIMESTAMP=1970-01-01
KBUILD_BUILD_USER=user
KBUILD_BUILD_HOST=host
KBUILD_BUILD_VERSION=1

For the code diff, I use:

objdump --disassemble --demangle --no-show-raw-insn --no-addresses

and when doing the manual examination:

objdump --disassemble --demangle --reloc --source -l --no-show-raw-insn


My not-great way to filter out the movsbl/movzbl, I added this to diff:
	-I '\bmov[sz]bl\b'


-- 
Kees Cook
