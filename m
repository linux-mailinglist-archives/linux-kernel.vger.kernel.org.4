Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA906B8D25
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCNIVo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 04:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCNIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:21:18 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F695E13;
        Tue, 14 Mar 2023 01:20:15 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id r5so15905234qtp.4;
        Tue, 14 Mar 2023 01:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678782014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4lI7q9jGUXAO8uwyJQW1pOS/OekqJ62OeVWS1QjDXo=;
        b=pChzl4WF4vG8/B023IFFGU07jZ6u1W7FsZkzdP/nJ8jgfShReUbIYN1hSx7alOO8th
         IafVsykxsqPpeSLmXGvyVd0ZXatz4Wv8wmSGyxShRNwbiSt1gj1VVCuj1TrwK/iwKGJ+
         QV+nqAzzJfh1soz8J3RWUUkEWSZFMOAMcX0CYIwVa/FZQ3yO4CA/YHcUeMA9Vp0aQIeb
         dTwXy0nRLb8RztL23viv6hiZejm/01oKYuUlNyuC5kwRpXvh4kO84x5bEcuLqs4ZPSix
         CPd9wahpxq2gADovrvS1iSHH1odpXDzG4rmx9srCcrIbxoGdFlEZvWtV+fhIYdaib7Ne
         zh6w==
X-Gm-Message-State: AO0yUKXvZn9eD/Cd1z/3B4aH+Edd9m+FDf1eI5cXmsyivXWMH0NvkFGt
        cPQaa10x5HcStmDi2BxdgejhBKJ4FaF2oA==
X-Google-Smtp-Source: AK7set962J6QcB+c/GwoJ9V/s1IQe5RIZBCUm9yIyDHsUCKBiZ+AR7KBMlwUioGyZ1U7yEdty1AICg==
X-Received: by 2002:a05:622a:1895:b0:3bf:b504:d5ea with SMTP id v21-20020a05622a189500b003bfb504d5eamr31503547qtc.48.1678782014341;
        Tue, 14 Mar 2023 01:20:14 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 71-20020a37054a000000b007436d0e9408sm1293889qkf.127.2023.03.14.01.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 01:20:13 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id t4so14539774ybg.11;
        Tue, 14 Mar 2023 01:20:13 -0700 (PDT)
X-Received: by 2002:a05:6902:188:b0:a99:de9d:d504 with SMTP id
 t8-20020a056902018800b00a99de9dd504mr22847227ybh.12.1678782013408; Tue, 14
 Mar 2023 01:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230216175347.99778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXNrBCdLvMKK6kPbMLhSmuxXtd5A+Lt4J0ddVorODqCvw@mail.gmail.com>
 <20230308230001.GF31765@pendragon.ideasonboard.com> <CA+V-a8uQ8fAc-F=7WokcH4otbap0F_ik9Dnw4GpB8ALdVRuWgg@mail.gmail.com>
In-Reply-To: <CA+V-a8uQ8fAc-F=7WokcH4otbap0F_ik9Dnw4GpB8ALdVRuWgg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Mar 2023 09:20:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbUqkHOxkJR7_QNa8zstwysHZ0vt45M3dimwQajVfuBA@mail.gmail.com>
Message-ID: <CAMuHMdVbUqkHOxkJR7_QNa8zstwysHZ0vt45M3dimwQajVfuBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: rzg2l-smarc: Add OV5645 node
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
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

On Mon, Mar 13, 2023 at 9:54 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Mar 8, 2023 at 10:59 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Mon, Mar 06, 2023 at 08:27:19PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Feb 16, 2023 at 6:57 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > OV5645 sensor can be connected to the CN1 connector on the
> > > > carrier board. This patch adds the ov5645 node under i2c0 node.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > > > +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > > > @@ -6,6 +6,10 @@
> > > >   */
> > > >
> > > >  /dts-v1/;
> > > > +
> > > > +/* comment the #define statement if OV5645 is not connected to CN1  */
> > > > +#define CAM_INTERFACE_OV5645   1
> > >
> > > I believe the camera is optional ("can be connector" above).
> > > So shouldn't this be commented out by default?
> >
> > Even better, could you turn this into a DT overlay ?
> >
> Please let me know your thoughts on this.

I agree with Laurent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
