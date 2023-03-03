Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A88C6A90B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCCGDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCCGC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:02:59 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA4093C5;
        Thu,  2 Mar 2023 22:02:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bg11so1031634oib.5;
        Thu, 02 Mar 2023 22:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677823377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY40wTgLWqE1HWG5gSrcD3SfOE1S6aDb/jRZfClrmSM=;
        b=kuZNbXdE6O4INKyXCNzVS0kV/bVcXLFhWJPzILeewXEyHshXoSxVCkzZ+xHvDrSctK
         0h1y79PnJ0TpzAPQHFHhIaS575c2ixyvfRpQfaga1ATI2srYbYD7y9xr0+jJwoezuI/E
         S/AZ72AGafYESH+jKUTDIZa9uvPHvKDnPPjtfZ9m9FxuqxPaBE5AJq5veUjwTD3q63Mg
         LJbpWx5VPMlhgf9h5pZS6p2UMNiV8qddN7ddcq5SPHlKY7RnDz83hP3InszF4ZaM2N27
         +sEkiFB9LtRvPjuM5IvqIy+E2JyS2Xp0bdkY1A457eBwYCbrdn9LYPA2ZGdgWFxik+CF
         AVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677823377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY40wTgLWqE1HWG5gSrcD3SfOE1S6aDb/jRZfClrmSM=;
        b=qd6/Vh67WXdA3ouZVkHmDrotLav8awBLjR5u1XuGu2NbXRn1aurSmLa/9RO9mZjcfT
         PJPsnXbwuV/V9YyVvm5JkFlEOd2MG07327lBzEDVAlOJ2gtzbot0HUEvOpttHI6sfiKH
         dPuxDriJ8lo8xCQZ4tLRokYJTqUlygzrFSD+xPd2LiqswA7s2n/3VGFoKiiprajZd7iU
         zxXbGEhO15LLaHQLJpfQBsuS6B7fJIANd5MboLXbBd0ccmJ/nID9IyVuf/teky+oil/v
         ogw6PYgZXjynZy13+0MwOiVR3kv6KPpI0ytW2d46kMPgado3zTDkhwmjQMTtaEqZDTQ+
         wErA==
X-Gm-Message-State: AO0yUKXfciA4j1+fOBDr+VjZNB5P0bnXVxpGkEZUdg20W7/2AvgoYORD
        PXpRO3Q84FU4UVcixoWfjAYhUwgiuNjctVstYwI=
X-Google-Smtp-Source: AK7set/PPBGBmqaFLu/x/7FEaM9awhg94M6PTTjS9Ii+pHqbbjJ24I27AlnH45802wz/elA/L97MBTJkOhhEpnCw33Q=
X-Received: by 2002:a05:6808:9b1:b0:384:efe:729a with SMTP id
 e17-20020a05680809b100b003840efe729amr201801oig.2.1677823376576; Thu, 02 Mar
 2023 22:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-4-arinc.unal@arinc9.com>
In-Reply-To: <20230303002850.51858-4-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 07:02:44 +0100
Message-ID: <CAMhs-H_Ydu=A8Dcy8L3KZw_32FNW5iCytqUJXqkk8ijzhLK1yA@mail.gmail.com>
Subject: Re: [PATCH 03/20] pinctrl: ralink: rt305x: add new compatible string
 for every SoC
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
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

On Fri, Mar 3, 2023 at 1:29 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> Add new compatible strings to make every SoC, or SoCs that use the same
> pinmux data have a unique compatible string. This ensures that the pin
> muxing information of every SoC, or a set of SoCs that use the same pinmu=
x
> data can be properly documented.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  drivers/pinctrl/ralink/pinctrl-rt305x.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
