Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2FD5B77B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiIMRVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiIMRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:20:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5799A98B;
        Tue, 13 Sep 2022 09:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E192FB80EFA;
        Tue, 13 Sep 2022 16:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1361EC433C1;
        Tue, 13 Sep 2022 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663085247;
        bh=QaoiK9aHa52swA7QKWMCX1EdP80hRX2/nxRk/GpprBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKwZdm4WAYhORxtrjVWX3jK8jtUkf3+s7w9BGbo6zkFAHRSf1QOrT6JChhhPLzZJw
         TAtv7ptoZDK38BBxg2FZvgu/H9mTVqH9We4eMUIMluzyz6xMHsidjGaz2fi0BtDEmW
         +8FfilwaepdjbJuexMxP4GoFtFRPq37IrVKcPxXGpbHRzUW166rUVe2mAAsMDRmYKl
         YSw5AbQ437TAr1DyWLmfCe+Ob0MnuS8eUx9BL4p9D/12MjQorRaKyXH8lyKs47k0Xk
         y+5wCEtnGUVHKb4rwas4IoiOAg9ph9cFXrG6oIsXzFGewkl6kjfxgUXv0vm8hjP+VA
         spKB4ZGPlS9SQ==
Date:   Tue, 13 Sep 2022 17:07:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-mediatek@lists.infradead.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH 00/10] ASoC: mediatek: Set i2s clock sharing from machine
 drivers
Message-ID: <YyCquxBE3q+kOZuH@sirena.org.uk>
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <166276355052.332114.1969052042106279493.b4-ty@kernel.org>
 <96cd0c78-a76d-e32c-8f05-32e127df3fb0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SU6+datVMQKdk1vm"
Content-Disposition: inline
In-Reply-To: <96cd0c78-a76d-e32c-8f05-32e127df3fb0@gmail.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SU6+datVMQKdk1vm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 13, 2022 at 05:56:00PM +0200, Matthias Brugger wrote:

> DTS should go through my branch. We can see if there are any merge conflicts
> in linux-next and fix them somehow or you drop the patch and I take it
> through my tree. As you like.

Sorry, dropped now.

--SU6+datVMQKdk1vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMgqrsACgkQJNaLcl1U
h9D/Owf9Ed/45wBsYkHFdYgI94NFz7iEMKYxN0ldW1A09VLfXzSGfRbdW9ziBNRn
9772Ua4+Z+YUJMkSl6Y93O41N/Rpqlt91iSOnI12R8++h3rCpzjzhSM3slgULRCX
vVnAJ4W4X1ArVJLq9LAizAg4bXJqdYI8rQ2IppS1J29Kwym+/yUyZvcAsyVKIeX8
o8Py5HgC2ycUEyG46b49g7LqE5qosl179z9AtUix8LD3op2TSIfNcfxuOOM42Sbd
FHo6UbBHpMoHSIQgYRcCOcCPsiQczcdAFXThtwgJFFR5Cq0JEW5Nv1+R3DoDETdY
gSWLGLBgtmdWDlBojKg0J203ZVUFOw==
=jebS
-----END PGP SIGNATURE-----

--SU6+datVMQKdk1vm--
