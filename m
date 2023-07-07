Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795E374B5D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGGR2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGGR2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:28:38 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07891BD2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:28:37 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-440b9d60606so895889137.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688750917; x=1691342917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFu4flp75v9onUsNmfCEUOpEoM1tS1lAreinLjPuGSc=;
        b=sgX0/IfuWQLnwlciUncvEw+t8Wj3pdMJUvHXNvaFKuZcWT5sgNOAnp9BZ+zhCDRfu7
         OBoRDoAx61DBjg/tYlTZpOIEEA3Uimf6uN3lrNQKYDBCSDyM3cWIAjyuSFO40q+iQIhY
         3zPFyk6vD7TBSck5UBViVZle4sIf02kBmFzISlHb6QVBNud4LaHUavRuV/D+NHZKH4rI
         OZk2qKe7mNeY4QDLhhqEJQUi9OESuOskgwd2/RnEtaUOsGaGbuongJBlmT/uXWw2Dekl
         dImwuO+dEHQP2c8/H7bOdoOs80kAB9Qya8pUwyh+MuHBr0Fn6OpQsmlvxEM0BBCPjaUA
         XLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688750917; x=1691342917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFu4flp75v9onUsNmfCEUOpEoM1tS1lAreinLjPuGSc=;
        b=R4wNB1W8byPcYMrA3uGne+0o9EXG4t+la45rQzZVfTyNAgTnVfBgelFN0vSCTz3ncG
         UV37BxclPPBQj/0ydX456K9vYgOerjhBqRJAD5Ey2RA0KEYPw+YP9DkEtjgToOJ1eCSn
         9nLfqloCBELoXWd+9NkkpHWxbJv3x0O8vAfaFVaEJk4F1RsSV4auQl8QDLF5I2nTDQCN
         0BQwo55zcAo+TOyPV8ZIdRE00Q7jp+5znur+/JeL1FlKM2Z4eVIUAckdh/0LdjrmCHNu
         5Z9w+SDp04iL0nm+yExICmPhrFyVtU+COtSheBDAj86r13qlf3UBbhxRl6zcYZyAyF/F
         VrMw==
X-Gm-Message-State: ABy/qLYjnJLuKwzUkjoC6PH6CuqBswB7SVAkt0U45yGjD8rQa/uyogwA
        a1xDz8x9BEzJG2ReMXLttVAzujIV5KlA3JWSMy8=
X-Google-Smtp-Source: APBJJlGTEYV9dPqQC3jdHNFHGSC0vERwM9T6QcSXH9U3UDUw54xeJ5CtOQL1uwFB/JoLYuDX0Jj5TUzBseP5SYDGX44=
X-Received: by 2002:a67:e918:0:b0:443:6c53:e26b with SMTP id
 c24-20020a67e918000000b004436c53e26bmr3585085vso.10.1688750916646; Fri, 07
 Jul 2023 10:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
 <20230706120103.GJ2833176@hirez.programming.kicks-ass.net>
 <CAG-UpRTQ-ovVO02HRd5z-9oZGCPvZ0vODJse8oyuA9L-3NV_pQ@mail.gmail.com>
 <CAG-UpRRLFTHg64b0hG4=FbuzhhqNQEU8jGt6TygCVAK1BaT2kQ@mail.gmail.com>
 <20230707125942.GB2883469@hirez.programming.kicks-ass.net> <f4e839ac5ecb285b8a9d666f1a73e0a39b698864.camel@gmx.de>
In-Reply-To: <f4e839ac5ecb285b8a9d666f1a73e0a39b698864.camel@gmx.de>
From:   Henry Wu <triangletrap12@gmail.com>
Date:   Sat, 8 Jul 2023 01:28:25 +0800
Message-ID: <CAG-UpRTur0PHkWNZ0FqLnz5K85P-HQkuO-PCCxOwJ5XVgwgxyQ@mail.gmail.com>
Subject: Re: Fwd: Possible race in rt_mutex_adjust_prio_chain
To:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter and Mike.

Mike Galbraith <efault@gmx.de> =E4=BA=8E2023=E5=B9=B47=E6=9C=887=E6=97=A5=
=E5=91=A8=E4=BA=94 23:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2023-07-07 at 14:59 +0200, Peter Zijlstra wrote:
> >
> > The below implements this duplication and seems to not insta-crash.
>
> RT bits of ww_mutex.h needed tree_entry -> tree.entry.  Modulo that, RT
> seems content.
>
>         -Mike

I patched my kernel with Peter's patch and tested it with my test
program. I haven't seen any race so far and I will test more tomorrow.
Fedora's default kernel config doesn't enable CONFIG_PREEMPT_RT so I
didn't come across with compile error. I will test final patch if
available.
