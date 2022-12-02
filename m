Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8BC640E01
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiLBS6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiLBS6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:58:15 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC392FD7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:58:13 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id l127so5086294pfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPdGcOCEsG7lUmArEzStFj43mzNWvKg2+Ebw16M3TCY=;
        b=PU3gDK3JBsY8Izq24LkRkMa24eKn0Mu0dmVHTCV4yTEpqX6bxxHxWKaBIDHx0HnqeJ
         jhExXB/Ex03vAiF69WJEpsCl4UWQ9Tovfwyo9wxw+NkZDdH0KfetQa679Ugg8duke325
         KxFZeqdCU9j9zaf0rQ4JEC0LZDDu0WcfjaHss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPdGcOCEsG7lUmArEzStFj43mzNWvKg2+Ebw16M3TCY=;
        b=YOuhGmrG3SBhX9Gu5rctSrmFC/mk0+q6RuQV+7go8bGzZPSCASPZzFw3es97Jjpy2T
         E+iPdBvKAF6ctwFEBSRqgONmZvwWdoiaQ3u0ydyuGM1HP+/39duWKPv/IHXXd4WOcZCe
         HD2swc/dDiyPFr0l4pc4zpjYU9X1S5USrUVUco77eDnVnQJ9BmwdJfTr5dqrjwAtioAR
         gyYqiqMv8q5PeQGNuQxxfw87Iwe3u3oiy2sSHLN3TiopbSY2jm4cCFOq+9EALdSMhKqX
         IxwKEFXBE7s0yKb9gc8gCkJR+83/pnEm0KnwUNkEKMOTss89tE2QoyNeOkAWAzjwDu9J
         kyPw==
X-Gm-Message-State: ANoB5pl0EAw3oK8lnwH0x1FkeJgYOfD4B362MjYurDnVmf96bSjyfPvQ
        igrw6ocYURtpff2pPrlDDjm4iQ==
X-Google-Smtp-Source: AA0mqf48V3uHLmY0yySTaOoB/FYAXZPXo2e4ikb3ZgTnAR9y+ke4PQBq1FnMqulyBpKVV19bLfFIbA==
X-Received: by 2002:a62:65c3:0:b0:562:ce80:1417 with SMTP id z186-20020a6265c3000000b00562ce801417mr53353551pfb.19.1670007492560;
        Fri, 02 Dec 2022 10:58:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b0016c9e5f291bsm5948660plh.111.2022.12.02.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:58:11 -0800 (PST)
Date:   Fri, 2 Dec 2022 10:58:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Anders Roxell' <anders.roxell@linaro.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Message-ID: <202212021057.B1B1BDE380@keescook>
References: <20221028210527.never.934-kees@kernel.org>
 <20221202005814.GD69385@mutt>
 <4f7ffdd948a84013a0e84876b3e3944b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f7ffdd948a84013a0e84876b3e3944b@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 10:01:50AM +0000, David Laight wrote:
> From: Anders Roxell
> > Sent: 02 December 2022 00:58
> > 
> > On 2022-10-28 14:05, Kees Cook wrote:
> > > GCC 12 appears to perform constant propagation incompletely(?) and can
> > > no longer notice that "len" is always 0 when "data" is NULL. Expand the
> > > check to avoid warnings about memcpy() having a NULL argument:
> > >
> > >    ...
> > >                     from drivers/crypto/caam/key_gen.c:8:
> > >    drivers/crypto/caam/desc_constr.h: In function 'append_data.constprop':
> > >    include/linux/fortify-string.h:48:33: warning: argument 2 null where non-null expected [-
> > Wnonnull]
> > >       48 | #define __underlying_memcpy     __builtin_memcpy
> > >          |                                 ^
> > >    include/linux/fortify-string.h:438:9: note: in expansion of macro '__underlying_memcpy'
> > >      438 |         __underlying_##op(p, q, __fortify_size);                        \
> > >          |         ^~~~~~~~~~~~~
> ...
> 
> Is this really a bug in the fortify-string wrappers?
> IIRC the call is memcpy(NULL, ptr, 0) (or maybe memcpy(ptr, NULL, 0).
> In either case call can be removed at compile time.
> 
> I'd bet that the constant propagation of 'len' fails because
> of all the intermediate variables that get used in order to
> avoid multiple evaluation.
> 
> The some 'tricks' that are used in min() (see minmax.h) to
> generate a constant output for constant input could be
> use to detect a compile-time zero length.
> 
> Something like:
> #define memcpy(dst, src, len) \
> 	(__is_constzero(len) ? (dst) : memcpy_check(dst, src, len))
> 
> With:
> #define __is_constzero(x) sizeof(*(1 ? (void *)(x) : (int *)0) != 1)
> Which could go into const.h and used in the definition of __is_constexpr().

While it could be possible to strip the nonnull attribute, I think it's
not an unreasonable check to have. This is literally the only case in
the entire kernel that is tripped, for example.

-- 
Kees Cook
