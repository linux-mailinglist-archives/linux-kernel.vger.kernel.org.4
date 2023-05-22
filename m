Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE770BF47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjEVNKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEVNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254292;
        Mon, 22 May 2023 06:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC3F96144C;
        Mon, 22 May 2023 13:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70FDC4339C;
        Mon, 22 May 2023 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684761043;
        bh=Q6nXsGuYfXF82B6FIh74i5ECEIvwWrfYD9ajsFfKZBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhiC5dFtgZii/kGOkEqpVZsjEENlc24xthUKpATgER4t2rOo7aYz+8mAI8bojgu4T
         uKrzvjYn+Y9CMKALXlJvqrLOZTApT8u9Iaoh1BsZXLcGIi3LdboT7oODyHP9BjCPhD
         2YLjB2YwKbYaqeLp4d4OkBJAWdSr/USnRzYw2ZLPSnJgzBAb7Q9gHkvwroSdcEDqFV
         ESec46JeLlhMbW1QI0W6T3WzEfvdCwlV4ovs79NKNlVqg6iPhZWo3NC0fnC7QT+95d
         GNP6K8mOFH3pvyXaN7CKzBv61njnfUAqL/G0x0UIZyX7JY2e1bXHtAOrFlJrh7lrVm
         vIlbeH950pCMA==
Date:   Mon, 22 May 2023 14:10:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v11 0/2] spi: loongson: add bus driver for the loongson
 spi
Message-ID: <9f6672a2-4a39-4a34-9c2a-0257b05c9699@sirena.org.uk>
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <3c15d22f-4f94-4cc5-96a8-f565e58c66b9@sirena.org.uk>
 <4dfa5245-d330-f432-e81e-163053687d42@loongson.cn>
 <a4afd330-6ffd-432e-a868-f8a19fddb47d@sirena.org.uk>
 <1e8c3e92-4043-11f2-e7a7-0bf4273c65d8@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LylT5SjI1jBuapnp"
Content-Disposition: inline
In-Reply-To: <1e8c3e92-4043-11f2-e7a7-0bf4273c65d8@loongson.cn>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LylT5SjI1jBuapnp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 09:07:47PM +0800, zhuyinbo wrote:
> =E5=9C=A8 2023/5/22 =E4=B8=8B=E5=8D=887:56, Mark Brown =E5=86=99=E9=81=93:

> > What's causing problem is that you patched MAINTAINERS in both patches
> > but also used the wrong subject line for the first patch so I was having
> > to fix it up by hand every time.

> spi series patch apply failed,  then I have a look about your spi ci
> tree and that what I need to do is just change the title of [1/2] patch
> like this in next version ?  Correcting the title can solve the problem
> of patch series apply failure in your tree ? actually, I don't reproduce
> that apply faile issue in your current spi tree and for-next branch.

> spi: add loongson spi bindings

That's a good title.  The patches get reordered in the mailbox when I
rewrite the title prior to applying them.

--LylT5SjI1jBuapnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRracwACgkQJNaLcl1U
h9CKpgf+LMM6O00gE10SHDrZBRPdS+b0o9Y4hXcQsAKCjFi7yXfgasUsLgFi7nJn
Qwve17EyC0vLxerRCqMVi1t+N9PTowFumbQKwSJRoRTiHsdu7rq75KoZZkoCg1X1
UpGVJPiHyCTeV3OcncIBmguhM5a2XIX7JlJttk0KvCHSklOeIDB0aQmhtO2MEVb3
jM8CGUNXGreo1aQml03BtNS/pVxx1sn+DG05GK2j/uGzQtpQObbScZHNAXDgFrIZ
VOaIQsLcShlnHMRRvWMvP630q9+FJK8GQkbCPWTNa7iEyHg+4WvH57EVIvXkF/qV
YD+g4W/Pa4Y6YTlWs1tZ8VieT/21kg==
=hsT5
-----END PGP SIGNATURE-----

--LylT5SjI1jBuapnp--
