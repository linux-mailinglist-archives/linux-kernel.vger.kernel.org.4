Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0B64F4DC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLPXPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLPXPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:15:17 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4451563A1;
        Fri, 16 Dec 2022 15:15:15 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso5104181wms.4;
        Fri, 16 Dec 2022 15:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBsUm8iDTB+c2THpWnNDO3v6zfDYGcvFBEzQEwB5p+Q=;
        b=2TDXOIWSJhk3wAeCu4qMaFNwMz6v+33DlY4AlnalYCk3TUHKjcvD1w2te8BZOyg1X0
         xMwXLHHwpJjpBf01A+wY3kZO8S1TUZbHhFLxW1pyAwmHOZTrga2erJyTzpforX2RLkqS
         zOgKCZOECUPtpPotXVJr9Qgkg97RmOz9yoKZpbxRrM05C1ZLOpBtY7KHZAd0pQotKsEr
         fHJddQnDQa6/yTvLqmqmc08Crun0M8At8GKj3PFw2ZGc6S0wTpd/8bwV/x/mcuAzp4J8
         ZKW7fBrv3hppw0vWObrATQo2pX4SPKcYNtNGGsVym5NYNVcx3jCyhq59IurgK+/0oJD0
         ZazA==
X-Gm-Message-State: ANoB5pmh5Wn7xypf4e7brTxCqHZSTlbrUXiAHNYUkls65E2UUPzELYRH
        GkzGKDxVgQ4m3nSjz/3zarAW24zrHHY=
X-Google-Smtp-Source: AA0mqf69VdlADAtAcOu7aIwHaTjSRlqjYaHbBCGX0RiV1+qcxsWc0R71WoRsYxrexyS40+lyu23dKA==
X-Received: by 2002:a05:600c:21c1:b0:3cf:8833:1841 with SMTP id x1-20020a05600c21c100b003cf88331841mr26926497wmj.39.1671232513890;
        Fri, 16 Dec 2022 15:15:13 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x33-20020a05600c18a100b003d1cc0464a2sm3681803wmp.8.2022.12.16.15.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:15:13 -0800 (PST)
Date:   Fri, 16 Dec 2022 23:15:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>, rust-for-linux@vger.kernel.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH] rust: kernel: drop repetition in offset_of macro
Message-ID: <Y5z7/9OVzZd1ols1@liuwe-devbox-debian-v2>
References: <20221216174927.1008629-1-wei.liu@kernel.org>
 <CANeycqo2qKUnyh6XVkBHyAcVjvN9NKJ9sb9bTzkHq7jC1C-B0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANeycqo2qKUnyh6XVkBHyAcVjvN9NKJ9sb9bTzkHq7jC1C-B0w@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 06:26:57PM +0000, Wedson Almeida Filho wrote:
> On Fri, 16 Dec 2022 at 17:49, Wei Liu <wei.liu@kernel.org> wrote:
> >
> > It doesn't make sense to allow multiple fields to be specified in
> > offset_of.
> 
> Why do you say it doesn't make sense?
> 
> Here's what I had in mind:
> ```
>     struct Y {
>         z: u32
>     }
>     struct X {
>         y: Y
>     }
>     offset_of!(X, y.z)
> ```
> 
> Which is something very plausible.
> 
> > No functional change.
> >
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Alex Gaynor <alex.gaynor@gmail.com>
> > Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
> > ---
> >  rust/kernel/lib.rs | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 6a322effa60c..2f3601e4e27e 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -208,7 +208,7 @@ impl<'a> Drop for KParamGuard<'a> {
> >  /// ```
> >  #[macro_export]
> >  macro_rules! offset_of {
> > -    ($type:ty, $($f:tt)*) => {{

Shouldn't this be + instead of *?

offset_of!(X,) is valid according to this pattern.

Thanks,
Wei.
