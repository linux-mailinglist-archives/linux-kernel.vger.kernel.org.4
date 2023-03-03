Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AFB6A922B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCCIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCCIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:07:46 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C434E580E5;
        Fri,  3 Mar 2023 00:06:56 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-176261d7f45so2098135fac.11;
        Fri, 03 Mar 2023 00:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677830816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7QpGfrYtcv5SGcNl5G4v9Xn9QWnRvb8nIvOqr78+os=;
        b=k7guXsPHeVoVD+Vbixqv4M6ny4qAnlteCS7f3M/a2QWY9ket+idPpZzazOjWV2xChB
         BM6JK1W8/zLYHqNDb3qfeFY5gw2/BKSJqhcoL59AlX+Mf5dpmvpYCcH0FnYXkDrhGnyG
         oABzxSh7fVn3sAANt/8eywGVPg37mPIC/MK+pQorBKrf6sJROHwznMgt44cyQfsMaFuY
         NxJ5n27phnIZhvv1z3q9cC1JpfLOyYz1W1Fmc44sF9FlCS1nWTyY/+Niy8p9X3XOws1C
         BqOfpWurRWpxgA//uFIjk8m0vaZ63XJ3Uyp3sc8MOLCP5qoTKJjlOhn86d4k3ar4Iebi
         NCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677830816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7QpGfrYtcv5SGcNl5G4v9Xn9QWnRvb8nIvOqr78+os=;
        b=o+IoWJbcwiezMB6xw9WJHsqfhO2e3Q36cmY5z67CaXWDJdrF+6GXCGsXTnj3w4hfjW
         rVI/vn1ZGRCAzOkV/JVp6DSK1tPxwvwngU9ac1vbvrwU8ny/x7cO0vfmQUxe4662bf8o
         JtcG7dugl1fY6v62+my4LjK+86xVYP6msm4qU5e7LbahVDq2MwMRsBYpi1gaEMt6a8RR
         ycDzKW5bgWuEQMuqMak6hu0jZ6k7IgqJhUFaquajR3zRggX69aMOFs9L75O5nD0dkXdF
         PHsqesuAzQPgEPmeHK3bSJdkEzYcu5Wf1EjrU70Mwiy6KGBSc61rjcSbvtU83gns73DP
         GVQw==
X-Gm-Message-State: AO0yUKXcbirOrbjVnrq1GYgqtSqqJ4bJuXrkfc6V5RvZJhUo8k2V/61M
        4irfKTXm1FQnKsKOjInceFhqsBK2kCCG6GACSlY=
X-Google-Smtp-Source: AK7set//qZ7/g6AGTDdSDk92EyeB6C/kVGk1Ak8YIBBkbU9XgYc6bCZY9NyCH6NF2bQsATm6DpVeTt8gOTYu3yGQd24=
X-Received: by 2002:a05:6870:d346:b0:176:42a5:a544 with SMTP id
 h6-20020a056870d34600b0017642a5a544mr246286oag.2.1677830816060; Fri, 03 Mar
 2023 00:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-5-arinc.unal@arinc9.com>
 <CAMhs-H9qVE0Z23Z3J8D1voo5UaKZrjUYU=7V=oRMd8=vVGASAg@mail.gmail.com> <b6dae90f-2c2a-3434-9995-527f33533730@arinc9.com>
In-Reply-To: <b6dae90f-2c2a-3434-9995-527f33533730@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 09:06:44 +0100
Message-ID: <CAMhs-H9RhKjkKa3YoXfOjtzJxTth5ZhTPG3aLp7mT_qmZ-3QiQ@mail.gmail.com>
Subject: Re: [PATCH 04/20] pinctrl: ralink: mt7620: split out to mt76x8
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Fri, Mar 3, 2023 at 8:53 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9=
.com> wrote:
>
> Empty mail?

It seems it was :). Sorry, something weird happened with my fingers
while typing, I guess...

>
> Ar=C4=B1n=C3=A7
>
> On 3.03.2023 09:03, Sergio Paracuellos wrote:
> > On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
> >>
> >> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>
> >> Split the driver out to pinctrl-mt76x8.c. Remove including the unneces=
sary
> >> headers since is_mt76x8() is not being used anymore.
> >>
> >> Introduce a new compatible string to be able to document the pin muxin=
g
> >> information properly.
> >>
> >> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >> ---
> >>   drivers/pinctrl/ralink/Kconfig          |   5 +
> >>   drivers/pinctrl/ralink/Makefile         |   1 +
> >>   drivers/pinctrl/ralink/pinctrl-mt7620.c | 257 +--------------------
> >>   drivers/pinctrl/ralink/pinctrl-mt76x8.c | 283 ++++++++++++++++++++++=
++
> >>   4 files changed, 290 insertions(+), 256 deletions(-)
> >>   create mode 100644 drivers/pinctrl/ralink/pinctrl-mt76x8.c
