Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266B56B5FD8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCKSry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCKSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:47:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8F069074;
        Sat, 11 Mar 2023 10:47:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A996B80066;
        Sat, 11 Mar 2023 18:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB54C433D2;
        Sat, 11 Mar 2023 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678560468;
        bh=kFQx+HAbFEs5u6irGsPPllMCYBhAE9GYQcqAluddabM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGrSTOFFLMEXwu72vZf9uR1FY46yrpAE39ishw/tXQGZR+UeVBJ6igm/87EB59wXt
         cUyz2vEloyc2Vwrrzm+pibg4pcV/1uiA8GbkyRK2m1YKARfKEUQDRZtQp1+lik0Lmx
         WQx+5+dWIKmQ8WWzNqNgvRzLQMQeOu9hM7XyAALsqX3o99S9iu5qLjxlVq+Pp7Ud9I
         3YgTRxI+E2D6kGfEw4fLcMfWRDupPRMVfytGlDGt4kVuRg0EPeGQHf++Hc1THz+yY/
         m/ZLw6n+W0+k0RTz4kd3vCFrCnzGKBmEbx4JBwYMf+fq3r7aJRdguznYtQRK6jD6br
         gmNXo7a0tnDLQ==
Date:   Sat, 11 Mar 2023 18:47:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: rcar-gyroadc: mark OF related data as
 maybe unused
Message-ID: <20230311184752.303c5bf2@jic23-huawei>
In-Reply-To: <179df7bf-8ab4-c3a7-7af2-d576670e3d9e@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
        <20230311122342.7aa5e6ad@jic23-huawei>
        <179df7bf-8ab4-c3a7-7af2-d576670e3d9e@linaro.org>
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

On Sat, 11 Mar 2023 13:26:12 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 11/03/2023 13:23, Jonathan Cameron wrote:
> > On Sat, 11 Mar 2023 12:14:54 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> The driver can be compile tested with !CONFIG_OF making certain data
> >> unused:
> >>
> >>   drivers/iio/adc/rcar-gyroadc.c:286:34: error: =E2=80=98rcar_gyroadc_=
child_match=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=
=3D]
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =20
> >=20
> > Whilst in general I'd prefer to see these converted to generic fw prope=
rties, this
> > one is not trivial. So applied to the togreg branch of iio.git.
> >=20
> > It would be nice if anyone has time to circle back to this and get rid =
of
> > the of specific stuff. =20
>=20
> This is device ID table. What do you want to remove here? What OF part?

All of it (well not the table, but the code that directly accesses the
table).  As a general rule I'd like to see all driver in IIO
using the generic firmware accessors in property.h so that they work
with PRP0001 and other firmware types (see reply to later patch)

It's understandable that a given driver is only used on dt based
platforms, but that doesn't mean I wouldn't prefer generic code
if we can do it easily.  It becomes easier to review and better as a source
of code that might get copied into future drivers.

Jonathan

>=20
> Best regards,
> Krzysztof
>=20

