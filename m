Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E955738E36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFUSIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFUSIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:08:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB9E1739;
        Wed, 21 Jun 2023 11:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97D436163E;
        Wed, 21 Jun 2023 18:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B63DC433C0;
        Wed, 21 Jun 2023 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687370926;
        bh=7X2X8ssl0I3kcuFvuGnHm5dMbraS+AchudpTPC7LNWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4DJ+UJRtFJKhCCto+lT99MoBZ6V7nuT9q6CgeyuzKZmpw2J2ZwN1dh7AfDjnoxl6
         sZmy8JYG0Oi/j4Fz8aguiE7LgeR1tigNX39QtlI4QWehDKb/hp+O97HLkROQqhhnnS
         /BJQ5aHx+PgNhipWuaGW3H5+3xEECG+LEAn9Tt9hJ8+eSczQBPhHUWj68zM2LvB1dT
         4RIMng4Q8ltmxRD4YmqUQGJGMTTti8jcL+ZKOel+bDtLkT3pMB613BlJcnvKIML36M
         2tYLeSdWJHayagt6J+pysMSfpxj/wbWXsjhM23Qnd6mkZIzzkdNnEbtMgtrwA0wmAr
         mrN07k1wKMBVQ==
Date:   Wed, 21 Jun 2023 19:08:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 1/5] spi: dt-bindings: Add bindings for RZ/V2M CSI
Message-ID: <20230621-bubbling-sarcastic-252180c2d8ec@spud>
References: <20230621140944.257352-1-fabrizio.castro.jz@renesas.com>
 <20230621140944.257352-2-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ocggzProvjUdezXp"
Content-Disposition: inline
In-Reply-To: <20230621140944.257352-2-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ocggzProvjUdezXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2023 at 03:09:39PM +0100, Fabrizio Castro wrote:
> Add dt-bindings for the CSI IP found inside the RZ/V2M SoC.

Seems fine to me..
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--ocggzProvjUdezXp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJM8qAAKCRB4tDGHoIJi
0raHAQDOkiuW6YrEZdb7mRU8M4bDhlwX+R8LnXm7bFsVowSxZQD/Zuwzwdgem7MP
yoiX0tC/2zHO15P8XdnvjxkkJzVnZQg=
=Ppgm
-----END PGP SIGNATURE-----

--ocggzProvjUdezXp--
