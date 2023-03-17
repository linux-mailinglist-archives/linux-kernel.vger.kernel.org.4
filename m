Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0096BEEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCQQxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCQQxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:53:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5645B52934;
        Fri, 17 Mar 2023 09:53:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so22884542edd.5;
        Fri, 17 Mar 2023 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679071988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xik3iJ00mVNTE2RhMz8qKcSHsqehHvNwOtK7XaZrqLU=;
        b=eaQwsSVwxarxhh1j5Q/OGFagC7mZqqgwlEifOKAuo/MdgYoqcz5yMDjGj5kS6Ql8dz
         +yUKqxh8WQg4B9myzmEhVvtA31b9tEnlOkj/bieK+tAF43TXImAmx/ZEtXIp6gtHZXPK
         ++iGSS32BGUrpInzp8xokQGRgzSVcGvKlKIrNi6QLNhYx3oqZR3xuf+IGkB62wi44YFB
         T6o+jcH16dSezrS06k4Cxwt08xDkFrRi3kJe+XfN+Fk/63/6biZtUtcTNGqPR4rLb4mh
         ArtWN1OAPqkCLLbUmG67tltL3nums7lBzIJ3oac38rptd9OE9fJO/8ugMc297gjPOmcg
         teZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xik3iJ00mVNTE2RhMz8qKcSHsqehHvNwOtK7XaZrqLU=;
        b=2Kqsp96PgIqn/eEsmUZJ9vvyHZhkHFzV33X7wTqlPWsB/hjW2G2T+D3J2WgtZaTMTg
         wZH8SsZKY5nBhS4baI4LOzUQRt4inQT+XcaE+p0RIiq5YS7BqgqVeiy7gJ1DkyxlDLcn
         ILjyiQHO1Vp5oAzsCAzVM/hcv77hqRscd1HP/RE2ECJ8zh6GEhR5bj+UaWdz9Fvhv55/
         EB7k0d9fktLUuvIUq/QzTXeXfgT8XmdT+u8jLRSymR8W514WhEyQARd7ffO+GKkmWFuN
         H/0N/P81Ts+mYK35mY52Mjy9Fju/gKBEQcm0Sxz8YBwoEJIMvrk21AwmTq6te+4AAAvS
         nCyg==
X-Gm-Message-State: AO0yUKWRRmGHyG5Doy78xzMpBkH1ex7XtHpsuQXk/WIWUlbNXcoK13RU
        9rJf3UEvmv2Jb9xU7uVGbw==
X-Google-Smtp-Source: AK7set/bFSw2rvWP4R0Btu2M1iXG9y4DWm0zfqTdDTos/vXQhZ5DffbYhkOL3uRCuN/SNOnX0MxuPg==
X-Received: by 2002:aa7:c9d5:0:b0:4fb:e9b8:ca56 with SMTP id i21-20020aa7c9d5000000b004fbe9b8ca56mr3056447edt.41.1679071987722;
        Fri, 17 Mar 2023 09:53:07 -0700 (PDT)
Received: from p183 ([46.53.253.24])
        by smtp.gmail.com with ESMTPSA id r29-20020a50d69d000000b004c2158e87e6sm1278785edi.97.2023.03.17.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:53:07 -0700 (PDT)
Date:   Fri, 17 Mar 2023 19:53:05 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] ELF: document some de-facto PT_* ABI quirks
Message-ID: <cc449f31-071c-48b8-a6a8-7b91f205c3c6@p183>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
 <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
 <ZBQjRLiXOwfmoIs+@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBQjRLiXOwfmoIs+@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 03:22:28PM +0700, Bagas Sanjaya wrote:
> On Tue, Mar 14, 2023 at 07:34:11PM -0700, Randy Dunlap wrote:
> > Hi,
> > 
> > [adding linux-doc for other interested parties]
> 
> Unfortunately akpm had already applied this doc as 60b38b7cbb295d ("ELF:
> document some de-facto PT_* ABI quirks") while it being reviewed and
> doesn't have any consensus yet.
> 
> > And could the document have a title, like:
> > 
> > =========================
> > ELF header usage in Linux
> > =========================
> 
> The current doc path is Documentation/ELF/ELF.rst, which means that
> readers expect to find general info about the executable format, not
> some sort of trivia/niche like this.

General info is in ELF spec. This document is intended to be Linux
specific stuff you won't find anywhere but source.

I'll write down overmapping rules as well.

> > (I just made that up. Feel free to change it. :)
> > 
> > Also, the .rst file should be added to some chapter in the current
> > documentation tree, such as under "Other documentation", so add this file name
> > to Documentation/staging/index.rst. In fact this file could live in
> > Documentation/staging instead of in Documentation/ELF/ (IMO of course).
> 
> If there are more ELF docs there then a separate directory may be
> warranted.

This is codification of what Linux has been doing for years:
e.g pre 2.4.11 executables with multiple PT_INTERP segments were
rejected.
