Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70F170F36A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjEXJsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjEXJsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:48:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E9993
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECFE761C01
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624AAC433D2;
        Wed, 24 May 2023 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684921725;
        bh=XOfwDSgrY2BQhVwfm4T7jxksI5sC8k9yj6vj9mTkvlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8FQMMbuxu8++UlKgK+2WH+jnW7nU7KvYQ3d72jMUrVBi152HGqALC7FI6cPr629p
         kGMe23Nbzdmlh+o4Setd5gKGS5XLGdYS7LM8VIZVLpm6j6JJPKCPHTYwbNAdU0ICPk
         kn0InzG/zSzzW9zgywbBWuEM/pkS4Un9Xo+sXGx3H8CPEmnX2IczUe7IGDAoLyBfG/
         RgeNMN1LCSjHVRnV8PxIgeitELI17VBcIFc/eeZnqV/WNumZAQubxM6rTezEZvrjSI
         mvlXB9tdOPbZwOnMJcCXppkuaoFkErHSEqeQnY23fvNBoQD8XoG1NxtG4r3YnCO0u3
         r28sUd9i/COFg==
Date:   Wed, 24 May 2023 10:48:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Message-ID: <c24b2f1c-3b08-492f-954c-c4f10ae5ad81@sirena.org.uk>
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
 <00283665-e44f-457b-b2c9-1acf59d1cbd8@sirena.org.uk>
 <c37b88ae-7f54-3c07-666f-010a5fd84bd1@linaro.org>
 <d94e734c-e816-4b3f-9fb3-a6589063c05a@sirena.org.uk>
 <af7b7d4f-d7ab-b5ef-e639-9a8b13de54ee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z25BQUiQltUZUpg7"
Content-Disposition: inline
In-Reply-To: <af7b7d4f-d7ab-b5ef-e639-9a8b13de54ee@linaro.org>
X-Cookie: You will be divorced within a year.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z25BQUiQltUZUpg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 10:42:21AM +0100, Srinivas Kandagatla wrote:
> On 24/05/2023 09:57, Mark Brown wrote:

> > I'm unclear, is this a limitation of the hardware or of the current
> > Soundwire code?

> Its both.

> Codec itself does not have any private write callback to support this and
> AFAIU Qualcomm Soundwire controller does not have any such hw facility to
> program multi-registers for device at one shot.

How about the *CODEC* hardware?

> Is write callback used for both Bulk writes and multi-writes?

Only multi-write at this point but we probably should consider redoing
bulk writes to use it as well.

> Is multi-write feature of regmap bus or device?

Well, I don't think any buses that understand registers have implemented
it yet but there's nothing fundamental that means that a bus couldn't
usefully do something with multi-write.  The current users all use raw
buses that don't know anything about registers or values.

--Z25BQUiQltUZUpg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRt3XcACgkQJNaLcl1U
h9CdRgf+Nhy3duqWiV/9INno44wrOWxhqUR8tBBmnKtwdQwe1czT+kEXwFf8iJ4k
Yi6z8w3tWfDOXyW7cxhrgWqraV9oE7XMyhNK0NNx9qWR4gDWItAmxzriB67iIJnd
3wyVoz61coztitpVVkdEgI8mFqqeKluRkDxtYrWDPRSHguQtt3e+Pw+bTY8QvtvW
GDbPdrLrUSIl7ZUn/J6Rfbs6C3iuQ+6Mh8udyNIq8angXzBVT0Dyn9pKb5hjPusf
RN7PlaPjYDG00J8cg9QPhkfY9RWJs1S3JlaxBJ9lkTQx5gffEe4rPhBNkqXpAOVH
/40RVfp952NEWhOjy/LlgCwEZW68hA==
=9Wc1
-----END PGP SIGNATURE-----

--Z25BQUiQltUZUpg7--
