Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8975C72AC40
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjFJOYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjFJOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:24:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F01E5;
        Sat, 10 Jun 2023 07:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57C5160E26;
        Sat, 10 Jun 2023 14:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA2BC433D2;
        Sat, 10 Jun 2023 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686407069;
        bh=nrYgj3koXJKYAk0s0notSidtVGUhTbIO5OOV/U6xp1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAYLLruzhabh8clfFTd68mfgJB/Lnc8TWBL7aKyZhLhuzcFDKP2i6epz42IuMIe6z
         PFjXdJ2d5zxSxBgFb8YnZYmt4VgyzKhyK+lwM4dfYPP+3g2hRthNKV0h2L9zhMp5E8
         w8k3FpQYmS6TChWYixPxgCiX0l1J/wlv/jGxeWRJfzS7GP67BOksecQSxBAzXtce8k
         JIpKpG+tOM4vO6o0EcS+NrGQP5NCq43Dt3eUp1T3TpYuv293B6ZswMHsHO1F4WmfZt
         wstP8yTEc0mnEzHCrK6Pu4lhpMmS7uzUUP/F0rOULLE4dmyXSHHWUR5/S/jQBlLgHm
         dq4amP0i03ItA==
Date:   Sat, 10 Jun 2023 15:24:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] hwmon: Update single register drivers to use maple
 tree register cache
Message-ID: <da6696d1-7b3f-4366-a0a4-e2f7bafe8cbf@sirena.org.uk>
References: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
 <e2c965e9-3bcb-5857-087a-9e457040ab88@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2Z8lOuw99vqriu3A"
Content-Disposition: inline
In-Reply-To: <e2c965e9-3bcb-5857-087a-9e457040ab88@roeck-us.net>
X-Cookie: Sank heaven for leetle curls.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z8lOuw99vqriu3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 10, 2023 at 07:15:48AM -0700, Guenter Roeck wrote:
> On 6/10/23 06:59, Mark Brown wrote:
> > A number of hwmon drivers only support single register I/O and therefore
> > gain no benefit from using the more modern maple tree register cache
> > over the rbtree cache, convert them to maple tree.

> "gain no benefit from using the more modern maple tree register cache
> over the rbtree cache, convert them to maple tree."

> Is that really what you wanted to say ?

Sorry, other way around - gain no benefit from using rbtree over maple
tree.

--2Z8lOuw99vqriu3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSEh5gACgkQJNaLcl1U
h9BJZQf/W7qio5KlQp7V3+r/EsLMiTpgToICRoR/AW99rDRdedLfuRW5mQgtJ9G7
hoKa/FE7oN5/ol552pib04G+hFh7IxgtdLJz6pgtMC2DEHXGY2JXJDkEkWdqljt2
wVRVUS36iJyWGu2X6zPQj2+QkmglHkHM0/SIHro72ZajKS5QIWpXiK9dIqPfQq04
RnlEWjTalCR/QG1wjE9nK9FvbhRHj0+X50NKXsDivQUEr3clj1ELcPrjdS36yeAO
wKEzjVUpt0Ub9li30FcQsDg4YpNDifzg9JCZInBE18UJPjn6QhwQ20cHoz+JhPpK
KzLGIZH5V+HlT/phrQMaGq4oAnk7Gg==
=ic+0
-----END PGP SIGNATURE-----

--2Z8lOuw99vqriu3A--
