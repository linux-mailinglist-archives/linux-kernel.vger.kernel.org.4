Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8416A90BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCCGEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCCGEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:04:22 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C3D16895;
        Thu,  2 Mar 2023 22:04:18 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17671fb717cso406493fac.8;
        Thu, 02 Mar 2023 22:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677823458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7cWEU8HBpDT1/6MmuaACtH+747N38odJNoAvMZIW4s=;
        b=HvMhQ+C++OAaROBUVGxijhPsBRIWJ2d22Q39MiHLywKs7Fyuzr9ikuCa20DuiD2SjY
         cgDQ57q2ESmg6yGM2J00VxQGgLPb93w+O4hPPqVRcsqVUJmwEtGy02Y7G9ehQzIys/CB
         mC82JiZeAxRlo+UlyYpLqWf6q48BwHIOOPpia8lt4mVDUjn5RVW4T9DRKcI0Xxz+FXbo
         YC6BwvTCCuIavWR8B5SZhO9tuDm7ejZrjP5TP1WXU1kk+LM6UrFOtjpWucI4M86qjuU3
         yNXd+5hTfawTOw0g3zKIxcqtQzHuPQnwnKyjsvHcI+i4Z3NkXox/gw+0XDFEae/+fzfp
         +f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677823458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7cWEU8HBpDT1/6MmuaACtH+747N38odJNoAvMZIW4s=;
        b=ewaoL0Zy7jgULVJ8DcdlzMzz4eYXtU4HmxaHE2J8Pyib0QhCKhgi63aE4fw6NCZl+s
         Ocf0KN2QSsW6JltKk6UCKWlNx+bubZaEoPFXB4yDTuf7iYksioAGxo3gVlkbdrsuS4CI
         XLACQeqpZxu1sM7rmqUdPIYtr0CNGuuh2YJ9Ax7pxQaJXajPN+Gzpnyc9o/86HY3dyyg
         wHbxwYqkDR/lb3ZpHQDkZ6l8qa9Qbd+cqsZOoq9VM+/zKZQ6P5QFifOMgNe6tmyDEq4e
         Ta+EkLush73Tu8+ddX8TPLEurHXVDjRRLtrE8pa3aCzOsBGeQxJhDp2N/EgsC726IQye
         UdJA==
X-Gm-Message-State: AO0yUKWmWcgz7ETx8a+XElUQYotJed+GwFb+NyeLe0IhWYosYX/ZVJzd
        Ng9rJpdLVQ0r/ofsHkLD8yUvXUj2Knb0nQ+pUdg=
X-Google-Smtp-Source: AK7set8poKz9lmsr4x7Pzww0rh+JcHA/O5B1fvAZHniZfyEHHNU5hGFb/a4ovY5xGj1iTGUZoY9D+1fIUZNTHc0x+J8=
X-Received: by 2002:a05:6870:8c2f:b0:176:45a7:1ec0 with SMTP id
 ec47-20020a0568708c2f00b0017645a71ec0mr252872oab.2.1677823453219; Thu, 02 Mar
 2023 22:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-5-arinc.unal@arinc9.com>
 <CAMhs-H9qVE0Z23Z3J8D1voo5UaKZrjUYU=7V=oRMd8=vVGASAg@mail.gmail.com>
In-Reply-To: <CAMhs-H9qVE0Z23Z3J8D1voo5UaKZrjUYU=7V=oRMd8=vVGASAg@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 07:04:01 +0100
Message-ID: <CAMhs-H9kPMsaMHJx703qSS4fxZh_KyGib+VKf9DfP0s085O3Mg@mail.gmail.com>
Subject: Re: [PATCH 04/20] pinctrl: ralink: mt7620: split out to mt76x8
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

On Fri, Mar 3, 2023 at 7:03 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
> >
> > From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >
> > Split the driver out to pinctrl-mt76x8.c. Remove including the unnecess=
ary
> > headers since is_mt76x8() is not being used anymore.
> >
> > Introduce a new compatible string to be able to document the pin muxing
> > information properly.
> >
> > Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> > ---
> >  drivers/pinctrl/ralink/Kconfig          |   5 +
> >  drivers/pinctrl/ralink/Makefile         |   1 +
> >  drivers/pinctrl/ralink/pinctrl-mt7620.c | 257 +--------------------
> >  drivers/pinctrl/ralink/pinctrl-mt76x8.c | 283 ++++++++++++++++++++++++
> >  4 files changed, 290 insertions(+), 256 deletions(-)
> >  create mode 100644 drivers/pinctrl/ralink/pinctrl-mt76x8.c

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
