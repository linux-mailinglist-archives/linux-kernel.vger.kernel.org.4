Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534106A473C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjB0Qn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjB0QnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:43:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA54E3A8;
        Mon, 27 Feb 2023 08:43:23 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cy6so28381194edb.5;
        Mon, 27 Feb 2023 08:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hOx+Lx5LmOM09OgXmzxi2LsSdJoGdR3sG6KvTTKaATI=;
        b=a61a7/DIAAPoyHbNLVSSkFweYQQ4MX8oFnrHkdCNCK7SeU6uXbWiPIOV9bgUYjenA/
         kMVBmoaYu1LsJ5/23nPcQcIhTkf01ItUnU5JaCJKnTOS3Z9xr7PUJhG8fbIfKHZhqrHV
         s5qpSFd313YTbTjKE+ND3h+mOFTN8BZLCrr1Tn9xcJH6KtGuKWWycpmvVkOUxfkVBaKl
         LIPhKrAVu23deiKatwAAyO85ezC5JsYihXUKwVdBfADJuyLUAijTk6+WxgSxEbyUa8xi
         UJOZlnyFR3lUl03PwmlPlqFA/+m1R8ou5Nf2WY7NB9cYeFoT5rD1GG+nHXmI1erHYMCL
         cFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOx+Lx5LmOM09OgXmzxi2LsSdJoGdR3sG6KvTTKaATI=;
        b=Jm5LeXJ5VHmMmeaJlUX5iBkH6VRFiuz/auSZQc4vA16VULg0J9yHvqc0BxhnfvvjAb
         XtL0uPRrZx+oneLANMFviE692BzW+z0XkTjQ7zEj8WBn2wpQ4VU6qtB/fuhdmXz2E3f4
         OAr2pYb0d9o4EyS9FE9lli7ONnzQeyKIGooqAdnS7+T/QLoItQw4TKpJj3Tmp6bLyAwd
         K6VmEMl3Ze7F3Y4CNaIRWIHKhvyjaW3felCsMt5yVzF80xf8YTwuQyyNBILv+NFpn/2B
         8u4IXjeLfaz/5ksW5WdHSPU5frIJIt58FXjuJb6siJnsZzSqtQ/VcMu1GjuxF0Ys2QYr
         xDaw==
X-Gm-Message-State: AO0yUKWBAzMW6bT43t4cQxGh2YaM+yJYkana28Ebk25bZiz3h7jts76o
        FJTBsjPOayLBBLPW6DUrGacrqeIXDYNc6l7tDaU=
X-Google-Smtp-Source: AK7set/MGVEvrtdD63U/g8sFifLNquXgtczaePn8Jsk7sX8vclGD49tHR3zYDQOWmugjaLuMvvH6hC5cijEoGC+SrYA=
X-Received: by 2002:a17:906:3a58:b0:8b1:78b8:4207 with SMTP id
 a24-20020a1709063a5800b008b178b84207mr1239508ejf.3.1677516202115; Mon, 27 Feb
 2023 08:43:22 -0800 (PST)
MIME-Version: 1.0
References: <7799513f0fb5aee27b64752c037980471be669c5.1677120686.git.self@dylanle.dev>
 <Y/bqtlbnWkKMIJI4@debian.me>
In-Reply-To: <Y/bqtlbnWkKMIJI4@debian.me>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Mon, 27 Feb 2023 09:43:11 -0700
Message-ID: <CAOCk7NrAKZ2G-VbQW3MJUZmkKkO1Ccrs2wo12kg6QHysH-d=Yg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpu: add acceleration node section
To:     Bagas Sanjaya <bagasdotme@gmail.com>, ogabbay@kernel.org
Cc:     Dylan Le <self@dylanle.dev>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org
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

I'm thinking the drm_file.h reference is broken.  I suspect it should
reference Documentation/accel/index.rst

Oded?

On Wed, Feb 22, 2023 at 9:25 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Thu, Feb 23, 2023 at 02:52:52AM +0000, Dylan Le wrote:
> >
> > This patch was initially written for the Linux Kernel Bug Fixing Mentorship
> > program. The patch adds a temporarily stubbed section on Acceleration Nodes
> > to resolve a documentation warning.
> >
> > This resolves the warning:
> > ./Documentation/gpu/drm-internals:179: ./include/drm/drm_file.h:411: WARNING: undefined label: drm_accel_node
>
> Please write the patch description in imperative mood ("Do foo" instead
> of "This patch does foo").
>
> >
> > I would appreciate any feedback on what should be documented here.
>
> I think above is better placed between the three dashes and diffstat ...
>
>
> > ---
>
> like here.
>
> >  Documentation/gpu/drm-uapi.rst | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
>
> > +.. _drm_accel_node:
> > +
> > +Acceleration nodes
> > +==================
> > +
> > +.. note::
> > +   There is not any documentation yet need to figure out what this is.
>
> I'd like to write this stub as generic .. admonition:: block [1] instead,
> with the content which is "This section is empty, add appropriate
> documentation here." or similar.
>
> [1]: https://docutils.sourceforge.io/docs/ref/rst/directives.html#generic-admonition
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
