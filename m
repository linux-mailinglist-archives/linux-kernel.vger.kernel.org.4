Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4FD702B52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEOLVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbjEOLVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136A31725;
        Mon, 15 May 2023 04:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E502622B4;
        Mon, 15 May 2023 11:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A59C433D2;
        Mon, 15 May 2023 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684149662;
        bh=T9fUIZM//OsaJoszK2rbswFzc+I4mXJQ/XmvdRAp4Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxnqPdLb3m/VqY4ug2kVgU5qZqloUDQHQVPZeluUdr8l3mjkkvoXSaXdxIToBfBtO
         Fz8kuh86bJ+B77su2sh0jtfsfCjMgOvg5Z3tLhC6AC2NcrthHURs5hmszzoiqM7f58
         kao6P7OhvBtH7deZIW92FOwbCSM99Xyl2dCFlMJOFJ8hJsDoxrZkv90EQfKZEQJUNT
         xkpyJiAAMy66g/HsIgDDEvPMdPQHP3AzjjkU3FxZJZIFUzv1rJNMaKZHZJwhY99BnM
         fClP+I7y5JGSE+N0ybTcTlCnDS73tXDdg2Vg5outqNhUp+U5xGsR2aXB1ftLLPLTrH
         V0ReRNOs0Ouiw==
Date:   Mon, 15 May 2023 20:20:59 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] riscv: dts: starfive: add the node and pins
 configuration for tdm
Message-ID: <ZGIVm6LHMpIylvAC@finisterre.sirena.org.uk>
References: <20230511091549.28003-1-walker.chen@starfivetech.com>
 <20230511091549.28003-4-walker.chen@starfivetech.com>
 <cd7803a2-38a0-c498-467f-1ef802645527@starfivetech.com>
 <20230515-dragonish-diffuser-48a1c6f4c8ae@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mqP7O91n5Vmg09iP"
Content-Disposition: inline
In-Reply-To: <20230515-dragonish-diffuser-48a1c6f4c8ae@wendy>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mqP7O91n5Vmg09iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 09:58:12AM +0100, Conor Dooley wrote:

> It's only been 4 days chief, of which 2 were the weekend, you don't need
> to bump it yet! You'd be better off asking one of your co-workers to

4 days, 2 of which were the weekend and 4 of which I was on holiday...

--mqP7O91n5Vmg09iP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRiFZoACgkQJNaLcl1U
h9A3UQf+Pl3EGxms+J3grtXRzBY+ejt6SgLQdSTJw9Uqz7Fwgfsw7oQ+yPWHDHp1
mXYCBFBWzfWWVh+Q9ogUF7GFDGMM9GmzU2ywgbDvmrxKBugimlXWbEArFWNi9vdr
qNsA4VX1rXD7qkkDptHDxoHuhcIsef6Rc3SGhCjByAeom+lEgOrPLmLOSxO+Fuh5
SemO/Tlac48KtG2L+oNRrQW3EVA8buAkkilgRmPpXOBQpJRinJNy/Lfc7KSCqk1U
MT4BpMeIS0kugU0brTvopy7W8+VuZhuflVhGOn9DWiKPJLz1Dt59TpKcdE9ABGVV
KcFKmBwEaJacIJQ8yKhiiEakuLImFw==
=6jDZ
-----END PGP SIGNATURE-----

--mqP7O91n5Vmg09iP--
