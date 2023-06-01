Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18FC719AD3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjFALRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjFALRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE80124;
        Thu,  1 Jun 2023 04:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B3A861D55;
        Thu,  1 Jun 2023 11:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655FEC433EF;
        Thu,  1 Jun 2023 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685618252;
        bh=PQTKK4TNTGd6SkNciPTZxhjIN8KD4aPCXVFtu9urh0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwLd9186Cl7yV6e6P5jeJ8w1Q/Vkm3zq07lBa4pxAuTmYF5jaBtrRroFxK3RG7EL7
         nwksoTS7+n8AearzxyD/PGe5L1jK2Y51cuXKdUkoseI4vr/GdwYCFfPjSFVkx3EusD
         LCx5CHkNsqYjPvWKrcoZQtDrpllobQnksjUWeYAPGneibLAiYaY211BxD56rmj/pWL
         B7owhhYcDy5CPuSuWDFvMv+t+g8Dfv9YBl+gmyES0riKtFzInI/ZpuWu+nvCOaJc+Y
         yM1FXBhNT4BuBK9sRQhJ/bUraW0JWEcunXiEB1EPFukV5sAwUOne5WanRariFYDXUU
         UaHSy9W9hmFmw==
Date:   Thu, 1 Jun 2023 12:17:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 17/43] dt-bindings: spi: Add Cirrus EP93xx
Message-ID: <d6bc264b-9c52-49c0-8012-b938da37337f@sirena.org.uk>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-18-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AKogeu+AvJwZdIqg"
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-18-nikita.shubin@maquefel.me>
X-Cookie: Positively no smoking.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AKogeu+AvJwZdIqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 01, 2023 at 08:34:08AM +0300, Nikita Shubin wrote:

> +  cirrus,ep9301-use-dma:
> +    description: Flag indicating that the SPI should use dma
> +    type: boolean

My previous feedback on this property still applies.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--AKogeu+AvJwZdIqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR4fkYACgkQJNaLcl1U
h9D2FQf+II4RWUC3YTpWqIDLH2ty9ClJoudhNuUP8oYmUpY2FZogg4DQ+r3a/Hxs
xEA1aTgyE2Os3RTZf+OXfZgTjHInNvb5Z5/txOUdFDuYW/Xt5NMGRCfpflrS9Y1k
NLpK/XESM3GR9+DnVJi8K44fkO9YvbuxPesZFIYAk7qFagamzOxmiqE4lvzkgPy6
Kb7ut2Hun9ZS0odsW3MOobBFeKCPxSifpinx+UdP+hw+5D6VfsF0hEfW4kp/w/6i
LSkMy17aTHGMgX/oXUHMX70Nx59pE1g5jz7oBT/p7WyQFvj/XGh89eM/4xuP0RM+
Aq9Zn0YzKwEKLdBKzObjSyuC1ptLyQ==
=bKAo
-----END PGP SIGNATURE-----

--AKogeu+AvJwZdIqg--
