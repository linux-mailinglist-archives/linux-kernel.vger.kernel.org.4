Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7197F706886
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjEQMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjEQMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:46:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A2C171A;
        Wed, 17 May 2023 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684327603; x=1715863603;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KwRK9xF7Z2t2wsO9PZfO2viMcidcKuoWbd38SwZvKgQ=;
  b=gHzT5/upQF2jGP9BUue29M/Sw+ig4axlEm4Z1lywc30zhrH1xDigjRRY
   YN4Fwn9a7m+w06Lk5AaLj92tFMluWsyxDI7geqoY4TMaJX12uqow2GasJ
   o30qLSzriT4bCwfTtqlkidnoC7VZVAHighicSSHJ2/5y663hRMQ6+HiPf
   OBxqmnrX6PpsncSB7hDnCcKxEwKUSHXX/OkA342FU9V6BEMluDpK1TMbz
   D6h1s9zmQxHk561fCAeUyYyl6NZrs9UH2DcLiMyoFMvZuDghsEznBYPRx
   1Ysc2zFIX/ZMDmV5BFGFFyJurwiHYJAqtyNAVOSHJ5En7mNw64l5ILkXw
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="scan'208";a="152530767"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 05:46:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 05:46:42 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 05:46:39 -0700
Message-ID: <67bf21d4cf9573233fc8154ae73b966adba6df09.camel@microchip.com>
Subject: Re: [PATCH] arm64: dts: microchip: add missing cache properties
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>
Date:   Wed, 17 May 2023 14:46:38 +0200
In-Reply-To: <20230517-crop-limeade-73369ac8594d@wendy>
References: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
         <151169f7-dcdb-47f1-9616-67c3c388a233@linaro.org>
         <7772a5981d9a3d46056a53997162d1d75d22a701.camel@microchip.com>
         <41c72642-7d46-d7d1-d49a-6bef685f934c@linaro.org>
         <20230517-crop-limeade-73369ac8594d@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor and Krzysztof,

On Wed, 2023-05-17 at 13:37 +0100, Conor Dooley wrote:
> Hey,
>=20
> On Wed, May 17, 2023 at 02:10:53PM +0200, Krzysztof Kozlowski wrote:
> > On 17/05/2023 13:38, Steen Hegelund wrote:
> > > Hi Krzysztof,
> > >=20
> > > I would love to do that, but I am not familiar with the procedure, so
> > > maybe you
> > > could help me out?
> >=20
> > Hm, there is no dedicated maintainer for Microchip ARM64 platforms? I
> > mean one which actually handles the patches?
> >=20
> > It looks like it, because my recent changes were going through me. This
> > also means that maybe several other changes got ignored. For example:
>=20
> Aye and the branches etc in the repo itself are all a wee bit stale.
>=20
> > > This is my understanding of what I need to do:
> > >=20
> > > Clone the upstream repo listed in MAINTAINERS:
> > >=20
> > > git clone git@github.com:microchip-ung/linux-upstream.git
> > > cd linux-upstream
> > > git checkout sparx5-next
> > >=20
> > > Fetch the latest mainline tag from upstream:
> > >=20
> > > git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
> > > tag\
> > > =C2=A0v6.4-rc2 --no-tags
> > >=20
> > > Rebase the current branch on top of that tag:
> > >=20
> > > git rebase v6.4-rc2
> > >=20
> > > Use b4 to fetch and apply the mail thread patch series:
> > >=20
> > > b4 shazam -tsl 20230421223155.115339-1-krzysztof.kozlowski@linaro.org
> >=20
> > You should collect some more patches... For one patch it is probably to=
o
> > much effort. I can take it instead.
> >=20
> > > Tag the current work for inclusion in the next kernel version with a
> > > decription:
> > >=20
> > > git tag -s sparx5-dt-6.5
> >=20
> > git tag -a -s sparx5-dt-6.5
> >=20
> > Because you need to provide some explanation. Take a look at examples
> > from other sub-arch maintainers what to write in the tag:
> >=20
> > https://lore.kernel.org/soc/20230410170233.5931-1-andersson@kernel.org/=
T/#u
> >=20
> > https://lore.kernel.org/soc/20230405080438.156805-1-krzysztof.kozlowski=
@linaro.org/T/
> >=20
> > >=20
> > > Push work that to the public repo:
> > >=20
> > > git push origin sparx5-dt-6.5
> > >=20
> > > Create a pull request (to stdout) to be included in an email to the
> > > maintainers:
> > >=20
> > > git request-pull v6.4-rc2 origin sparx5-dt-6.5
> > >=20
> > > Send this PR to the maintainers and CC co-maintainers.
> > >=20
> > > Is this the correct procedure?
> > > Who should I send the PR email to (is there a list somewhere)?
> >=20
> > Yes, it's correct with few nits I mentioned.
> >=20
> > You send it to arm@, soc@, Olof and Arnd. Addresses are in examples abo=
ve.
> >=20
> > I will be preparing today the pull with various cleanups for arm-soc, s=
o
> > I will take the patch if you do not mind.

Absolutely - and I am glad that I at least got to a point where I understan=
d the
procedure, but as changes are far between, I was not aware that I had some
responsibilities here.

Thanks for the clarification!

> >=20
> > For future (and all previous patches), please think what do you
> > (you=3DMicrochip) want to do with it. If you do not handle the patches,
> > then someone should or the platform should be marked as "Odd fixes".
>=20
> If noone is set up to actually be the maintainer of the tree, and the
> patch volume is low, it might be a good idea to combine its maintenance
> with some of the other microchip trees.
>=20
> I've added Nicolas to CC here, since he is the main maintainer for the
> 32-bit ARM Microchip stuff. For some context, I maintain the RISC-V
> Microchip bits and a few other things like dt-bindings and some
> non-microchip RISC-V platforms.
>=20
> If you like, I could easily pick up patches for
> arch/arm64/boot/dts/microchip/* as I am already sending PRs to Arnd for
> other trees and another branch would not be much overhead!
>=20
> Clearly I do not know the hardware at all, and reviewing the patches
> would still be up to you, but I could handle the "administrative" side
> of things (applying the patches & sending PRs) if that would be helpful?
>=20
> Otherwise, Nicolas & I could probably help you through setting things up
> to send PRs without taking up Krzysztof's time?
>=20
> Either works for me!

It would be preferable for me if you (Conor) would handle the
arch/arm64/boot/dts/microchip/* tree as you suggested.  It is not often we
update it, so it will hopefully be low overhead for you.

>=20
> Thanks,
> Conor.

Thanks to both of you for the assistance.

Best Regards
Steen

