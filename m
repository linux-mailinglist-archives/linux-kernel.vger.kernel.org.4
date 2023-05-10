Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4D56FD87B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjEJHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjEJHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:46:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41181BC0;
        Wed, 10 May 2023 00:46:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so12347909a12.1;
        Wed, 10 May 2023 00:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683704812; x=1686296812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9F5lRR3nU5ik1iM4JNGpvgMBHRkuI2L2MRe+HsWM1E=;
        b=aCASxiNmtfiQlCFgg8xxPUHhOz7p4P4u9H2Q1iTujydnsKu3Bz9hBklBJXY0awyi8I
         ltJc7Cd8bXfpfdJxdf64J70/9q09t2K4E/5ZRImL9y0ynQNDjQBCzJyH3YEQRfALOIp7
         U6HteAyd+2lpYdzKDHPgESvWKxr+knuvXNwLD/XK8Lv8ov6ioTZMjPtM6Q0KV/KGuvkG
         WQ7lgs/ygWrvyMf8pXEuceC7Y+4r9YFXXynHYL3mIh0cZEJEEyDhW89isordRH6PMW5U
         6WoYiGiF8rGTE1ZtMVW0kH1TF10MLOO462pbo3Q9M2ZkKfwVukKZtpNGBc2H0CCdYPOL
         eq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683704812; x=1686296812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9F5lRR3nU5ik1iM4JNGpvgMBHRkuI2L2MRe+HsWM1E=;
        b=bBxW5eVnKo2d/MJQhfJawXBsWpq/FQwXdUOkcMO5B+y+66hPmsYPqrdA2C06F7XxAH
         dz8IZaNDSA64/HvwZA0YequVoPkZPNlTDLmL0SG8hHhtRoU8Z0soCzToRYERNl/7wgmR
         40UKL8hnhu0o/0L//IzE3N5uQ6WopRP4z1Md/eFwwBlD/5p0JDn1Twgs49dLq6uSg8EC
         /DflA72G6y3AD6S9MzO4dFjGd54pRSkOSlYflhR2z48crWIGNrBKiQHcaNOZIo4CbMTI
         Imv02d1OczKVByeLZ2/wHt6ZHXIbmX5pVsKouDhnB/Cv6k5WkLEH60YhjIpjUIeZxt1m
         Rf4A==
X-Gm-Message-State: AC+VfDzN1J/oqfc7cIakLMnAQUjiIIecssWxCxqgJnpunmEO4qPYGFWH
        +w4Tl1xrT62zX3kEc+GhKTOBQlmYqFNhRPVny1k=
X-Google-Smtp-Source: ACHHUZ7V22GIOu7lJOvWYzYqpjjEK3G8zDUJN0y/VJbHuKqGgm1lyKTw9GfZ1eU4EpYlN0vi4unZNpSF1sNcdyAaQ5E=
X-Received: by 2002:a17:907:6ea0:b0:958:801b:9945 with SMTP id
 sh32-20020a1709076ea000b00958801b9945mr15111309ejc.31.1683704812032; Wed, 10
 May 2023 00:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
 <7cbe80f0-dcc3-bfc3-3bd8-c9f96704618d@intel.com> <CAKXUXMxO4b-8wT-88fJ=++woH-p79_4R-vUr=aELNFYinGcEuw@mail.gmail.com>
 <ea00d762-b0df-ab72-988b-98c62ffc7949@intel.com>
In-Reply-To: <ea00d762-b0df-ab72-988b-98c62ffc7949@intel.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 10 May 2023 09:46:40 +0200
Message-ID: <CAKXUXMw77cSBz6nBF4K5BT3AUU2Ac3JGTj6qXJ5mDnUFmRrWeg@mail.gmail.com>
Subject: Re: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 8:38=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 5/9/23 11:20, Lukas Bulwahn wrote:
> > On Tue, May 9, 2023 at 4:07=E2=80=AFPM Dave Hansen <dave.hansen@intel.c=
om> wrote:
> >>
> >> On 5/9/23 01:40, Lukas Bulwahn wrote:
> >>> Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPER=
T")
> >>> introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBED=
DED
> >>> and just gives that intent a much better name.
> >>
> >> That was quite the changelog, and I'm still not quite sure:
> >>
> >> What is the problem with the existing code?
> >>
> >> What is the end user visible impact of this problem and of this propos=
ed
> >> change?
> >>
> >
> > Thanks, Dave, for your feedback.
> >
> > The commit message is so lengthy, as I copied it from the original
> > cover letter into each commit, but I agree with your feedback.
>
> Uhh...  *What* cover letter?  A cover letter is usually the 0/NN message
> in a patch series.  It is not obvious at *all* that this plain
> non-numbered patch is part of a series.
>

Yeah, sending out the patch isolated that originated from a larger
patch series was a bad idea. I got that.

> > So maybe this commit message fits better:
> >
> > To simplify build configurations, the CONFIG_EMBEDDED is to be
> > removed. All configs that are only visible with CONFIG_EMBEDDED=3Dy
> > shall be now visible with CONFIG_EXPERT=3Dy.
> >
> > In the x86 architecture, the config X86_FEATURE_NAMES is visible when
> > CONFIG_EMBEDDED is enabled. Now, make the config X86_FEATURE_NAMES
> > visible when CONFIG_EXPERT is enabled.
> >
> > Dave, what do you think? If that is good enough for you, I will send
> > an updated patch with that commit message.
>
> CONFIG_EMBEDDED is being removed:
>
>         <INSERT LINK HERE>
>
> That means that everything in Kconfig that uses CONFIG_EMBEDDED needs to
> switch over to something else.
>
> Move X86_FEATURE_NAMES over to CONFIG_EXPERT instead of CONFIG_EMBEDDED.
>

Just for completeness of the mailing list archive, I will add the link:

CONFIG_EMBEDDED is being removed:

https://lore.kernel.org/all/20220908104337.11940-1-lukas.bulwahn@gmail.com/

Following Boris' suggestion, I have now created a different patch to
make the option non-visible in the prompt (see Link below). So, this
patch may not be required at all if the other patch is accepted. In
case there is a critical number of users out there that really want to
tinker with this option and we decide to make it visible with
CONFIG_EXPERT, I will propose this patch with the commit message you
provided. For now, this patch is superseded by the patch 1 of 2 below:

Link: https://lore.kernel.org/all/20230510065713.10996-1-lukas.bulwahn@gmai=
l.com/

Thanks for all the help.

Lukas

> --
>
> This actually isn't _great_ for x86.  We hid X86_FEATURE_NAMES behind
> EMBEDDED because we didn't want to see it 99% of the time.  But just
> about everyone uses EXPERT=3Dy, so the end result here is that everyone
> will now see X86_FEATURE_NAMES.
>
> Oh well.  It's just one Kconfig option.  Not a big deal.
