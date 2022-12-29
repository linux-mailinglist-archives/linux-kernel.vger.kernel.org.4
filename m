Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4B658DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiL2OPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiL2OPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:15:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB012ACF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:14:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u28so21996949edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjmRScmtp39n7S/rhPWTeGcIUneg1sLl3mxQCDJTbJ4=;
        b=UMg+Eagqzm9m4G0WN1qu1Ig+mNVJCESqXKCNyLJyVThGMogTRfhqtXfTYYuROYdDcV
         Us1Z3moaio3gQnSz6HwciysU9e1JsAxYriDD7hl48tA8hEfCiJ0uDlXC+pHZmUfL4wR2
         b2hsqiK6utyuLratU/hjW2UJ7jqd4UiJvytikO/UwaKsE5Ri/S3bGbdkHNdXpYTpOVTE
         JMIa4PwRuY2hKUNLHGg8h4YKQfAWwRb1iPRmk/08Gv6kiViFrPwct/oyQL4S6rrBsAb2
         hs1LH0GBvvPafRhEAjDsR2wsol3cMdVVFXTEKRb3YFL9UHfJiePqtH6mAq3h09nrB/X0
         1hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjmRScmtp39n7S/rhPWTeGcIUneg1sLl3mxQCDJTbJ4=;
        b=pioHbVl6kAUs8C/v4ccVCYdjGyZqA4IEKcyukoouuYSUNTbHlzUSiqzM9q2Y3RSzam
         1p4pd1j7qLKIE4oX+tvuy3zLtOO/i3HsRK5wXBLzNQzQGFbv3jyJNTcE2FZJic8i/gU3
         77LSJn7Z4Dm4fM22vWShnTOlboXLvaxk0qcx1ZyOtRwkZFDxq77hlgKYv/FT6FfcG7Hh
         kA/Jvn2Ak7fMArE5Q97FeQeCZ+2DO/H0LO87vKzD8PirjWgYo05BvG1zxs0qU2yk+Alj
         9tgH1zORiP7Irof9oLUWAWNDQBf8jOq5BHOfp5Go+mOb4Bht1PHax8L6iyzurxGU6CCi
         nkFA==
X-Gm-Message-State: AFqh2kok0RwonCB0QeMqP48HUpriAHhSm00BlILHuWR4wpXnJ5WOOAj9
        sT6df5ZMeCCJnEsKK1z5Vxg+x+qFv3/0y3Y7TEB520uaEd74ahHHYXQ=
X-Google-Smtp-Source: AMrXdXurSWhoSAECW0DaIhzk9hAe4irvaadE6oZbV9MWek1ZwrnALYGKoeNwYn4EUNBKsCD1tvpbZ6N5flvZu9aT+Z4=
X-Received: by 2002:a05:6402:34d1:b0:485:8ee3:83b with SMTP id
 w17-20020a05640234d100b004858ee3083bmr1216510edc.395.1672323298175; Thu, 29
 Dec 2022 06:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20221228200234.86391-1-mig@semihalf.com> <Y6zuJrb+8j+XCksN@lunn.ch>
In-Reply-To: <Y6zuJrb+8j+XCksN@lunn.ch>
From:   =?UTF-8?Q?Micha=C5=82_Grzelak?= <mig@semihalf.com>
Date:   Thu, 29 Dec 2022 15:14:47 +0100
Message-ID: <CADcojVPnZYtNHJUsLJCcHTnG=j0dfCbDNRqf2xmhcmV3b-oGfQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: dove.dtsi: Move ethphy to fix schema error
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        mw@semihalf.com, upstream@semihalf.com, mchl.grzlk@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for quick reply.

On Thu, Dec 29, 2022 at 2:32 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Dec 28, 2022 at 09:02:34PM +0100, Micha=C5=82 Grzelak wrote:
> > Running 'make dtbs_check' with schema in net/marvell,orion-mdio.yaml
> > gives the following warnings:
> > mdio-bus@72004: Unevaluated properties are not allowed
> > ('ethernet-phy' was unexpected)
> >       arch/arm/boot/dts/dove-cubox.dtb
> >       arch/arm/boot/dts/dove-cubox-es.dtb
> >       arch/arm/boot/dts/dove-d2plug.dtb
> >       arch/arm/boot/dts/dove-d2plug.dtb
> >       arch/arm/boot/dts/dove-dove-db.dtb
> >       arch/arm/boot/dts/dove-d3plug.dtb
> >       arch/arm/boot/dts/dove-sbc-a510.dtb
> > Fix them by removing empty ethphy subnode from dove.dtsi and describe
> > PHY on the relevant board .dts files level.
>
> I don't think your description is correct. What i think is causing the
> problem is that the ethphy subnode in dove.dtsi does not have an @X.
>

Yes, it is exactly the case. The problem is after adding dummy address
e.g. ethernet-phy@0 in dove.dtsi 'make dtbs_check' shows warnings
about missing required 'reg' property, that's why ethernet-phy is
moved to .dts files.

> By moving it into the .dts file, you can then give it the correct @1,
> or @3, which makes the linter happy. The kernel itself does not care
> about this, it is an example of the linter being much more strict than
> the kernel.
>
> If you agree with me, please update the description.

This patch exactly fixes this issue by setting proper
ethernet-phy@<reg value> in board files.
In such a case would you like me to update the commit message to
better describe the change or do you have other remarks to the diff?

Best regards,
Micha=C5=82
