Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB9611BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJ1Uzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJ1Uzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:55:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D841C97CC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:55:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b2so15758803eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kNdeRVDq3L5op+Fxz0QQwN3+MO+sNKBJU9syvyNI8Y=;
        b=YWc+v8IENqLqoB0neFzDuwkYIkK8SmwinZVFJcCpjl1S+OEGHNHiRjGUl5kilo6lw9
         2d+SN1s99Wz11sK013Cz2bK/ojPQ5ZAcmJBM8M4qCvCGcznoNPE3GdXI/B0yMmddI3yo
         aA/tcPt1+zDXQYtTd1dWesWngAHxI25lN4zzyNZxi3aCetxwHdS9Q01K8LuPpU1w5xly
         a5+J8ycbluMz0UizVLEGeLljQslZKyJoAdeKxxPc3InN344mioCrnLLbh/tg3YTfccca
         FyO8y2GVcMyrVR2ZIvKCTZDo7T+JGvhGLtjQEgrOGwe2GULOsA5PO0wN6a3mJ6NPtGDG
         sO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kNdeRVDq3L5op+Fxz0QQwN3+MO+sNKBJU9syvyNI8Y=;
        b=2r0OJnzHcWNCXxZWRNVRyH4rQrQsqmriqkC826HTXxpaI+LIkzeE0BRODJDcnikWvq
         wdSg8SJffb2MiSxIj9sfYmO04ShXOniqcwRbTwwFziTesuRPlxCVAc4AN38y88eSqzm2
         Gaj1hVT5tLQ1INS7oHSjFS/0G9qnjK6QCabTvzqBBWpwsqXD4C3mWFy+3HLw4ub3e5iS
         KhulK4+EOnYHK7fQchDp4AqeR4e7WIV/vh7zlKILLZTM38Gr4PtnQ0qD4FD78NEG3vjc
         hKrb4vIxCqvecAzlDxP2VIMbT5hjbb8w0pQKYQmGPqM5qDWSqmp1x3OikfDo06IohYze
         jLsQ==
X-Gm-Message-State: ACrzQf1T6WOa4xExSbGbJrZD3U9CU6RLmtjlUI1mymJgzRsMGNfqq5qN
        pbJvm1BA+AC2iGIDYHI7m0SE1YDPnQ==
X-Google-Smtp-Source: AMsMyM7MP1TmCGNFuLwpDI6i66LDtXZwDXsbrpR4mkE/NT7M6jL90pzGFH9mBwvHed6fSEHJJn+ECg==
X-Received: by 2002:a17:906:99c3:b0:78d:9cc9:deda with SMTP id s3-20020a17090699c300b0078d9cc9dedamr1100949ejn.712.1666990531961;
        Fri, 28 Oct 2022 13:55:31 -0700 (PDT)
Received: from p183 ([46.53.251.139])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906304700b007ad4a555499sm2596134ejd.204.2022.10.28.13.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:55:31 -0700 (PDT)
Date:   Fri, 28 Oct 2022 23:55:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        rafael.j.wysocki@intel.com, masahiroy@kernel.org
Subject: Re: [PATCH] kbuild: drop -Wdeclaration-after-statement
Message-ID: <Y1xBwRCHoQtMyPf8@p183>
References: <Y1w031iI6Ld29IVT@p183>
 <CAHk-=wiEXm3y7BrFnymC_6icE7seicGyyML+Oxd_BP9t=ztNKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEXm3y7BrFnymC_6icE7seicGyyML+Oxd_BP9t=ztNKg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:29:08PM -0700, Linus Torvalds wrote:
> On Fri, Oct 28, 2022 at 1:00 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Putting declarations in the beginning of the block is an afterfact from
> > single pass compiler era. Compiler would parse all declarations, layout
> > stack frame and proceed to generate code.
> 
> No, putting declarations at the beginning is still kernel syntax.
> 
> Don't declare variables in multiple places. It gets really confusing.

It is not. Somehow millions of programmers manage to find their
variables just fine in C and other programming languages.

> Put all declarations at the top of the block they are contained in.

I tried it the other way after years of LK style. Universe didn't collapse.

> IOW, -Wdeclaration-after-statement does exactly the right thing, and stays.
> 
> This is not about "old compilers", this is about coding rules.
> 
>                 Linus
