Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771A869A574
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBQGCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBQGCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:02:49 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E5B1716
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 22:02:48 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id w22so3065106vsf.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 22:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676613767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u9GPgrTY0DLm/wxmt4RtPvwXg0S8Lq4pJDG4ArN9ekw=;
        b=SUTUWLVUCb14Gnhf72u6TH2gTP0AU/8Pe5npLron7Ql/FFYbb0/7qPJget3c1DyWpC
         Kxv9z4d6lckAUSxYD44Osf9lu+DtCLL6hZNk5AK91bEfYi2S7LOuhG552s7n2qRe5WN9
         i2fJGjtd2tFdyfDjZ0VXPslxzETsd9dd4jm9nqAg4JZ0hsKHjm7fGGZZiOgSoZwDNJsy
         larwjyVOnELvunpTSNJppvonw5cnx8XjXA9SBnhHKIep3OZnC4+JRwkieQix+FrM/5sA
         JQcg27pnXja7f2u4+iUSEUZtihZNxcxEglMeNQ0kBq+ONpS9uZCu9IIwTe9rgfF0zN05
         MVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676613767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9GPgrTY0DLm/wxmt4RtPvwXg0S8Lq4pJDG4ArN9ekw=;
        b=kNCjgZv0l/D4g1TGzxT3E5D2TrTIP5eLmLUeh7l3Yh69nGs4GAc4Suy891LTitOrg9
         2CwT1Ou5SE9U0yNYp3A8MKZnf5hLL7hjg867v6v5PSwDQqeZ5DahoOqwqjBLQIbM4zo7
         Oy9XFdj+0BdqqBdc7JW+E+B1caypkmieKQxSuqptQHBrZS8SfGYOr/8uEOaErTbGdbvG
         saeJni6ld+lcG3D4JB+wgv5APkH1dW85LM8TxtHZUUQEpr18oJ1vy4WpXt0ryZVg1ztf
         8MmLV0TA2i3EIJ96KvQJJt/+rz8rqg0ZBXQTFF15H9VYaIfDxd1sMFzqaVujL68SU/aO
         2/aw==
X-Gm-Message-State: AO0yUKUXYmkNui38RSYTrqNejWPuL7/ErEYQkIB4n6jzCWBDcM3/G0lr
        qZ59mfLKNBFxwtqlb5yUeJcoMT9EAPKL5UUCGeE=
X-Google-Smtp-Source: AK7set9+f4rgLmuybGHahgh7UR0fG4HSmWUil2h/MeYTZ0vI2DFuOWLVb3Fgp+976mqo5yAyGIVUarAYxL3Mt55r0Jw=
X-Received: by 2002:a67:f44e:0:b0:3e9:272:76c with SMTP id r14-20020a67f44e000000b003e90272076cmr1364367vsn.64.1676613767236;
 Thu, 16 Feb 2023 22:02:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676566871.git.jbaron@akamai.com>
In-Reply-To: <cover.1676566871.git.jbaron@akamai.com>
From:   jim.cromie@gmail.com
Date:   Thu, 16 Feb 2023 23:02:21 -0700
Message-ID: <CAJfuBxwOwJzbeX8OMsS7axWEJSHumjJ=LVAS9WYGdPvyQCSOzQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] dyndbg: let's use the module notifier callback
To:     Jason Baron <jbaron@akamai.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
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

On Thu, Feb 16, 2023 at 10:16 AM Jason Baron <jbaron@akamai.com> wrote:
>
> Hi,
>
> Jim Cromie hit a BUG() while toggling jump label branches in a module
> before they were properly initialized. This isn't currently an issue,
> but will be as part of his pending classmap series. Seems like we
> should covert to using module callback notifier for dynamic debug
> anyways. First patch is just a cleanup.
>
> Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@gmail.com/
>
> Thanks,
>
> -Jason
>
> Jason Baron (2):
>   dyndbg: remove unused 'base' arg from __ddebug_add_module()
>   dyndbg: use the module notifier callbacks

Ive rebased my set upon yours, and dropped my RFC-workaround patch.
No panics on uninitialized jump-labels,
and test script works correctly.

Tested-by: Jim Cromie <jim.cromie@gmail.com>

I will include your commits in my next send, so theyre testable as a set.

thanks
Jim




>
>  include/linux/dynamic_debug.h | 13 ----------
>  include/linux/module.h        |  3 +++
>  kernel/module/internal.h      |  1 -
>  kernel/module/main.c          | 30 ++++++---------------
>  lib/dynamic_debug.c           | 49 ++++++++++++++++++++++++++++-------
>  5 files changed, 51 insertions(+), 45 deletions(-)
>
> --
> 2.17.1
>
