Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625F76DD96D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDKLcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDKLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E403AAE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 286C960CA3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80305C433D2;
        Tue, 11 Apr 2023 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681212764;
        bh=0QlH7LYkuY8oOCmXf3UQZzhd7H5TZf542g4qbnpMDfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sG4m8x1ieqysBBSJn6P4HnE/fw+p6JRR4BtekvMHnK9NSGgyN6nhUoTXbxqwqKZQh
         sWU7TSPsidJaqf/S5OBiKOW9gZlKfnGM7iLJUwkeG8juJKYzzYQmeCFS3RpdRsBa00
         Ij+6BsE8+aMZQliHvQEiGKeLM6wkt8gyNVFdzT4bTRlLaYkkikXd1OG6Kek5JMnBIn
         DdSPhFz5CSCoTPR8yNaeYSu9Qe6a5nu0onFr3H/8uhmhgo4bqGgnA1js5TQDEa2Gmg
         brG5JN8+a2nogmIXD8f5B+xsIJUcDOTP7HKC8P5mjfP/uyrtGZ0qbaiwji8bIkDw7F
         UNVEPyUX5CPAA==
Date:   Tue, 11 Apr 2023 12:32:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, bailideng@google.com,
        groeck@google.com
Subject: Re: [PATCH] ASoC: da7219: Improve the relability of AAD IRQ process
Message-ID: <d9dac02a-328d-485e-9aff-158852eeb990@sirena.org.uk>
References: <20230410092634.4870-1-David.Rau.opensource@dm.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6JgKId6MKfB0txCu"
Content-Disposition: inline
In-Reply-To: <20230410092634.4870-1-David.Rau.opensource@dm.renesas.com>
X-Cookie: In the war of wits, he's unarmed.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6JgKId6MKfB0txCu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 10, 2023 at 09:26:34AM +0000, David Rau wrote:

> This commit improves the control of ground switches in AAD IRQ

In what way does it do this - what was previously unrelabile and how
does this change address that?

--6JgKId6MKfB0txCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1RVYACgkQJNaLcl1U
h9D3wQf8CxeEZ+9n04Njm+X6ndWhi3heDySWcGxfJ8BmE7MrpCluRWPbSGXKfxwV
tphbZzPetgoMUJHw8XIU578Cyje4Dfc5A3FzTYH2sRTteO4AYKnhOltdf4J1JoSp
73akt5C9NyXUyh0AqfYNDTKwpmTd/eIqsP4KGMP5Rfvwg0ejfzeecDojvZl1JWdW
7dOs14xj0NNiuB2IUBdCOs7nWPlO2lWxc7Ghn4eHFYNlclC/eaMig2EbBIRt9MQ0
TLaQeE1MuuFhCtFVhnLaJxMEe9ft6WAfWMIZh8dJ46XUPe6Zd/FGVXBTjUev8v5L
wW7HqTsfG+ODchGj6iwMwYgiaflwyQ==
=V6Mp
-----END PGP SIGNATURE-----

--6JgKId6MKfB0txCu--
