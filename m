Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF26656646
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 01:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiL0AaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 19:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiL0A3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 19:29:51 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87C6368
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 16:29:44 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-142b72a728fso14017268fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZCjKnF3mrmFabJqyKS5HhejnoYCph4rooGlB9wNlak=;
        b=oxIG+0kCjxP8imY2AwiM772NAgqwLKk7qvT2ohI5UTXmzgHEOGVwoHm52ngDpJ3pYa
         YEC2vZ3X4X73G5XjPF/10hmq1pnQXNLfam33f76GH9hYFL/sAKqk0/Rllgu8L92WUlpI
         UfQeGMksx+rT4BkKQwOyCXTgCYInvXPoMXEofmenSgBXutdVhu2o7Rbsi0cPjc/gG3qB
         wmB4DQML4d6J5Jax+CGmE9ySXlUJe22B2RHohdx8gITzJLxNhtn4tE8Efp3B4mrBxsy6
         M6TmTMVB/m9p3qhAgfdtuNItm7S2veyf0IoSTR2PovCVe9TqXxXQSlmRYjFHRbBhfx+4
         CkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZCjKnF3mrmFabJqyKS5HhejnoYCph4rooGlB9wNlak=;
        b=7u0lB8d1D8I2Td2UuoF17e5fUps4yXe0Me/zsvDyNvaxzq/oUYtU7E/JtsTMKvbenM
         KACidbDXAp28cAXuFK0W/wzQIm2rqdld4SxsukHFY8hYAySdbK+7HJvLACioJpLViisV
         w5dyIO2gI2Z63k51GVLVeB50q9CxeunSPn1Y5VSD3ojJKLZaaG1isEztfACYuIW+06PD
         yC+K6A5cNXvJskFjACnpNTA5BLxrWl6Yy5Ypey024Jo0DsKhejR0LtV9lhvOEDTcHZF3
         2975kvCfz86XC2gLYaCdc7Ak/sKdbSoxrIu8d8+Pq8ChA85iJ2L/JLEGtdIyhDsuutrL
         6JiQ==
X-Gm-Message-State: AFqh2kqAcePL3FWcp2QxnWMv+2/3eCvsgxgVmS2YuBVBmbyh7LbVikWc
        cDJH7r2/GtVC9Wj39+QJhew=
X-Google-Smtp-Source: AMrXdXt5IX+GVgNLaE1bFJmprOXoGvddihAlvb2ARng0s7epDkH/lZ45NE/QZGU4lX9cGbq0MJXidg==
X-Received: by 2002:a05:6870:4254:b0:144:1ba:3d5a with SMTP id v20-20020a056870425400b0014401ba3d5amr8420332oac.41.1672100983975;
        Mon, 26 Dec 2022 16:29:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k16-20020a056870d39000b00132741e966asm5518008oag.51.2022.12.26.16.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 16:29:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Dec 2022 16:29:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <kees@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20221227002941.GA2691687@roeck-us.net>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221226195206.GA2626419@roeck-us.net>
 <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
 <DA632860-284E-4923-8863-9D2745DD289E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA632860-284E-4923-8863-9D2745DD289E@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 01:03:59PM -0800, Kees Cook wrote:
> On December 26, 2022 12:56:29 PM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >On Mon, Dec 26, 2022 at 11:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
> >> include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
> >> fs/f2fs/inline.c:430:9: note: in expansion of macro 'memset'
> >>   430 |         memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap - src.nr_bitmap);
> >>       |         ^~~~~~
> >
> >Well, that's unfortunate.
> 
> I'll look into this.
> 

I did some more testing. The problem is seen with gcc 11.3.0, but not with
gcc 12.2.0 nor with gcc 10.3.0. gcc bug ? Should I switch to gcc 12.2.0 for
powerpc when build testing the latest kernel ?

Guenter
