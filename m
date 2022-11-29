Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3064163BA01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiK2GyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2GyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:54:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F4B317C0;
        Mon, 28 Nov 2022 22:54:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D5F3B8110A;
        Tue, 29 Nov 2022 06:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34739C433C1;
        Tue, 29 Nov 2022 06:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669704859;
        bh=syhTa4Rv2j2bHLOI/+XB369IkPY+WGcPvONSdA4KJes=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=hid+UV6aNFqn6SxhgLL+EvqQ9o2mgxKmtbFasQQrZQN5DKZ7nAVmZJ45MdsK2ZxT3
         YmyCvwCldrKbu0c2Arx2OuW6t/dhnZaoEnN7EZ+u1SqgjX/0gj2kQiD4epIhWYg0yS
         g8mIQemYc8xeKgT7LtqTmKr1k61LHT5pj3gUFx5O6hQK8bltp/86nPvpw7+ZhmnrBt
         hSifj0E+WvQiyZlF0Sal5DAK6yKTi5AbYWFt+4vO4IIgAXMx06weeIpZ6lICN/7dbh
         uUb5/qYF3bICSnYZTrminAlS9R7Pww9xYtFF3wfVAHszoMj+xGM77CLl7A7RU+5HOl
         PaCPXp0Nfn88w==
Date:   Tue, 29 Nov 2022 06:54:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>, palmer@dabbelt.com,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_12/12=5D_riscv=3A_defconfig=3A_En?= =?US-ASCII?Q?able_the_Allwinner_D1_platform_and_drivers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221129064925.kjjqrzmi3fm67akt@kamzik>
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-13-samuel@sholland.org> <Y4JBa52o4Yemv/uj@spud> <11740765.nUPlyArG6x@diego> <6aad3b63-498e-b13a-af49-b5af0d4e721e@kernel.org> <20221129064925.kjjqrzmi3fm67akt@kamzik>
Message-ID: <BBF52D3D-B8D3-4895-B316-33555E22C56B@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 November 2022 06:49:25 GMT, Andrew Jones <ajones@ventanamicro=2Ecom>=
 wrote:
>On Mon, Nov 28, 2022 at 09:17:38PM +0000, Conor Dooley wrote:
>> On 28/11/2022 21:11, Heiko St=C3=BCbner wrote:
>> > Am Samstag, 26=2E November 2022, 17:40:11 CET schrieb Conor Dooley:
>> >> On Fri, Nov 25, 2022 at 05:46:56PM -0600, Samuel Holland wrote:
>> >>> Now that several D1-based boards are supported, enable the platform=
 in
>> >>> our defconfig=2E Build in the drivers which are necessary to boot, =
such as
>> >>> the pinctrl, MMC, RTC (which provides critical clocks), SPI (for fl=
ash),
>> >>> and watchdog (which may be left enabled by the bootloader)=2E
>> >>
>> >> All of that looks good=2E
>> >>
>> >>> Other common
>> >>> onboard peripherals are enabled as modules=2E
>> >>
>> >> This I am not sure about though=2E I'll leave that to Palmer since I=
'm
>> >> pretty sure it was him that said it, but I thought the plan was only
>> >> turning on stuff required to boot to a console & things that are
>> >> generally useful rather than enabling modules for everyone's "random=
"
>> >> drivers=2E Palmer?
>> >=20
>> > Isn't the defconfig meant as a starting point to get working systems
>> > with minimal config effort? At least that was always the way to go on=
 arm
>> > so far :-) =2E
>> >=20
>> > So having boot-required drivers built-in with the rest enabled as mod=
ules
>> > for supported boards will allow people to boot theirs without headach=
es=2E
>> >=20
>> > Disabling unneeded drivers if you're starved for storage space in a s=
pecial
>> > project is always easier than hunting down all the drivers to enable =
for a
>> > specific board=2E=20
>>=20
>> I wouldn't mind being able to turn on all the PolarFire SoC stuff and
>> yeah, that would be the way that arm64 does it=2E But I do recall heari=
ng
>> that I should not turn stuff on this way, when I initially tried to
>> turn stuff on via selects, got a nack and asked if I could do this inst=
ead=2E
>>=20
>> But it may be that I misremember, which is why I appealed to the Higher
>> Powers for clarification :)
>
>FWIW, I don't worry too much about modules in defconfig because I always
>immediately apply a 'LSMOD=3D$PWD/L localmodconfig' to it, where the L
>file is an lsmod output which only includes modules I need=2E

idk, defconfig to me is not about you or I, it's about A Developer that ge=
ts an SBC or a devkit and their experience=2E
Or alternatively, someone's CI ;)
I'd like to put everything in, but I recall that being shot down, that's a=
ll=2E
