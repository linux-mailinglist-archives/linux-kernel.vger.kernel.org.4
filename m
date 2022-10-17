Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754B96014E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJQRZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJQRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:24:37 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D4665CE;
        Mon, 17 Oct 2022 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666027472; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2LKFFdukj0Teo80d6xApjlkPmcHoDYGqshawhQ6Zp4=;
        b=iamdcSxFgEwdT5Dd6NOiZ9hoaP/6qqx46nqgsRbZ84SwzSqeu69s+BZ4NZ+BKfwwJ9ja/k
        oOaC/T7wZONdZpGf2331jSVlaUC+JhE+pfKNwBSccrGc0fMzPX4dEf+Ufh5oK8wZWUHPnf
        tsyYtrCA+zggOaba6/A+8HQQZLoD0IM=
Date:   Mon, 17 Oct 2022 18:24:22 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 4/4] clk: Add Ingenic JZ4755 CGU driver
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <M0RWJR.TI6Q9ATD37DF3@crapouillou.net>
In-Reply-To: <CAKNVLfYEMwRC+4VuGcaENd1eTvbhWD9=uFDAhaz+1Fd8Aaqg_w@mail.gmail.com>
References: <20221016150110.3020451-1-lis8215@gmail.com>
        <20221016150110.3020451-5-lis8215@gmail.com>
        <0S4WJR.4KB18PR21S9K1@crapouillou.net>
        <CAKNVLfYEMwRC+4VuGcaENd1eTvbhWD9=uFDAhaz+1Fd8Aaqg_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun., oct. 17 2022 at 20:10:56 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =C3=A9crit :
> =D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:24, Paul Cerc=
ueil=20
> <paul@crapouillou.net>:
>=20
>>  > +     [JZ4755_CLK_AIC] =3D {
>>  > +             "aic", CGU_CLK_GATE,
>>  > +             .parents =3D { JZ4755_CLK_I2S, -1, -1, -1 },
>>=20
>>  Wrong parent here, should be JZ4755_CLK_EXT_HALF.
>=20
> I don't  agree, see Figure 20-13 in the JZ4755 PM.

20-13 describes the I2S clock, no?

AIC clock's parent is EXT/2 according to the diagram in 8.2.2.

>>  Well it would be good to know...
>=20
> Indeed, I will try to figure it out.

Cheers,
-Paul


