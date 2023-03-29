Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5096CDB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjC2OBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjC2OBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:01:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B810640C1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ED78B82335
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68062C4339B;
        Wed, 29 Mar 2023 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680098503;
        bh=1JDbhnlCXp+QXLo5gNdlSiUGxdit8Xpa1A249X+r5nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yb2f4ey82U54YWrWHMhRSO0+xhD3rKO+L0dJds7/mUT6EJmcKsg/pg09cL3+X5yqt
         gFuMyYAqbDZY3cEDnM6llKeqjmH9by/n8O2qI6wtTy6hRWxe7iYezwbla/8b25zhJ9
         WNJ364D7fx+R6QVth+7HrL7hXm/yzTFQpFxjXTtnm5XnlIjgDpMnWqeYu9lT8id1kz
         qcNdtUweOdwD8Ad3f7LSwkUkwfG6kmHjPMuLXYqIuODnuMvqXeCZymI+sCYmdkiadQ
         lvKLZfewORTWAwD6ewoFa8F4S45ir/3ctqPG/Atxn7uQou0Rb17xPVGkhvGS3/ZyJI
         rlKZgmjOReilA==
Date:   Wed, 29 Mar 2023 15:01:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhu Ning <zhuning0077@gmail.com>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, posteuca@mutex.one,
        tiwai@suse.com, yangxiaohua <yangxiaohua@everest-semi.com>,
        Zhu Ning <zhuning@everest-semi.com>
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <ZCREw+j8W0Uo+Fvy@sirena.org.uk>
References: <CANPLYpBv82p-Fve-JgM=WDwUFp-VnKfG2yFvcGv8AT2roPEifw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XYlcBw+sQgu2A6wr"
Content-Disposition: inline
In-Reply-To: <CANPLYpBv82p-Fve-JgM=WDwUFp-VnKfG2yFvcGv8AT2roPEifw@mail.gmail.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XYlcBw+sQgu2A6wr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2023 at 09:54:41AM +0800, Zhu Ning wrote:

> > There being two different GPIOs sounds like it just allows the headphone
> > and speaker to be controlled separately - that seems more flexible, not
> > a problem?

> Yes it's called multi stream in Windows. However, extra GPIO causes
> more confusion
> in the driver.

That might be true on Windows, however with these being
representable as DAPM widgets on Linux I would be surprised if
there were much burden on Linux.

> +       SND_SOC_DAPM_SUPPLY("Headphone Power", SND_SOC_NOPM, 0, 0,
> +                           acp3x_es83xx_headphone_power_event,
> +                           SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
>         SND_SOC_DAPM_SUPPLY("Speaker Power", SND_SOC_NOPM, 0, 0,
>                             acp3x_es83xx_speaker_power_event,
>                             SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),

Note that both of these would be much better represented as
events on the actual headphone or speaker widget, these have
event callbacks.  This will ensure that they are sequenced after
the CODEC minimising pops and clicks.

--XYlcBw+sQgu2A6wr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQkRMIACgkQJNaLcl1U
h9Dergf2LoQ4OhmixCubBqEKo5pEd7TxQ2no3/OnZjDm9Y71fYE510O+go7U1WdF
8Sp3iC1O8S9jCMm1hZVdYZaEQvcjZIvgDsVk3K2i6bcjo7B6bwY+v1JmzI8g2uMq
lbeZL/S2fLefpchh43LU1KWSSkPUm85XOk9Yv5kebnvz9cb5EqNGtypU5bC7+nQY
Szn7OUiWEbGbQE8hE64lm2HevlovU/v0IsNO31ocHSjGIUFZt/PpHUJCErbh8X8k
UOhWzu3UCudV4+RV75vRD8jL+zchU1Z+lAiBqJUPrbHqvTEx8IVUzVt0ppOdF/VZ
Q1la9dgWj9LbBnWZYh7eqVnpKcLQ
=2zek
-----END PGP SIGNATURE-----

--XYlcBw+sQgu2A6wr--
