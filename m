Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA3636CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKWWBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiKWWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:01:15 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFE2ECCFE;
        Wed, 23 Nov 2022 14:01:10 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 91CFD1C09F9; Wed, 23 Nov 2022 23:01:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669240860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q65EMJnwcuNJS6WHzM0LQX+f1I0sGP+f67KLpa3vbZE=;
        b=IG0Y0wHqiAgKueehtVZeBYE4TV6104FF7i3Cf+qplvTduvnvJ7kiEMEKG+8N8gEXh3jbPa
        d+PdEBWC9aVSxLvk4WtE07IhWHSXhEtx/DUniJVDa/mOZOEAf+51pmgJgAvgIEQHkHsdm3
        EJO31VjUIi8ynXq4xsvYJ9jDiYHzAbI=
Date:   Wed, 23 Nov 2022 23:01:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Eric Blake <eblake@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: nbd: please don't spawn 16 threads when nbd is not even in use
Message-ID: <Y36YHNVmbozzSdxH@duo.ucw.cz>
References: <Y3y4+QqOlF00X9ET@duo.ucw.cz>
 <20221123200845.cuct5euvikqksojm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eZEEPNQ49Z9vZpD+"
Content-Disposition: inline
In-Reply-To: <20221123200845.cuct5euvikqksojm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eZEEPNQ49Z9vZpD+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I see this... and it looks like there are 16 workqueues before nbd is
> > even used. Surely there are better ways to do that?
>=20
> Yes, it would be nice to create a pool of workers that only spawns up
> threads when actual parallel requests are made.  Are you willing to
> help write the patch?

I was thinking more "only spawn a workqueue when nbd is opened" or so.

I have 16 of them, and I'm not using nbd. Workqueue per open device is
okay, current situation... not so much.

      	       	    	  	  	    	     		Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--eZEEPNQ49Z9vZpD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY36YHAAKCRAw5/Bqldv6
8tYzAJ9XeuHxOzeqq2h6cNWDEpX8sxtKMgCcD6V7OICwJACN3mYJp/TZEwnnrV0=
=kZvb
-----END PGP SIGNATURE-----

--eZEEPNQ49Z9vZpD+--
