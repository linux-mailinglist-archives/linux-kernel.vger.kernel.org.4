Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB1723F30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjFFKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbjFFKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:19:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF910C3;
        Tue,  6 Jun 2023 03:19:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-650bacd6250so3281553b3a.2;
        Tue, 06 Jun 2023 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686046744; x=1688638744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bbjyBbEiwdYGerfA3UYwYsEjpwWau1SSzZ+iV7om+S0=;
        b=C2FIxH/7xOecRMUfPhLu94PEGdzFwSi1dvb/rPjPZXRtqyLoEi0z64KkElhK8Dnv1K
         j60BjtRpF+R2WNYILffL3sfpuDDFVuOp9mO9hE4CTLkL9nUF9npmmBw32pfWOOrb1m5m
         TLGngTA3P7EodABzWoEz+qisUDmCrmcLik7U7fkLuW83mrVH9opIPINGWgkzE7XdnKZL
         MLdL4DBdIavaTRNWCmttct2a9nabOjbGLv+qQNvw3HlQgJ84jwiUr+u0uuvIbc5JxrCY
         47BN8qk11eL32RH4TsQMp6jLVQqz3aaXAS18jlXg2P/DyWEo5mYej/MOJGVYGRak1T0w
         OMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686046744; x=1688638744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbjyBbEiwdYGerfA3UYwYsEjpwWau1SSzZ+iV7om+S0=;
        b=PzPP7iPKJ7Um2BTxw2ZePmogMq1lWMAggZFOHfEgbOI2JhQqU/26FY59g9Mzc72yyT
         n1aJIiEkePZt31c4sNSjGK5rFmk1myeMTl8xtHo4oBF9/I1vee+JCknmiaux9Cd13HnK
         X4lrh1KhTLf6WjTv4qP+YPmVBhJLbE296sLZo5ya93ebbxDIoJsoWdKaRWA3w0wYwC+F
         enZfrN0UgmMjXnhlIz6cx79WxfKYOlYaM1hyZ7Ynw0kAMXu8tetM6SYG56+Vr9u2ZiJu
         UKYr0rP11LD+5Dx9FYDQcmrrZcxMJBT7G9KyMBP+H/Vmzpu7EMidOzXgIyV36cf2aq0f
         z8rw==
X-Gm-Message-State: AC+VfDyY0T8B/mOKWigOB1KWtX3J2sKxILeutKYTS3O2J5sIi8tydW9F
        eYLQGVXU5cQDZmP9usx8F/E=
X-Google-Smtp-Source: ACHHUZ6JTJvW+Aww9T9wuEehWwqpz46AGgNXeU/HebD9bUMhmbjj+E+v+1bzWv1E6K04uTnXEa5Uiw==
X-Received: by 2002:a05:6a00:2d06:b0:64f:7c9d:9c01 with SMTP id fa6-20020a056a002d0600b0064f7c9d9c01mr683014pfb.30.1686046743961;
        Tue, 06 Jun 2023 03:19:03 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0064d4d11b8bfsm6574157pfo.59.2023.06.06.03.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:19:03 -0700 (PDT)
Date:   Tue, 6 Jun 2023 18:18:59 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH] gpio-sim: fix memory corruption when adding named lines
 and unnamed hogs
Message-ID: <ZH8IE5KLI73YyXEy@sol>
References: <20230606051323.17698-1-warthog618@gmail.com>
 <CAMRc=MfdusMAqfjnQTi_-DdjeLHQzywpk=zpKaQjahy6_gds0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfdusMAqfjnQTi_-DdjeLHQzywpk=zpKaQjahy6_gds0Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 12:01:53PM +0200, Bartosz Golaszewski wrote:
> On Tue, Jun 6, 2023 at 7:13 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > When constructing the sim, gpio-sim constructs an array of named lines,
> > sized based on the largest offset of any named line, and then initializes
> > that array with the names of all lines, including unnamed hogs with higher
> > offsets.  In doing so it writes NULLs beyond the extent of the array.
> >
> > Add a check that only named lines are used to initialize the array.
> >
> > Fixes: cb8c474e79be ("gpio: sim: new testing module")
> > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > ---
> >
> > After writing the comment above, and looking at the code again, it may be
> > clearer to instead check that the offset is within the bounds of the
> > array.  Or do both.  Consider that my review.
> >
> 
> Like:
> 
> if (line->offset <= max_offset)
>     line_names[line->offset] = line->name;
> 
> ? If so, then I agree it makes the purpose of the check clearer.
> 

Using line_names_size might be even clearer.

So, either that or 

if (line->name && (line->offset <= max_offset))
    line_names[line->offset] = line->name;

to also not repeat the zeroing that the kcalloc() did.

Too many options.  Let me know which you prefer.

Cheers,
Kent.



