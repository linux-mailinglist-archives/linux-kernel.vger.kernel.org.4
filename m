Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133A66A5595
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjB1JXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjB1JXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:23:21 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79C210C8;
        Tue, 28 Feb 2023 01:23:15 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id i9so12258598lfc.6;
        Tue, 28 Feb 2023 01:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677576194;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=npzAjHtm5Aug8QOfbJ5dztAADOLzeyYlASny4nFL7nA=;
        b=WLPbn+kwyy5ORuAFd/3EiqfumHpfaM6rnMcaibOSwSZVt0+KqRUQZEThXo5XUlaXIj
         cZuIw6H/OqTktALRUwXmZ7/zwE4qXJFUO+I9XLvG+IQGgL7Mi3UTFhmrtCaXh6r9sPbJ
         XyPdBzkjscLuYBwX9ZwKh62WuRPYbYfpyz0yNLO5b1cpJCTTxMS4nNiSUfnwCzbyWi1E
         iHvSAWOEhoBlj+gRWPFzNM/LY6ojiBWUJ52ZJczHTKwX+J9YOm7luVtxksqaIe7qSXE1
         IFi0HwDDMPe3rN7oNsnOWMMPtfWEFbID1sGprpzkoHluJcFGj2l2LusSeV2oajAJETFx
         RjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677576194;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npzAjHtm5Aug8QOfbJ5dztAADOLzeyYlASny4nFL7nA=;
        b=nJjTvHRe5wPVlKcCrFVrprZ56HA8wy87SI3nk4x6rJKGh94mtuBcwF9A8B0Z72QPxB
         4wRFjfTEE0FesiPlPKTQJU5cG2BABtaIthWHxZi1kOM6m/lKYWsRajgZzvCVzlXFHue8
         l0xsNsEqTSgGh1oOqwsu7CFKUA+2ah37m8OP1k36QsbhbCusqqOE+R1FjP3BDfcw4jgY
         9fffJDwcey1J89Dd85diGmenMiB969ZpKzcmnxaCk9sJedSlPFpgkdoYWTWE5AncSK+2
         S5HhXefne7yAfJVnd5AUv8nJ/BQP9j/jSkaZlp6VyEg/0CfgxxztejTCOcCNGDfbO2hi
         mNaw==
X-Gm-Message-State: AO0yUKUwfoAKtMFzAnTIprKtTG6G8VPKapXJzzsF4sA1Y0GFtPExjPiv
        x5dEKpRkCc0ujpnIgAVbv6A=
X-Google-Smtp-Source: AK7set9mdzfycnAPOkQV6+lzwV3/EwkFTPfCVDBUrije806Gw9JGtAIGIjLIbxRVPQP92RCNiQ3KAQ==
X-Received: by 2002:a05:6512:2203:b0:4d8:51e7:9f23 with SMTP id h3-20020a056512220300b004d851e79f23mr741318lfu.34.1677576193727;
        Tue, 28 Feb 2023 01:23:13 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b004cb3fbc7925sm1253133lfc.77.2023.02.28.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:23:13 -0800 (PST)
Date:   Tue, 28 Feb 2023 11:23:10 +0200
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
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v7 07/15] dma-buf/sw_sync: Add fence deadline support
Message-ID: <20230228112310.39274fcf@eldfell>
In-Reply-To: <20230227193535.2822389-8-robdclark@gmail.com>
References: <20230227193535.2822389-1-robdclark@gmail.com>
        <20230227193535.2822389-8-robdclark@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8aE4tGFLiLpdo+6qg3s=3bO";
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

--Sig_/8aE4tGFLiLpdo+6qg3s=3bO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2023 11:35:13 -0800
Rob Clark <robdclark@gmail.com> wrote:

