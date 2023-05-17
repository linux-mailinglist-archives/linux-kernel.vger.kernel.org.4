Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3CF706841
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjEQMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjEQMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:38:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1DF1FC2;
        Wed, 17 May 2023 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684327080; x=1715863080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZAc8UZBnPA9G5xnAwnyTPJtAKVlqjek6oR6R5rx42aQ=;
  b=GJp77CWrdwZwwI3ta2kUDfZrgyV74oHd+dSYFPHzXtggytmex3KvPmQA
   y2ef4kcniWYO+22o2rw9sG0RZ/7kTrHPhaBc2sve3xm9c3qZwj5aS2nmJ
   LkB89J/lL3Z8k2Rs8AMGRnLMtIGPbD/D9QNqvpstFOiYI1AyFqY2DXxGf
   rXdUzVKhv1k/4AcYElD6Xrb2qmO8Ont5o+dye+5//08S7CrKfA+vW6il8
   VkY4lMRtRtE+xh4wsSlOQZCqAUFfGSCxfLIMKkxu+k+TPSZawlN1gjm1X
   65vyydSVD3NLCixwNXR+IAIVPugxbInPoEeyUs+EbIw2bnt60Jhalfcby
   w==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="asc'?scan'208";a="214275079"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 05:37:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 05:37:57 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 05:37:56 -0700
Date:   Wed, 17 May 2023 13:37:35 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] arm64: dts: microchip: add missing cache properties
Message-ID: <20230517-crop-limeade-73369ac8594d@wendy>
References: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
 <151169f7-dcdb-47f1-9616-67c3c388a233@linaro.org>
 <7772a5981d9a3d46056a53997162d1d75d22a701.camel@microchip.com>
 <41c72642-7d46-d7d1-d49a-6bef685f934c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yBk2dQgk9ssUKrBX"
Content-Disposition: inline
In-Reply-To: <41c72642-7d46-d7d1-d49a-6bef685f934c@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--yBk2dQgk9ssUKrBX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, May 17, 2023 at 02:10:53PM +0200, Krzysztof Kozlowski wrote:
> On 17/05/2023 13:38, Steen Hegelund wrote:
> > Hi Krzysztof,
> >=20
> > I would love to do that, but I am not familiar with the procedure, so m=
aybe you
> > could help me out?
>=20
> Hm, there is no dedicated maintainer for Microchip ARM64 platforms? I
> mean one which actually handles the patches?
>=20
> It looks like it, because my recent changes were going through me. This
> also means that maybe several other changes got ignored. For example:

Aye and the branches etc in the repo itself are all a wee bit stale.

> > This is my understanding of what I need to do:
> >=20
> > Clone the upstream repo listed in MAINTAINERS:
> >=20
> > git clone git@github.com:microchip-ung/linux-upstream.git
> > cd linux-upstream
> > git checkout sparx5-next
> >=20
> > Fetch the latest mainline tag from upstream:
> >=20
> > git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git tag\
> >  v6.4-rc2 --no-tags
> >=20
> > Rebase the current branch on top of that tag:
> >=20
> > git rebase v6.4-rc2
> >=20
> > Use b4 to fetch and apply the mail thread patch series:
> >=20
> > b4 shazam -tsl 20230421223155.115339-1-krzysztof.kozlowski@linaro.org
>=20
> You should collect some more patches... For one patch it is probably too
> much effort. I can take it instead.
>=20
> > Tag the current work for inclusion in the next kernel version with a de=
cription:
> >=20
> > git tag -s sparx5-dt-6.5
>=20
> git tag -a -s sparx5-dt-6.5
>=20
> Because you need to provide some explanation. Take a look at examples
> from other sub-arch maintainers what to write in the tag:
>=20
> https://lore.kernel.org/soc/20230410170233.5931-1-andersson@kernel.org/T/=
#u
>=20
> https://lore.kernel.org/soc/20230405080438.156805-1-krzysztof.kozlowski@l=
inaro.org/T/
>=20
> >=20
> > Push work that to the public repo:
> >=20
> > git push origin sparx5-dt-6.5
> >=20
> > Create a pull request (to stdout) to be included in an email to the mai=
ntainers:
> >=20
> > git request-pull v6.4-rc2 origin sparx5-dt-6.5
> >=20
> > Send this PR to the maintainers and CC co-maintainers.
> >=20
> > Is this the correct procedure?
> > Who should I send the PR email to (is there a list somewhere)?
>=20
> Yes, it's correct with few nits I mentioned.
>=20
> You send it to arm@, soc@, Olof and Arnd. Addresses are in examples above.
>=20
> I will be preparing today the pull with various cleanups for arm-soc, so
> I will take the patch if you do not mind.
>=20
> For future (and all previous patches), please think what do you
> (you=3DMicrochip) want to do with it. If you do not handle the patches,
> then someone should or the platform should be marked as "Odd fixes".

If noone is set up to actually be the maintainer of the tree, and the
patch volume is low, it might be a good idea to combine its maintenance
with some of the other microchip trees.

I've added Nicolas to CC here, since he is the main maintainer for the
32-bit ARM Microchip stuff. For some context, I maintain the RISC-V
Microchip bits and a few other things like dt-bindings and some
non-microchip RISC-V platforms.

If you like, I could easily pick up patches for
arch/arm64/boot/dts/microchip/* as I am already sending PRs to Arnd for
other trees and another branch would not be much overhead!

Clearly I do not know the hardware at all, and reviewing the patches
would still be up to you, but I could handle the "administrative" side
of things (applying the patches & sending PRs) if that would be helpful?

Otherwise, Nicolas & I could probably help you through setting things up
to send PRs without taking up Krzysztof's time?

Either works for me!

Thanks,
Conor.

--yBk2dQgk9ssUKrBX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGTKjwAKCRB4tDGHoIJi
0glaAP9M7mSaNPH6qr9la4GASX5843bN0fsPKI1f0pTJ0ooFJwEAvb6ooXiRt0wm
1XLSJqo9Rnzbhbl1v/n9h13p6FuWtgk=
=ypew
-----END PGP SIGNATURE-----

--yBk2dQgk9ssUKrBX--
