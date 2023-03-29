Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13436CF177
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjC2RwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC2RwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:52:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144F4DB;
        Wed, 29 Mar 2023 10:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF665B823F8;
        Wed, 29 Mar 2023 17:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57552C433EF;
        Wed, 29 Mar 2023 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680112323;
        bh=w8jUtzScreWIDo7Aw/aAc5jBL+unzSwEx2kU/1yGx60=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XJeFVsqL56erab6j/2q5XeQRgm0r4cgkDDfbP/DntYv01dBpmrSTKXeflchMEmfdK
         B+yanwrkDp0DIbDzuTZicO6LQuH3P4k4iJI6rcjs/qOWVPgDkOl4YxWAgKFGEyou3y
         ZEMHuKqBcTIJKEq0k1juQqqWECXl7m0DV05zh4AwJ98oVG9lz618GdmGsDvoguRN3E
         IYFKMd1aKt9cbHYrTA3ZF0ZBJFVOHZfOwSx6j2I2W6kOL+dPQqMMpVoOiRXtTuUvCF
         KrwtRSWsLBbOIRIXmOulQyyaUkCQTexTEn4hW3Y5/zETHAuJsWKQcwVxbmiOAVVsyD
         /x6aU27LAIQCQ==
Message-ID: <e45cd7bb6dce2b8b2f08d3b3bd96bb06.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <458d454e-64ba-849a-38cb-88bf016f5a2e@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com> <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com> <c37e1f3a40c404acd81c2c9d5b28b340.sboyd@kernel.org> <129cf4b6-b3b5-2a12-5911-37e70a624812@gmail.com> <e5221cd020bc60513df6a1c1859e1acc.sboyd@kernel.org> <ad908782-8291-4240-d88e-61dff5a05ef7@gmail.com> <1d379f28f54fd025f687bfcb71e4bae5.sboyd@kernel.org> <dd7940fd-bf63-552c-6e2e-05eff5fdb636@gmail.com> <b816411c301e2b3afe9c3df36728f946.sboyd@kernel.org> <458d454e-64ba-849a-38cb-88bf016f5a2e@gmail.com>
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
Date:   Wed, 29 Mar 2023 10:52:01 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-03-28 23:02:31)
>=20
> On 2023/3/29 =E4=B8=8A=E5=8D=88 11:54, Stephen Boyd wrote:
> > Quoting Jacky Huang (2023-03-28 20:43:23)
> >
> >> We just employ regmap mechansim for the access to REG_SYS_RLKTZNS regi=
ster.
> >> Is this implementation OK for you?=C2=A0 Thank you.
> >>
> > No. Why can't that be a hwspinlock? Or why can't it be unlocked all the
> > time and rely on software spinlocks in the kernel to prevent concurrent
> > access to the registers accessed by a driver, like a lock for the clk
> > registers and a lock for the reset registers, etc. Or if no two clks or
> > resets exist within one 32-bit word then no lock is necessary.
>=20
> You gave a good suggestion here. Yes, of course we can let it be=20
> unlocked all the time.
> We can unlock the "register lock" before entering Linux.
> As a result, the unlonk and lock register related code is not required.
> Thus, we can remove syscon from the clock controller node.
>=20
> If you agree with this, we will modify it in the next version.
>=20

Sure, that works.