> From: Rob Clark <robdclark@chromium.org>
>=20
> This consists of simply storing the most recent deadline, and adding an
> ioctl to retrieve the deadline.  This can be used in conjunction with
> the SET_DEADLINE ioctl on a fence fd for testing.  Ie. create various
> sw_sync fences, merge them into a fence-array, set deadline on the
> fence-array and confirm that it is propagated properly to each fence.
>=20
> v2: Switch UABI to express deadline as u64
> v3: More verbose UAPI docs, show how to convert from timespec
>=20
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/dma-buf/sw_sync.c      | 58 ++++++++++++++++++++++++++++++++++
>  drivers/dma-buf/sync_debug.h   |  2 ++
>  include/uapi/linux/sync_file.h |  6 +++-
>  3 files changed, 65 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 348b3a9170fa..3e2315ee955b 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -52,12 +52,28 @@ struct sw_sync_create_fence_data {
>  	__s32	fence; /* fd of new fence */
>  };
> =20
> +/**
> + * struct sw_sync_get_deadline - get the deadline hint of a sw_sync fence
> + * @deadline_ns: absolute time of the deadline
> + * @pad:	must be zero
> + * @fence_fd:	the sw_sync fence fd (in)
> + *
> + * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank)

Hi,

the commit message explains this returns the "most recent" deadline,
but the doc here forgets to mention that. I suppose that means the
most recently set deadline and not the deadline furthest forward in
time (largest value).

Is "most recent" the appropriate behaviour when multiple deadlines have
been set? Would you not want the earliest deadline set so far instead?

What if none has been set?

> + */
> +struct sw_sync_get_deadline {
> +	__u64	deadline_ns;
> +	__u32	pad;
> +	__s32	fence_fd;
> +};
> +
>  #define SW_SYNC_IOC_MAGIC	'W'
> =20
>  #define SW_SYNC_IOC_CREATE_FENCE	_IOWR(SW_SYNC_IOC_MAGIC, 0,\
>  		struct sw_sync_create_fence_data)
> =20
>  #define SW_SYNC_IOC_INC			_IOW(SW_SYNC_IOC_MAGIC, 1, __u32)
> +#define SW_SYNC_GET_DEADLINE		_IOWR(SW_SYNC_IOC_MAGIC, 2, \
> +		struct sw_sync_get_deadline)
> =20
>  static const struct dma_fence_ops timeline_fence_ops;
> =20
> @@ -171,6 +187,13 @@ static void timeline_fence_timeline_value_str(struct=
 dma_fence *fence,
>  	snprintf(str, size, "%d", parent->value);
>  }
> =20
> +static void timeline_fence_set_deadline(struct dma_fence *fence, ktime_t=
 deadline)
