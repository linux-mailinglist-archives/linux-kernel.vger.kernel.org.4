Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE06B9DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCNR4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCNR43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:56:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDE45DEFB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:56:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id n16so4681877pfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678816586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd+1sCvHMwOBO08sAoxbEvUITd9t9ya85GRQ8ebYZaE=;
        b=mno7WqzXwLv6+dT/RotHxW/EXiTcEmyMHv8K1UXYl7XlQ5J8UIgJ6YjrLfec4yJu6n
         BZjVTb379GfLGxyjus8apvutBMeXm9rOhJyANuE7/2bGcWI6hOlfwgVI0bWTCzwHa5x1
         dHvQ02DZGXg1aOlufkqGfyn8NHOQ3vPhF/UN3YF+WRwHuAQspDa+6EDo3uPyaWiswWzf
         mMq7S82xiohh7SCPZxPfs/lBhX+28b7AFnLqx6J3vPsTSHwc8NIf7GLvN23R2RIrj2Je
         M7fV9PSlmkbP1YwJrdI7/RyoVeI4JYUNqQvMWDwhr01y4SRTVRKNtsu9LnM5dwzyoFwC
         CJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gd+1sCvHMwOBO08sAoxbEvUITd9t9ya85GRQ8ebYZaE=;
        b=lCBdRnP2ewYdz3myUZ8nDhE0e2gzGKIUBhXhuWNDCqapYqR2P0soLr9g+Ekc9sv1cr
         TErJfEF1HOfUvqg0D9U1uK1d2GWSrJ5bHR3QLK83QbQ6RU/SJ6uYQUgQ5fC3yluz3Y4G
         1t0qcCX//E9UB2FmET8mMZpW5GpEcanepic+iDiIxCEvFmkoJAEdleWjCdYYxROWuFdI
         Q4O2aVCuuuvgO9ngFO3K9jQRH/rUN1sLdDVU+gPkGaWOmclcZhVL3FoO0n0q85c9yRdK
         oeDcRNC8n9bIcvT8QghWUTxPiKwGKvEwNb9TBpRSV4VgUfY04KPngQdCxEyheUo0T8dF
         IjSw==
X-Gm-Message-State: AO0yUKUuy1oS7q1XPxsE1oQ1y61vi0eJUqYsA5tSgUQ09ZG3VSd2EAco
        rfAo3xsqTYIu8L7kcxFZSlNE5/faEZC0JErLuYk=
X-Google-Smtp-Source: AK7set+5qOEOnZpGZ6M48MgZ7XIb5WwECpEEcWyAPVDVDBcK7f5d2ZsuhIZXAaXLi5ZEVybY+17PYqY4imu75SgdEe8=
X-Received: by 2002:a62:1d57:0:b0:623:c7ff:46d8 with SMTP id
 d84-20020a621d57000000b00623c7ff46d8mr2948536pfd.6.1678816586037; Tue, 14 Mar
 2023 10:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <bc919c144f8684a7fd9ba70c356ac2a75e775e29.1678491668.git.andreyknvl@google.com>
 <59f433e00f7fa985e8bf9f7caf78574db16b67ab.1678491668.git.andreyknvl@google.com>
 <CANpmjNMpjREcMc2iUS2ycUih9SRbP93mUaNPXcDZAd-ZDT2d+g@mail.gmail.com>
In-Reply-To: <CANpmjNMpjREcMc2iUS2ycUih9SRbP93mUaNPXcDZAd-ZDT2d+g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 14 Mar 2023 18:56:15 +0100
Message-ID: <CA+fCnZf=t50u+5z-e9kHUqe=7aAWJpkNgt=aS0n_9R_r2jBSHA@mail.gmail.com>
Subject: Re: [PATCH 5/5] kasan: suppress recursive reports for HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Weizhao Ouyang <ouyangweizhao@zeku.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 12:20=E2=80=AFPM Marco Elver <elver@google.com> wro=
te:
>
> > + * Hardware Tag-Based KASAN instead relies on:
> > + * For #1: Resetting tags via kasan_reset_tag().
> > + * For #2: Supression of tag checks via CPU, see report_suppress_start=
/end().
>
> Typo: "Suppression"

Will fix in v2.

> > +static void report_suppress_start(void)
> > +{
> > +#ifdef CONFIG_KASAN_HW_TAGS
> > +       /*
> > +        * Disable migration for the duration of printing a KASAN repor=
t, as
> > +        * hw_suppress_tag_checks_start() disables checks on the curren=
t CPU.
> > +        */
> > +       migrate_disable();
>
> This still allows this task to be preempted by another task. If the
> other task is scheduled in right after hw_suppress_tag_checks_start()
> then there won't be any tag checking in that task. If HW-tags KASAN is
> used as a mitigation technique, that may unnecessarily weaken KASAN,
> because right after report_suppress_start(), it does
> spin_lock_irqsave() which disables interrupts (and thereby preemption)
> anyway.
>
> Why not just use preempt_disable()?

Ah, yes, I intended to do that but forgot to make the change.

I'll wait for comments from arm64 maintainers on the other patches and
then send v2 with a fix.

Thank you, Marco!
