Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2137341EA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjFQPb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjFQPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:31:54 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A4A173A;
        Sat, 17 Jun 2023 08:31:53 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-55af55a0fdaso1377113eaf.2;
        Sat, 17 Jun 2023 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687015913; x=1689607913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFRcy9xaOtTkKOFXeluqYOSA9lXpSOxpkjdjDAIDgE4=;
        b=AT538ixHycIm85RDPffWsO9rvNnXRUxHrFBotGzvrmdnjjH4/kINcPQjgq0EaC+cUE
         Kx8dxo3LMHYCsnJJptACcSqYm8J/2e/FOiBz98jsfY7qST1bXLFv/WQURbsH20t9a0Le
         uCJFHY6vAqQIg544kpbaHDJNFi7C9e7DEAVUkRAXp7Okjk/K8nyiQ54J6DABp+sRlBZ9
         Jh0b+nOzTFX2QAmAYFuowAtiDWPP+XFlgAUGtpnSQucwKWSfFXh/T04Ll5fOfSBXkxQ+
         71gHj+SvQkV82eyFi5JsZiGwsUmNd1zK0e1Fgiu5bZAkn6/koL81kAmAlWgqJEDC75KI
         W4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687015913; x=1689607913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFRcy9xaOtTkKOFXeluqYOSA9lXpSOxpkjdjDAIDgE4=;
        b=hCxfvobIxvOR092r0UUhv2TBMplWCISorA8eu6DCEBRXA8BYeWZ6CEyJyqwg4QvyeL
         TyfPxdXswn5iiyJ9MoANq+TyIQ1a1N1v1O+TnWRQPiZXaCMwVJn58hSZ8Ls5UngBK0w7
         h3V0OUsSsSCblLoctHfCeWgYnrjd3m1pasn1esgR3A0ro4X9HnPkBdzZ0GoPk4m29D9z
         NLKally9tMQd6J40UNnS5WX1LYdZ4mZGENnz03IDlvZA+DEbUoc2vLo4+m1KVE8idnCP
         71aKCOJ+dHACXF7GtL0gFTEclOrjmp+UqsMlLoFt9ZcDqwshSRprsjRl2mOn8keCl8in
         n+ew==
X-Gm-Message-State: AC+VfDzBtKLRIQ8oN7aNRL2lhDbKRcz/mCw0hU5rFZYUV0Az+iLkP0l3
        Qj3qF+AOAaR6K4kzoe8h96Dqdvd3mVs75pyxKr0=
X-Google-Smtp-Source: ACHHUZ4IUR51rgg1xp03+pO4cesgi9skb05Qde4K9z5nZ+EveB4NjJamwCKIv9Mom8aYSM1s2T/cx+YTL9VUZHMOfGM=
X-Received: by 2002:a05:6808:1a1c:b0:39c:6a30:cc7f with SMTP id
 bk28-20020a0568081a1c00b0039c6a30cc7fmr7329093oib.21.1687015912939; Sat, 17
 Jun 2023 08:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230617052435.359177-3-sergio.paracuellos@gmail.com>
 <TYAP286MB0315AB8274CDD341D49809A2BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <CAMhs-H8rt3-ffvjkNSORiNXQUVCUHCc7FNwYN7TOyQ0DxCe2fA@mail.gmail.com> <a61180e8-5732-2208-3a0c-e2b0137f9290@linaro.org>
In-Reply-To: <a61180e8-5732-2208-3a0c-e2b0137f9290@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 17 Jun 2023 17:31:41 +0200
Message-ID: <CAMhs-H_UZowVdVvQ_G_Jm+yLeCELDxjG=FQDQ-OOLt8FHJUZYg@mail.gmail.com>
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

On Sat, Jun 17, 2023 at 4:44=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/06/2023 15:26, Sergio Paracuellos wrote:
> >>> void __init plat_time_init(void)
> >>> {
> >>> +      struct of_phandle_args clkspec;
> >>>       struct clk *clk;
> >>> +      int cpu_clk_idx;
> >>>
> >>>       ralink_of_remap();
> >>>
> >>> -      ralink_clk_init();
> >>> -      clk =3D clk_get_sys("cpu", NULL);
> >>> +      cpu_clk_idx =3D clk_cpu_index();
> >>> +      if (cpu_clk_idx =3D=3D -1)
> >>> +              panic("unable to get CPU clock index");
> >>> +
> >>> +      of_clk_init(NULL);
> >>> +      clkspec.np =3D of_find_node_by_name(NULL, "sysc");
> >>
> >> The node name should be "syscon" as the example node name in the
> >> dt-bindings document is "syscon".
> >
> > sysc is label to get this node since it is the one shared by all
> > different dtsi files.
>
> If it is label, why do you use it to get by name? name !=3D label.

Sorry I meant both of them, node name in dtsi file and also label for
referring to it from other nodes.

>
> Best regards,
> Krzysztof
>

Best regards,
    Sergio Paracuellos