> +{
> +	struct sync_pt *pt =3D dma_fence_to_sync_pt(fence);
> +
> +	pt->deadline =3D deadline;
> +}
> +
>  static const struct dma_fence_ops timeline_fence_ops =3D {
>  	.get_driver_name =3D timeline_fence_get_driver_name,
>  	.get_timeline_name =3D timeline_fence_get_timeline_name,
> @@ -179,6 +202,7 @@ static const struct dma_fence_ops timeline_fence_ops =
=3D {
>  	.release =3D timeline_fence_release,
>  	.fence_value_str =3D timeline_fence_value_str,
>  	.timeline_value_str =3D timeline_fence_timeline_value_str,
> +	.set_deadline =3D timeline_fence_set_deadline,
>  };
> =20
>  /**
> @@ -387,6 +411,37 @@ static long sw_sync_ioctl_inc(struct sync_timeline *=
obj, unsigned long arg)
>  	return 0;
>  }
> =20
> +static int sw_sync_ioctl_get_deadline(struct sync_timeline *obj, unsigne=
d long arg)
> +{
> +	struct sw_sync_get_deadline data;
> +	struct dma_fence *fence;
> +	struct sync_pt *pt;
> +
> +	if (copy_from_user(&data, (void __user *)arg, sizeof(data)))
> +		return -EFAULT;
> +
> +	if (data.deadline_ns || data.pad)
> +		return -EINVAL;
> +
> +	fence =3D sync_file_get_fence(data.fence_fd);
> +	if (!fence)
> +		return -EINVAL;
> +
> +	pt =3D dma_fence_to_sync_pt(fence);
> +	if (!pt)
> +		return -EINVAL;
> +
> +
> +	data.deadline_ns =3D ktime_to_ns(pt->deadline);
> +
> +	dma_fence_put(fence);
> +
> +	if (copy_to_user((void __user *)arg, &data, sizeof(data)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static long sw_sync_ioctl(struct file *file, unsigned int cmd,
>  			  unsigned long arg)
>  {
> @@ -399,6 +454,9 @@ static long sw_sync_ioctl(struct file *file, unsigned=
 int cmd,
>  	case SW_SYNC_IOC_INC:
>  		return sw_sync_ioctl_inc(obj, arg);
> =20
> +	case SW_SYNC_GET_DEADLINE:
> +		return sw_sync_ioctl_get_deadline(obj, arg);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/dma-buf/sync_debug.h b/drivers/dma-buf/sync_debug.h
> index 6176e52ba2d7..2e0146d0bdbb 100644
> --- a/drivers/dma-buf/sync_debug.h
> +++ b/drivers/dma-buf/sync_debug.h
> @@ -55,11 +55,13 @@ static inline struct sync_timeline *dma_fence_parent(=
struct dma_fence *fence)
>   * @base: base fence object
>   * @link: link on the sync timeline's list
>   * @node: node in the sync timeline's tree
> + * @deadline: the most recently set fence deadline
>   */
>  struct sync_pt {
>  	struct dma_fence base;
>  	struct list_head link;
>  	struct rb_node node;
> +	ktime_t deadline;
>  };
> =20
>  extern const struct file_operations sw_sync_debugfs_fops;
> diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_fil=
e.h
> index 49325cf6749b..dc6645b2598b 100644
> --- a/include/uapi/linux/sync_file.h
> +++ b/include/uapi/linux/sync_file.h
> @@ -72,7 +72,11 @@ struct sync_file_info {
>   * @deadline_ns: absolute time of the deadline
>   * @pad:	must be zero
>   *
> - * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank)
> + * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank).  F=
or
> + * example:
> + *
> + *     clock_gettime(CLOCK_MONOTONIC, &t);
> + *     deadline_ns =3D (t.tv_sec * 1000000000L) + t.tv_nsec + duration_ns

Shouldn't this hunk be in patch 5 instead?

What's duration_ns? Maybe ns_until_my_deadline would be more clear that
it is something userspace freely chooses?

>   */
>  struct sync_set_deadline {
>  	__u64	deadline_ns;


Thanks,
pq

--Sig_/8aE4tGFLiLpdo+6qg3s=3bO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP9x/4ACgkQI1/ltBGq
qqcv6hAAkgjLuM8MZAr36UgGjARjMLvWOcq9adsey/FJJhu4S2+Ly3b/hDU9ZAMZ
Ri5QlZusfpYcpMdBK5xKUceapgPL9hmtbLkp2nQ8I70Bs9GL8qxnRDfXZNBSD+dD
8u5bHRVZy0TtmAfx7mTz/9EgQURTaHTmiQIHIwyMquQXFUep7H9EpA3YqlJFvPte
xPMVgQTJ+s/VT0aIkRwf4yGmPoBGTiRYrhJgMfZedP2huV1E3NXuPRRHDDxhIcbH
ODKSi7HOzuF3nmbsENPKL8TEpi7jblkUj3hVnrXdbzKpSfGlcK1PQ36n3X1SwKEJ
zQb5s6Qm3vWjkTYNljTfNDGv/w2DkJDQBYq6VkvkNoYB0IxJAEXVMYj1G1pTLPZy
bwVD3GC+gLdOrs9kAkbodzzRVAjEfer7RqrIQIfiB59MkWAl22zWWue65zU6jBIl
yIHahMl6JiCXSEdgBGeyLqDkba/WBD+hBic4ooI3JODFRH6xmcs2/zeLr2voY28T
lnAiQMh5JkPuuWdtd0w5HpeqzfMEPdWeEBWeScPXE3jX7utXf/aoHqDXvauH9PFl
xgH6JBqt1RX2e3QQ9IDZvZY6SyA7DeCutZJV0uJ24EoKhdFXjZO7pC0HUmblWo8J
vjgIIfjisKX3+B2tVlOMNYHvTzdkdmbWFV9Q8xf2nhwUpvMtakg=
=5sgc
-----END PGP SIGNATURE-----

--Sig_/8aE4tGFLiLpdo+6qg3s=3bO--
