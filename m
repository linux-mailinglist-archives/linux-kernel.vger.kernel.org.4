Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7EC73FDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjF0O0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjF0O0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4C0270F;
        Tue, 27 Jun 2023 07:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42F3D611BD;
        Tue, 27 Jun 2023 14:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F031BC433C0;
        Tue, 27 Jun 2023 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687875966;
        bh=uDJwemZzdMrOBvxK/AXpAI2LRxFTXEFs44rnTL8ZOZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEdXUCDuqP2Dm8vOi1EYAJBeECL8d/BnYXnLZ0oLD0u3fDKvvNPBeJaFYR0St/nvq
         Idxh3zi/j9KFsoEp8OTS9nIvyI4cOu7pCEt8otBg+ycDND2/5r6gJhjUrT9iuOaTCW
         MLZ9pMTximAMwn+DLFvrZMxKBUixwP4II6MbiSnfFywq4vfmTj+IfPL/P1XLRyJ1MS
         lH2wYIWvnqqieue0s/a2admPtEfAhBwNsJ+nDiTnUfUslO6txDMGBbqTCJ7oRYZpMg
         WixZId4LkT/yIiMe6eHWtg/xjS18ySpW56fRY0od13XApFDCKp4niiWvmXaTrgbP8v
         R3t8nX2nNoIuQ==
Date:   Tue, 27 Jun 2023 15:25:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <100c68b2-94e8-4b14-87e5-2579e32690ad@sirena.org.uk>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-6-okan.sahin@analog.com>
 <20230420103438.GI9904@google.com>
 <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
 <20230421073938.GO996918@google.com>
 <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
 <MN2PR03MB516860989BD8ED6AC9A767FBE755A@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230621171315.GL10378@google.com>
 <20230626175443.GA3446604-robh@kernel.org>
 <20230627135615.GF10378@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="12/sRpg/phEKl7LJ"
Content-Disposition: inline
In-Reply-To: <20230627135615.GF10378@google.com>
X-Cookie: Money is the root of all wealth.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--12/sRpg/phEKl7LJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 02:56:15PM +0100, Lee Jones wrote:
> On Mon, 26 Jun 2023, Rob Herring wrote:

> > The whole series has all the acks/reviews needed for you to apply the=
=20
> > whole thing, so why not take the whole thing? Plus this series has been=
=20
> > sitting for 2 months. Not a great experience for submitters...

> Patches are missing Acked-by tags.

>   Reviewed-by !=3D Acked-by

> I cannot merge other subsystem's patches without and Acked-by.

Things should be OK to merge if they've got a Reviewed-by, that's
generally treated a lot like a stronger ack and people won't tend to
bother with an ack if they've done enough that they're happy to do a
Reviewed-by.

In any case, there's no need to hold all the bits that do seem OK for
some leaf driver that has some problems, the leaf driver can always get
applied incrementally either in the same branch or in another tree based
on a cross tree merge.  That way the bits that are fine can make
progress and there's less people getting the resends of the bits that
still need work.

--12/sRpg/phEKl7LJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSa8XYACgkQJNaLcl1U
h9DCtAf/dIu/8hV1d6moGpMw2IIza17xHbBQfMN4qTjMGfkXqadno+1s9FDDyfa6
3/EAtmM86dfgix6p+NbmD0EJEIFvUJqE4+gRSWsa3sGMznXwxj8vRJLDrQXG4Yce
/AzubINZ50r08aNaDCS/6QQLqxFQjRu+Jm9trF4Pn3nyEoO4/RG1qM2rsnGPaDZE
5/+a2DKRgan/xniWIXw451/n75k8zRSPMlfNOV5hJswoljr5ypDwBOtLKWa6iQHk
zHcgOql78+LUeSDALWjwrwOTBCjd/BLzt0DQzDRy8yDjacw3qIVk/TOwlafJeuze
bkd07euBxNOcaCZ1M9004Q77sylAxA==
=DUXT
-----END PGP SIGNATURE-----

--12/sRpg/phEKl7LJ--
