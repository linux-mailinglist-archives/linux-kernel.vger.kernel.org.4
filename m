Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F876B963A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCNNaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCNN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7A99251;
        Tue, 14 Mar 2023 06:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A68A6177D;
        Tue, 14 Mar 2023 13:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68B5C433EF;
        Tue, 14 Mar 2023 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678800402;
        bh=rfEnNx/AtmKQ6+j2cB2Tu1ghvgv+nXYlVjsWMHYFeWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQdvzfIbZzXtrHVHeJg8joac91CkFNUhUzka7UIgOQ3I0FVOwkfTcWeroLJ31/N7O
         01OIfdO5oayYpm8+UDO0/KWpqhZlwRH++bOxN+0CTXQ6T/vAaAhHIWq3PWORYgNdu+
         z8HPP+L3vWZpC3QqInApRRu4W0ND12eVv9xd3zqw9nh3ErFL+dJoUC2MTlBkeIT8mz
         yRgg+BoDNQO8M885SHiRpZ4NlCsM74IxZcOG+swSKa0mEd8MzUkgN3Wh2np3OsVUhq
         wKWf8t4NW/4d/W9C03p5tiQl8tBdkxFnmud7ENuSVhpviYrfKxe4rpki0XfhGzz31+
         O0suXgkmHMBgg==
Date:   Tue, 14 Mar 2023 13:26:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 01/16] spi: armada-3700: Drop of_match_ptr for ID table
Message-ID: <5782b7a2-3942-4bed-9a70-55a43833f69c@sirena.org.uk>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
 <7a65d775-cf07-4393-8b10-2cef4d5266ab@sirena.org.uk>
 <08e98d1d-e79b-fe7e-0d59-827f72277fc5@linaro.org>
 <9bf3dd37-71c2-4118-a8da-40e656b42d10@sirena.org.uk>
 <ed293caf-e787-a29e-f1c5-bdcaf1aa483a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="elD8KD6t7+wRv3Op"
Content-Disposition: inline
In-Reply-To: <ed293caf-e787-a29e-f1c5-bdcaf1aa483a@linaro.org>
X-Cookie: For office use only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--elD8KD6t7+wRv3Op
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 14, 2023 at 07:44:04AM +0100, Krzysztof Kozlowski wrote:
> On 13/03/2023 20:22, Mark Brown wrote:

> > If that's the case then why are you adding maybe unused annotations for
> > half the drivers rather than removing their of_match_ptr() usages?
> > There doesn't seem to be any logic here, it's just randomly making
> > changes as far as I can tell.

> These are not random but depend on whether OF is the only matching
> method or one of few. Although for IIO all of my patches would be
> dropping the of_match_ptr... For some cases in other patchsets I added
> __maybe_unused also because of_match_node(), when the table is not used
> in driver of_match_table.

This logic is both not apparent when looking at the patches and doesn't
move us in any particular direction - I'd expect this stuff to be
written the same way for all drivers, there's no reason for it to vary.
That just adds complication, it's more random obscure rules people have
to learn.

> > The PRP0001 stuff isn't an issue, of_match_ptr() can just be changed to
> > do the right thing for CONFIG_ACPI.

> That's actually interesting idea, kind of obvious so I wonder why it
> wasn't done like this in the first place in 886ca88be6b3 ("ACPI / bus:
> Respect PRP0001 when retrieving device match data"). Maybe not to
> populate OF device ID tables for the ACPI systems which do not care
> about PRP0001?

Or just it didn't occur to anyone at the time.

--elD8KD6t7+wRv3Op
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQQdgoACgkQJNaLcl1U
h9Anagf/THfRG/RbMsHxaqKJsYsu8z++5R15gbuBbWAl1XHrOE03sdWawbw9nx6/
7FjyWP0YguU7o9glL92CdGxV9CSl2mMJw06/Mvasde/AqKVs1hIrTEBLc8esfnmK
y/l3de8OGXwYRz7UontPhCtwqNjdwza95hPCqQNLi1LhQ8DwEK9TIRvpfsD15NfI
p+M8l80hFu85Hz+2LrWrmgcbQwuvowzOGYminHMypypU2qkEka6P8Avhuz9sB6Jj
H1qukPGKGE02cXrtNfCG6DPdWzp2vPcIzeyFSendbDtHhlOets4W06I02bN3bFD8
VlVyWgaICjPC/DjVXOuTe1yovomvig==
=lrkL
-----END PGP SIGNATURE-----

--elD8KD6t7+wRv3Op--
