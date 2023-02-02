Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0302E6875C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBBGTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBBGTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:19:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F176474ED;
        Wed,  1 Feb 2023 22:19:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0661C615F2;
        Thu,  2 Feb 2023 06:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8E5C433EF;
        Thu,  2 Feb 2023 06:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675318750;
        bh=6xVy9dVamZI7gmmEzbNj10pwoYuJsIbEypFo0Ly+oSE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=MH2PlScttKkJ8L9i3MHuyqbOxDreiQ+KHwP6+kJufOqJi+UvsWmYFGJstE5pKFMDn
         Q4oUKPf64y3OQx7ITz3jYZF9ivClKbAXbkheGYxtdwfZPfMXMPpHx41Wc5yqyyQWbi
         OaAUZvC1+nqd03VSSznxGj/fH2IZmLiX8W6rC6xHUn30IRtkx4pGRhhxA0uTaxnTqc
         F+TrO0RXbvl0FNxnKZw8aI9uq7ZccNe7gwcKSv7AHYgLIXlhUOwxa8PvRkaZlpG0ug
         d7lE+y8cFhmdYstJO0doJlDMXgyYT4OjWDXHS3pLyhBLO0HzubJ006nQ+XuSDQAJOQ
         Y6uhYGWaP6bjw==
Date:   Thu, 02 Feb 2023 06:19:07 +0000
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
In-Reply-To: <0ff800a1-5e90-64bc-af53-2736e698c9e4@starfivetech.com>
References: <20221220011247.35560-1-hal.feng@starfivetech.com> <20221220011247.35560-7-hal.feng@starfivetech.com> <0db7824b-184d-dfae-f61d-3048392c9895@starfivetech.com> <39F228FA-2298-4813-9BDE-7100DE920213@kernel.org> <0ff800a1-5e90-64bc-af53-2736e698c9e4@starfivetech.com>
Message-ID: <A6312791-75C5-478A-8B76-27F293B43DD6@kernel.org>
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



On 2 February 2023 02:42:32 GMT, Hal Feng <hal=2Efeng@starfivetech=2Ecom> =
wrote:
>On Tue, 31 Jan 2023 06:17:17 +0000, Conor Dooley wrote:
>> On 31 January 2023 02:00:26 GMT, Hal Feng <hal=2Efeng@starfivetech=2Eco=
m> wrote:
>>>On Tue, 20 Dec 2022 09:12:46 +0800, Hal Feng wrote:
>>>> From: Emil Renner Berthing <kernel@esmil=2Edk>
>>>>=20
>>>> Add initial device tree for the JH7110 RISC-V SoC by StarFive
>>>> Technology Ltd=2E
>>>>=20
>>>> Signed-off-by: Emil Renner Berthing <kernel@esmil=2Edk>
>>>> Co-developed-by: Jianlong Huang <jianlong=2Ehuang@starfivetech=2Ecom>
>>>> Signed-off-by: Jianlong Huang <jianlong=2Ehuang@starfivetech=2Ecom>
>>>> Co-developed-by: Hal Feng <hal=2Efeng@starfivetech=2Ecom>
>>>> Signed-off-by: Hal Feng <hal=2Efeng@starfivetech=2Ecom>
>>>> ---
>>>>  arch/riscv/boot/dts/starfive/jh7110=2Edtsi | 411 +++++++++++++++++++=
++++
>>>>  1 file changed, 411 insertions(+)
>>>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110=2Edtsi
>>>
>>>I wanna add i2c nodes (i2c0-6) in the next version, so someone else
>>>can use them when they submit i2c driver patches=2E
>>=20
>> All of the other series depend on this one for enablement,
>> so unless the binding for i2c is already upstream I'd advise keeping it=
 separate=2E
>
>The i2c IP of JH7110 is from Synopsys and the same as the i2c IP in JH710=
0=2E
>The binding and driver for i2c are already upstream=2E It works as long a=
s we
>add the i2c nodes and configure pins for i2c in device tree=2E It will si=
mplify
>the dependency if we do that=2E

Please make sure that you add a device specific compatible for jh7110 then=
, thanks=2E

>By the way, I am checking the ISA of U74-MC on JH7110 with someone else=
=2E
>I will reply you today=2E

Cool!

