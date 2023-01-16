Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0166C40A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjAPPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjAPPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:34:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDA22DD6;
        Mon, 16 Jan 2023 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673883168; x=1705419168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IX6MG/DkLSU/QlvZhY0E7d815jJXpDQyeiduYgOCx3c=;
  b=MIA5cfxtFtmTx2yMTwzHc2stXaNqelbOhjxIPdwVD4Z6cKWssYIdJww7
   Iz5dcNKRcOzFZWsdBwkvnNIy4QMHSaA3fa4wLSRRM7UKwxxkT1zGtVi/p
   WnW6Jjgp+L4+H/krgG3y6UfLle9M7fU8z28pECtbPQ1bMvgrhPi0qhUm0
   PMHOMUg691+jxP2YPvtwbt6OyBQ25URnraAd84tDe8u1NDZ9HTvyBY1r5
   dlmfopZAezG7wdwtmMZwxV+eSbUnrZcjBveZMjltEmQn/aVoSir3ImvS7
   x11MD9V4R8iQ9pDbCehNkQMNibBfVtV963NmH4IyyV3DZMsgMhysukg0Y
   w==;
X-IronPort-AV: E=Sophos;i="5.97,221,1669100400"; 
   d="asc'?scan'208";a="132556156"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2023 08:32:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 08:32:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 16 Jan 2023 08:32:46 -0700
Date:   Mon, 16 Jan 2023 15:32:23 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Peter Lafreniere <peter@n8pjl.ca>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: x86 - exit fpu context earlier in ECB/CBC macros
Message-ID: <Y8VuB7kmn9dQ8/en@wendy>
References: <IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca>
 <CAMj1kXGjOF7bNCS-v02aTZWmzvM-Ad-VYiNbHEmYf5RMHL57bQ@mail.gmail.com>
 <T7YG602WaDuPk4rYB6-BwCn0pdxSTJxyOR7-vs59gUu1sXMFtkbjCUd1DZ9xuFy9724II9A1qQWf0hKsLJ04qawtcrfO90FA5eYn5hyLzvw=@n8pjl.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GTFKFmdaX+KuRxuR"
Content-Disposition: inline
In-Reply-To: <T7YG602WaDuPk4rYB6-BwCn0pdxSTJxyOR7-vs59gUu1sXMFtkbjCUd1DZ9xuFy9724II9A1qQWf0hKsLJ04qawtcrfO90FA5eYn5hyLzvw=@n8pjl.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--GTFKFmdaX+KuRxuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 16, 2023 at 03:20:59PM +0000, Peter Lafreniere wrote:
> > Please don't send encrypted emails to the mailing list. Plaintext
> > only, with the patch in the message body (not as an attachment).
> > Please use git send-email if you have trouble configuring your email
> > client.


> My apologies. I was having difficulties configuring git send-email,
> but now I believe that I have the issues resolved. Future patches will
> be properly formatted.

It landed okay on lore:
https://lore.kernel.org/linux-crypto/IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca/#t

I've seen enough of these now to know where this is going, I'd bet that
you're a protonmail user...


--GTFKFmdaX+KuRxuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8Vt/AAKCRB4tDGHoIJi
0kxFAP0c0W3exQ+SRD/pD/kjDfDsSquFbKpeHbDfYfM9ZJnkHQEAvZpvA9RM967Y
lyGgBJ8TfeB4sOOicKh02a/Viogb7Q8=
=bBcu
-----END PGP SIGNATURE-----

--GTFKFmdaX+KuRxuR--
