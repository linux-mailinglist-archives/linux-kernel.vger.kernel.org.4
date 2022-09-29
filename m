Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E845EFEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiI2Udx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiI2Udv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:33:51 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95DF1296B2;
        Thu, 29 Sep 2022 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=4+GjA4+t+FzJUOojt9RIJscA2LdcugK+jY+KWvx9VGc=; b=GUY4j4gO6c8Nj/KLnYCcpKa/mN
        Kh7jelRHhC5GURsBbQwvuOZgWHzubD8jwPw+iPVY5nLpL5Y9jE+LNP05kuBpvF1LY9V395zwMMFBQ
        2njCRDh/UhL6z/FNqLT+OLnf9kcGE87y3Iy8SfD4pUoeBqkVlBgh6OhfiiGbMhqG0qSnHCTh/aYCD
        jMJe60bpAfuXHVI/c94vb/vgkzLg/lE6wQ6mr2bUXz76ju7uryMX8X4yYovELCXBVBZ21UG8vSq7o
        EDfghfU8so6cambSalU5n2GNDeKNx39RTG0rLd1R2GMdaQwsp80Z16wPgWiTMfYus9PC2R7KciNyO
        DpMxVX/g==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe0Dq-00DTdP-EC; Thu, 29 Sep 2022 22:33:30 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe0Dp-001WpD-2o;
        Thu, 29 Sep 2022 22:33:29 +0200
Date:   Thu, 29 Sep 2022 22:33:29 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     heiko@sntech.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH RFT 0/5] crypto: rockchip: add crypto offloader V2
Message-ID: <YzYBGQeaouraFDyo@aurel32.net>
Mail-Followup-To: LABBE Corentin <clabbe@baylibre.com>, heiko@sntech.de,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220927080048.3151911-1-clabbe@baylibre.com>
 <YzNsgjPFwVEDo4E4@aurel32.net>
 <YzVKR0DjpXT/bB8J@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YzVKR0DjpXT/bB8J@Red>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-29 09:33, LABBE Corentin wrote:
> Le Tue, Sep 27, 2022 at 11:34:58PM +0200, Aurelien Jarno a =C3=A9crit :
> > On 2022-09-27 08:00, Corentin Labbe wrote:
> > > Hello
> > >=20
> > > Rockchip rk3568 and rk3588 have a common crypto offloader IP different
> > > than rk3228 one.
> > > I started to work the driver for this IP on a rk3588 based board, but=
 this SoC
> > > is still not upstream.
> > > So it is why I send this serie asking for test since I own no rk3568 =
and
> > > I need to be sure datasheet is right.
> >=20
> > I did a quick test, and it doesn't seem to work. I get:
> >=20
> > rk3588-crypto fe380000.crypto: DMA timeout
> > rk3588-crypto fe380000.crypto: DMA timeout
> >=20
> > That's on an ODROID-M1 board, so with the set of patches I sent
> > yesterday to support it.
>=20
> Thanks for testing it, probably I did something wrong because I got a suc=
cessfull test by someone on #linux-rockchip.
> But I dont know on which board it is, and it was on my debug tree, so pro=
bably cleaned something wrong before sending the patchs.
>=20
> If I sent you a link to my tree, could you retry ?

Yep, I can try that.

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
