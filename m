Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99006A558F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjB1JWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB1JWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:22:49 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B71E5D5;
        Tue, 28 Feb 2023 01:22:43 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n2so12213735lfb.12;
        Tue, 28 Feb 2023 01:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677576162;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsQK0hNV4XmU0F6XjhscNf54T4h8GnwUQ061Wlk9Tzk=;
        b=GUWDqdPGpjrjvibZS8Qv1BxmyT4O4yPEJ0NuSN8ZUTq6nkLWr1MMcq37zCYG+Mu1Mn
         Y2FtWyKbcQu4OBnNTgY5mFNG9JQab6+uqIwbzitC6Fp4eFeOAB7uawQc5PV0B6umBPSf
         K/3Cf7zrOoqaRTpWRxg+r4Qu5XXRrrxT+OxCkfvIZ2YPL2BtDJBBJGtJHjk0NlshiDvB
         f9ggJHxIZZUZEB8QZJOgc67arafHI7poxZ4XRxJEGE79Nj5tLy9VaRmJW23mrzgW930A
         pRz9CiKsfCkEu78pwvPxNfupEb5pHoT7lmXaYBl1wpNPBJj7ncgf0ruRLsuApNgDKwLt
         TdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677576162;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsQK0hNV4XmU0F6XjhscNf54T4h8GnwUQ061Wlk9Tzk=;
        b=v9uwdw0QFIyZEVQvAi9nEd2J+5m3bMyNNYFg0d9qCwIjciuHhsp92grInLSY5xTY7M
         cAVOOYqszEVamiewtJ0e0oyVYdjRIyQ58i6a3x1ByY2GwV/UuTJ2ZKUHJAYbII3MaG+H
         V+BKtnG/6t/KhKPCmgjJxUuPXCKwc98DAc+cfcgI5r8LwPqhFT8WpypLbyA5Jsdkbd1M
         nRFmkKy416LGrYW8e3n4MY9rEQpjmuIv6znYxxGJAgzGqV8CUF9v+pnD8KZA7MqSYabJ
         HF3YXmA29vwe+lfy8+OYSJ3A6Fad+oY2xxCynCmtVNePQ67RB89k/gZwzIIwqzByOHu6
         QHmw==
X-Gm-Message-State: AO0yUKXvy46eXCzawrIXfv2h3HN3hISeW9IKjPClBxsJ9TCFJF9zqn7s
        65RwIyfii1GJbp1QfXsrzAY=
X-Google-Smtp-Source: AK7set9XRi6D4mXG0XyHlnfXEgQSLKmwmc5W+YD31WYJ95pcPak+8Jvf19/aj6JG0bKTDHKIlBQyxA==
X-Received: by 2002:ac2:5197:0:b0:4db:38a2:e989 with SMTP id u23-20020ac25197000000b004db38a2e989mr509397lfi.63.1677576162165;
        Tue, 28 Feb 2023 01:22:42 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id k11-20020a2ea26b000000b00293cc5f83b4sm1113668ljm.27.2023.02.28.01.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:22:41 -0800 (PST)
Date:   Tue, 28 Feb 2023 11:22:38 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v7 06/15] dma-buf/sync_file: Support (E)POLLPRI
Message-ID: <20230228112238.40e2ad43@eldfell>
In-Reply-To: <20230227193535.2822389-7-robdclark@gmail.com>
References: <20230227193535.2822389-1-robdclark@gmail.com>
        <20230227193535.2822389-7-robdclark@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4g4mIUnoEruvrvGrMqxjkCL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4g4mIUnoEruvrvGrMqxjkCL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2023 11:35:12 -0800
Rob Clark <robdclark@gmail.com> wrote:

> From: Rob Clark <robdclark@chromium.org>
>=20
> Allow userspace to use the EPOLLPRI/POLLPRI flag to indicate an urgent
> wait (as opposed to a "housekeeping" wait to know when to cleanup after
> some work has completed).  Usermode components of GPU driver stacks
> often poll() on fence fd's to know when it is safe to do things like
> free or reuse a buffer, but they can also poll() on a fence fd when
> waiting to read back results from the GPU.  The EPOLLPRI/POLLPRI flag
> lets the kernel differentiate these two cases.
>=20
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/dma-buf/sync_file.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> index 418021cfb87c..cbe96295373b 100644
> --- a/drivers/dma-buf/sync_file.c
> +++ b/drivers/dma-buf/sync_file.c
> @@ -192,6 +192,14 @@ static __poll_t sync_file_poll(struct file *file, po=
ll_table *wait)
>  {
>  	struct sync_file *sync_file =3D file->private_data;
> =20
> +	/*
> +	 * The POLLPRI/EPOLLPRI flag can be used to signal that
> +	 * userspace wants the fence to signal ASAP, express this
> +	 * as an immediate deadline.
> +	 */
> +	if (poll_requested_events(wait) & EPOLLPRI)
> +		dma_fence_set_deadline(sync_file->fence, ktime_get());

Hi,

I don't think this doc will appear anywhere where it could be found,
maybe not in kernel HTML doc at all?

I also think this is not a good idea, but not my call.


Thanks,
pq


> +
>  	poll_wait(file, &sync_file->wq, wait);
> =20
>  	if (list_empty(&sync_file->cb.node) &&


--Sig_/4g4mIUnoEruvrvGrMqxjkCL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP9x94ACgkQI1/ltBGq
qqcKcRAAg5Pur+aKyhVVpZKHRYWfXoeqKBZEkhvsWa15fq6LTXk22BghXfokd1N2
c381QCbhigGI0bovn9MPDu2/nJrLNpqKLGwyd+vFxDTqByHorplcZZGgb26Mg0wM
hkkXktzemleNfjt+uVeG9T8dtXqdbgBH6v4GlCLEZj3weXkNslNe+DPkJ1850L6Q
eAysExnpk48OlBvF1Cbj28sd9ejXQdRU7+gTZutDk959gHAb1JMGyEHfP0Km9iBD
0gJo+lwDVjIYUlVxoq/gBRQStWtDG2kQ8mNsTLKOKQo8oyc1ocFCzrFVyJW5+bmm
gUxJBOyIvIdphde1zH9Ba7aA2/pi6dUCxHjMBnQP6nU8qu+FXXd1HZYByJpNicvF
s22Yd0sWjEQ+LDpt6XmjaHhB7jphANx49sCdA+K3X1v7e8IBELzRFmiJJYfv17fN
mAeyEn96ldcUxDjrQzWboL2w0KsEK4MkOsZozVG189Z1iKH+uXmUNMsySRDHd+ig
+EQ3gp326zylALGQUzK0nJFOlJq2CNYnkK/HixYvLLw1fNp3M7g5WeaBUWLkcfHg
eiSjSPWatT7wNmhjLe4tT/FNlFp4Wwe3ZuTbpQE86IK80rbY77k0zoErHcjEP71a
6AtO1z8VQNeBsFviNgmwufeFiq9LExsu2n8WEKNcwrIWq/aE2m4=
=JLUn
-----END PGP SIGNATURE-----

--Sig_/4g4mIUnoEruvrvGrMqxjkCL--
