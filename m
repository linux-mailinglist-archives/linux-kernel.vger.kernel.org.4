Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DF773749D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFTSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFTSye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:54:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E547910FE;
        Tue, 20 Jun 2023 11:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 665FE61440;
        Tue, 20 Jun 2023 18:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DC4C433C8;
        Tue, 20 Jun 2023 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287271;
        bh=WzI/gdfee49OMr+3Iqlqirbylnbk2GIsTPA78V9j4KE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EN3/IlAvIcwERObGMLcWlk3+qZcwh4dhZAFLgzXIoCm6QDpYwcZqceA/UBMVCcThQ
         MpUT8Zye4QVCMkXa+bJM0210lA27X24JYM49XupZcaocnh4x8ucJ7AztUk3q+q0COg
         wJtRMEIPPFuShzv10YbBEdhu/Yhn5wIZP0L9rFYXxLReGqIx6lrdO879lfSceZCOCU
         GWr/CUjWUZ/DDvbDhHYAQxjWtnbCKN45hUio1oj/KD5qxZyc2gBiXUtpcI6NpYLe96
         sBAjGcyDy0GulLraRoDN4s1YIXDHTk9Sa82sQwKon3AB9Qa4eeEtP2JFmwockLNrdo
         j6MvFRfpHeCEA==
Message-ID: <ff48113a0f4fffbd73fe96a3889734da.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230530093913.1656095-4-claudiu.beznea@microchip.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com> <20230530093913.1656095-4-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 3/8] clk: si5341: return error if one synth clock registration fails
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     aford173@gmail.com, mike.looijmans@topic.nl,
        robert.hancock@calian.com, shawn.guo@linaro.org,
        fabio.estevam@freescale.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, kristo@kernel.org,
        luca.ceresoli@bootlin.com, michal.simek@xilinx.com,
        mturquette@baylibre.com, nm@ti.com, ssantosh@kernel.org
Date:   Tue, 20 Jun 2023 11:54:28 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2023-05-30 02:39:08)
> In case devm_clk_hw_register() fails for one of synth clocks the probe
> continues. Later on, when registering output clocks which have as parents
> all the synth clocks, in case there is registration failure for at least
> one synth clock the information passed to clk core for registering output
> clock is not right: init.num_parents is fixed but init.parents may contain
> an array with less parents.
>=20
> Fixes: 3044a860fd09 ("clk: Add Si5341/Si5340 driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
