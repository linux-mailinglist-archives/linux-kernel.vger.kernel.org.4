Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB36364690D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLHGWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHGWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:22:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7397465F9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 22:22:38 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 21so523324pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 22:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s6jTgKsQ68J7skKW9eoZwb+OAXDCIfdVmUwGyZmiR50=;
        b=AyUhrXdx4t4YNuWSvUXNR0u6S9ja5ELKXekSpg11PKxxIcrOAvXxfHUrzsjmWsZWXQ
         C849JfRruviAREfe8IOQZ21YCj+oTkq+ow5MQs77e1hP8w9nps/75PQJZmhZAviDhikl
         4jzN3TiwDqgr8Ax7mkbv+zD5mq7M9EDsx0yfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6jTgKsQ68J7skKW9eoZwb+OAXDCIfdVmUwGyZmiR50=;
        b=3nR7YlRQvWngMKlvJ8sa5D5N1te6eEz0Kq956lvfyWpYN0P2E0ZIxIcxc4CCyCUj0a
         ilX6QO+ODXETQDWX9sOwMvH73f5BC6YfeSa4i4cWCZN23xtZ2AIJiu7D/PI5oQAc95BC
         2/S6uaOghzXGWYejH5Xiu4upsx7s3y2GQiILvEUCqt5WteosGiVTCvK+1wht/iK8Kb27
         YlGozsLYUU9xWxIA8YKtSqE5rDhuXUl48rkSJQPF8VKgG+H8jkhQDidIKx5f7S4nbef4
         6wUy/z79AxaiIOjZI/caNiyIYDSf60WFmpqARWecFUVc+oShlfl4PNvLxLXqEoIEBQpw
         0MlA==
X-Gm-Message-State: ANoB5plsWpVULqjCgM9FmI/ty2c4Ld6iJx6FXCWjm066+rd3aMbEYmPi
        sIS+0D0ZmdjfB6Ly2CNTew6UWg==
X-Google-Smtp-Source: AA0mqf6BVrewrRkokET1aUlODnvYJPULRifGLbbikXTrtOHQ58JHn3uEnJ/pHsMHinBavlzZriYsRQ==
X-Received: by 2002:a05:6a00:2794:b0:575:335f:dd33 with SMTP id bd20-20020a056a00279400b00575335fdd33mr49246661pfb.84.1670480557858;
        Wed, 07 Dec 2022 22:22:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b00188f8badbcdsm10158750plg.137.2022.12.07.22.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 22:22:37 -0800 (PST)
Date:   Wed, 7 Dec 2022 22:22:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Dan Li <ashimida@linux.alibaba.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Message-ID: <202212072221.A9FCC905CF@keescook>
References: <20220416001103.1524653-1-keescook@chromium.org>
 <CAEUSe78kDPxQmQqCWW-_9LCgJDFhAeMoVBFnX9QLx18Z4uT4VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe78kDPxQmQqCWW-_9LCgJDFhAeMoVBFnX9QLx18Z4uT4VQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 06:28:53PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Sat, 16 Apr 2022 at 00:30, Kees Cook <keescook@chromium.org> wrote:
> > In order to test various backward-edge control flow integrity methods,
> > add a test that manipulates the return address on the stack. Currently
> > only arm64 Pointer Authentication and Shadow Call Stack is supported.
> >
> >  $ echo CFI_BACKWARD | cat >/sys/kernel/debug/provoke-crash/DIRECT
> >
> > Under SCS, successful test of the mitigation is reported as:
> >
> >  lkdtm: Performing direct entry CFI_BACKWARD
> >  lkdtm: Attempting unchecked stack return address redirection ...
> >  lkdtm: ok: redirected stack return address.
> >  lkdtm: Attempting checked stack return address redirection ...
> >  lkdtm: ok: control flow unchanged.
> >
> > Under PAC, successful test of the mitigation is reported by the PAC
> > exception handler:
> >
> >  lkdtm: Performing direct entry CFI_BACKWARD
> >  lkdtm: Attempting unchecked stack return address redirection ...
> >  lkdtm: ok: redirected stack return address.
> >  lkdtm: Attempting checked stack return address redirection ...
> >  Unable to handle kernel paging request at virtual address bfffffc0088d0514
> >  Mem abort info:
> >    ESR = 0x86000004
> >    EC = 0x21: IABT (current EL), IL = 32 bits
> >    SET = 0, FnV = 0
> >    EA = 0, S1PTW = 0
> >    FSC = 0x04: level 0 translation fault
> >  [bfffffc0088d0514] address between user and kernel address ranges
> >  ...
> >
> > If the CONFIGs are missing (or the mitigation isn't working), failure
> > is reported as:
> >
> >  lkdtm: Performing direct entry CFI_BACKWARD
> >  lkdtm: Attempting unchecked stack return address redirection ...
> >  lkdtm: ok: redirected stack return address.
> >  lkdtm: Attempting checked stack return address redirection ...
> >  lkdtm: FAIL: stack return address was redirected!
> >  lkdtm: This is probably expected, since this kernel was built *without* CONFIG_ARM64_PTR_AUTH_KERNEL=y nor CONFIG_SHADOW_CALL_STACK=y
> >
> > Co-developed-by: Dan Li <ashimida@linux.alibaba.com>
> > Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v1: https://lore.kernel.org/lkml/20220413213917.711770-1-keescook@chromium.org
> > v2:
> >  - add PAGE_OFFSET setting for PAC bits (Dan Li)
> > ---
> >  drivers/misc/lkdtm/cfi.c                | 134 ++++++++++++++++++++++++
> >  tools/testing/selftests/lkdtm/tests.txt |   1 +
> >  2 files changed, 135 insertions(+)
> >
> > diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
> > index e88f778be0d5..804965a480b7 100644
> > --- a/drivers/misc/lkdtm/cfi.c
> > +++ b/drivers/misc/lkdtm/cfi.c
> > @@ -3,6 +3,7 @@
> >   * This is for all the tests relating directly to Control Flow Integrity.
> >   */
> >  #include "lkdtm.h"
> > +#include <asm/page.h>
> >
> >  static int called_count;
> >
> > @@ -42,8 +43,141 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
> >         pr_expected_config(CONFIG_CFI_CLANG);
> >  }
> >
> > +/*
> > + * This can stay local to LKDTM, as there should not be a production reason
> > + * to disable PAC && SCS.
> > + */
> > +#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
> > +# ifdef CONFIG_ARM64_BTI_KERNEL
> > +#  define __no_pac             "branch-protection=bti"
> > +# else
> > +#  define __no_pac             "branch-protection=none"
> > +# endif
> > +# define __no_ret_protection   __noscs __attribute__((__target__(__no_pac)))
> > +#else
> > +# define __no_ret_protection   __noscs
> > +#endif
> 
> We're seeing this problem with allmodconfig on arm64 and GCC 8 (this
> one observed on 6.0.12-rc3):
> 
> -----8<----------8<----------8<-----
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/2/build
> CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- ARCH=arm64
> CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
> 'HOSTCC=sccache gcc'
> /builds/linux/drivers/misc/lkdtm/cfi.c:67:1: error: pragma or
> attribute 'target("branch-protection=none")' is not valid
>  {
>  ^

Uuuh... how is CONFIG_ARM64_PTR_AUTH_KERNEL getting set if the compiler
can't support the 'target("branch-protection=none")' attribute?

-- 
Kees Cook
