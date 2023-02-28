Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7474C6A5947
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjB1Mn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjB1MnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:43:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2BA8A46;
        Tue, 28 Feb 2023 04:43:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so13517784pjb.3;
        Tue, 28 Feb 2023 04:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677588182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GNoSdXiAy4Hnpx4GSmf9v1s/TnoJ2Easnzikmce7RFo=;
        b=Df7zrRz22eg8YZi+bpqjSJPlYpN8eIwr9o77wJ4OIQ+4kuTEVXpnUz/mPubCGdCkzm
         wB0GhDQXs3xOQYDpZ9TG3khGJT4x7Ps3f8Vj0npRhk0C4oSB96tMQoW50c51EZ3lfU6+
         vFMlcXzfaK3nk76iyyHVvUt22CWre9Kuihg8DdAXM83Q0NBTYhnQ9e1mcv7ZaGj3nj6C
         DWIlEvKfO56rW78AV5SO5ICvqhDgv2GTFKuLLPU+zrXAXmgq0Z3G0wNqW6+IdX6MRcKc
         JC/a+Zbq22en8EaGBqwiunzxOiXmQHaNTUI4tKBNSby2zUAc3XWf8SlBzOOJfcD8IlKJ
         SM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677588182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNoSdXiAy4Hnpx4GSmf9v1s/TnoJ2Easnzikmce7RFo=;
        b=FBDohP3fu3kQLytahyhOvYTIj72q4/9UJrAxCkl3mmAnomevTHmr3nclTXlGdUmM8P
         OhnakrWnAMFJAM2OL3rS/V+DxRVIiL3WuF5stbCLF9kwRy0Q8cf/3Yb9cW6DiLyO+lfw
         goa1EVOVD3maW3PsGSds+yjbCRvckigrXS5xW9vLw5tg82T6SI48/rnIVS0XFxA+tpvk
         y52bvQ3vfSTfx1/ee12pe3UVET0KRAiGctIXLXHC7zNR2dn05hviK5lv6W4zATvy+NT8
         zvhqd+scZL2atbNQXPYBM6il+lYEWz84dLZYUSPoN2kqlk3JvIHNZXFNG/O7XJI6dvRP
         dlmg==
X-Gm-Message-State: AO0yUKV2seuGNnS5LdA318lpsTVq5hp6nWui9PgGrzYWaURXIj0c/fez
        aHyBcGq6ICP8VeuMxGNFyL0=
X-Google-Smtp-Source: AK7set9OdAQjCkCpgdCiYZHKKMRQTrLw3bEzWK8cbf3O+nNoqA5K32bwW9Ij9MRpVcAkVdH7hRxAQg==
X-Received: by 2002:a05:6a20:47d7:b0:cc:68a1:5033 with SMTP id ey23-20020a056a2047d700b000cc68a15033mr3052844pzb.16.1677588182510;
        Tue, 28 Feb 2023 04:43:02 -0800 (PST)
Received: from debian.me (subs02-180-214-232-83.three.co.id. [180.214.232.83])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78052000000b005a909290425sm6172405pfm.172.2023.02.28.04.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 04:43:01 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 24D0210105C; Tue, 28 Feb 2023 19:42:57 +0700 (WIB)
Date:   Tue, 28 Feb 2023 19:42:57 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        intel-gfx@lists.freedesktop.org,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Subject: Re: [PATCH v7 00/15] dma-fence: Deadline awareness
Message-ID: <Y/320d96QmbLe1J8@debian.me>
References: <20230227193535.2822389-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wAv6Jr7MZqhKVbDV"
Content-Disposition: inline
In-Reply-To: <20230227193535.2822389-1-robdclark@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wAv6Jr7MZqhKVbDV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 11:35:06AM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>=20
> This series adds a deadline hint to fences, so realtime deadlines
> such as vblank can be communicated to the fence signaller for power/
> frequency management decisions.
>=20
> This is partially inspired by a trick i915 does, but implemented
> via dma-fence for a couple of reasons:
>=20
> 1) To continue to be able to use the atomic helpers
> 2) To support cases where display and gpu are different drivers
>=20
> This iteration adds a dma-fence ioctl to set a deadline (both to
> support igt-tests, and compositors which delay decisions about which
> client buffer to display), and a sw_sync ioctl to read back the
> deadline.  IGT tests utilizing these can be found at:
>=20
>   https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/fence-d=
eadline
>=20
>=20
> v1: https://patchwork.freedesktop.org/series/93035/
> v2: Move filtering out of later deadlines to fence implementation
>     to avoid increasing the size of dma_fence
> v3: Add support in fence-array and fence-chain; Add some uabi to
>     support igt tests and userspace compositors.
> v4: Rebase, address various comments, and add syncobj deadline
>     support, and sync_file EPOLLPRI based on experience with perf/
>     freq issues with clvk compute workloads on i915 (anv)
> v5: Clarify that this is a hint as opposed to a more hard deadline
>     guarantee, switch to using u64 ns values in UABI (still absolute
>     CLOCK_MONOTONIC values), drop syncobj related cap and driver
>     feature flag in favor of allowing count_handles=3D=3D0 for probing
>     kernel support.
> v6: Re-work vblank helper to calculate time of _start_ of vblank,
>     and work correctly if the last vblank event was more than a
>     frame ago.  Add (mostly unrelated) drm/msm patch which also
>     uses the vblank helper.  Use dma_fence_chain_contained().  More
>     verbose syncobj UABI comments.  Drop DMA_FENCE_FLAG_HAS_DEADLINE_BIT.
> v7: Fix kbuild complaints about vblank helper.  Add more docs.
>=20

I want to apply this series for testing, but it can't be applied cleanly
on current drm-misc tree. On what tree (and commit) is this series based
on?

--=20
An old man doll... just what I always wanted! - Clara

--wAv6Jr7MZqhKVbDV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/32zQAKCRD2uYlJVVFO
o1TBAQCAHLKqy5NdumoKS+DbOAOm+KfhLK93EKYDC8UmiebsRAEA+JAK75T6QTDt
aHxaJFTZKkVfK7+Eq1MfYn2ZeBgJXgU=
=jpg1
-----END PGP SIGNATURE-----

--wAv6Jr7MZqhKVbDV--
