Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB765ECF77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiI0Vq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiI0Vqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C01F1D61;
        Tue, 27 Sep 2022 14:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EC6561BE7;
        Tue, 27 Sep 2022 21:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA006C433D6;
        Tue, 27 Sep 2022 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664315212;
        bh=qYZL8JnpHc3IGwyZkoyEUCdc3AJwhlb1nBEkxNMbH6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJRbeXwgsHaebDSE9MvsbQ/D8MtmsmPUke/E53aKxaGjL+1Ovk6e0gxmOa6FGYJ3M
         SgQoV6TOHmlWTRx75MjPFAPcOdDXnqRe/DuvYpBpWWf+HRQgeUv5eQMl2aC9h0wS5P
         p3oGOIY8XJ6KyxFkI9ki9tdAxZ+E2Konhxy+lQfn9WJOzERVRpBaLw8dPecOtwWqKy
         +Sfzd48hrw/hz1NnfcRegK3Vgbyw95w62wb6QvWr5P0BU3lz5wHxAjvinpgLPAM2xp
         8YHYFGZ+iMeJgSmDvORja1BdmJnziHXG8qs7GnyJS35QsuL2ryOjhRMaoY6Ap0D6Wm
         KrgyT6xT6Q+TQ==
Date:   Tue, 27 Sep 2022 17:46:48 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com
Subject: Re: [PATCH v6 0/5] Add support for Counter array components
Message-ID: <YzNvSMoqZUCN+BkW@ishi>
References: <cover.1664204990.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vfPCSC56fwPLnZNT"
Content-Disposition: inline
In-Reply-To: <cover.1664204990.git.william.gray@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vfPCSC56fwPLnZNT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 11:16:33AM -0400, William Breathitt Gray wrote:
> Changes in v6:
>  - Rebase on latest counter-next branch
>  - Add ABI Documentation lines for capture_component_id and
>    polarity_component_id
>=20
> The COUNTER_COMP_ARRAY Counter component type is introduced to enable
> support for Counter array components. With Counter array components,
> exposure for buffers on counter devices can be defined via new Counter
> array component macros. This should simplify code for driver authors who
> would otherwise need to define individual Counter components for each
> array element.
>=20
> Eight Counter array component macros are introduced::
>=20
>         DEFINE_COUNTER_ARRAY_U64(_name, _length)
>         DEFINE_COUNTER_ARRAY_CAPTURE(_name, _length)
>         DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length)
>         COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _array)
>         COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _array)
>         COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _array)
>         COUNTER_COMP_ARRAY_CAPTURE(_read, _write, _array)
>         COUNTER_COMP_ARRAY_POLARITY(_read, _write, _array)
>=20
> Eight Counter array callbacks are introduced as well::
>=20
>         int (*signal_array_u32_read)(struct counter_device *counter,
>                                      struct counter_signal *signal,
>                                      size_t idx, u32 *val);
>         int (*signal_array_u32_write)(struct counter_device *counter,
>                                       struct counter_signal *signal,
>                                       size_t idx, u32 val);
>         int (*device_array_u64_read)(struct counter_device *counter,
>                                      size_t idx, u64 *val);
>         int (*count_array_u64_read)(struct counter_device *counter,
>                                     struct counter_count *count,
>                                     size_t idx, u64 *val);
>         int (*signal_array_u64_read)(struct counter_device *counter,
>                                      struct counter_signal *signal,
>                                      size_t idx, u64 *val);
>         int (*device_array_u64_write)(struct counter_device *counter,
>                                       size_t idx, u64 val);
>         int (*count_array_u64_write)(struct counter_device *counter,
>                                      struct counter_count *count,
>                                      size_t idx, u64 val);
>         int (*signal_array_u64_write)(struct counter_device *counter,
>                                       struct counter_signal *signal,
>                                       size_t idx, u64 val);
>=20
> Driver authors can handle reads/writes for an array component by
> receiving an element index via the `idx` parameter and processing the
> respective value via the `val` parameter.
>=20
> For example, suppose a driver wants to expose a Count's read-only
> capture buffer of four elements using a callback
> `foobar_capture_read()`::
>=20
>         DEFINE_COUNTER_ARRAY_CAPTURE(foobar_capture_array, 4);
>         COUNTER_COMP_ARRAY_CAPTURE(foobar_capture_read, NULL,
>                                    foobar_capture_array)
>=20
> Respective sysfs attributes for each array element would appear for the
> respective Count:
>=20
> * /sys/bus/counter/devices/counterX/countY/capture0
> * /sys/bus/counter/devices/counterX/countY/capture1
> * /sys/bus/counter/devices/counterX/countY/capture2
> * /sys/bus/counter/devices/counterX/countY/capture3
>=20
> If a user tries to read _capture2_ for example, `idx` will be `2` when
> passed to the `foobar_capture_read()` callback, and thus the driver
> knows which array element to handle.
>=20
> In addition, this patchset introduces the Signal polarity component,
> which represents the active level of a respective Signal. There are two
> possible states: positive (rising edge) and negative (falling edge). The
> 104-quad-8 driver is updated to expose its index_polarity functionality
> via this new polarity component.
>=20
> Counter arrays for polarity elements can be defined in a similar
> manner as u64 elements::
>=20
>         const enum counter_signal_polarity foobar_polarity_states[] =3D {
>                 COUNTER_SIGNAL_POLARITY_POSITIVE,
>                 COUNTER_SIGNAL_POLARITY_NEGATIVE,
>         };
>         DEFINE_COUNTER_ARRAY_POLARITY(foobar_polarity_array,
>                                       foobar_polarity_states, 4);
>         COUNTER_COMP_ARRAY_POLARITY(foobar_polarity_read,
>                                     foobar_polarity_write,
>                                     foobar_polarity_array)
>=20
> The only component types supported for Counter arrays currently are
> COUNTER_COMP_U64 and COUNTER_COMP_SIGNAL_POLARITY.
>=20
> William Breathitt Gray (5):
>   counter: Introduce the Signal polarity component
>   counter: 104-quad-8: Add Signal polarity component
>   counter: Introduce the Count capture component
>   counter: Consolidate Counter extension sysfs attribute creation
>   counter: Introduce the COUNTER_COMP_ARRAY component type
>=20
>  Documentation/ABI/testing/sysfs-bus-counter |  21 ++
>  drivers/counter/104-quad-8.c                |  35 +++
>  drivers/counter/counter-chrdev.c            | 135 +++++++--
>  drivers/counter/counter-sysfs.c             | 304 ++++++++++++++++----
>  include/linux/counter.h                     | 147 ++++++++++
>  include/uapi/linux/counter.h                |   8 +
>  6 files changed, 583 insertions(+), 67 deletions(-)
>=20
>=20
> base-commit: 7d333188e1d048457572d3a7d0630cd7b91f902d
> --=20
> 2.37.3

Queued for counter-next.

William Breathitt Gray

--vfPCSC56fwPLnZNT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYzNvSAAKCRC1SFbKvhIj
K9iyAP4wnZT68R2puTkyL55mphWpqb1F5F5M29wUnXtmXRZ7MQEAw5XBEOer4R91
tp+09+nZCQdcKsToJyrxgygEQl/Q1Ao=
=c0oW
-----END PGP SIGNATURE-----

--vfPCSC56fwPLnZNT--
