Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333DF682460
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjAaGR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAaGRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:17:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3313B641;
        Mon, 30 Jan 2023 22:17:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 567FE612E6;
        Tue, 31 Jan 2023 06:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17996C433EF;
        Tue, 31 Jan 2023 06:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675145842;
        bh=GMEUHLupoK0SLnzwoNrELALifXu7rHL8trakhBe60h4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=uxfkiJCiW5WhOuRBS4BNgeXUffWbsrOlGizOBCGS/UIl5arVe+6S/Nf0jw56N0f7C
         XsQ2rlXcU9la577QEiw/swtUUqciaPxKIVzZzd60BpNODNekhVK4OX4RAuL9QU9UsV
         fpz2+DDVjEprzKZ47BJgswq9feotRSfR8FH7TduQdYOXAdiisKiGEUiTki22Mk/v9+
         Elc12LkVYARdHIqcZuu8aK+3FOSGyekfBQZSEU8ujP0bBGB5L+4hHJy4HY3PzeVFJJ
         YkoG+RDNzk82i8gV4sDgp77pWQKxce2xU4b8/WF4anVRs7q7wajjsL4rRyQFuNWWP6
         sn8aOoDnWg+Ag==
Date:   Tue, 31 Jan 2023 06:17:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_6/7=5D_riscv=3A_dts=3A_starfive=3A?= =?US-ASCII?Q?_Add_initial_StarFive_JH7110_device_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <0db7824b-184d-dfae-f61d-3048392c9895@starfivetech.com>
References: <20221220011247.35560-1-hal.feng@starfivetech.com> <20221220011247.35560-7-hal.feng@starfivetech.com> <0db7824b-184d-dfae-f61d-3048392c9895@starfivetech.com>
Message-ID: <39F228FA-2298-4813-9BDE-7100DE920213@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31 January 2023 02:00:26 GMT, Hal Feng <hal=2Efeng@starfivetech=2Ecom> =
wrote:
>On Tue, 20 Dec 2022 09:12:46 +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil=2Edk>
>>=20
>> Add initial device tree for the JH7110 RISC-V SoC by StarFive
>> Technology Ltd=2E
>>=20
>> Signed-off-by: Emil Renner Berthing <kernel@esmil=2Edk>
>> Co-developed-by: Jianlong Huang <jianlong=2Ehuang@starfivetech=2Ecom>
>> Signed-off-by: Jianlong Huang <jianlong=2Ehuang@starfivetech=2Ecom>
>> Co-developed-by: Hal Feng <hal=2Efeng@starfivetech=2Ecom>
>> Signed-off-by: Hal Feng <hal=2Efeng@starfivetech=2Ecom>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110=2Edtsi | 411 +++++++++++++++++++++=
++
>>  1 file changed, 411 insertions(+)
>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110=2Edtsi
>
>I wanna add i2c nodes (i2c0-6) in the next version, so someone else
>can use them when they submit i2c driver patches=2E

All of the other series depend on this one for enablement,
so unless the binding for i2c is already upstream I'd advise keeping it se=
parate=2E

Cheers,
Conor=2E

