Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6ED6655C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjAKIPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjAKIPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:15:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171CB62FA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673424949; x=1704960949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p31trvFFxY9NGsb5ANyo8Ra0PPLVGtTNm0Zv32+6Hac=;
  b=Ow0amwMcML1D1DUsNFzCqEix8rsK1cb0b/SuOYMvRgUE057uulOeGqC9
   vsDBV0BMvQtyTB++4H1BAm0Q7C+eDf4YFhQLKSsn6leitQQt5f5GiAtmS
   jpVwqo2cmTE+QpnHZxC+FA1l78WYaDgJqwrS+5YqOp2QjcPo46H7F7i3Z
   kFsZ60RxFZGe9boyEmvkEYngvZLuYlGZ+21R/EgfKSDMcr60At+G5uOMM
   PNhW6zDVLpVh+aM40+OxKYJO7fLKe2PDiqJK41Ywx4dU5ERhPAVq7wlCc
   V/sBqdZAY/nDrNXT/DT4VpIMePz8QXRaGAc0u6AjXZlpz8nI9yk2vHoOy
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="asc'?scan'208";a="131794907"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2023 01:15:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 01:15:46 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 11 Jan 2023 01:15:45 -0700
Date:   Wed, 11 Jan 2023 08:15:23 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y75wGwt2r8iWlCYf@wendy>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0fTjad5ULtm+9/dX"
Content-Disposition: inline
In-Reply-To: <Y53BputYK+3djDME@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0fTjad5ULtm+9/dX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

You didn't ask me specifically, but if it helps...

On Sat, Dec 17, 2022 at 02:18:30PM +0100, Greg KH wrote:
> On Sat, Dec 17, 2022 at 06:32:48PM +0530, Kaiwan N Billimoria wrote:
> > Hi,
> > Any update on 6.1 being set as the next LTS release?
>=20
> You tell me please.  How has your testing gone for 6.1 so far?
> Does it work properly for you?

AFIACT, it does. We had some issues, but they've since been resolved.

> Are you and/or your company willing to test out
> the -rc releases and provide feedback if it works or not for your
> systems?

Already do! Although so far I've just been reporting breakages rather
than providing tested-bys.

> Do you have problems with 6.1.y vs. older kernels?

Nope, anything that needed fixing that was on my radar has already made
it into 6.1.y.

> Is there
> anything missing in it that you feel needs to be addressed with a newer
> kernel instead?

Anything missing on the RISC-V side of things, that we would want, is
still a work in progress for kernels later than 6.2 anyway.

Hope that helps,
Conor.


--0fTjad5ULtm+9/dX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY75wGwAKCRB4tDGHoIJi
0pA6AQD+9VQLgcLu+K8XHYKSzCGEqgiqiWCHA799nNbuQJKU0AEA0vcM3y1r4yO+
UblrIt2uEVm+INKyygt6TxP8r9c69A4=
=eZUG
-----END PGP SIGNATURE-----

--0fTjad5ULtm+9/dX--
