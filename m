Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B1A7374B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFTS4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFTS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D468F1BCF;
        Tue, 20 Jun 2023 11:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C3266142A;
        Tue, 20 Jun 2023 18:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C56C433C0;
        Tue, 20 Jun 2023 18:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287345;
        bh=DJtxnLa8T0QvZ3FOKY+0DYUsHOygwlAJ6pFSsoXj3Tk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W2FdW9e/CIFM8QuKwMX9ikxmXFexPjQDNCzbdbsRGYcmoQ+VrO9CYSKjEYVASxzmZ
         Cr57mvFn2ZwRsX+22s1i0zWpVS+Vu9X7gg+CIIJCOjeOnJGXd0+zgrsMAx5YEZIdcr
         lEt2pDCYqFRa/z92QlBzGv9ma9mqdZXzZSgw4HgSKi26rqtrn3MxwyZ44REfYJuS7x
         y5AtAzHbCpKQODl2IgJRBrtiGsm921AO4g0H82lLUJwPg+WWJbKDJ1uaB1S1k1pc5a
         IA+S6Vs4qakUGba77X8JXc76urO3+7UvmTKLfAovHKu2GwE72F3ZjZEwxx2i+Qrejo
         kBHgkTwgBULWw==
Message-ID: <bed4bf81998f5dc3a0382b1d9f1497fa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230530093913.1656095-8-claudiu.beznea@microchip.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com> <20230530093913.1656095-8-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 7/8] clk: ti: clkctrl: check return value of kasprintf()
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
Date:   Tue, 20 Jun 2023 11:55:41 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2023-05-30 02:39:12)
> kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
>=20
> Fixes: 852049594b9a ("clk: ti: clkctrl: convert subclocks to use proper n=
ames also")
> Fixes: 6c3090520554 ("clk: ti: clkctrl: Fix hidden dependency to node nam=
e")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
