Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA0C7343AB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346511AbjFQUix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjFQUiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:38:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BADE68;
        Sat, 17 Jun 2023 13:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9372561259;
        Sat, 17 Jun 2023 20:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4A7C433C8;
        Sat, 17 Jun 2023 20:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687034329;
        bh=9Zb9UAFksFY7Cy3ynj/wFUHzUz5qBHPgp+UpGMmeKMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LotxR04o8Wf7joBGdeaq8Ul9ardmmlWypp8vCP8MULOLW3ynQfkptGWdoofkBK3tR
         p4O7na8+o6MWz65Na5Tz56BYNf9BPuRHm08wD5KV6S4Lw+CIzwxOLU3wj91oZoulvF
         /oM21NPF0UC2iNHJo0YMMq5I6RkmA29Ik3ZaNWlgFoPyUAGTJbnHQhRMg/J+/nyLyB
         hHZ3yl+Ulr5r/D0VmOV/moMmfjz5r/ic/r7o9ma/H7YtDyvv4rBUgbi6TSO0ujivKy
         jmBUq9FBI0h+fJaepebdy1dCY9jztmBJc5YzOj95vWc8T68kyNgvT9UyTrGP/w0wo5
         BQdwqSB9nau3A==
Date:   Sat, 17 Jun 2023 21:38:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: sony,td4353-jdi: allow width-mm
 and height-mm
Message-ID: <20230617-postal-alienate-9afb55ff895e@spud>
References: <20230617165726.279886-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OGrMT6Z9yvE6MzoL"
Content-Disposition: inline
In-Reply-To: <20230617165726.279886-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OGrMT6Z9yvE6MzoL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 17, 2023 at 06:57:26PM +0200, Krzysztof Kozlowski wrote:
> Allow width and height properties from panel-common.yaml, already used
> on some boards:
>=20
>   sdm845-sony-xperia-tama-apollo.dtb: panel@0: 'height-mm', 'width-mm' do=
 not match any of the regexes: 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--OGrMT6Z9yvE6MzoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZI4Z0wAKCRB4tDGHoIJi
0nrWAP0eOCIlGa1oo6zjaF71YuRF2e8/Se/IBTj1c8YHldvz3AD+POZcUdowCLo3
XoWPPKwJBlqJsOGNTLousij+OblgdQ4=
=5gXF
-----END PGP SIGNATURE-----

--OGrMT6Z9yvE6MzoL--
