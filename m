Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E7712E19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbjEZUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjEZUT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A2198;
        Fri, 26 May 2023 13:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF0586534A;
        Fri, 26 May 2023 20:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2169C433D2;
        Fri, 26 May 2023 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685132393;
        bh=AgbhjS0GDCsub3YYcu69LdZzREsbk406Yh1DCaZiz0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpi2urDwFZlgsqEzss8gGLT/9RMTNw9+WQe0f63xxp+jFF4Z7qf9R76hLxFX7a9Hq
         +mUWAbfveDPUwHVzeNKFm55rhN651loxwIG9mgStHH5SLKUDnnFElX3VfkYIvviU2l
         QJ+A/C/Rqz+JVyeXOKvlQk56XHIILmsslbW7lFqZU9F6kTPRJH3+bx8ySclXO9kCQl
         8uSO+U6oWNCpcTCjnbgLoiduCeZjRz4jSK/Qc+t1Muqv7n7zh32fPwO4N9xkRn2m0n
         iE2emh/j+k5FdBowS52Zhog4HQo5M2yTHhgVcMnUxS3RhrVl6aDFi5FgBT/MjVepUa
         xMDwa+P4he3Ug==
Date:   Fri, 26 May 2023 21:19:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: media: camss: qcom,msm8996-camss:
 Add CAMSS power domain
Message-ID: <20230526-street-pox-2ff5ee106c43@spud>
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
 <20230526180712.8481-2-y.oudjana@protonmail.com>
 <20230526-obstruct-venus-5833511a58af@spud>
 <838b134d-46cb-6237-49b0-0c287141ebb3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UjCFKO2thr+dq+dl"
Content-Disposition: inline
In-Reply-To: <838b134d-46cb-6237-49b0-0c287141ebb3@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UjCFKO2thr+dq+dl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 09:05:47PM +0100, Bryan O'Donoghue wrote:
> On 26/05/2023 20:46, Conor Dooley wrote:
> > > +  - power-domain-names
> > Why is this now required?
> >=20
> > Thanks,
> > Conor.
> >=20
>=20
> Its an accurate description of the power/clock tree to have the top power
> domain be switched on prior to the clocks that depend on it.

But what does that have to do with the *names* now being required?

> I think Yassine, you could probably include the majority of your
> cover-letter text in this commit to explain this change a bit better.

I think it would be good to have that regardless.

Cheers,
Conor.

> bod
  ^^^ I've been trying not to think about rugby since the weekend :(

--UjCFKO2thr+dq+dl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHEUYwAKCRB4tDGHoIJi
0mVHAP9TYs3pHgCu5GdkyYe74/LeC+lid58dBEnBbHUtMU7LtAEAwtQqhGgUTuUq
DL8qApZQrWSW+Cutl3RmzMJFt1jwYgw=
=+F8y
-----END PGP SIGNATURE-----

--UjCFKO2thr+dq+dl--
