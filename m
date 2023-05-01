Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E286F3090
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjEALv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEALv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 07:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E8F118
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 04:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2029760DD7
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 11:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD65C433D2;
        Mon,  1 May 2023 11:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682941915;
        bh=PTUqml0KfqhJWIeXuByhnhJKI3zhK3+wmQdyCWWC3EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcvXXDaVbwhEyH6POjahCb0dacnt3BwqfxUx7gQUYEPMUDfSxOTc8jao38qfMTJOp
         65gmkXiMSxb616qP+iMTrqyXG8pm9N6rLc0kLPAfz1T8elAmSzRjF1L14NKCh8GyZ0
         WZboT+B4ZOycuS+ZrvBUssys3U5PDgQxqFXRzQHeAFs3nxOKi5ElYPKGY9E5mwNbLb
         zgxmRqGGMQUgYwCSYj//GVzOITdRSrqTWdLzxouRKE01cBITvL9g8DhOkN16t8jK8N
         pnoazmVlJiPgvJvWMEZ1xNT8rkpaVVNZ7jAU3o4m1gFGLMFFlkFBid1ndR0vzQkoRl
         QBvdpQx10Gdug==
Date:   Mon, 1 May 2023 12:51:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yangyu Chen <cyy@cyyself.name>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>
Subject: Re: [PATCH v2 1/2] riscv: allow case-insensitive ISA string parsing
Message-ID: <20230501-chosen-aliens-31d8bf864c22@spud>
References: <20230428141601.678489-1-cyy@cyyself.name>
 <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1JCA6WPwtEwqPNSb"
Content-Disposition: inline
In-Reply-To: <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1JCA6WPwtEwqPNSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 28, 2023 at 10:16:00PM +0800, Yangyu Chen wrote:
> @@ -205,7 +204,7 @@ void __init riscv_fill_hwcap(void)
>  #define SET_ISA_EXT_MAP(name, bit)						\
>  			do {							\
>  				if ((ext_end - ext == sizeof(name) - 1) &&	\
> -				     !memcmp(ext, name, sizeof(name) - 1) &&	\
> +				     !strncasecmp(ext, name, sizeof(name) - 1) &&	\
>  				     riscv_isa_extension_check(bit))		\
>  					set_bit(bit, this_isa);			\
>  			} while (false)						\

I was doing some poking in this area the other day & noticed that the \s
being misaligned isn't just the diff's fault and they are now misaligned
in the code.
If you are re-submitting, then I think you could align them.

Thanks,
Conor.

--1JCA6WPwtEwqPNSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZE+n1gAKCRB4tDGHoIJi
0v6lAQChAe/yJ4cHi/l2cp8YBucpqz62jqpHexJm2U3KsYSaHwEAylnjecClaueT
nQCcOTduxbsZRr0VzwpZiHfG3MGSRwA=
=9WPD
-----END PGP SIGNATURE-----

--1JCA6WPwtEwqPNSb--
