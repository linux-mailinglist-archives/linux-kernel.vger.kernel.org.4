Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510F76B5FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCKSol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKSoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:44:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15A239CEA;
        Sat, 11 Mar 2023 10:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C930B80522;
        Sat, 11 Mar 2023 18:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA9EC433EF;
        Sat, 11 Mar 2023 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678560275;
        bh=R61uuLBKxcLdI3OJXsXmw4vhuj7flt+NKOn0jarEm/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rd3srJsyEvrf/zZkBVJjMf0UO59iICYUbe9aCRZfdvbcHJzVSu/2avrUr35TE+M6A
         zcZO86VlUbbOshd/Ho10TMDtgg5fXO30PRu7RYDAumBSJtwZYlCd82xT0g78lwmkcr
         ZP0zNNEXpojAIBE/gaCPP/S/RNZJmkBJSzraqv44IFpWHGEn4CGcoyi7gT4IvP+zmG
         46FoS8NZu/hJ8b3dwzHRI93RKx3xBFjeRjOwiV3faWC7PD4zbeOZYrefMFCVb/8Gk3
         0uYjgwv298ecVuRRC4Sa8CbewcNek6Yj2ncp4PIRCJfMu/Esu30zLKncityE4ODoVL
         8bG5a7mTHPxPA==
Date:   Sat, 11 Mar 2023 18:44:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: proximity: sx9500: Mark ACPI and OF related
 data as maybe unused
Message-ID: <20230311184440.22a1ff0f@jic23-huawei>
In-Reply-To: <c66c3f92-fa33-5af1-6f19-79b6d3530862@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
        <20230311111457.251475-4-krzysztof.kozlowski@linaro.org>
        <20230311122833.03b5a3d7@jic23-huawei>
        <c66c3f92-fa33-5af1-6f19-79b6d3530862@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 13:30:01 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 11/03/2023 13:28, Jonathan Cameron wrote:
> > On Sat, 11 Mar 2023 12:14:57 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
> >> certain data unused:
> >>
> >>   drivers/iio/proximity/sx9500.c:1039:34: error: =E2=80=98sx9500_of_ma=
tch=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =20
> >=20
> > Hi Krysztof
> >=20
> > Thanks for looking at these warnings.=20
> >=20
> > Drop the protection macros instead.  The tables are trivial in size and
> > the of_match_ptr() breaks some ways this driver can be used.
> > ACPI_PTR() isn't as bad, but is pretty much pointless given this size of
> > the array.=20
> >  =20
>=20
> For ACPI platform, ACPI table is used, so nothing for PRP0001. For OF
> platform, OF table is used.

So you would think, but nope.. That's not how it works (I was surprised
when I came across this the first time too)
=20
PRP0001 is magic and requires no specific support in an individual
driver beyond not using that of_match_ptr() macro!

https://elixir.bootlin.com/linux/latest/source/drivers/acpi/bus.c#L754
Docs here
https://elixir.bootlin.com/linux/latest/source/Documentation/firmware-guide=
/acpi/enumeration.rst#L450
>=20
> What usage exactly is broken here? What ways?
>=20
> Best regards,
> Krzysztof
>=20

