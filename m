Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02D746D45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjGDJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjGDJZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:25:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5980D1B7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:25:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso87065701fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688462726; x=1691054726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3WG4cGF8CRsbmj1ToTEuLfuzUDIEOrIrelQmjq4q3k=;
        b=o9zy4rdoGn3NN1323n5JeCPR2P82Vf7Xrb/k/pDWdQHvrcIZ5KNk8E5Rc9AOWvUohR
         8JC5CIa5pDomtb1dfZMDcahgFK74EO8eDQO9LSJYgjPzn4Ic41LS4QQHFX6p621xcc3u
         XO4jHaVK/oWekFPVOXt8KXkFrL5uwNVhzPe0OW6mFqCpgsPLCDGha7mZqCOpezE+7azY
         JK43WUYppygu4AR6pSjwNQ4n71biZrLvyDxyiBacmVPLZW4xC0G71z1vFrh8dIliQYVo
         8F/dIQJ/5ufMEC1w88uKtvPWoHp5fDYBZKYi1NiHQpep1YJRz5d/czwVmMlpXQets9oL
         KN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688462726; x=1691054726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3WG4cGF8CRsbmj1ToTEuLfuzUDIEOrIrelQmjq4q3k=;
        b=l8e1IHof7+patguf5IgURxMJZmrJC8yJSTwp+bD00B0DqTaOqSM6PVC4obwLGZHZUX
         viSpfRXZPldAurhvkXikY4ADrUetDDUZlileGviGyvqJDdFZa5sXY5YrU0Ms16Hs1NIh
         YNU1XXbstf2mDyEPiMeDQZjh3sZkR05Uktv0v8QYiS2ApGBvTTB/l0+OTm21PIvr0HVc
         U4HKG4Q++47/qjIyy5jTPErgcMt2AVIvYt0a+K9E9qP9Du+FOAnvkTg1jnZF881fn9rR
         eq/BLYULJgyDL/zuYVfDxiYygNLzPHvmRHhQ5ksofs+dwUtx6OM1GRRE3hjFDQvSAeDY
         XMqQ==
X-Gm-Message-State: ABy/qLb1A1Zgydx8Lvw2xXVk9xfTMW/9vhWsqslt2NxX9alyOHO6g+NR
        J/BLEs0s+jyp3KA6pgKlCel8UcuzSwHmWgqrB70=
X-Google-Smtp-Source: APBJJlHbSJ2Cml2qn4cb/1edSGf064IsnqMZE4INWgBRJ+bUKVKGU+1ukWl3wQA36b7Pv4rNzHUvKd3ZOMoslroDlxM=
X-Received: by 2002:a2e:3218:0:b0:2b6:f1d5:619 with SMTP id
 y24-20020a2e3218000000b002b6f1d50619mr1554642ljy.14.1688462726472; Tue, 04
 Jul 2023 02:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230703150859.6176-1-ubizjak@gmail.com> <87o7ks16gh.fsf@intel.com>
 <CAFULd4YDHqUud94Q1mbKyKqGHh==Gv7+FpNhgm5s1p=0ZwcAXg@mail.gmail.com> <87lefw139r.fsf@intel.com>
In-Reply-To: <87lefw139r.fsf@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 4 Jul 2023 11:25:15 +0200
Message-ID: <CAFULd4azR=ft9kEYN19WjxORcJNT_-v7q3sVs904Bf_td-VgEg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/pmu: Use local64_try_cmpxchg in i915_pmu_event_read
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
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

On Tue, Jul 4, 2023 at 10:37=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Tue, 04 Jul 2023, Uros Bizjak <ubizjak@gmail.com> wrote:
> > On Tue, Jul 4, 2023 at 9:28=E2=80=AFAM Jani Nikula <jani.nikula@linux.i=
ntel.com> wrote:
> >> You could save everyone a lot of time by actually documenting what the=
se
> >> functions do. Assume you don't know what local64_try_cmpxchg() does, a=
nd
> >> see how many calls you have to go through to figure it out.
> >
> > These functions are documented in Documentation/atomic_t.txt (under
> > "RMW ops:" section), and the difference is explained in a separate
> > section "CMPXCHG vs TRY_CMPXCGS" in the same file.
>
> Thanks, but *sigh*.
>
> No kernel-doc above the functions, not even a regular comment
> referencing atomic_t.txt.
>
> $ git grep local.*_try -- Documentation
> [nothing]

Unfortunately, this was always the state w.r.t. local.* atomic
functions. There is an effort to improve the documentation of atomics,
perhaps it will be also extended to local variants.

Uros.
