Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187AF700D44
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbjELQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjELQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:45:28 -0400
Received: from mail.icequake.net (64-251-151-187.fidnet.com [64.251.151.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524249EF9
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:45:26 -0700 (PDT)
Received: from mail.icequake.net (aurora [127.0.0.1])
        by mail.icequake.net (Postfix) with ESMTP id AEA5ED42C7;
        Fri, 12 May 2023 11:45:24 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icequake.net;
        s=mail-1; t=1683909924; x=1684514724;
        bh=KElXq4OwK+pk7AEPmliksFgajImN6q7NU4SHNUXF/eo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:Subject:
         From:To:Date;
        b=lpJgsGLPFwIBKIherzSSVrljhxr4lmLCVyCFL/RdTBDOnXTsXhqmC/QvlbxBuzQ8y
         tx9vdjcCu41zCb7RFunErSL6IHRcL12Se//sCC6sg4JiSGerkNxrQxkp6oqNUWORFl
         NkreIVAl2k+dJobTZ5ehv+QuHdGhh8kRiCLGo54Y=
Received: from localhost (aurora [127.0.0.1])
        by mail.icequake.net (Postfix) with ESMTP id 6FEC3D4319;
        Fri, 12 May 2023 11:45:24 -0500 (CDT)
X-Virus-Scanned: Debian amavisd-new at icequake.net
Received: from mail.icequake.net ([127.0.0.1])
        by localhost (aurora.icequake.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 30pky7ZJko4f; Fri, 12 May 2023 11:45:23 -0500 (CDT)
Received: from localhost (rrcs-71-42-125-220.sw.biz.rr.com [71.42.125.220])
        (Authenticated sender: nemesis@icequake.net)
        by mail.icequake.net (Postfix) with ESMTPSA id 9B04ED42C7;
        Fri, 12 May 2023 11:45:22 -0500 (CDT)
Date:   Fri, 12 May 2023 11:42:34 -0500
From:   "Ryan C. Underwood" <nemesis@icequake.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] snd-hda-intel: Apply HP B&O top speaker profile to
 Pavilion 15
Message-ID: <ZF5seo0JPbcU7wij@icequake.net>
Reply-To: nemesis@icequake.net
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
References: <ZF0mpcMz3ezP9KQw@icequake.net>
 <871qjmar8h.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R89g+Ma61XKxmtYR"
Content-Disposition: inline
In-Reply-To: <871qjmar8h.wl-tiwai@suse.de>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R89g+Ma61XKxmtYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 10:28:14AM +0200, Takashi Iwai wrote:
>=20
> The patch seems mangled by your mailer (spaces instead of tabs).
> I applied it manually as it's a trivial change.  But at the next time,
> please check your mailer setup.

Sorry, I pasted to terminal from another system and that must have
mangled it.

> Also, please include all maintainers to Cc :)

Apologies for my ignorance, but what's the correct way to get "all
maintainers" if not scripts/get_maintainer.pl, which you said produced
too many cc's in the previous attempt?

--=20
Ryan C. Underwood, <nemesis@icequake.net>

--R89g+Ma61XKxmtYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSqqegowG2kcGXAAAMiiceeH7ruOQUCZF5sdwAKCRAiiceeH7ru
OeccAJ41DD664qHQsDBkqYgGqbGR8A4ragCePqIccuv8uSeo8B7KLqnmxvdOb8E=
=sLbV
-----END PGP SIGNATURE-----

--R89g+Ma61XKxmtYR--
