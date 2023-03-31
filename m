Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76496D1DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCaKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCaKOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:14:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8C21EA31;
        Fri, 31 Mar 2023 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680257341; x=1711793341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orqfeghqH4zHO2/uMXU2ntP81yDrZCI5FsJrO4csPzg=;
  b=2kLSIW0JeqEGO2YLHun7TVm0ssj2EoxV99tsHhdQ9Bs7LvviEXNLNQ3E
   noSuOT/7YjsYIh6aR2LsMfKYkVPpqB/aayG7AvdhVy0kJQgtoBW/XjsFM
   7T/kYRrRhKTIdmMr3T8iFNEizMFPsx4kRknbAbcjGsIwt87/KsPJqLeyj
   lwr8HL16riS+RAkMO7OXyRM+uBbkbSlJw3XToTAqJVXEyrkNNienynHlX
   qkRunsd00aL0lGid6EqbIoAsz40JQebHGMiNX1Y6j7jqUz5J6GNI+PS3S
   UX2gl64phLydv4tIP/RF52BqDK4PfAHQCX0EAAo2+fJWWjvQ5WwjOemqf
   A==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="asc'?scan'208";a="207166712"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 03:08:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 03:08:59 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 03:08:56 -0700
Date:   Fri, 31 Mar 2023 11:08:43 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
CC:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?iso-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <mptcp@lists.linux.dev>
Subject: Re: [PATCH v3 0/4] docs & checkpatch: allow Closes tags with links
Message-ID: <cf5a3e73-c97d-4f98-80d7-4bcc68eb557a@spud>
References: <20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net>
 <2194d19d-f195-1a1e-41fc-7827ae569351@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sMLH2/sMXXEvCsA+"
Content-Disposition: inline
In-Reply-To: <2194d19d-f195-1a1e-41fc-7827ae569351@leemhuis.info>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--sMLH2/sMXXEvCsA+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 11:39:22AM +0200, Thorsten Leemhuis wrote:

> -Please check the link to make sure that it is actually working and points
> -to the relevant message.
> +If the URL points to a bug report that is fixed by the patch, use 'Close=
s:'
> +instead.

This is not specifically a comment about your additional diff, but this
sprang to mind (again) while reading it.
I have been wondering if this sort of thing will lead to inconsistency.=20
Reports sometimes report more than one issue at once. Other times a
patch that is (intentionally) not a complete fix for the problem.
Using Closes: in those cases is not really true, as it does not close
the report.
Having a series of N patches, each of which purport to close an issue,
also doesn't seem quite right.
The word Closes has a meaning and "forcing" the use of Closes: for
reports implies meaning that may not be present.

I suppose it is true that just because documentation or checkpatch says
to do something, doesn't mean that you **have** to do it but I don't
want to be the one on the Rx side of a rant...


--sMLH2/sMXXEvCsA+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCaxKgAKCRB4tDGHoIJi
0tXzAQDYkO5GAuTFyz0Dvwf4L1NEyHqz2c9/ib0AqzTqT2eJDAD+LHrHwO6Glr7O
3EOtr+9fzQGH1+jlQnxnBRaF2dYZjQE=
=47sB
-----END PGP SIGNATURE-----

--sMLH2/sMXXEvCsA+--
