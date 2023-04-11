Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513AA6DD84A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDKKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjDKKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:49:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D4340E2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:49:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p8so7490141plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681210180; x=1683802180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBq+Uus/FZgXLcP8xGrtvuI6hfCEGIicJ5yksbFAHOs=;
        b=VP8SPdz6m7bZCqjSwbu2CWMhRIG43BNbcqdzzY7lI+mm1XgQkzJoznsPKHwRhbsMGR
         KYzhqjfPAwtY8v6VwvJh72H3PD+8p6AzBCbYDZflR9rIzXLnpIOjS0e5auJMYOSvfpne
         Jg0SO4gptkizxsgzz1qgvjQ5IxSvBh1QFBLpZ+ztV8uZiQlV8weiOAgIHibrfLgz0Yfe
         yy0dUANC2umHn13hoAARAuhapAXPhTexD/2+22p9hmxDqPnNQx2UkYfILLDOxPVlYiV1
         dpcgX82R8z+0y/xrGeeziqknvIHW6oSVk7QV6hBa+g89OeE5e91f2I/FbPGJG2beo4AI
         o+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681210180; x=1683802180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBq+Uus/FZgXLcP8xGrtvuI6hfCEGIicJ5yksbFAHOs=;
        b=mTVPttNpH+OTYWuaPy0cfMYvJ11UjY827Bmr67gh/bB7zWO5tRRNEivxKqT3NUQJc/
         Zvx0TYeu3zQ3mutTXGQko+rd74Vd1G+gAFpgscdIDBeFSFMQvcZXaqs8AAE/4QzRxWvm
         LpdcvMun4008JUU0llstq0GUVC9eKFcN5G2px3O0KulfoYHezQaHZo+l1IRwopjWjdGe
         FY/S5qmxG9VC+BfyovAC2cppOA+isEmwpi77obev/AiLkX3xpWpjEjbePfQZKdXYQ9G5
         iIjryE8AWx8nKItX+x35TX4BbqePGw6glRi0QIFQzy2AuAEWwKlkY4ikjOHN3Rab0keI
         oQHg==
X-Gm-Message-State: AAQBX9egrcqQ61B/uLZfj2ohxDe9R96UvLR4wEPv41E70TqElveeBnkO
        IxF3kdE/hckPgXdafCpT1DUBNRyLC0u15l6Gs/U=
X-Google-Smtp-Source: AKy350bBaHnbfX5Z4+nwRR0UpaT9fDAZeLkAIJE04Q3LMr4Qeoz1k+1ZhYYkSfXpJw7gduNPvA9r6OY5zluuA05qVUQ=
X-Received: by 2002:a17:90a:d3c8:b0:240:d397:e66f with SMTP id
 d8-20020a17090ad3c800b00240d397e66fmr3918615pjw.6.1681210180619; Tue, 11 Apr
 2023 03:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <50439958420f91cc97ad929437334bfb19ca4d90.1681208396.git.geert+renesas@glider.be>
 <fd7c23298f2c62db85abc9114d12059ef5e5f330.1681208396.git.geert+renesas@glider.be>
In-Reply-To: <fd7c23298f2c62db85abc9114d12059ef5e5f330.1681208396.git.geert+renesas@glider.be>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Tue, 11 Apr 2023 07:49:29 -0300
Message-ID: <CAB9dFds_C9hfwW+YBMbF8sakUwVXm4etVPSAXgXQpKMeTA9+yA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: Spelling s/randevouz/rendez-vouz/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan@rox.of.borg, Xinhui <Xinhui.Pan@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 7:44=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Fix a misspelling of "rendez-vouz".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/drm/task_barrier.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
> index 217c1cf21c1ab7d5..59ead429acb2afb0 100644
> --- a/include/drm/task_barrier.h
> +++ b/include/drm/task_barrier.h
> @@ -24,7 +24,7 @@
>  #include <linux/atomic.h>
>
>  /*
> - * Reusable 2 PHASE task barrier (randevouz point) implementation for N =
tasks.
> + * Reusable 2 PHASE task barrier (rendez-vouz point) implementation for =
N tasks.
>   * Based on the Little book of semaphores - https://greenteapress.com/wp=
/semaphores/
>   */
>
> --
> 2.34.1

Sorry for the drive by comment, but shouldn't this be "rendez-vous"
(with an 's' rather than a 'z')?

Marc
