Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50156A54E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjB1I5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB1I5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:57:04 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B7DF97D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:57:02 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v11so6135810plz.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677574622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMCK1aWtyIXb3CHIEdrWl/Mvgwf+H1xlGoUb2yNtzaY=;
        b=kIt7h3rO0mqEjGuh8mFxR+dTf0KR5QUZMX9KgFSm1RPMTgI01BcxB7+17fhY35NCKJ
         kkc/ilT3+EgMyx7yTdpJHO/mHJKNOs6Nbtdcj43CHkkd7Apxt6eqM3dR9KUaP33czNCg
         sGEi2j19Q77huUSCaJFnuup76Y6UXVp/NW/PG6CjfydhMNa0ml9Zk4g08gxaCz9XtbP1
         Qk7WP6xNYW25PJ83Ou4yKZfRksdwY8j1QBHAx/Y9Lhf1FeGzVNS/f8FVpRYbZIqzHi5N
         IukmN3Z4S1vJag1qGYKag/N/f/Id5Ldh3D7hlIDXAZPgolYfqScVhMpxh1J+e8VB2u2W
         UbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677574622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMCK1aWtyIXb3CHIEdrWl/Mvgwf+H1xlGoUb2yNtzaY=;
        b=HT523QFMww6KGWnABuKx/bKjbZjm/u9d3SYAH/u5RBnI2ClNZ2VIgE/lKbxFwnmScQ
         EXq0NFChqOewirNSSu+//lAp0dzeBcNqYot3HRllseaEHeV2obqygOtpSo3TxbNVhRqK
         eMkrfESaQUoG7oZub7pHik8j8R4Ta5+7nCDNNzVEN0Ot5YJ+7J1r6XgSOVSn+dpwdfUf
         KVIEjauf8vg9qFpMbcOBzxED8bYNGFyXB90nsACL6gYmUwZudpgoANO3k4LvS95lVuhV
         REEV6hZhrS8ykWVVsqU/xx6WxCNVBd7s8uatoeVv9BTIaaZdU93VTqnPIYIpHlEStNLz
         enPQ==
X-Gm-Message-State: AO0yUKW8vkpZ+Pyyx50DjYE8QBUEBcqxbMOOrCTIogt4HFit3iYWrHXx
        Rc7gBZGyvI+GzLX/Qx95CyM=
X-Google-Smtp-Source: AK7set9+knhQj0U7hk2Eer9QGeK2B7A4Qi8BWzGLq51cz7xhVQbyqwHIZRw8UOk5RMmx3Dr5AkZFpw==
X-Received: by 2002:a05:6a20:8e04:b0:cd:7fcf:11a6 with SMTP id y4-20020a056a208e0400b000cd7fcf11a6mr3020020pzj.48.1677574622213;
        Tue, 28 Feb 2023 00:57:02 -0800 (PST)
Received: from debian.me (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id s23-20020aa78d57000000b00593c1c5bd0esm5503155pfe.164.2023.02.28.00.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:57:01 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B6B2610105C; Tue, 28 Feb 2023 15:56:56 +0700 (WIB)
Date:   Tue, 28 Feb 2023 15:56:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     zhenggy <zhenggy@chinatelecom.cn>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix rq nr_uninterruptible count
Message-ID: <Y/3B2CwI+RdoDt7T@debian.me>
References: <9b271641-ea59-daa5-333c-1dd1f02cdb52@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9UX63Gy/Zfo3mF4u"
Content-Disposition: inline
In-Reply-To: <9b271641-ea59-daa5-333c-1dd1f02cdb52@chinatelecom.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9UX63Gy/Zfo3mF4u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 03:08:58PM +0800, zhenggy wrote:
> When an uninterrptable task is queue to a differect cpu as where
> it is dequeued, the rq nr_uninterruptible will be incorrent, so
> fix it.

tl;dr (too much typos above). Would you like to "massage" the commit
mesage?

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 25b582b..cd5ef6e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4068,6 +4068,7 @@ bool ttwu_state_match(struct task_struct *p, unsign=
ed int state, int *success)
>  {
>  	unsigned long flags;
>  	int cpu, success =3D 0;
> +	struct rq *src_rq, *dst_rq;
>=20
>  	preempt_disable();
>  	if (p =3D=3D current) {
> @@ -4205,6 +4206,16 @@ bool ttwu_state_match(struct task_struct *p, unsig=
ned int state, int *success)
>  			atomic_dec(&task_rq(p)->nr_iowait);
>  		}
>=20
> +		if (p->sched_contributes_to_load) {
> +			src_rq =3D cpu_rq(task_cpu(p));
> +			dst_rq =3D cpu_rq(cpu);
> +
> +			double_rq_lock(src_rq, dst_rq);
> +			src_rq->nr_uninterruptible--;
> +			dst_rq->nr_uninterruptible++;
> +			double_rq_unlock(src_rq, dst_rq);
> +		}
> +

Can you explain what the code above does to fix the problem you
mentioned above?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--9UX63Gy/Zfo3mF4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/3B1AAKCRD2uYlJVVFO
o2/bAP9O5pBoA/zWyZz2ioyTzukHi0qSFgJ1vWZBauiezu4fCgEAyvQyh0QmAQZ1
Iy5tYopi0L1eMdT2BAg+QhmC1ccJEwo=
=tNCM
-----END PGP SIGNATURE-----

--9UX63Gy/Zfo3mF4u--
