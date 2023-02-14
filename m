Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8769638B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjBNMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjBNMde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:33:34 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D5D61A9;
        Tue, 14 Feb 2023 04:33:28 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-169ba826189so18810069fac.2;
        Tue, 14 Feb 2023 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgtohfWeywZ5iaLHdRCZwUltQwqi6R7eJSFSt3jFt1A=;
        b=ahSpfx86XqAtB35bv9vGGoPsTo6tRJw76mR/f9pqZP5h4at93ToHPqfDTyaujxVltZ
         Eaeq4YwGMoMFgq5sBAP6R9uK9FGJCoF5BxbILFUoH9jTSuFba91stliOkUWYSizcriZU
         CcBZyHeZiccpZIfU4+Rslmx+q4x5tRv2OA58BhREFE1JoFGirc1DxCx8NhivzUv/TAek
         ejwkNT8SCa/mmHY5WjC7DuXsXHqujkarTBPdeV83IU1FQfj80u9nvShiVEVPKOm1WA9N
         POLQ43bm4XNDmVLZuUyw3DSxGIGd0NXjQ7DV0fZhYQ1yOjfnL3qFaUzYoLEFqcImKnfT
         JxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgtohfWeywZ5iaLHdRCZwUltQwqi6R7eJSFSt3jFt1A=;
        b=rj73OgSz1e8Tbj/QI8xlupS2+0qlCa3nA2Vd8Rx1PJ9HzPJdZPeBIUuNjzERKmh5sG
         KessbfsgXwjAjHL9yB1ozky1NHIE/U0VeKFLgWJExaffq0LDPhOPJC16R0t5QPr/Of1H
         Rlhuo8gPToQKsFF0wJC8fjfWo89RVgo0eCHsiynGx/yvcXVQXLtJy6waLUIsxBHuKh2v
         7w5bIO9IXm8ZwsTCjsuSWVsTj0gv2GkbkwtZ31ZCYhpouW+QLcvQ9vCjosVPvMHk1lP6
         hGepAnactzhflArrtCJZQHXTXUaAL0ySVvW3yM2i7F+QekfNYG6SmbkPRfZI0dPx/t+Y
         do/w==
X-Gm-Message-State: AO0yUKVWoBMmc0BiA97POxNcircPHlaD1+tLYfRduojebvnzoliN7+fH
        WIcmQDK2VuSUhHJ/927KVWZzPqY5tc0uwVM/+Ac=
X-Google-Smtp-Source: AK7set9VmI1aC0fo8MVkfJmUvsrhVzrosS4PhPHb5s/dRPxRa4h1Qrdsu5DgtiwOBWMoPGqOsYrPiPeQ2DIJtDuU9bQ=
X-Received: by 2002:a05:6870:9615:b0:169:fabf:b222 with SMTP id
 d21-20020a056870961500b00169fabfb222mr3882911oaq.83.1676378007140; Tue, 14
 Feb 2023 04:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20230211104915.116253-1-arinc.unal@arinc9.com> <20230211104915.116253-2-arinc.unal@arinc9.com>
In-Reply-To: <20230211104915.116253-2-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 14 Feb 2023 13:33:15 +0100
Message-ID: <CAMhs-H-=Xgv-6OVji13R=kJhQr46cn661nL=Y3DwPc4fwZQxNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mips: dts: ralink: mt7621: add port@5 as CPU port
To:     arinc9.unal@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 11:50 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> On MT7621AT, MT7621DAT, and MT7621ST SoCs, port 5 of the MT7530 switch is
> connected to the second MAC of the SoC as a CPU port. Add the port and se=
t
> up the second MAC on the bindings. Revert PHY muxing on GB-PC1.
>
> There's an external PHY connected to the second MAC of the SoC on GB-PC2,
> therefore, disable port@5 for this device.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc1.dts  | 16 +++++-----------
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc2.dts  |  9 ++++++++-
>  arch/mips/boot/dts/ralink/mt7621.dtsi         | 19 ++++++++++++++++++-
>  3 files changed, 31 insertions(+), 13 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
