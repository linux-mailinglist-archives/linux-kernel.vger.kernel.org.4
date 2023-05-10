Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A47D6FD989
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjEJIfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbjEJIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:34:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB1786BE;
        Wed, 10 May 2023 01:34:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so66722965a12.0;
        Wed, 10 May 2023 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683707648; x=1686299648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0p9eN+ggVsgeu7VJetFmhwwW1D4ZwxzfXfjX9kMJRM=;
        b=aeJMh3kSstDe1tz2bumuhjkcM10fYPnNrpPFTf8YaH+43l4LdtxVqZKDDS6zar4ITc
         Hqyxpo3mhZi7S8O/stKHeIkPNQubDmKQi8SGpJkxKOFdRwNDNhH3LTiSZx73UID970SX
         013fKgK1EoMIFg0iEmRgbk7wzOrtA4JRBD3VzS6NgvmgOPdYGXf5Ygbz87M9CEQrZG87
         w98LSZC1YVvPzzi+1uODZ3QtjeZbPvjh1op9tN/oulKncSxqKt09CrFJHKxfhWftL6n0
         rwX5KAgGtkRzfriquYC1kaYGLT+z8RrY62wCWWEAo72iNN1rQv2ZBRYgnmhRbqe1njoH
         HVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707648; x=1686299648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0p9eN+ggVsgeu7VJetFmhwwW1D4ZwxzfXfjX9kMJRM=;
        b=g1KPI59tdl53McNW6Lqth6tDqUEQ19vBGbzrJuyAK5oC/F4Bfn5Xm7PkWasJUxSYNm
         w4mZD1XeKvko8KudK0vQc3pKtDPwCK6S/Bw0+HPiIDNi5Hd4Hhu7WPcvPUplrRwOlYls
         xuUJtvGVo0Vff/W80k5gbeUDalhb6fUUEX3tnh+1cBSMZgqrYPWQHezFvU6Ht3ZAt1+m
         A/KQOPextAbGBEu4+DfYJNcihEkJJCe0zeq9apTR8WBpRfgiBHB6D3vKPeKB03YdI0Zc
         HrF46OOx8rDE41tXwTyYxH8cyN2zZycrhmJiJ1Q5C+taWmqVQEOK8i4WxMj1zKqaE92o
         PcFw==
X-Gm-Message-State: AC+VfDy86LyuaZ+RAfU9KwFZdxz5+Dqn7fEEocOQfT4Ezp6SgnzYBba3
        Yx/GC3FVlCrcxCjRhWXRGoj08TFvmAd84kwPruo=
X-Google-Smtp-Source: ACHHUZ5LA+oyV/jkzhbvC/Oj8UgFvIAECULeZEfOx2nOpmbXWSiznXG43fIAKb5+pEqhaTHmHRKki6vY600b90D3Eyk=
X-Received: by 2002:a17:907:724b:b0:94d:e2ef:1618 with SMTP id
 ds11-20020a170907724b00b0094de2ef1618mr14022272ejc.7.1683707647722; Wed, 10
 May 2023 01:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
 <20230506232616.1792109-3-bigunclemax@gmail.com> <702d085b3b814759a344886364c518f8@AcuMS.aculab.com>
In-Reply-To: <702d085b3b814759a344886364c518f8@AcuMS.aculab.com>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Wed, 10 May 2023 11:33:56 +0300
Message-ID: <CALHCpMh84Q8RAh2Y+cHzAvsm4h5zBZY=9fPF6OVmtLNvX+ePxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] spi: sun6i: change OF match data to a struct
To:     David Laight <David.Laight@aculab.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David

> Is it worth doing a structure copy at this point?
> The 'cfg' data is short and constant and it would make
> the code that uses it smaller and faster.

I'm sorry but I don't fully understand what you are suggesting.
In patch 3\5 we extend the sun6i_spi_cfg structure with the has_clk_ctl fie=
ld.

=D0=BF=D0=BD, 8 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 12:47, David=
 Laight <David.Laight@aculab.com>:
>
> From: Maksim Kiselev
> > Sent: 07 May 2023 00:26
> >
> > As we're adding more properties to the OF match data, convert it to a
> > struct now.
> >
> ...
> > -     sspi->fifo_depth =3D (unsigned long)of_device_get_match_data(&pde=
v->dev);
> > +     sspi->cfg =3D of_device_get_match_data(&pdev->dev);
>
> Is it worth doing a structure copy at this point?
> The 'cfg' data is short and constant and it would make
> the code that uses it smaller and faster.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>
