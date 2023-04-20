Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1766E9061
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjDTKgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjDTKfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:35:53 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4F3C24
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:33:11 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3ef480b4768so940301cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681986790; x=1684578790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGwZRkRlnsA+vGof+tjeyG6hWGi5lvtYkhKPwunLX8A=;
        b=Iq5QEWxAKEYRJ7WPHNhJ8UlX+yubs+UNSHhXEgJ8A7lQIFVREmWHZa4I/YWUbOo4ve
         y4n5aFWcZghPvezJBrb1gQTszLaMM38owWU148LCA7p8f6USPnp7rEDkG1oQqz7j70Ag
         W9aybdAmzWJSUzftjW1OD8chs9J1IZJMGbogH/3mRjjqOwO+GmWtFHADy6BlRzd0ArVz
         dU78Zf9XcGsQtmlrViWtHO20VFm5DiX8ulew8t5BoXO4LdG3itKuo0fD1ciio2W/Lx8r
         TgRxsKZw5ebPVaNGZRSCgL0ST998ZRRH6vNU2SyaVdEBDBwzIGbdGsIay+NwyZ3cHJgO
         6ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681986790; x=1684578790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGwZRkRlnsA+vGof+tjeyG6hWGi5lvtYkhKPwunLX8A=;
        b=WAX0SxYXPhcJGKfSAYSZ4QJCAX26X1Nz4geGkBs8CaUwYsG2CHd5LfQtw2Dy9ANBF2
         CpjGV5BsCHlexLHkdmPp8tbQoMK6Wi5qrdbDf1rwmY2EXZL/X88TKZ54R6SHgAyyMiie
         dQ1oem0LxPaQ57dJvY9Q5iR1ja21BKRq9cuHu9P1/3A43xNn2IkF4XNw1ES79/y3qmTQ
         RhI7dW+z6ZzBoEjU84aJoPUDgVVSu96tyQVlDiFEaPmdPv1x00516PqeugZbNLM54d7J
         26Xpzn7Gt4EJ9O7qrGuwIO6LSwDClW0yonvIgVdd47wqo/W09IyxnBpM4uNLOWEda4Lg
         jx9g==
X-Gm-Message-State: AAQBX9dpO59t5WXDtqKJZiljQZBetpcxNubxtJnjEjwoHWr6X5zd8YaP
        rtkj01JQBP3qWG0GdpPX/bQdQidivJbtxFRxAXQSWXt+eZuQDfwCFNg=
X-Google-Smtp-Source: AKy350YtBYEERlx+sQJO+modBKx/Gx0XrP1st2ET3yAiNNT10OgF3OckybBYcYbFBA5wgXUkBWVpnx1HU01jaCYIVmw=
X-Received: by 2002:a05:6214:2aad:b0:5f1:31eb:1f0e with SMTP id
 js13-20020a0562142aad00b005f131eb1f0emr1074380qvb.4.1681986790164; Thu, 20
 Apr 2023 03:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPZxgpFzAVN=eFXu0WV+Jk0vB4rv4p+Jt31C841LcqV=A@mail.gmail.com>
 <CABXGCsO0sST8+MvQs=T1JP49ogRsaHPT9gMQZGJ3dY7v3m0H8g@mail.gmail.com>
 <CABXGCsOTEpJG_0NWdGXRvcXQ4iTav6AUJm-U4SQb-vVzjoL6rA@mail.gmail.com>
 <10b2570f-a297-d236-fa7b-2e001a4dff12@gmail.com> <CABXGCsPcPY8dqZm0aF4c1p0ZvMYHy+NksMrZi9xK0=WdE5_osA@mail.gmail.com>
 <d96519fb-9e12-5a81-a60b-384dcb286f28@gmail.com> <CABXGCsP2JQMtNjBROSLs2y612iLZuCyoe-uD6OScAWbKHBWsCA@mail.gmail.com>
 <b6ab0086-7d52-2a41-2f76-44694faed317@amd.com>
In-Reply-To: <b6ab0086-7d52-2a41-2f76-44694faed317@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 20 Apr 2023 15:32:59 +0500
Message-ID: <CABXGCsP+LSPE9fH4TW781w67ju=HrNMe9s0kigqBarketr_Qog@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in drm_sched_job_cleanup+0x96/0x290 [gpu_sched]
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
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

On Thu, Apr 20, 2023 at 2:59=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Could you try drm-misc-next as well?
>
> Going to give drm-fixes another round of testing.
>
> Thanks,
> Christian.

Important don't give up.
https://youtu.be/25zhHBGIHJ8 [40 min]
https://youtu.be/utnDR26eYBY [50 min]
https://youtu.be/DJQ_tiimW6g [12 min]
https://youtu.be/Y6AH1oJKivA [6 min]
Yes the issue is everything reproducible, but time to time it not
happens at first attempt.
I also uploaded other videos which proves that the issue definitely
exists if someone will launch those games in turn.
Reproducibility is only a matter of time.

Anyway I didn't want you to spend so much time trying to reproduce it.
This monkey business fits me more than you.
It would be better if I could collect more useful info.

--=20
Best Regards,
Mike Gavrilov.
