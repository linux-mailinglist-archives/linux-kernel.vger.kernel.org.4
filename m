Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB936A90AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCCGBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCCGBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:01:38 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3613DD5;
        Thu,  2 Mar 2023 22:01:37 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-176261d7f45so1874242fac.11;
        Thu, 02 Mar 2023 22:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677823297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzua8Cl3tTCME8NV0mhnsS8EW+rjsfEa0ZFN10SsFgI=;
        b=eQB3BdL0G3eGddPb3oLdFcwtaZIBLTfdPVUPniwQMa5xxFxvJ8BHaiZETRafVsbKNm
         J5/jmq/LD03N6eg3F7fTtYWnZY7M25YDGDfjKR6yhUzShRGAmBX/2I6skcKoYO5T5NmG
         szD6UW2qmjgRW1ZgJHUUM4g/9UCRZ0jx2P+s1BrTUNwA9dcYdMkch/RS05fjI01Eao3f
         HgS6K2uHrfjNZjAn8mzA4I73LuagoM1Ag9a+sCgYC8DrxSZizy92c+BBAZ1HxbF13fwT
         iRb5nW98pW04qu0h+T9NB2R3uUwVPEEdPmXsjGIJOKtGb7Vw5s7fu3iU/jQpZ4qfju9E
         ylyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677823297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzua8Cl3tTCME8NV0mhnsS8EW+rjsfEa0ZFN10SsFgI=;
        b=Wz462yhY+8eu7xCZMWHwGdXmaLvno22ZMUrtz6ZUWvhi1XrVyiNSYIZfJpr93ITMCr
         CgGr5xpkTOTcQ1+/ikTSXWLt5y5CqCbEq/Nv1Vo6xwNmShXXbE6OJRHhoE2vN756fJmH
         IOpvO3PYJ8BfEnt9+5LMJrxEBaQYRnXwwpeM/tr/61qVDdzJcOsWwGlSpsNNH+4OeVAU
         y01tMgwBi/7odgfhp/VWAr2Qisn9vEwJB6WmvaXN0Un9DwJWbkDToCnpGP37u9QWfjf0
         4aeumPZg+is/uuEa/963yRoQbH5YUL3DZiNhBfLHMOph7Q3chHdxPCP7wwNdKrKQCqlH
         n/Kw==
X-Gm-Message-State: AO0yUKXJqG8ayMHK7tgaSDRsk826o720A2z6xHSYQeEv5GuqXQAGLXcm
        8aiC401oSDPizl/yL+62RcYi7srApG3aZon0dXw=
X-Google-Smtp-Source: AK7set+Hmjz9vN1HtENmntmfhawOBSotKp4hgtaGKlUZ90N9OjYAbSyofATfoSrd9YzuoyrbUtSJk2leiTy4YselH2o=
X-Received: by 2002:a05:6870:d346:b0:176:2168:12a2 with SMTP id
 h6-20020a056870d34600b00176216812a2mr234510oag.2.1677823296922; Thu, 02 Mar
 2023 22:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-2-arinc.unal@arinc9.com>
In-Reply-To: <20230303002850.51858-2-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 07:01:24 +0100
Message-ID: <CAMhs-H98FoBN+B_A0wgwtmSpgZ93YakEtEL6Yf+KwUyoSzhK5g@mail.gmail.com>
Subject: Re: [PATCH 01/20] pinctrl: ralink: reintroduce ralink,rt2880-pinmux
 compatible string
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
> There have been stable releases with the ralink,rt2880-pinmux compatible
> string included. Having it removed breaks the ABI. Reintroduce it.
>
> Fixes: e5981cd46183 ("pinctrl: ralink: add new compatible strings for eac=
h pinctrl subdriver")
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  drivers/pinctrl/ralink/pinctrl-mt7620.c | 1 +
>  drivers/pinctrl/ralink/pinctrl-mt7621.c | 1 +
>  drivers/pinctrl/ralink/pinctrl-rt2880.c | 1 +
>  drivers/pinctrl/ralink/pinctrl-rt305x.c | 1 +
>  drivers/pinctrl/ralink/pinctrl-rt3883.c | 1 +
>  5 files changed, 5 insertions(+)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
