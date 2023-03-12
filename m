Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0CA6B671A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCLOOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCLOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4084E35261;
        Sun, 12 Mar 2023 07:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403CB60F3A;
        Sun, 12 Mar 2023 14:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBA0C433EF;
        Sun, 12 Mar 2023 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678630447;
        bh=bWf9bpCUZXJYZe3tQafcDcUrDygNkw9MnO7jzO0YGnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i7S2dr9OZTTP770hKNaO/EcfAwvJRRouoQuRL+l9dbNLC6ClYH0pIxwEndSBOLG1v
         6pNXJUG30TskK+KgUIuu36aUCijBEmGg4daFByJ70kGKhch8OuqZcA8JI6Sr60oo/l
         jd+aihU4iwzdfP+VOJGQit9R6lPfF8OQ+o3GBYsgdsyKlSMCbnaZ6h96yux95eMcFa
         AWbzCq4ahup2I/l0SiYZLcuGVTwpSIV+MpNz9ox97Gwq04yN4PaSQHaht2i4YfDNWz
         PoXnWny2K+GfjkzFzEcTnn9Kc5z7zxRl47b6R+TANOKYgrEfStJWfCAnZxuLSX6Nja
         vOMRDTxeUKkFQ==
Date:   Sun, 12 Mar 2023 14:14:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: proximity: sx9500: Mark ACPI and OF related
 data as maybe unused
Message-ID: <20230312141413.49a130bc@jic23-huawei>
In-Reply-To: <e3deb29a-9468-a937-b95f-ace165aa8085@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
        <20230311111457.251475-4-krzysztof.kozlowski@linaro.org>
        <20230311122833.03b5a3d7@jic23-huawei>
        <c66c3f92-fa33-5af1-6f19-79b6d3530862@linaro.org>
        <20230311184440.22a1ff0f@jic23-huawei>
        <e3deb29a-9468-a937-b95f-ace165aa8085@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 11:17:05 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 11/03/2023 19:44, Jonathan Cameron wrote:
> > On Sat, 11 Mar 2023 13:30:01 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> On 11/03/2023 13:28, Jonathan Cameron wrote: =20
> >>> On Sat, 11 Mar 2023 12:14:57 +0100
> >>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>>    =20
> >>>> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI mak=
ing
> >>>> certain data unused:
> >>>>
> >>>>   drivers/iio/proximity/sx9500.c:1039:34: error: =E2=80=98sx9500_of_=
match=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =
  =20
> >>>
> >>> Hi Krysztof
> >>>
> >>> Thanks for looking at these warnings.=20
> >>>
> >>> Drop the protection macros instead.  The tables are trivial in size a=
nd
> >>> the of_match_ptr() breaks some ways this driver can be used.
> >>> ACPI_PTR() isn't as bad, but is pretty much pointless given this size=
 of
> >>> the array.=20
> >>>    =20
> >>
> >> For ACPI platform, ACPI table is used, so nothing for PRP0001. For OF
> >> platform, OF table is used. =20
> >=20
> > So you would think, but nope.. That's not how it works (I was surprised
> > when I came across this the first time too)
> > =20
> > PRP0001 is magic and requires no specific support in an individual
> > driver beyond not using that of_match_ptr() macro! =20
>=20
> I know, we talk about ACPI table.

I'm not sure I follow.   I thought by ACPI table you meant the acpi_device_=
id
table pointed to by acpi_match_table in struct device_driver.

That one is not needed for PRP0001.  It is irrelevant if there is one or no=
t.

Maybe the confusion is that you think the presence of an acpi_match table m=
eans
we don't also check PRP0001?  As you can see here
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/bus.c#L886
it is checked in all cases.

If you meant the DSDT table being provide by the firmware I don't see the r=
elevance
to this discussion.

>=20
> >=20
> > https://elixir.bootlin.com/linux/latest/source/drivers/acpi/bus.c#L754
> > Docs here
> > https://elixir.bootlin.com/linux/latest/source/Documentation/firmware-g=
uide/acpi/enumeration.rst#L450 =20
>=20
> The code is compile when CONFIG_ACPI is defined, right? Then you have
> ACPI table, so what for ACPI platform is missing? ACPI platform has ACPI
> table.

I don't follow.  A given ACPI platform may provide in DSDT one of two choic=
es
to bind to this driver.

Either it provides an entry from the acpi_device_id table, or it must
use PRP0001 and a compatible entry from the of_device_id table.  That only =
works
if of_match_ptr() is not used.

As a side note, both the IDs in the ACPI match table are not valid IDs for =
use
in DSDT.  We are supporting them only because they have been used on shippi=
ng devices.
Semtech does have a PNP ID of STH but that's not the one used.

Anyhow, to be clear. For IIO drivers, don't use of_match_ptr()
or ACPI_PTR(). There are some legacy cases that we haven't cleaned up
yet, but I'm not taking patches that add any new ones without a very very
strong argument in favour and so far no one has successfully made one.

Jonathan


>=20
> Best regards,
> Krzysztof
>=20

