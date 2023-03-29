Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836B56CD0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjC2DZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2DZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA31270D;
        Tue, 28 Mar 2023 20:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03FC761A15;
        Wed, 29 Mar 2023 03:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524DEC433D2;
        Wed, 29 Mar 2023 03:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680060352;
        bh=rGesu/nbEnFvbtmlz6tgs+4c/cLzd437HpK/3VSCMlA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LFEQzM13qMc7C5WJrI2LVx8MuRWfOA/rOL5mZSpeoaaGr9GeppcMFsibDn211CaMK
         C2pn4KIiFGVQvYabOI4zp7Vw3dGvIO3mjMYEeKc/v37cVk9Y38AJBvNDm238WsHCXz
         Oq/QwUiNRF9CSlriFpkmFdkHDA8ysUFAJTVatpvDa2JpsR3VzOmcBtY1gEvh1vYYfg
         Qko+pgK1lC1WF/+oJfBjbtJF1TZVxp/xHFkwouQfP3ZMgm/scmw8qfLdC02glQ+I0k
         sXqVG+KsPCLLmOeXdjPxkO0KbCpktJ2sdjtRQmYmC0gAMn55Llko0CFwcQ6inBfvB7
         MQnGQYRDzfJAw==
Message-ID: <1d379f28f54fd025f687bfcb71e4bae5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ad908782-8291-4240-d88e-61dff5a05ef7@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com> <20230328021912.177301-9-ychuang570808@gmail.com> <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org> <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com> <c37e1f3a40c404acd81c2c9d5b28b340.sboyd@kernel.org> <129cf4b6-b3b5-2a12-5911-37e70a624812@gmail.com> <e5221cd020bc60513df6a1c1859e1acc.sboyd@kernel.org> <ad908782-8291-4240-d88e-61dff5a05ef7@gmail.com>
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
Date:   Tue, 28 Mar 2023 20:25:50 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-03-28 20:13:11)
> Dear Stephen,
>=20
>=20
> On 2023/3/29 =E4=B8=8A=E5=8D=88 10:46, Stephen Boyd wrote:
> > Quoting Jacky Huang (2023-03-28 19:39:36)
> >> On 2023/3/29 =E4=B8=8A=E5=8D=88 10:19, Stephen Boyd wrote:
> >>> What do you use the syscon for then? The clock driver must want to use
> >>> the syscon for something, implying that they are the same device.
> >> The register lock mechanism is applied to protect many critical
> >> registers from false written.
> >> The register lock control register is one register in system controlle=
r.
> >> Some registers of the clock controller are lock protected. Not only
> >> clock controller, but other
> >> IP such as RTC, PWM, ADC, etc, also have lock protected registers. All
> >> these IP requires
> >> syscon to access the lock/unlock control register in the system contro=
ller.
> >> That's why we add a <&sys> to the clock controller.
> >>
> >> Should we implement a ma35d1-sysctl driver to protect register_lock()
> >> and register_unlock()
> >> and export to those drivers?=C2=A0 If yes, we can remove the <&sys> fr=
om
> >> clock controller.
> >>
> > You can implement the lock and unlock in the hwspinlock framework. See
> > drivers/hwspinlock.
>=20
> I may not explain clearly enough. The lock/unlock register of system=20
> controller is more like
> a kind of write protection for specific registers, rather than=20
> preventing hetero-core CPU access.
> In many different IP of ma35d1 contain write protected registers.
> In fact, ma35d1 has a "hardware semaphore" IP, and we have implemented=20
> the driver in drivers/hwspinlock.
> Even the control register of "hardware semaphore" is also write protected.

What's the need to lock and unlock the registers? Is some other
processor also writing to the registers that we need to synchronize
against? Or is Linux the only entity reading and writing the registers?
I'm wondering if we should simply unlock the registers and never lock
them.

>=20
> So, should we implement a system controller driver to provide=20
> register_unlock() function?
> Is it OK to have such a driver in drivers/mfd?
> Or, just use syscon in device tree for those devices that have write=20
> protect registers.
>=20

The hwspinlock framework doesn't require there to be another entity
accessing some resource. It's there to implement hardware locks. I don't
see why it can't be used here.
