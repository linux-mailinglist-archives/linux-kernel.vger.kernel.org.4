Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A296069402F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBMI66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:58:42 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8F3C08;
        Mon, 13 Feb 2023 00:58:31 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x26-20020a056830115a00b0068bbc0ee3eeso3517743otq.0;
        Mon, 13 Feb 2023 00:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XDApV+TQsaAczWZIC7r05ZJzQoVsoU2vq6O/+VFkR8=;
        b=Piy9/ZyE7+GQGZ0gw5fxiuT3hsROm257raDQa+O/WvpCgPqnbSfckbKZA1QO+lQJb5
         +0CL/431ltXek3flUd+gBsYs3NUhyIIj+P6vDrvVZ7rbIOMChJo20m+KFQNdczundxNY
         MoFT5xad8G6M364RYrD113ufbzW0POqJSJyk2G0IhWXAckxAxlD8h0lfmCyS7AWCHtgr
         djgCAYPouf6k0OoI+6LjbRuBNsiTHA+9ZWXg1XLD00xUfIiOKUmi9gGFwOMQaoHquwfH
         +SF6kVNPGBaYRmK5qVicCgBUxbNIuitIV9Y6ZgxUjHvNcBz7UOvqUbOgv86Za3c4IlTw
         mj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XDApV+TQsaAczWZIC7r05ZJzQoVsoU2vq6O/+VFkR8=;
        b=U9BuiW+wZZ3RXcaLbpyNYvsnZvkIOSIs/FFgKuikJ+l7vtxRTcFfyVYtrqAJ4A6iUj
         cd61diJsA1u/XDkGAfzQtXZoTvzZSOZT9P3WOm+2m3bdxZrcd2SEUh5cLhYlvTOUTJ1n
         jFb8zOO3WvGIKVxhzHFVHo3Q0q7rYce+VHBony/TQ5Ldx0x2nFmMg/KRsY8GOQgXRClp
         Cuyvygam+QrNr5ldehlOlDOMrlxF4k7s06TwR7HbT6TaPcjEdNdHz8AVn9hWKbhPSLi3
         qSXf1GZuD27aWy89DvrZuqmHSCSli2mOMhl3F65pYPXhCxFq9DZrc75Rg5Ut+ppS/tOE
         wG9Q==
X-Gm-Message-State: AO0yUKUR+xuNKFzZqouYWwxiLugo2p0ExnJwnJovcUpJf2lr32K+pNez
        uyiUs9e5Vs9DYExMr41CeWopAp71D4gzI4T0clM=
X-Google-Smtp-Source: AK7set/XQN1bHnHh38gDwEcs8AsUYgO9jtYwvo7fp5L4jM0g2x8kPbg8l4pOgQ5FbM1/+r9tcAm0bEU/RbeGZlaTnoE=
X-Received: by 2002:a9d:454c:0:b0:686:b479:ce9c with SMTP id
 p12-20020a9d454c000000b00686b479ce9cmr2177662oti.132.1676278711219; Mon, 13
 Feb 2023 00:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com> <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
 <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com> <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
 <76353597-0170-e0d9-9f5d-f208a03e44e8@linaro.org> <CAMhs-H-JGZMR6mB=USywAh4aRS9ZFOVebwLv8=N2f3uvWpcXDA@mail.gmail.com>
 <d10e541a-cdfd-08af-6a2c-eb7edcdb486a@linaro.org>
In-Reply-To: <d10e541a-cdfd-08af-6a2c-eb7edcdb486a@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 13 Feb 2023 09:58:19 +0100
Message-ID: <CAMhs-H-rKmks4xL-nK8BF7RtRxX95aYhH6VUpvy_bR1-=-xdLg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
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

On Mon, Feb 13, 2023 at 9:38 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/02/2023 09:13, Sergio Paracuellos wrote:
> > On Sat, Feb 11, 2023 at 12:42 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 11/02/2023 12:01, Sergio Paracuellos wrote:
> >>> On Sat, Feb 11, 2023 at 11:47 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.una=
l@arinc9.com> wrote:
> >>>>
> >>>> On 11.02.2023 13:41, Sergio Paracuellos wrote:
> >>>>> On Sat, Feb 11, 2023 at 10:10 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.u=
nal@arinc9.com> wrote:
> >>>>>>
> >>>>>> Is this mediatek,sysctl property required after your changes on th=
e
> >>>>>> watchdog code?
> >>>>>
> >>>>> I don't really understand the question :-) Yes, it is. Since we hav=
e
> >>>>> introduced a new phandle in the watchdog node to be able to access =
the
> >>>>> reset status register through the 'sysc' syscon node.
> >>>>> We need the bindings to be aligned with the mt7621.dtsi file and we
> >>>>> are getting the syscon regmap handler via
> >>>>> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Ar=
=C4=B1n=C3=A7.
> >>>>
> >>>> I believe you need to put mediatek,sysctl under "required:".
> >>>
> >>> Ah, I understood your question now :-). You meant 'required' property=
.
> >>> I need more coffee, I guess :-). I am not sure if you can add
> >>> properties as required after bindings are already mainlined for
> >>> compatibility issues. The problem with this SoC is that drivers becom=
e
> >>> mainlined before the device tree was so if things are properly fixed
> >>> now this kind of issues appear.  Let's see Krzysztof and Rob comments
> >>> for this.
> >>
> >> If your driver fails to probe without mediatek,sysctl, you already mad=
e
> >> it required (thus broke the ABI) regardless what dt-binding is saying.
> >> In such case you should update dt-binding to reflect reality.
> >>
> >> Now ABI break is different case. Usually you should not break it witho=
ut
> >> valid reasons (e.g. it was never working before). Your commit msg
> >> suggests that you only improve the code, thus ABI break is not really
> >> justified. In such case - binding is correct, driver should be reworke=
d
> >> to accept DTS without the new property.
> >
> > Thanks for clarification, Krzysztof. Ok, so if this is the case I need
> > to add this property required (as Arinc was properly pointing out in
> > previous mail) since without it the driver is going to fail on probe
> > (PATCH 5 of the series). I understand the "it was never working
> > before" argument reason for ABI breaks. What happens if the old driver
> > code was not ideal and totally dependent on architecture specific
> > operations when this could be totally avoided and properly make arch
> > independent agnostic drivers?
>
> It's just an improvement and improvements should be incremental and not
> break ABI.

Understood.

>
> > This driver was added in 2016 [0]. There
> > was not a device tree file in the kernel for this SoC mainlined until
> > 2022 [1].
>
> 2022 march was almost a year ago, so there were kernel releases with
> this ABI.
>
> Also, what about all out of tree DTS? What about other operating
> systems, bootloaders, firmwares etc?

Pretty clear, thanks. So I guess I have to drop all the changes that
are breaking ABI and just maintain those that make no real changes in
bindings.

>
>
> Best regards,
> Krzysztof

Thanks,
    Sergio Paracuellos
>
