Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3889D6C2AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCUHBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCUHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:00:56 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AE20058;
        Tue, 21 Mar 2023 00:00:50 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso8002527oti.8;
        Tue, 21 Mar 2023 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679382050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbrkTS/iLndjrdpPHgh8KLjdf4t93SADOoKQyTzdYQU=;
        b=qqokbMwbpqGKvc0/tIeC8smk2R161+graQop2B9RDdp1Rp4f2j9ZD5EDsAdjv7Mxs6
         V6bsrC58etpR+/N1Xu8MI3i3j4FYCDnsxgj6BGoYQsI0Ki6EkR6KhZx50P+lwgFB2L2l
         YnIdWGPhvnw1YBQJsUNYzLGMMMpiB738hoRvTQEmP80Nkka0PGQCT7sR2ZkeIZYk2deQ
         TWfMZQXNh2KJArJmmcFiI2MtO050vro48998fHm+4qujFqZyzmTSFOqHsWURZQPH9T0q
         6DVGl0pbL7tMBv8BElxwZP+qkf735bQ9Bar5PsdxadjNjuDxvPXp0SG51sPleWv4DcjE
         1jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679382050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbrkTS/iLndjrdpPHgh8KLjdf4t93SADOoKQyTzdYQU=;
        b=SUhTeB3u+fagr9GTJSqSamckpIRKpsW0/ifgNA+tN743NlivpEDpXr4xwWqpc9E48f
         J+LymunkGRcmp/45ZrQJM/wwdp8L0Dxm61P6kKZlvKPKYTRJ3xNaxJs69VEfT+dx+3B6
         YX4DTb9xbb/Z83MKZsUeOupEt6gxUXzx8c2ceh+Anqm91CYh927bBhuZhcuXCdN3FGD4
         OEvHtQfHVKDu2ZnPvLb60HLVmNUmZV1gDgwFZVf/TyQcgXgbd2Sp4BwKPnnySvIHgZ6L
         LVGk08HfXvzSb4EUbbk9S/F78UmZhetmQJHfS1BED8oD+O3w6xr42YHzpMkq2aQ/WJ7h
         YSTA==
X-Gm-Message-State: AO0yUKXeIIcwiZ6f8UnWnM672Y89uMOtk+w8cPm6MKqjLvvM1WlsXhqL
        zFQkzUATr4AUZ8sR1C6YI9enp0df31QCMjfRaQ8=
X-Google-Smtp-Source: AK7set9As8qzNFZRMiI8hYNSzsoJkhpajOQqfBgO3uiI8I+ZIbrUkFthAFTHBSFbp0FMGSO2dXcerwsgheva/lK7ZTY=
X-Received: by 2002:a05:6830:2083:b0:69f:882:cdb2 with SMTP id
 y3-20020a056830208300b0069f0882cdb2mr480283otq.3.1679382049674; Tue, 21 Mar
 2023 00:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
 <20230321050034.1431379-2-sergio.paracuellos@gmail.com> <5f295438-8334-d374-2ae6-2a385ffb317d@linaro.org>
In-Reply-To: <5f295438-8334-d374-2ae6-2a385ffb317d@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Mar 2023 08:00:37 +0100
Message-ID: <CAMhs-H_dSgcPNQVusHWVvztYHptOxSJ_o7G0eU9=M1C7RXdsVw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 7:45=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/03/2023 06:00, Sergio Paracuellos wrote:
> > Adds device tree binding documentation for system controller node prese=
nt
> > in Mediatek MIPS and Ralink SOCs. This node is a clock and reset provid=
er
> > for the rest of the world. This covers RT2880, RT3050, RT3052, RT3350,
> > RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../bindings/clock/mediatek,mtmips-sysc.yaml  | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt=
mips-sysc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/mediatek,mtmips-sy=
sc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
> > new file mode 100644
> > index 000000000000..f07e1652723b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/mediatek,mtmips-sysc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MTMIPS SoCs System Controller
> > +
> > +maintainers:
> > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > +
> > +description: |
> > +  MediaTek MIPS and Ralink SoCs provides a system controller to allow
> > +  to access to system control registers. These registers include clock
> > +  and reset related ones so this node is both clock and reset provider
> > +  for the rest of the world.
> > +
> > +  These SoCs have an XTAL from where the cpu clock is
> > +  provided as well as derived clocks for the bus and the peripherals.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - ralink,mt7620-sysc
>
> Since you decided to send it before we finish discussion:
> NAK - this is already used as mediatek

Sorry, there was too much stuff commented so I preferred to clean up
all of them while maintaining the compatibles with the ralink prefix
instead since that was where the current discussion was at that point.

>
> > +          - ralink,mt7620a-sysc

As I have said, this one exists:

arch/mips/ralink/mt7620.c:      rt_sysc_membase =3D
plat_of_remap_node("ralink,mt7620a-sysc");


> > +          - ralink,mt7628-sysc
>
> Same here.
>
> > +          - ralink,mt7688-sysc
>
> I expect you to check the others.

I can change others to mediatek but that would be a bit weird, don't you th=
ink?

>
>
>
> Best regards,
> Krzysztof
>

Thanks,
    Sergio Paracuellos
