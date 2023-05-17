Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F067068C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjEQM6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjEQM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:58:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165AA527B;
        Wed, 17 May 2023 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684328315; x=1715864315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pfxLDmYlNv8jVbDG1lWGXBMFuPi1LtF51GJAHyI1gUM=;
  b=IJnn/348MLwavJGFxhd07I4kEk5mYWZHeuHExXygkC7cGRgOtH1JczC0
   9ZKLu0tnglwl/2jR+B9x6kYdFZVHN55Oldg1fmK2t5LiZdpgipKPulhnL
   eBiTiK96C03Ngu/yW2cZsHx4tdgSTHp2QTGXo2MpAcqAm2gBYLLcTFXEw
   3qC0YX8ZrWsTQhQXRHltGkfPi70tyjZVbr6RKzw3fPYJYY4vNl3LnskUR
   /PaHSOR+eHwFSuicUW4izd0CeWqvvVfEG2V/4AzFJRQ9byoC7EHNxn5rC
   Fx6oEtuZRM0yoghjp2TqJpr7bdAvr9iePPqh23/MA7ekFgzPCxwDyjJbz
   w==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="asc'?scan'208";a="215881804"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 05:58:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 05:58:34 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 05:58:32 -0700
Date:   Wed, 17 May 2023 13:58:11 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] arm64: dts: microchip: add missing cache properties
Message-ID: <20230517-revivable-scuba-dc7ece33723c@wendy>
References: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
 <151169f7-dcdb-47f1-9616-67c3c388a233@linaro.org>
 <7772a5981d9a3d46056a53997162d1d75d22a701.camel@microchip.com>
 <41c72642-7d46-d7d1-d49a-6bef685f934c@linaro.org>
 <20230517-crop-limeade-73369ac8594d@wendy>
 <67bf21d4cf9573233fc8154ae73b966adba6df09.camel@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ATput7/eoNE7mQn"
Content-Disposition: inline
In-Reply-To: <67bf21d4cf9573233fc8154ae73b966adba6df09.camel@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2ATput7/eoNE7mQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 02:46:38PM +0200, Steen Hegelund wrote:
> On Wed, 2023-05-17 at 13:37 +0100, Conor Dooley wrote:
> > On Wed, May 17, 2023 at 02:10:53PM +0200, Krzysztof Kozlowski wrote:

> > > For future (and all previous patches), please think what do you
> > > (you=3DMicrochip) want to do with it. If you do not handle the patche=
s,
> > > then someone should or the platform should be marked as "Odd fixes".
> >=20
> > If noone is set up to actually be the maintainer of the tree, and the
> > patch volume is low, it might be a good idea to combine its maintenance
> > with some of the other microchip trees.
> >=20
> > I've added Nicolas to CC here, since he is the main maintainer for the
> > 32-bit ARM Microchip stuff. For some context, I maintain the RISC-V
> > Microchip bits and a few other things like dt-bindings and some
> > non-microchip RISC-V platforms.
> >=20
> > If you like, I could easily pick up patches for
> > arch/arm64/boot/dts/microchip/* as I am already sending PRs to Arnd for
> > other trees and another branch would not be much overhead!
> >=20
> > Clearly I do not know the hardware at all, and reviewing the patches
> > would still be up to you, but I could handle the "administrative" side
> > of things (applying the patches & sending PRs) if that would be helpful?
> >=20
> > Otherwise, Nicolas & I could probably help you through setting things up
> > to send PRs without taking up Krzysztof's time?
> >=20
> > Either works for me!
>=20
> It would be preferable for me if you (Conor) would handle the
> arch/arm64/boot/dts/microchip/* tree as you suggested.  It is not often we
> update it, so it will hopefully be low overhead for you.

Okay. I will send a patch for MAINTAINERS then - although I'll give
Nicolas a change to look at it this thread first ;)
If the mpu32 guys ever decide to become mpu64 then we can perhaps
re-visit things.

> Thanks to both of you for the assistance.

No worries chief.

--2ATput7/eoNE7mQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGTPYwAKCRB4tDGHoIJi
0vq4AQDam3z9mzYOVIZmJgVwduNQuHbUo0n9SYMThMhW/brX4AEAzsdg66m9cs9r
VESVBV35h+K95krEtxT7oAAGVOQjrAw=
=yRWl
-----END PGP SIGNATURE-----

--2ATput7/eoNE7mQn--
