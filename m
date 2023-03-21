Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B572B6C2B70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCUHfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCUHfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:35:44 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418F07ABE;
        Tue, 21 Mar 2023 00:35:42 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-17ab3a48158so15465944fac.1;
        Tue, 21 Mar 2023 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679384141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdHfj4sdFMGXDnAj5aOPs1KpxyU4UUeMTEwbtSXJ54c=;
        b=LBQpduqOap6tVJmYINV6onRQ2QPO+9UdWalgPVl/1NdQwYSxscoSrPPtWTpMJmTaZc
         piMsJXuBiVXFk+J3Sdpn5LYyE6bwxsWc6lReQ2slWGn97gf95GeYPscVypiMptCBi8O4
         JU7d3ard6XMJhxhlj5WLxD1Rf921wvCxEx9b65AgXzuaTW6PBHiFsStJ0S7gPPPAngB6
         E6duzrf/OgR8tPB9U4fxDpf5kVgxW1DqFiz0YL7EuSbxUGlttSmqY0KTpfVFtqS4n3iJ
         yoHT6G6SnZO54bQgVIt/LUjxXE6Km708JbunJwQgEkEHe7Mk1JsWwXTXeu8+atwP6gL7
         Bw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdHfj4sdFMGXDnAj5aOPs1KpxyU4UUeMTEwbtSXJ54c=;
        b=0SJRcK9ELJGofos17AxeVI5+o0P6GhnwbOW2L1ruxDa7Jqpls/CJ85Q1ugxYeRBVZB
         ST1QTTbBb8ZNOOmgZsSfVxPHOCjYnARHzpcihYSIgBWGkQkoYW4K7u4OP899UbhcICEi
         PgE7CHiIiHVWQ+ipoV9Ad9zoy560dJPCX3apGyHNBA8lHipSjc9VDDzFsXCSovKn0WVq
         qD3SRyfKb25OT+z+/gamQFCpcADQWmzfsj/yENNA+oSvnCqbGH0xCl40M5YQGlimlSNH
         cL+I9yAcyUQ3W57j6y43Cze4xIdG6p6XFYkm6U9EIIjH/9b//NtimuScirFIg9MxUZJw
         jBkg==
X-Gm-Message-State: AO0yUKUEkOlYb4xT46ImbP+jSXwHoWyM/SbnrkTVWy69bwkz/wbN/Y5B
        FCxxryp/DEK0KGgHfZoN5ZJd1gX418+zfU/c7rZU+8qBDu+k6g==
X-Google-Smtp-Source: AK7set/1n3lp8dOhZMqOoyuQesh615zIgJC3SfMMrLq0l5xZcGIIvBxf2PJUsrIjODZByGDuC+hQCaBSqmFZgaTLAns=
X-Received: by 2002:a05:6871:4904:b0:177:abbb:f20c with SMTP id
 tw4-20020a056871490400b00177abbbf20cmr374592oab.0.1679384141429; Tue, 21 Mar
 2023 00:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
 <20230321050034.1431379-2-sergio.paracuellos@gmail.com> <5f295438-8334-d374-2ae6-2a385ffb317d@linaro.org>
 <CAMhs-H_dSgcPNQVusHWVvztYHptOxSJ_o7G0eU9=M1C7RXdsVw@mail.gmail.com> <0ece990e-fd81-856a-bd0e-8a2572448aa3@linaro.org>
In-Reply-To: <0ece990e-fd81-856a-bd0e-8a2572448aa3@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Mar 2023 08:35:29 +0100
Message-ID: <CAMhs-H81DYAQYbNo+tNj+M1Og+cgomcTepPUBiLK7QXmbjuB=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: clock: add mtmips SoCs system controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
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

On Tue, Mar 21, 2023 at 8:16=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/03/2023 08:00, Sergio Paracuellos wrote:
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - ralink,mt7620-sysc
> >>
> >> Since you decided to send it before we finish discussion:
> >> NAK - this is already used as mediatek
> >
> > Sorry, there was too much stuff commented so I preferred to clean up
> > all of them while maintaining the compatibles with the ralink prefix
> > instead since that was where the current discussion was at that point.
>
> You did not even wait for me to send feedback on this, in old thread.

My apologies, I thought it was better to send it at that point. Will
wait for feedback from now on before sending anything.

>
> >
> >>
> >>> +          - ralink,mt7620a-sysc
> >
> > As I have said, this one exists:
> >
> > arch/mips/ralink/mt7620.c:      rt_sysc_membase =3D
> > plat_of_remap_node("ralink,mt7620a-sysc");
>
> And why do you ignore others which have mediatek?
>
> >
> >
> >>> +          - ralink,mt7628-sysc
> >>
> >> Same here.
>
> Same problem.
>
> >>
> >>> +          - ralink,mt7688-sysc
> >>
> >> I expect you to check the others.
> >
> > I can change others to mediatek but that would be a bit weird, don't yo=
u think?
>
> No, I expect to have mediatek where the model is already used with
> mediatek prefix.

It is clear now, thanks.

>
>
>
> Best regards,
> Krzysztof
>

Thanks Krzysztof.

Best regards,
    Sergio Paracuellos
