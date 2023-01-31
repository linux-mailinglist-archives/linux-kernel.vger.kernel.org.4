Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECAB6835F3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjAaTBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjAaTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:01:43 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C458644
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:01:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k13so16128155plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ee8VrbotWmdr9Bi0GM3TMNLFcbwdi2SIi4lojz2pU58=;
        b=XvW89yFHLvEH5FtjCjRzR1OcJ9e6Q58euegSx2t/bvrMiQ5qefxzakEVcB/6eZBa9L
         aB0SonjcniQJivx3I+EUo9hrv2nvPpkD998u35GBnao5S0MJNobwq/9gCgLctoVY7pxg
         3iQFaU3hKm9nvR22Zi/bfyCtcuCISGSCboUIshOy8BEvkAmPsznDfT7TeamE0exui72G
         75PgLUdYiT0OSJne1pbDFsnekXMhCVyNJBks6dMjfyf9AWLGr1F4oMbIIbWQczDioaDl
         vw1zrXclFSM1gAquI9b4DkESWnFEoT4iItwB6Fgz/Y/wV7j3MjDSs25KdI/gXkZV4RM+
         GCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ee8VrbotWmdr9Bi0GM3TMNLFcbwdi2SIi4lojz2pU58=;
        b=YRw8rbg5jC/l7mDGQv2JavQ5L/oG5aPv+xjbgMHSLOycLIVbGjSxLGLyeGIEhneDmj
         d3ZV9UCRQmVDQsnBEEamTZ4NFkccwgXYeTXSuGYGtMplZ3TgJqFMQ2ih6zKxyilLi6o1
         rqmCDwslgkeG40V0mbJYDu3ddt7HNbbtcIulrPut6uXYsau7yQ16bDkEvIf2d2sh253V
         RjOccC3BKNkQYj4L55KXuIoEG2nDNlqtKHJ09qBSfMA3ZkHuoRG00+up7nTsNGMCNpKe
         PlhbSoXgoSKg87I/eI2/cVPHjUP5mXyMa0L32IJ69nSxwxuUOg1iirpbvmvVfSrh+rmM
         QUwA==
X-Gm-Message-State: AO0yUKXqGt6B0d8NTUb/Apn+93f+14EiSrAWAdXvmrDOZWMz1Bargov7
        M4Ikv/D0RjDANBSCwii6DS0LQPVbGHDg69O8imc=
X-Google-Smtp-Source: AK7set+yUD4D01GYukAfSV3dRkXZgkK9SbG2nkRlsQJ0msHz2SU+hB69wi+HMHIV6g6rIgPYOsJAPCBLTQlxMWGR0UU=
X-Received: by 2002:a17:90a:cc5:b0:22c:4462:fb92 with SMTP id
 5-20020a17090a0cc500b0022c4462fb92mr3208121pjt.44.1675191687937; Tue, 31 Jan
 2023 11:01:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <be09b64fb196ffe0c19ce7afc4130efba5425df9.1675111415.git.andreyknvl@google.com>
 <CAG_fn=WnxbcbjfKvRGen7fkKyx_9_S+nL9p+8xfeU8N0L93f7w@mail.gmail.com>
In-Reply-To: <CAG_fn=WnxbcbjfKvRGen7fkKyx_9_S+nL9p+8xfeU8N0L93f7w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 31 Jan 2023 20:01:17 +0100
Message-ID: <CA+fCnZdeQ1LqmzD=vCk6tG3GBydY1dwzNM94wZ_+oDcWTrY=Uw@mail.gmail.com>
Subject: Re: [PATCH 06/18] lib/stackdepot: annotate init and early init functions
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:31 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Add comments to stack_depot_early_init and stack_depot_init to explain
> > certain parts of their implementation.
> >
> > Also add a pr_info message to stack_depot_early_init similar to the one
> > in stack_depot_init.
> >
> > Also move the scale variable in stack_depot_init to the scope where it
> > is being used.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> ...
> >
> > +/* Allocates a hash table via kvmalloc. Can be used after boot. */
> Nit: kvcalloc? (Doesn't really matter much)

Ah, right, forgot to fix this. I initially wanted to point out that
early init allocates in memblock and late init in slab or vmalloc but
then decided it's an unnecessary level of details. Will fix in v2.
Thanks!
