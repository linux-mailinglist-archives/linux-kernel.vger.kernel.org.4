Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A117461B3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGCR7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjGCR7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665EE42;
        Mon,  3 Jul 2023 10:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF0A460FFB;
        Mon,  3 Jul 2023 17:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2F4C433C8;
        Mon,  3 Jul 2023 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688407142;
        bh=XiKFb7V3OWMEwZYvzGXbVzuxPSM8FbOxPhs9OT74TMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhW9voFlWsg2QeJzEydQBhtOwjlMm8fZzCdy3Jg6bgRw3Esqh+f8rsZBYIA3SCaPx
         AQz+Oc9EBN6nn93BEoFFPSg+57WrZmANomGNefAIrNciFIsppxAehBRnMqXAt/ywjm
         z7iqgzyrENrfpeSnG308kL3EU9gR+y4v6L3MlpiOyNoivVjA3mh4bTEnyioySkQzgM
         GxeHgvOxN6ShRkFj3TRimrwaeLvgUIl10cAmpoOAJRCAw3PSjPMnrlQB4GB7fHJBUf
         S3+AIOJVoJNcN8mVzU6/cDqq2x4yEOq0egDriSpyLBXZ5+3puLj3beKYTz+4YpegCI
         Yid4vMQ3ucBZQ==
Date:   Mon, 3 Jul 2023 18:58:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 1/6] media: v4l2: Add audio capture and output support
Message-ID: <090cc065-b078-4f2c-9b2d-3b0b7418461d@sirena.org.uk>
References: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
 <1688002673-28493-2-git-send-email-shengjiu.wang@nxp.com>
 <ZJ6o5fT4V4HXivFa@valkosipuli.retiisi.eu>
 <CAA+D8AND1yZ7eZLjBGxVF=i3hLMecUm-j7AVHN9npJi-4=3VrA@mail.gmail.com>
 <87h6ql5hch.wl-tiwai@suse.de>
 <43f0ecdf-7454-49ae-96b3-2eae5487e9a5@sirena.org.uk>
 <d78e6ec3-a531-8fd4-a785-29b6712f83ae@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lxJuGwNgfQ7aT3CA"
Content-Disposition: inline
In-Reply-To: <d78e6ec3-a531-8fd4-a785-29b6712f83ae@xs4all.nl>
X-Cookie: Please go away.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lxJuGwNgfQ7aT3CA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 03, 2023 at 03:12:55PM +0200, Hans Verkuil wrote:

> My main concern is that these cross-subsystem drivers are a pain to
> maintain. So there have to be good reasons to do this.

> Also it is kind of weird to have to use the V4L2 API in userspace to
> deal with a specific audio conversion. Quite unexpected.

> But in the end, that's a decision I can't make.

> So I wait for that feedback. Note that if the decision is made that this
> can use V4L2, then there is quite a lot more that needs to be done:
> documentation, new compliance tests, etc. It's adding a new API, and that
> comes with additional work...

Absolutely, I agree with all of this - my impression was that the target
here would be bypass of audio streams to/from a v4l2 device, without
bouncing through an application layer.  If it's purely for audio usage
with no other tie to v4l2 then involving v4l2 does just seem like
complication.

--lxJuGwNgfQ7aT3CA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSjDF4ACgkQJNaLcl1U
h9C2qQf/T1bo/x5kzUxZUiZwHmeGiBJp44klM7V/tJxivlJLnJasmtd1XuabJOck
svgGpJOHeeAAIAQIleix37Lwq5hMLYgRdPPAHw3+uw4mYtDzqo5dx8t7Wb8d7+px
152zx6Cv8YdJ1mK/UOKXC/+knHpkW0r9PtzwItAAnCTPpAIPjB0FAjSkhRuQr2bl
tlzLcAepTA/uPQYuK1FbwUZEcm0i/qo/aFpE5T7hYpY3IlFYrtMz8uNyqhXMsuM2
SMREMMIMF84hMJkJ3sRrf6609xv86w+Rkh6illa8jX/GCKDHQRNR0xa+0Gky5cah
eOW+Q5lSP6NtzVnkBdM3DUDl/+IaRg==
=ImD6
-----END PGP SIGNATURE-----

--lxJuGwNgfQ7aT3CA--
