Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423846DFFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDLUcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDLUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C840C5;
        Wed, 12 Apr 2023 13:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EDA36392C;
        Wed, 12 Apr 2023 20:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D97C433EF;
        Wed, 12 Apr 2023 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331556;
        bh=4f85G7qmQu0cjMFlLuwC+FY9Rzyah8PJLhITq+Oo0N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3T/1oUQsj4w/eU8173BXiV87rg7FOx+fMhXSd8zFkm53FoXzQz+c16PDffD4AHQO
         mBDD995fCyBC/pFN0SKeSWuBjgsNg2/7BjS4ytqnS5Sh/vHjnGruOvIqBjnDTYYpoW
         oBVixmrfZIOiAQ4b1CYEE/LKgydw1LUd18DZSl/9K3r1IXjztt+Km4+RNigSastq2t
         5LMt53hqf29xBguA578w2mLkBlk76/roIM/CtGJ4lUv7NJq6TmIJbzI3UMGq+iKeie
         O1kogLAgoJDQXd6fHPrCbyID0ESdxD9O+Mca7swAeTw+keHsBb9v4dHb5fmorGCxV6
         BrPKqwPdn7UGQ==
Date:   Wed, 12 Apr 2023 21:32:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8 0/7] Add non-coherent DMA support for AX45MP
Message-ID: <20230412-populate-busybody-4c6d7cfc4667@spud>
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wokudRuMrcrR61tg"
Content-Disposition: inline
In-Reply-To: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wokudRuMrcrR61tg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2023 at 12:08:53PM +0100, Prabhakar wrote:

> Note,
> - This series requires testing on Cores with zicbom and T-Head SoCs

As I said last time, I dunno what actual Zicbom stuff exists, other than
perhaps the Ventana lads having something. I did some tyre kicking on my
D1 and it was fine, although nothing has actually changed materially for
either of them with this series in v8..

Cheers,
Conor.

--wokudRuMrcrR61tg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDcVXgAKCRB4tDGHoIJi
0hcDAQDyjF067mLfUHvBJlvlHcRbETM+ZVvN06gg2JGFRQC2CQD+J6L/segmEeV0
Gsgp3NcVV5niFc7YF5NTmNv/R4lEqAw=
=4ZCG
-----END PGP SIGNATURE-----

--wokudRuMrcrR61tg--
