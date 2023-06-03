Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C972106F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjFCOVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFCOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:21:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A11E132;
        Sat,  3 Jun 2023 07:21:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9319C5C018F;
        Sat,  3 Jun 2023 10:21:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 03 Jun 2023 10:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1685802067; x=1685888467; bh=dKpv1LCqZsLda5jy30mL1GfFfsWw6vZ6LzT
        kuuwmaqA=; b=r71TgOkjHSV2LTGdDpS2uiVeegoZ6Uc0gOLW/rkZ75EdHqAJxL/
        4/36vVt8K290QV4JVB/QunHc7L/WPe/fqUpcGOSzN92Vt5TmK9zNuTDO9DKdlTMo
        oYdKJhItxUo4NZN3QdTWlPL9ds31TQeQuvakMTvPsg+WmeB8JOzSu/Ov9f0g3k5u
        0kOIIsY7IiC6oyfPEnn10HhA+D5oMlomrHcExw+OphN61GXaYokJg29uPPEmykf/
        tyMnz52vDgJueOeDYirlS6aprh10zfdLPsepri4wbIeFq6iOf0i7m5krh0VdMgQF
        +Px+bCr9R0h/5Kq2iB1YtglBc+NQvu+XmMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685802067; x=1685888467; bh=dKpv1LCqZsLda
        5jy30mL1GfFfsWw6vZ6LzTkuuwmaqA=; b=g2vSMmxAZ2PRZEjk7kxQAKxo9O4WN
        Nxz4lbaWhXwxFGS4dq/XVRqSZpXnXu0kND9dTOLT4BFc7sz4s/S/pBlu2xfIYxUR
        GkHCAGdSgL7yLGUQAxCzBYw8dvyAwMssb/3CCAfuxHgTqZ5/a3EsZfnXGY6jwVZy
        qXrvOYT2usYi8xpgRB9T/5JWy3ci5wS9VoA7NRzDQqJUC7+13aszubmP6e9lJGo+
        7pfDrNtDfCWoTxtOVnOlIntjQg71CIBNAw3Ic9z4yDY6hY6OHkuVNFKjD0VdNidt
        NNKBKyo164ddd5gaGpTWkXb3cOHFFlzPOHWzoRHYdKnsb8RH+plvhjMug==
X-ME-Sender: <xms:U0x7ZGsVYOeAWbDs1nk46HIXgXzyG0HI5ZJa7AzkM4o_2R6YfU_XVg>
    <xme:U0x7ZLdcwadrCJ-8z4uX2F4kLEtgrk4fijCq7RDjYrF999v-yDhmHkxf0fNx9l2Xf
    qCwTyovUBVxGlM>
X-ME-Received: <xmr:U0x7ZBw8tUjbukgPT995iV4dckKCc5JfHFcn8-73Mr8dv8WoS5DLh86Mhqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelhedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepledvfefgffffvdejfedtjefffeei
    heelgffgheeuledtgeeuudfhgfeltdejfeevnecuffhomhgrihhnpehgihhtqdhstghmrd
    gtohhmpdhgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpddtuddrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesih
    hnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:U0x7ZBMs37-IISWLNoVvqFhdMmKyD5sSBwOTAgwl2W20pxIP7-Q2Pw>
    <xmx:U0x7ZG-aZou-u9CsVc-14ZCUPZY5vRkDOq91hYGkUm1HNWKogihZmQ>
    <xmx:U0x7ZJUXqqow6Jo83o1vGGZsied59AMjkWMvfLEgUhC5VLpIfZK0sQ>
    <xmx:U0x7ZKawqUmxfvqBnMb4by8tKEeMdUamfrnkuHWLPxC-02xyLSbOiQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 10:21:06 -0400 (EDT)
Date:   Sat, 3 Jun 2023 10:21:02 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     kernel test robot <lkp@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4/6] device-mapper: Avoid double-fetch of version
Message-ID: <ZHtMUfaiTbOGnDnN@itl-email>
References: <20230601212456.1533-5-demi@invisiblethingslab.com>
 <202306031511.xIeQ4BQz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X0fO6tZZv9iIK6Ht"
Content-Disposition: inline
In-Reply-To: <202306031511.xIeQ4BQz-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X0fO6tZZv9iIK6Ht
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 3 Jun 2023 10:21:02 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: kernel test robot <lkp@intel.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/6] device-mapper: Avoid double-fetch of version

On Sat, Jun 03, 2023 at 03:40:09PM +0800, kernel test robot wrote:
> Hi Demi,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on device-mapper-dm/for-next]
> [also build test WARNING on linus/master v6.4-rc4 next-20230602]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Demi-Marie-Obenour=
/device-mapper-Check-that-target-specs-are-sufficiently-aligned/20230602-05=
2741
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/lin=
ux-dm.git for-next
> patch link:    https://lore.kernel.org/r/20230601212456.1533-5-demi%40inv=
isiblethingslab.com
> patch subject: [PATCH 4/6] device-mapper: Avoid double-fetch of version
> config: x86_64-randconfig-c032-20230531 (https://download.01.org/0day-ci/=
archive/20230603/202306031511.xIeQ4BQz-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306031511.xIeQ4BQz-lkp=
@intel.com/
>=20
> cocci warnings: (new ones prefixed by >>)
> >> drivers/md/dm-ioctl.c:1900:42-48: ERROR: application of sizeof to poin=
ter

Ugh, silly mistake: I changed an array to a pointer but did not change
the sizeof.  Will send a v2 with the fix.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--X0fO6tZZv9iIK6Ht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmR7TFEACgkQsoi1X/+c
IsGh5g/+PSVo2QHxj3XAzYLyxiIgG6cPSNjCO7JB40lmB7BKw3e1l3CjEEq+bE1D
4xYlz+ohkPT4o0/z/OTbG9jSG+/4TVpITDqdXEapZX9uo4Gt9IL8ylVykb9SsQml
DLsPuG4m3SqMms4Nu3Em8uNkxocooeH6kwTvBzOOnfA+O3laEUpikoeR9nxdlYec
fE9+ujmRQc/kfeaJsAhX8YEAD+N9oFT9F3VaDChlhuctF4AGN38BYvuWHjHYDwx6
VCoo1BCmZHk3r1+VSlZsxtN3xKzHZF1LVTcpNXweBfPaCC9+dLdJBZUuefIqFLdT
o3kGc4dG4ciAb8XA7SwS/iWmMG9kk0hCFbmb3RqCHq+2qU1XPfgr2EuzU9Mf3J+K
9iHmgtPy9UqdslpX8MLw0ymWS2rrTuHy4p+afpoFebdDDhTM86BSo3nk31jtsxJB
dNPtVhMSNuj6+BX87p6NVrfrEHYrMaqnCHO/EdYICzooJT2pWzNYmS99ue+xVkTT
JPAOiRDM/Sgwx2PYbUl9GLaXsOmVnp+YV3aVB9Vey3i37n9+dShNYATem0iLxgex
iWM49YFFPBIIWHIvwM3+CP23P2nMY5FnCmmNA10Otb15EwDgBq4xWev3AkmUWQ+F
pMkDa08A4vPmO3jl95jGA1mrmAmaDJp+paNajVLWugk1mnz/B3c=
=ufIA
-----END PGP SIGNATURE-----

--X0fO6tZZv9iIK6Ht--
