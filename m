Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF67341FE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjFQPha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjFQPh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:37:27 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB692113;
        Sat, 17 Jun 2023 08:37:26 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-55b2fb308bbso931607eaf.1;
        Sat, 17 Jun 2023 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687016246; x=1689608246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpEgbAvd4Rpa2cpb2b0WRy6XUI0q4eSUyrFvXMVL2do=;
        b=boiIxLq0ZLviOjBySVDMyTsKwtsAOv9+aiF09uJNx2btNybkQhokxSbdCLwHS2Yab4
         2G8xP9Kav0I2mOAE722v+6rrxnCqeI+9KQOOtvKJG2HAP/REiRHCg+nSSkwme01/ptEC
         v3s+KP85Mz4EcP8viIB/AEQ9aXprHspyS2pBSF4/7uTjFA3gSAcsgR8OnBvW1wgLqGWQ
         CJ9ZBVn/2aJMzrPYVBtqQhZ3Q3/Gm4kQZnNdIOtwYaqj18vaO+raphmY6ZwkfKipSxK+
         9k7iyvrMaS3XcuD6bgGm8OnHuP3UNX2NU2c4r4EGY8AL2TznojXSweAbQj+IEEy3uN1+
         DwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687016246; x=1689608246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpEgbAvd4Rpa2cpb2b0WRy6XUI0q4eSUyrFvXMVL2do=;
        b=ROLrEIQ4ei/mlbDSpRGpavX2pKsiYb7ic0KI5YgzCAEPmw4sbT78yUq0VyFnx9lDzU
         c4veIuDDdI0sSDU6u+239mzns44P1Ks5NA3n7juqPwyyf0LsaJ8p4Pd5HvEnBXTF/Sws
         aMF7OD2NkA2NzW/+tZTTual0q8M1098ewbcZtojYJcSVlZiN7qw1EDB/OQBtbs+7NufA
         sV/Xbzt17lr0EAS/Mb7PRXGuzijkpYCor3zCUmBY5/jHiAhWCh8eVocOkH7sHmVtRJUm
         vAql+ltQV+py+OLRE0Yq0CSnHNIeDd6cAsG5aEP/FoUdXAm5f2Puyd4ARSespBg1WFoz
         pAPw==
X-Gm-Message-State: AC+VfDypsoaCpblRe0DfwwbB4XxHJEuLYVkVmyO71rmauw6ctQyRVvdZ
        5uaUnOq4bdQG3kqBBIvQ7jOQsH4rAwyU9PNEiNg=
X-Google-Smtp-Source: ACHHUZ5Hg4nujb0aOEaoOvIl6Kzj5cmF6w9DyuViIoF+QZBbd31I3dH2InAlhWSjePdQtQXRIhjf4hosor9uu/6jOV0=
X-Received: by 2002:aca:919:0:b0:39a:bf44:7f40 with SMTP id
 25-20020aca0919000000b0039abf447f40mr4099020oij.55.1687016245759; Sat, 17 Jun
 2023 08:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230617052435.359177-3-sergio.paracuellos@gmail.com>
 <TYAP286MB0315AB8274CDD341D49809A2BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <e0f74bdc-3a4b-596a-5ec7-83054377813e@linaro.org> <CAMhs-H9M_c8+AkqUTpYeS2q7_+wBA-jhhiXj-QVXNUDmuERcOA@mail.gmail.com>
 <05e3ff33-ad4e-d2fb-dfd5-7b5265881b74@linaro.org>
In-Reply-To: <05e3ff33-ad4e-d2fb-dfd5-7b5265881b74@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 17 Jun 2023 17:37:14 +0200
Message-ID: <CAMhs-H-ncXC37SAMkLfrFmpRi0ORkkCV9rQmrtmw_ndOLo+J0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shiji Yang <yangshiji66@outlook.com>, arinc.unal@arinc9.com,
        devicetree@vger.kernel.org, john@phrozen.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 4:43=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/06/2023 15:31, Sergio Paracuellos wrote:
> > Hi Krzysztof,
> >
> > On Sat, Jun 17, 2023 at 3:07=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 17/06/2023 14:54, Shiji Yang wrote:
> >>>> void __init plat_time_init(void)
> >>>> {
> >>>> +    struct of_phandle_args clkspec;
> >>>>      struct clk *clk;
> >>>> +    int cpu_clk_idx;
> >>>>
> >>>>      ralink_of_remap();
> >>>>
> >>>> -    ralink_clk_init();
> >>>> -    clk =3D clk_get_sys("cpu", NULL);
> >>>> +    cpu_clk_idx =3D clk_cpu_index();
> >>>> +    if (cpu_clk_idx =3D=3D -1)
> >>>> +            panic("unable to get CPU clock index");
> >>>> +
> >>>> +    of_clk_init(NULL);
> >>>> +    clkspec.np =3D of_find_node_by_name(NULL, "sysc");
> >>>
> >>> The node name should be "syscon" as the example node name in the
> >>> dt-bindings document is "syscon".
> >>
> >> NAK for both.
> >>
> >> Node names must not be an ABI, unless you talk about child of some
> >> device node. I don't think this is the case here. Look by phandle (for=
 a
> >> device context) or by compatible (looks the case here).
> >
> > We need to get the cpu clock to set the initial cpu clock here. Search
> > by 'sysc' is the only  shared in all the dtsi files since it is the
> > clock provider node. Why is this not correct?
>
> Because device node name can change anytime and your entire Linux driver
> gets broken. Node name is not an ABI.

Understood.

>
> > I don't understand what
> > you mean with look by phandle for a device context.
>
> Your device node should contain phandle to the other node.
>
> > The case of
> > searching for compatible is a mess since as you can see in the
> > bindings there are tons of compatibles to search for, then (this code
> > is common to all ralink platforms).
>
> Compatible is one of the ways using ABI.

Ok so it is also a broken approach, then.

>
> Best regards,
> Krzysztof
>

Thanks for clarification.

Best regards,
    Sergio Paracuellos
