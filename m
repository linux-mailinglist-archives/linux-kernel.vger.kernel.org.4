Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5488705FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjEQGUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjEQGUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:20:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F532691
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:20:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f423521b10so2176775e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684304413; x=1686896413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E2SYMNkYj5fwh2CwNKXNMw46e/jfwO8wrtwmmlwcF+U=;
        b=BwH0XaCVAk3BuMCFjpXVa3jmDLdLInbVss2XtWSfcGd2KzJkIKvxnaOdoONNclKG6b
         4DNXjKrxNrWjHJEST/TyPvQjuBVg7xkSDfdR7i+zXEO8Pe6kuBhoRImqDSAJiWycHwsJ
         X8iFScjWV3U7dgbDIMc8IoYcjj8aTGKTFrRrulJXeE5eVPKMHAxo2ZNa+ioDDf/JLEV8
         WFdmDLhgnEtRi2tWot6BvLE3pVP783A6svlg64qH6QdW6ZfLNHJNtBO9KopoyDLnfkt2
         r+WJBNS8CB9Tv7aKTFNh6Ve1eso+AfrXkw1/VXXdDwLi1+tCOth9cewsFuz3pkFn5y0d
         cGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304413; x=1686896413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2SYMNkYj5fwh2CwNKXNMw46e/jfwO8wrtwmmlwcF+U=;
        b=RlxemLeQZtRwdT9SOTmXFgrROncM6YZ551y84B8UuWFM5iRyRbVOyxmGyR/HSNMcyj
         /Jq6wiEYepYVClfTXlsoBfjTNSAldD5A/CrRSet/cFrgygn+I6S2WgDdacoyZBM9d6Kh
         7SiinCD6N1Y/JIjzYVy4xzoP4e2+EhSWiPVn+P52gA9cnvKGOaoZSwd52JP82+SiBBrT
         fwGpHggQJe87hkQoP6x4xBJp5rvgmQmv9Qq9wkgNpXPWLve40wMys8BA9QQuRtZ+UO/l
         3LtG9jXuoemET7CNSgBEu8nO//+Yr15GO9t/OMxUqdceFj2Ivx/YDKySqBP163xWmKcC
         AnMQ==
X-Gm-Message-State: AC+VfDwPDn/ZbuqyPc+groro+N/hpa2EiEzCfhPeptUEw5NE4KecyeWS
        ucnAqLr8la2EISqvlIKqfpYWBG0F/Q==
X-Google-Smtp-Source: ACHHUZ7npiNQcZZwu7ZgV/R5wR36KjVl8u2DOnb9h7uJV+178AtK44FXGzM0999L31ZdiNoMT9iFNQ==
X-Received: by 2002:a7b:c7cb:0:b0:3f4:2cb2:a6cf with SMTP id z11-20020a7bc7cb000000b003f42cb2a6cfmr18565734wmk.10.1684304413293;
        Tue, 16 May 2023 23:20:13 -0700 (PDT)
Received: from p183 ([46.53.250.125])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c21c700b003f4e3ed98ffsm1056121wmj.35.2023.05.16.23.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:20:12 -0700 (PDT)
Date:   Wed, 17 May 2023 09:20:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] auto: add "auto" keyword as alias for __auto_type
Message-ID: <7aa74931-f558-4eb9-9083-f4d4789d4fb0@p183>
References: <20230516164947.86543-1-adobriyan@gmail.com>
 <20230516164947.86543-2-adobriyan@gmail.com>
 <20230516143910.ad39ddb949ca29d3a7cfdba1@linux-foundation.org>
 <CAHk-=wizmGie-9SznxRraSEAAQ7OHmyR0y0foWEDF35M7dfJEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wizmGie-9SznxRraSEAAQ7OHmyR0y0foWEDF35M7dfJEw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 04:18:59PM -0700, Linus Torvalds wrote:
> On Tue, May 16, 2023 at 2:39 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > It is pretty cool and could get used a lot.  Cc Linus for his thoughts?
> 
> I'm not against it, although I'm also not convinced we need / want to
> convert existing users of typeof().
> 
> The reason we use typeof is that that has always worked in gcc, and
> __auto_type is relatively "new" in contrast.
> 
> But we require at least gcc-5.1 anyway, so it should be fine.
> 
> Note that mindless conversions can be dangerous: using "typeof(x)" in
> macros may end up feeling a bit verbose, and "auto" can appear nicer,
> but the auto use needs to be *very* careful about integer promotions.
> 
> For example, in
> 
>   #define WRAPPER(c) do { \
>         typeof(c) __c = (c);
>         ...
> 
> it is very obvious what the type is.
> 
> But while using
> 
>    #define WRAPPER(c) do { \
>         auto __c = (c);
> 
> gives you the same result with less redundancy (no need to state 'c'
> twice), if you *ever* then happen to make that an integer expression
> that is not *just* 'c' - even a trivial one - suddenly 'var' goes from
> 'char' to 'int' because of the integer expression.
> 
> So __auto_type (and I agree that if we use it, we should probably just
> wrap it in an 'auto' #define, since the legacy 'auto' keyword is
> useless) can result in simpler and more obvious code, but it can also
> lead to subtle type issues that are easy to then overlook.
> 
> The above is not an argument against 'auto', but it's one reason I'm
> not convinced some mindless "convert existing uses of __typeof__" is a
> good idea even if it might make some of them more legible.
> 
> But I have nothing against people starting to use it in new code.
> 
> And no, I don't think we should do that
> 
>     KBUILD_CFLAGS += -Dauto=__auto_type
> 
> in the Makefile as Alexey suggests.
> 
> I think this is a 'compiler_types.h' kind of thing, and goes along
> with all the other "simplied syntax" things we do (ie we redefine
> 'inline', we add "__weak" etc etc etc).

Sure. I thought about where to put it in the filesystem under nice name
but somehow completely forgot about compiler_types.h

I'll probably go through core headers at least and start conversion
myself. Expect version 2 soon.
