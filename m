Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6048863F52D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiLAQYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAQYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:24:00 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5E9075D;
        Thu,  1 Dec 2022 08:23:59 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1433ef3b61fso2680814fac.10;
        Thu, 01 Dec 2022 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KltAmapYpz63pHSS934XDuUCup563TiM194vCjhuy8E=;
        b=dhMBGMgjjGXudG2yJwPHJvjiMm0oe89iSDLss674ttuPG014RRPaD/1saawpqsgOb5
         B64o1My4Desw43I5WLnXYoUACE/NXEBDnUuB+nQqjwcOj/aK/qtivktSjg2f6QsmHAHp
         5X9rjSj/2zwV///VjVRgX3w2a6tI5zJIp8Mm1iVw74WIMXWjM9dmOhlvNnsmVaLvkkPj
         S/o6tseLe82RugnCpWGBDXCitczR9e677/J/AAwhzMeSNOV7ngR+PtyWSvy6bLJHoUiQ
         ZhXJQpDFO9aWK90f/H2Ia1PE4u8tl0arXqYGskA2nizwQQyXJa1Uqp3Ln2bD0m28kh/C
         r9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KltAmapYpz63pHSS934XDuUCup563TiM194vCjhuy8E=;
        b=G7e+bVAm9wP+M8GL7TmGuJkEU7NRMoBzhB7VvisQcpYPb5ftPVS+QF6cWdqttr0BqT
         OkRIFQ9dJWCqGpTVImeKPCWtX46EGXNDMMuUgVpklyZe0hW9IjR40auJfNgyp8MEJZ8m
         qS9Uxk8f5YopeGpq0Bx/8r8V9M5IC19Ea5BS0of4jL/rkSuFyH70IVbum54oTCQnAK5v
         Mhbr8XwMwwc2QFkQzh+l3BlxfY4zm/xzxGOJBW8r8xbtkr7yreaOnUzgGM/GQ5LpBXat
         j4kAeNT26X+l6YxwMyFWF+L2fb81TmwN08UF1+9eArcfr9MLWJLj6uD7S8s+PpvYc0Dw
         VhmA==
X-Gm-Message-State: ANoB5pmLMT3UqgFrNhVzIf7aK33qe4qLpbTEPlHHNR7q2pBt4mFdjxc8
        8cKiiaL7CY0xNWmhRUglWLys//VAzafYqF6H8iQ=
X-Google-Smtp-Source: AA0mqf7BBlikq4JHSEmVYt/WMn5IrbEFJXCqnlubbwten9TagjFWlXEEC/8TM5xBSFPYMY1B5j1ut1/j0/EerkW9IPk=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr28251793oab.46.1669911839290; Thu, 01
 Dec 2022 08:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20221201153820.257570-1-bellosilicio@gmail.com>
In-Reply-To: <20221201153820.257570-1-bellosilicio@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Dec 2022 11:23:47 -0500
Message-ID: <CADnq5_NN08omJKjJC3rCSYY4oLzBJpJwhbf-wgfeHUAZ+BMbnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] amdgpu/drm: Documentation updates
To:     Peter Maucher <bellosilicio@gmail.com>
Cc:     alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Applied patches 1 and 3.  Patch 2 is not exactly correct, I'll send
out an improved version of patch 2.

Thanks!

Alex

On Thu, Dec 1, 2022 at 10:38 AM Peter Maucher <bellosilicio@gmail.com> wrote:
>
> Explain difference between gttsize and gartsize
> module parameters, and amend related documentation.
> Also, amdgpu does support RDNA GPUs.
>
>
> Peter Maucher (3):
>   drm/amdgpu: improve GART and GTT documentation
>   drm/amdgpu: add GART and GTT to glossary
>   drm/amdgpu: mention RDNA support in docu
>
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst |  6 ++++++
>  Documentation/gpu/amdgpu/index.rst           |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      | 11 ++++++-----
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> --
> 2.38.1
>
