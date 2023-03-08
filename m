Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59086B0769
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCHMrY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Mar 2023 07:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCHMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:47:21 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6487F9BA5D;
        Wed,  8 Mar 2023 04:47:20 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id o3so11004291qvr.1;
        Wed, 08 Mar 2023 04:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678279639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QoG6lFQOa6DcT5o3dgKUDLc2SadqzJqm0y9eSB0xFU=;
        b=nG+j4YOD2JVhSl4hcyKpdvmK1un8v0edt9ZYfajsDJF2EPXTDHpUIq7sV7Xs7TkAaX
         24+DKRctJyQx2iKDSorirYl7q+2jfcVOvokkQlVSs18pTj3qfjxer6a3U6R+utcvhqvk
         vL7Le6zYCtQ5OKiLRPTGXxVuSyXjclh36pBtmv4m7C8DgyE1ZQ6hlYIWLsz1niSK2OX/
         jz3Uv2NfU1biXphD3jNoojZMJf7sqa3oBXbnB6F+5fvy3uR76IB7js3NKucLsuIYRfJU
         IOYiHleFexcL8bif22kpgg/omwKhMUL4b9IrbMKYT/Wdi5A+/AwHg4jsWppyYPss2dt9
         eFag==
X-Gm-Message-State: AO0yUKXtLdCWEy+p+kNzme47KNM+cyccNS/FTOsF3lBgx3SSU3stfjng
        by6bWuNa8T+c1HQlY1JJ9Q6WNEDTU4tP+RT1
X-Google-Smtp-Source: AK7set9JBOfDxCQq+YtBlsQQAhBu+VBVXlH+b5fhIVEb2NsojjgW7dZ+Kr0ZfdnI4RUt4vx59S+5AQ==
X-Received: by 2002:ad4:5749:0:b0:56e:9551:196b with SMTP id q9-20020ad45749000000b0056e9551196bmr33500719qvx.3.1678279639330;
        Wed, 08 Mar 2023 04:47:19 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id n132-20020a37408a000000b007425dade624sm11436821qka.41.2023.03.08.04.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 04:47:18 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-536cb25982eso301993487b3.13;
        Wed, 08 Mar 2023 04:47:18 -0800 (PST)
X-Received: by 2002:a81:ae18:0:b0:52e:b22b:f99 with SMTP id
 m24-20020a81ae18000000b0052eb22b0f99mr11588158ywh.4.1678279638260; Wed, 08
 Mar 2023 04:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230216175347.99778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXNrBCdLvMKK6kPbMLhSmuxXtd5A+Lt4J0ddVorODqCvw@mail.gmail.com> <CA+V-a8up5tnNt==6nUcpK44o+eN0VVMLdtLD5NyZzd37Rx=GgA@mail.gmail.com>
In-Reply-To: <CA+V-a8up5tnNt==6nUcpK44o+eN0VVMLdtLD5NyZzd37Rx=GgA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Mar 2023 13:47:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXz-giK7M-Z0EeBwJrgvStEk_U+ocBmUrkK0DkDFMSZxQ@mail.gmail.com>
Message-ID: <CAMuHMdXz-giK7M-Z0EeBwJrgvStEk_U+ocBmUrkK0DkDFMSZxQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: rzg2l-smarc: Add OV5645 node
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, Mar 8, 2023 at 12:08 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Mar 6, 2023 at 7:27 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Feb 16, 2023 at 6:57 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > OV5645 sensor can be connected to the CN1 connector on the
> > > carrier board. This patch adds the ov5645 node under i2c0 node.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > > +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > > @@ -6,6 +6,10 @@
> > >   */
> > >
> > >  /dts-v1/;
> > > +
> > > +/* comment the #define statement if OV5645 is not connected to CN1  */
> > > +#define CAM_INTERFACE_OV5645   1
> >
> > I believe the camera is optional ("can be connector" above).
> > So shouldn't this be commented out by default?
> >
> Yep, that makes sense.
>
> Shall I send this change or will you be generous to do this while applying ;)

As this has an unresolved dependency on "[PATCH v2 0/2] Share RZ/G2L
SoC DTSI with RZ/V2L SoC", I cannot do that yet...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
