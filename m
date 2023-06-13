Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A6C72EDA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbjFMVHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFMVHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271E199C;
        Tue, 13 Jun 2023 14:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD5A763B07;
        Tue, 13 Jun 2023 21:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46289C433C0;
        Tue, 13 Jun 2023 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690438;
        bh=dg1OBeira/SOkCADIAIlkIHpK6iLT9wV4cEyypcTp+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3wgzqqsVNJ7u2ppnUdieLBBiPZhWiKrR5Wp6DSKONfg8YxKms3srkxzLPMAkNsyr
         eDiWE8kGi1rCK+e+rcV5FwKjia3r5IXLCxn3ko54T13e/VWrzsc4h8N9r3WdwTT94P
         m92AqmVUgDZzsccLAYdQyRzHD1yl4hYC6uQ9RMIfAaHJno+iVxkQtJQI8uvx2l5wES
         vVNhUYt81b2VV2lA1/cuUTp1GeexGNr9DxkT2j4qvTlDSruVAVNcxGS/ujosnC6P3t
         UyXLSLXFd9GQYrJDKjaTVJUA6iFIa8WvT/qGnyVus5kMQ6xfTRl0a06mPhy+309PmN
         2B8KtohPhBIWw==
Date:   Tue, 13 Jun 2023 22:07:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: Add missing property types
Message-ID: <20230613-stand-dainty-b3bb31d83192@spud>
References: <20230613201114.2824626-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A/78unTD0TIXk5Vq"
Content-Disposition: inline
In-Reply-To: <20230613201114.2824626-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A/78unTD0TIXk5Vq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:11:14PM -0600, Rob Herring wrote:
> A couple of display bridge properties are missing a type definition. Add
> the types to them.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--A/78unTD0TIXk5Vq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjagAAKCRB4tDGHoIJi
0rfmAQDbP6Tjg5xc2FjaR9cJeQpufTo4mGa03A3AzVhICSgIiwD9E8wvLpm7Udq9
cj05X+hFncK/KDC1u2zOJwoIKoysjwo=
=sFZ3
-----END PGP SIGNATURE-----

--A/78unTD0TIXk5Vq--
