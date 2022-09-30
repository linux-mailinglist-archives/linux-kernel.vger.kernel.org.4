Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6705F14BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiI3VZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiI3VZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:25:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1701B77EAA;
        Fri, 30 Sep 2022 14:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C47AAB82A3E;
        Fri, 30 Sep 2022 21:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE46C433C1;
        Fri, 30 Sep 2022 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664573115;
        bh=NGiPuVABzFyGPmQ/SzDN2E0dR6JoMPnu+7zd+8tVBl8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YlPEqeYQEnL9u1Qtf2JEBtmzPwKQsvkbfjJehvqtpJWC6yosioqGJBrTknUXQ9O3j
         HZ4WC0WEDsADoSXUZnhSZ/422mwhZilOb2oXSUW1s3rjKTAgcu6ZVxKFFeb/McxA5X
         89XUVbckymEEcn7b+CA83l12sXLmfcKg0xOcMg8Tmep3zMwdgeGBXfKmx17AmHagRB
         qTC8oqAC1+Bi0iwz3ui2G+MvQ79+DGQgeFfiKd/AdXpAZjhD6lqspH6UiMGBTmqoiR
         6ZermWM3IgNldoh84i3YPYItjTQwnHNUaOIVuU0lRUUWrcFwMomsgkqL2XidDZydAt
         cM2JPmw3H+ClA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220929225402.9696-3-Sergey.Semin@baikalelectronics.ru>
References: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru> <20220929225402.9696-3-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH RESEND v12 2/8] clk: baikal-t1: Fix invalid xGMAC PTP clock divider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date:   Fri, 30 Sep 2022 14:25:12 -0700
User-Agent: alot/0.10
Message-Id: <20220930212515.5CE46C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge Semin (2022-09-29 15:53:56)
> Most likely due to copy-paste mistake the divider has been set to 10 while
> according to the SoC reference manual it's supposed to be 8 thus having
> PTP clock frequency of 156.25 MHz.
>=20
> Fixes: 353afa3a8d2e ("clk: Add Baikal-T1 CCU Dividers driver")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---

Applied to clk-next
