Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2B677E86
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjAWO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjAWO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:58:13 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1457DA6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:58:11 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4d59d518505so175656047b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvTqSv9IiiqJO7FY0k9EPMcUo95Z2K5HRqvuXpd73A4=;
        b=weCELVEjnhgirLS0yfICmHlYM1tJJK/1wLN12zzmlA69lZ/8m7OZl49Sz1klvbgzoU
         ne/WEVg5nXjUUCYdrmxXAnOYWpxrm0aQPTqm0gFH1HGewVCAs3YecycYgaTPaBcocZW3
         UizWpTtV2T6B1V0KueIpIOc5VABYaNPLZNPyDWZEV128P67OAl5aVs6DoR1asmQAwz5R
         CLePFN0oG16pKNmhr3T1iga/Y2bQK58xHS9mw4iNNDJZUnmUehfF/q+DX4P+TplSGWVR
         Mz22E+WC/kxzVjbef1FVlrkj46Nq11iZ4Wa8Q+Qp0DLV1m0TzVzc8/5c7iaHVfV6u06g
         Rj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvTqSv9IiiqJO7FY0k9EPMcUo95Z2K5HRqvuXpd73A4=;
        b=Jdihx9rcmFmOWK/0IrTGNPhsTIaaxFJqfpv4c4FmRV8JfNQYtAiK6uiN2t1ISSYeXG
         3vNV9Fwlr6vtbJtEpcs7FaQjep112pUH89dF1MrzWjX7qg6SrecmAvFcP5DCi+tV3iVA
         tpbiy0StOGkNyqBld0WqM40eJK7MA0VxkBYRj8kyM6kY1jPyYH8UgTAMZzgWJvfaqxiM
         ZxylLw4TGDTkXSbYZqJmMzRhrn+THwMm655tNz6kPlYD7NOKtVjFY/HQ6qRD1qMi2WGW
         60fJaYU8iLokmmxBR81p122kwgzBcm1n0MNuWCjmCA1BTzkcXyWN/mXGoo6h+ehOZrQW
         YZCg==
X-Gm-Message-State: AFqh2kpXI524YJYYFrFWJmGaGXFbJLKbr5F6scaZCmk6mqy7TD2PZGHl
        EpYMGmLkMGsKcffAvaXSyT87/EHV8Xi+KnpPMBd7tw==
X-Google-Smtp-Source: AMrXdXvb8K7VSIORVsr8Qw4LbxKTz53T405uI7iUamoWMQKa2zwGzQKmuAxlkobEyafiMl05CCpJpwK2s4Bv3QBaFj0=
X-Received: by 2002:a81:11c2:0:b0:3e8:76df:4afd with SMTP id
 185-20020a8111c2000000b003e876df4afdmr2507306ywr.380.1674485890612; Mon, 23
 Jan 2023 06:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
 <20230120082054.610626-1-michael@walle.cc> <CAFGrd9qXL-u4XzG9MLK2zbKoDudhTYpr-gJaZPjbysJ9Fo2gnQ@mail.gmail.com>
 <2aa2ff64cfd3b5ccd1342873fffa6cb4@walle.cc>
In-Reply-To: <2aa2ff64cfd3b5ccd1342873fffa6cb4@walle.cc>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Jan 2023 15:57:59 +0100
Message-ID: <CAFGrd9pKuMsjmqg=mPsrwn=u7pCHdHEGaiW5PnwA_=TSte5sDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
To:     Michael Walle <michael@walle.cc>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 23 janv. 2023 =C3=A0 11:44, Michael Walle <michael@walle.cc> a =C3=
=A9crit :
>
> Hi,
>
> Am 2023-01-23 10:37, schrieb Alexandre Mergnat:
> > Le ven. 20 janv. 2023 =C3=A0 09:20, Michael Walle <michael@walle.cc> a =
=C3=A9crit
> > :
> >>
> >> From: Alexandre Mergnat <amergnat@baylibre.com>
> >>
> >> > Add the "mediatek,genio" compatible string to support Mediatek
> >> > SPI controller on the genio boards.
> >>
> >> What is the use case of having the spidev? What if I want to
> >> connect a device with a linux driver to it? It seems like you
> >> just want to expose the SPI bus on the pin header. There was a
> >> similar discussion for a mikrobus connector [1].
> >>
> > Yes I want to expose the SPI on the pin header for two reasons:
>
> Then "mediatek,genio" doesn't really describe the hardware, does it?
> If you read that linked thread, NXP was also trying exposing the SPI
> bus on a pin header. IMHO this is just misusing the userspace spi-dev.
>
> That being said, exposing something on a pinheader (or on a standardized
> connector) seems like a common thing and we should be working towards
> a good solution. I still think Robs proposal for the mikrobus connector
> makes also sense for your case.
>

I don't think this is the same case. For the mikrobus case, it's
consistent to have a connector because it fit with other "add-on"
board which can be plug on the "mother board".
Here I've just a simple debug pin header. I've taken a look at
raspberry pi and Beaglebone black DTS, they don't use connector, but
DTS overlay to enable SPI. I think you're right when you say that I'm
misusing the userspace spi-dev.
