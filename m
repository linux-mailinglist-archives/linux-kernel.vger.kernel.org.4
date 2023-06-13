Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BD872ED99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbjFMVFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbjFMVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609C199B;
        Tue, 13 Jun 2023 14:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFD2863987;
        Tue, 13 Jun 2023 21:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996F0C433C8;
        Tue, 13 Jun 2023 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690337;
        bh=QZXPWxhX1keAlk8fv9Ti8a0CeUQ43Rk5jnOpLcyKEPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vw1Gys/KyWiPpmcYeFI/zbLIvIPg6yS4rAcpFesVIhbait04VE24G5MSdQNt4dTJQ
         JE8/AFLoegLkbg+4HP2rqGW2CQ/WkZWjUrP+ZqVdqZJ2RQZO1WWVIQYYjzLmuXfnw4
         ziJCS9n5d5r5fpy28oonymRYCNFlmJzTJtZr/V/ru3MIU9W1jtS4egy8ErMl67Oa+3
         w0EnNSJGeOcUgWuKKUoH6quIvFV0BF3Y+YJGvek32NhTFZ2z60+qC7Q72Zjxinzst5
         B3aWnUNsfhpy/W75hrLEK5IRjutZ8utVrpCbWJAdA8YvnCoPRn9VbgCQWIeehhJtmm
         01XFgRn7cJWSw==
Date:   Tue, 13 Jun 2023 22:05:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: auxdisplay: holtek: Add missing type for
 "linux,no-autorepeat"
Message-ID: <20230613-blog-skimmer-e36fa3c1b223@spud>
References: <20230613201049.2824028-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w2X92fXvUIy/OEv0"
Content-Disposition: inline
In-Reply-To: <20230613201049.2824028-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2X92fXvUIy/OEv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:10:49PM -0600, Rob Herring wrote:
> "linux,no-autorepeat" is missing a type, add it.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--w2X92fXvUIy/OEv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjaHQAKCRB4tDGHoIJi
0nI4AP93cUR4Ayt4sh/XWpC9ebn3Kag2cFlbF9p3sOjAmuFntgD7BRhiiBylHOtw
pIxjCauKK1FOIkZnk0gInsD1+O46xQI=
=AJm5
-----END PGP SIGNATURE-----

--w2X92fXvUIy/OEv0--
