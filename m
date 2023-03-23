Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7145C6C6224
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCWImw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 04:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCWImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:42:33 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77EA18B05
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:41:34 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id n2so25778057qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSRon8uumSXX+lBmL3TUcSnxJVfZ7VdRDnDW9u3FBoo=;
        b=jyoNGy8c5podkEa6zpShMV5bv2or/57tPYdoqpeI3hB8CNCHsPGnh96N7VFYoTGYQ7
         GEpaA7Ra7RToeOWbOu/F8Lg+jikoAu2vcTTY7jUvNRuYE/baXbH7Be027Ez1J9Fwh8Dx
         TkST1AjH7jo4ucAHyqZxf2HiSHJ2TSbPWlbs/UMl6+PPCHNakECq1fJRhgDQDy2FFlTc
         gMUx3oLB/Lb+UIJY+TmP8GOQYhkMhQv00Z+Xd2Ydlo0zcWhrHP6yQzqi6/xj9FLoGfi2
         WZexOfqzAMYrLYcasPpXQfTwUhCqzQluIXDWQ8l6LV0zy8Vo1eK6HBXAtmLVDF3jWcMa
         j1zg==
X-Gm-Message-State: AO0yUKWlnvcyURJ4sOsWxf1prlPQ6RbGszsNOq9NfoKKoMEwrg3HOCSz
        HbUpUkXYu6vqikYOnmpNtJqiR0COpeqc/w==
X-Google-Smtp-Source: AK7set/Ty2RMqzfs6AjxAGGp7JGZca5rLkC9bCSVYQjpPE200A6oTikHGzT3uQDLo18AjH0MEsBiVQ==
X-Received: by 2002:a05:622a:58a:b0:3bf:cea5:7004 with SMTP id c10-20020a05622a058a00b003bfcea57004mr9487588qtb.51.1679560893783;
        Thu, 23 Mar 2023 01:41:33 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id s14-20020a37450e000000b007417e60f621sm12902038qka.126.2023.03.23.01.41.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:41:33 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id l16so14329942ybe.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:41:33 -0700 (PDT)
X-Received: by 2002:a25:800d:0:b0:b3b:6576:b22b with SMTP id
 m13-20020a25800d000000b00b3b6576b22bmr1711103ybk.12.1679560893219; Thu, 23
 Mar 2023 01:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org>
 <mvmttybx3ng.fsf@linux-m68k.org>
In-Reply-To: <mvmttybx3ng.fsf@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Mar 2023 09:41:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQ3+OUKZ-6DqcJfMgq8_90Cejzc=onhUmbaYTWJkZHRw@mail.gmail.com>
Message-ID: <CAMuHMdUQ3+OUKZ-6DqcJfMgq8_90Cejzc=onhUmbaYTWJkZHRw@mail.gmail.com>
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, Mar 23, 2023 at 9:39 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Mär 23 2023, Finn Thain wrote:
>
> > Checkpatch says "externs should be avoided in .c files" and if this one
> > appeared twice I would agree. But as it only appears once, I can't see
> > any advantage to putting it in a new .h file instead of the .c file...
>
> Anything wrong with declaring it in <linux/nubus.h>?

It's not meant for NuBus device drivers (at least in its current form).
So a drivers/nubus/nubus.h would be the most logical place.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
