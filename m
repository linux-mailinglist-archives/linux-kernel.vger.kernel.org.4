Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541BF5F326D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJCPYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJCPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:24:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E491169;
        Mon,  3 Oct 2022 08:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFE34B81181;
        Mon,  3 Oct 2022 15:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B05BC433D6;
        Mon,  3 Oct 2022 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664810675;
        bh=hw5ubvJIUUpFp29R0cs6nGaJ9bn+UAWY3cw8/+RQie4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7xVduz54zW8RUY9LNp9lF/muM2LzygeHPUjSAr7QgiMsSwGCyp047Q6cb1/QAQpz
         t1y623bSVIykYONlBgn7BX457kZ/jqh7BKrw21OXwGv/yix0EvTGqnSW3ktb/6Ictr
         A0upMW2EXjGz3+T4WuyjJPQyrlpR/DwqcgrU+TDa38AnF+uH1d0SDdS0IYKzzydKgH
         oT2q9AtYuDF7UAqC/gLoFfU805Mk7hEaShveKzF1jGxZaOekqPnZtJrgtWUjerN36u
         dyrMxTWWO7Tvra28yM1HdxMQZ2k241RY/+oCUgS1D3+GOE5o99vsZ/OA3bwL3DAivm
         BQB49ph5KwkLg==
Date:   Mon, 3 Oct 2022 16:24:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        skomatineni@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: tegra210-quad: Use nbits in combined seq
Message-ID: <Yzr+rlDnppaL4Ylh@sirena.org.uk>
References: <20221001122148.9158-1-kyarlagadda@nvidia.com>
 <20221001122148.9158-3-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPSAY1MJDyNgI3Pb"
Content-Disposition: inline
In-Reply-To: <20221001122148.9158-3-kyarlagadda@nvidia.com>
X-Cookie: <doogie> dpkg has bugs?  no way!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPSAY1MJDyNgI3Pb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 01, 2022 at 05:51:46PM +0530, Krishna Yarlagadda wrote:
> Combined sequence currently forces cmd and addr transfers in X1.
> Check nbits for CMD and ADDR xfers and update config registers.

I can't tell from this commit message what this change is supposed to
do or even if it's a fix.

--ZPSAY1MJDyNgI3Pb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM6/q0ACgkQJNaLcl1U
h9CCbwgAhWbrcBah2t7saGXC97UPJ6vgTJbOdbY6VR8kZ0wXFjBVluTNgrzo7pH5
KV/uOBYGw7MQ5qeLJnmarqRzCu9Vx6cHb7H1267dGJMobSUTzR32EzKmRYSlLACo
4N6ECaqIitR53KGzntWW0gTxbogC/yoNXv5G9+i9gfzsh0DpT+OuwSX8SBT0fSXd
37uVCae2cL+BLQpd+ujMCAGgg4+Gj6ZZCHbJ0oa8atQXaHaVM/ViulTRh8XTEJGV
bmMet1KokFlf9UAJHdrh8u1Y2t2BXDi9dpNs/4PFPEXDna9Ksz5ZTNqVgpqYERI8
6JhMtrSFjCvUs1jz5n6EKSxKrVdzvw==
=Uqfg
-----END PGP SIGNATURE-----

--ZPSAY1MJDyNgI3Pb--
