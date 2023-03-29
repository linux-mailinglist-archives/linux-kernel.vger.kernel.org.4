Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5A6CD0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjC2Dyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjC2Dym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:54:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C207B2D74;
        Tue, 28 Mar 2023 20:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C3C3B81EA9;
        Wed, 29 Mar 2023 03:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF15C433EF;
        Wed, 29 Mar 2023 03:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680062079;
        bh=g3DYPi7TNL9lI7pPX5PFoUhZaJYFzaWu32tV23c823o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PulJjnFqoGXXJ8X81nR24DWvKb98rjEUx0py2KLQBHnymD9QHQ6lAG1OheoJwgHkT
         M+7ooWPnirh8nW6wTdZ/+/nQNNyPQXDpx1OJMCQAGfn3LhaLeANYhviCkEiba3BG44
         +/hjR9CB4EdAd/iJvoU8BMoe4Ycq82SkQ4lcxAsX37E9lMqQx3noibMO701/8fi0/6
         wxwNZg4xDjd4YyYwYZtwP3sw8hCC60THxCGmUAv6RbCu7j6Oq3wGrKdzkFH1asah3G
         MAPx4rgnHiH0HFPBFw5hcBip46KLxcAxP67Ih8MBydqIkOFwbRxMo2umIxbfvB4GTC
         N6nyzmwooqdlg==
Message-ID: <b816411c301e2b3afe9c3df36728f946.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dd7940fd-bf63-552c-6e2e-05eff5fdb636@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com> <20230328021912.177301-9-ychuang570808@gmail.com> <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org> <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com> <c37e1f3a40c404acd81c2c9d5b28b340.sboyd@kernel.org> <129cf4b6-b3b5-2a12-5911-37e70a624812@gmail.com> <e5221cd020bc60513df6a1c1859e1acc.sboyd@kernel.org> <ad908782-8291-4240-d88e-61dff5a05ef7@gmail.com> <1d379f28f54fd025f687bfcb71e4bae5.sboyd@kernel.org> <dd7940fd-bf63-552c-6e2e-05eff5fdb636@gmail.com>
Subject: Re: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device tree
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Tue, 28 Mar 2023 20:54:36 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-03-28 20:43:23)
> On 2023/3/29 =E4=B8=8A=E5=8D=88 11:25, Stephen Boyd wrote:
> > Quoting Jacky Huang (2023-03-28 20:13:11)
> >> I may not explain clearly enough. The lock/unlock register of system
> >> controller is more like
> >> a kind of write protection for specific registers, rather than
> >> preventing hetero-core CPU access.
> >> In many different IP of ma35d1 contain write protected registers.
> >> In fact, ma35d1 has a "hardware semaphore" IP, and we have implemented
> >> the driver in drivers/hwspinlock.
> >> Even the control register of "hardware semaphore" is also write protec=
ted.
> > What's the need to lock and unlock the registers? Is some other
> > processor also writing to the registers that we need to synchronize
> > against? Or is Linux the only entity reading and writing the registers?
> > I'm wondering if we should simply unlock the registers and never lock
> > them.

Can you answer this question?

> >
> >> So, should we implement a system controller driver to provide
> >> register_unlock() function?
> >> Is it OK to have such a driver in drivers/mfd?
> >> Or, just use syscon in device tree for those devices that have write
> >> protect registers.
> >>
> > The hwspinlock framework doesn't require there to be another entity
> > accessing some resource. It's there to implement hardware locks. I don't
> > see why it can't be used here.
>=20
> The current usage of register lock/unlock protect is as the following cod=
e:
>=20
> static void ma35d1_unlock_regs(struct ma35d1_clk_pll *pll)
> {
>  =C2=A0=C2=A0 =C2=A0int ret;
>=20
>  =C2=A0=C2=A0 =C2=A0do {
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 regmap_write(pll->regmap, REG_SYS_=
RLKTZNS, 0x59);
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 regmap_write(pll->regmap, REG_SYS_=
RLKTZNS, 0x16);
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 regmap_write(pll->regmap, REG_SYS_=
RLKTZNS, 0x88);
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 regmap_read(pll->regmap, REG_SYS_R=
LKTZNS, &ret);
>  =C2=A0=C2=A0 =C2=A0} while (ret =3D=3D 0);
> }
>=20
> static void ma35d1_lock_regs(struct ma35d1_clk_pll *pll)
> {
>  =C2=A0=C2=A0 =C2=A0regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x0);
> }
>=20
> And the following code is to unlock registers for write and then lock aga=
in.
>=20
>  =C2=A0=C2=A0=C2=A0 ma35d1_unlock_regs(pll);
>  =C2=A0=C2=A0 =C2=A0writel_relaxed(reg_ctl[0], pll->ctl0_base);
>  =C2=A0=C2=A0 =C2=A0writel_relaxed(reg_ctl[1], pll->ctl1_base);
>  =C2=A0=C2=A0 =C2=A0writel_relaxed(reg_ctl[2], pll->ctl2_base);
>  =C2=A0=C2=A0 =C2=A0ma35d1_lock_regs(pll);
>=20
> The above code is from the clk-ma35d1-pll.c from this patchset.

Yeah I understand that you write some registers in the syscon to lock
the registers.

>=20
> We just employ regmap mechansim for the access to REG_SYS_RLKTZNS registe=
r.
> Is this implementation OK for you?=C2=A0 Thank you.
>=20

No. Why can't that be a hwspinlock? Or why can't it be unlocked all the
time and rely on software spinlocks in the kernel to prevent concurrent
access to the registers accessed by a driver, like a lock for the clk
registers and a lock for the reset registers, etc. Or if no two clks or
resets exist within one 32-bit word then no lock is necessary.
