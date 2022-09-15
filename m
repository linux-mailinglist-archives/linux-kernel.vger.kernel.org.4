Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424535B9A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIOMEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiIOMEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:04:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E0B1CB;
        Thu, 15 Sep 2022 05:04:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso221142wmq.2;
        Thu, 15 Sep 2022 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GTDWAPzRsyFSCgEo/xQ7NozivtexTQr6waF1dmd0WW4=;
        b=XdgJU1eTrvqiPlVuWBJIoSVOz6UeMHYPWk2LIJKO9jGRyrapANn6Qa+MGqW3XjK05L
         eRaX31dmXi7rHUPS4HjgCdKFWuVG6dtLhRCdykqbCGjYVePGFee9sMKgf0tjI+4sTx8T
         daDF3+uwqyh3NybjbxOnC/krpSXZYQi3yy8M4TccmsNSvEDAsvYwCGa0IxC9cFVhl6jA
         1RwM4zgJJsMt0AGb2arJF1P78ZjuWOPMnolYxKE/bw8h2G86/z0SOxp/QhVubenSQPH7
         8EEWHYo28k0jQG6tcCHrgKzbxCRunvMRcw8mKvpk39A50eSaCKHdtjvWT3PIUk1AXpIS
         yDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GTDWAPzRsyFSCgEo/xQ7NozivtexTQr6waF1dmd0WW4=;
        b=UEWG/8ySJppY32NQFW7WRge7a7BNTsqsK3VlOQFATYEqFxZfwuvDBlib27YUFSK5k1
         zRimHWHtRZjOP4QrTgbzjmbFrgMmUkR7zZjHuHbFBZkDiZTwc5m91QCTsMTyceOIeLN6
         u+AFo6UPGranjkf8wLqPqB0vxtGoBYzX/uOkblmSIePdFGZMg7LRxiHlkBEVrjQYnaW+
         v2oc8pvf8kydsuETnji0i2b+aFbjHdRzk4C+jYHpi00o9BwBhph5JAmL0lmMs2M2Oknm
         tLl37wuDFFdrk7YhiUjoAN5K1zucjwjNgRBw3ejSEawPBQJRPBJUwta4AlIryCVg25Vq
         nxPw==
X-Gm-Message-State: ACgBeo1cRZK+hBEZ3IKgnq9wc3tI+0ADfZKlYqdBLpDY/MCZz4Z7qk+8
        n4c85xURxB6haOccgaZwgGc=
X-Google-Smtp-Source: AA6agR5gP0BegU9kHb3Zmn5OiE+xmFZii0czHnWhtHnh/ZgekfhGNexHMIldIjutQE4x++ElsIvYiA==
X-Received: by 2002:a05:600c:354a:b0:3a5:b01b:2ab0 with SMTP id i10-20020a05600c354a00b003a5b01b2ab0mr6245611wmq.61.1663243479840;
        Thu, 15 Sep 2022 05:04:39 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d5246000000b00228fa832b7asm2376315wrc.52.2022.09.15.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:04:38 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:04:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: build TEGRA SPI & QSPI
Message-ID: <YyMU1WqAV6A7yqg7@orome>
References: <20220913041012.17027-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vqw6/qZF1/rYoiav"
Content-Disposition: inline
In-Reply-To: <20220913041012.17027-1-kyarlagadda@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vqw6/qZF1/rYoiav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 09:40:12AM +0530, Krishna Yarlagadda wrote:
> Jetson AGX board has flash device on QSPI controller and SPI instance
> on 40-pin expander.
>=20
> Enable TEGRA SPI & QSPI drivers in defconfig as modules.
>=20
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry

--Vqw6/qZF1/rYoiav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjFNIACgkQ3SOs138+
s6EwHQ//WfP05aTNaotuPDBxg73V4ZTIJyA/6rlCKLpC0HU/pinxD3yiah3hkKiY
PQR3YEKVv6rfZBUX92N5c4V96JmOxpk1mo39P/Kfo5Ml33/YNOzfRRA59TkvaxfI
Hp2BxQubQ/9ue9yFKlEzDwgAcfpRTGXcRq3EBJkS0kCHnf26isoVRf+S3FF9ypUK
nZq7GtsiM2Ur/lWHoib6j8iAHXVtvp0BNfkOWN9t+lEyUEFD3WSV0LWUqu1YlLVE
ZpsoO4CSrbKQztLnRX/GysbsKthuw7H/XO32u9QbMvMRTwMBDdjdHgYMmpKa6Irc
0DbOkm8IMiEvk2NZdSjvVThpEMwsKahGwKd/oO/a82N5P1+sZxBpX5gWZ9HxrVdL
WqJ9rEVW7TmxW3bv0gtX0TF8mvjSPoNn0oq+XgLSdpnIM40P5Mxo4bT6UNeP5ZwY
ko3M5CieGHrEacpjqTVAyj4c+0TV8irr7rvPUvlDpW8nRaKaoqJzY0LVK6WFlz7G
gvLflHTXdGVsk7M/gQBVArEFFwJsPcp4/DJ9mv5EQcS+DAsuYI8W1xLzccqO2Aaa
pmVe5tUfcvwIxliJGINiso7ki85NZ1LpRUgR2PTdhgKzo3o7UmtNLr25NLg5V5qL
gk4g6fgGIf1ctuY/iIXH4S+Cyy16xaMfQx7gA0nSAnI+zjm/Za4=
=498g
-----END PGP SIGNATURE-----

--Vqw6/qZF1/rYoiav--
