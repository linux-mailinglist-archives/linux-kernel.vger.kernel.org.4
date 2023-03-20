Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B8C6C1BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCTQgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjCTQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:35:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749F112046;
        Mon, 20 Mar 2023 09:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A147CE1307;
        Mon, 20 Mar 2023 16:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758DDC433A0;
        Mon, 20 Mar 2023 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679329744;
        bh=kjNE+xZqCrD8iMoVdwZ7yuZZfBEJymUt10XwIxYh2IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vv4sNgoQPQYZIt80kDvbscTGV8EyAOBLnvQJNKOVjOIWof8MSUsP1pcxCF0mz9ilD
         QdNVhF/zy/ob6sZsf7Np9llMREtIsDd3VQEp4F26Of52jZ44R5ryPsOTBtdIMQ1AE3
         8dugyBf2AOcS1qqBnqPzyb8hdBKvxChJ65hR7ns4FF8TnD9anxfVvrRrE8LbXM1ve5
         QeLODxSRqLl/EnwXRwUB96JZfcfb4trlUcc8RSaE5/6lvDa6NAaYzoT08VoT55/Onn
         37iXDFAs1+YyXU9uqijre8jtsuOUDS2/Zhf52EXBvYN8x3ECX6pphoxUdsqZ4YacrU
         +51lo3tKKklTA==
Date:   Mon, 20 Mar 2023 16:28:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 02/11] dt-bindings: serial: snps-dw-apb-uart: Relax
 dma-names order constraint
Message-ID: <3f544569-553c-40c5-9d9a-31dfc48d06a4@sirena.org.uk>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-3-cristian.ciocaltea@collabora.com>
 <3679f2d0-55f0-1710-abc2-b268b6fc6969@linaro.org>
 <167904851367.26.16449705310108549543@mailman-core.alsa-project.org>
 <20230320155812.GA1755078-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SSpxkFyPmL3iEqN+"
Content-Disposition: inline
In-Reply-To: <20230320155812.GA1755078-robh@kernel.org>
X-Cookie: Keep away from fire or flame.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SSpxkFyPmL3iEqN+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 10:58:12AM -0500, Rob Herring wrote:
> On Fri, Mar 17, 2023 at 12:21:41PM +0200, Cristian Ciocaltea via Alsa-dev=
el wrote:

> >  dma-names order constraint
> > Message-ID: <8ae57fe3-56aa-7e50-3eaa-a12a40657baf@collabora.com>
> > User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
> >  Thunderbird/102.7.2

> There is something strange going on with your mails as there are 2=20
> copies in the archives with the 2nd one getting the header twice. It's=20
> coming from the alsa-devel list.

This is probably caused by alsa-devel, it'll be mailman rewriting bits
of the message.  There's stuff coming up with other people's mails too.

--SSpxkFyPmL3iEqN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQYiccACgkQJNaLcl1U
h9AWWgf+NrPa0MYP5i63yT+84rj5CMEVq9erNCfVLLi4aX7Rk2t3p7OHm6nPT5iH
nEuh1CIOa+avBw3wouVQt6nokWi+mq6QbmYustWX7hPq0Gz2FRTJyXl78DNWj8Ys
fZ4osjdXbr7f0Sa5lZVvImuVpGh7z03Fg9XbLkMXt7FDacubv1DY6RwJdphesoG7
C99xjwHv55veTyp/QbwCuyctpKWo1Dn4HvkL8XU//892rRaHt6enBBju6DWo8GTF
tr89XuM3flXYbOGumon2KSlsbzAXV7QKwnK9RCPsLaXuvO36PRBMippV/VmwnJCh
dYBmTNrePnumx6r2BbCzk0Gx8LMfdw==
=+3s7
-----END PGP SIGNATURE-----

--SSpxkFyPmL3iEqN+--
