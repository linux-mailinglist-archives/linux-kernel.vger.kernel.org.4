Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9035F09A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiI3LNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiI3LMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:12:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08A1D0C3;
        Fri, 30 Sep 2022 03:49:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c30so5466622edn.2;
        Fri, 30 Sep 2022 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sLfdwfGAGdIy8Vpz4sY75ob+Mqn+9Fq+UGKJ4awK39k=;
        b=ZgK9Ndov9go63KjVYLBZCO1oyIL+Rmq/LOi916CpZgVR1EqHENZGRBHqBHaXvYm2ql
         9y1hCravDhx9MtMoOEXw0qcjwaG8Sm62TaZjrEijWi8reLJiWJvAeXwc4A+Mew8V3kzO
         Mlcvxx6wrjyr8uw+yiJ/i1h8Dnscd46dwzx9q010CfituYy8ku5W+rCQ0z0Xs9evM+2w
         17A0QwIfyZOSigujAwqyEklg+2PcrL5hbOrp2s0BRPBVDvQ0fThyDTemK3du7sQiXAHn
         ltdnnqGEEaAp3rlS/H8NO3Q3kaf+t6dYmDWE6R1OyY/zINKueOybyJln71jcD+JOoOC5
         fNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sLfdwfGAGdIy8Vpz4sY75ob+Mqn+9Fq+UGKJ4awK39k=;
        b=qyKlDV/tXtEfVRKv1T0n3wHZl+9l4A6Oq6nwgq1CcmAzImv54zGVwK9DEjw/LSBxIN
         mqE38i4rwp1blLS3iFsRookzWUnugHZaJUxKx26aR9p5/NfYAAuqtXqDtVNpJp0rU3UD
         piDb0SwFPqqKj+wqBC3xlw63BFzG9o5Alr/SRZv3PpjxmKO/5YbmoNqM5M5alMrY2AxO
         DhaBssjC0rmBdIVB2gFiq/idCe8hgEBne3Zg5+BkNkBle1KxnIX1Lv7hAe6WAm0vy6Q2
         8AS5/GfX7n2ZhKKwTjncw84KEs8pHjOENW8B+ASjzCL9LLbsxE/54wZQxnmn4gPQDtlM
         cEXA==
X-Gm-Message-State: ACrzQf1teb4coIH9gXos54OXZZe8wQzBDatiIJiwslz/AoXz8znCvuxc
        KcrWiz7c4drjEGJ5zUVSTfIUAbBjvs5mW3ozf1E=
X-Google-Smtp-Source: AMsMyM7pepGBTUy4k8d3hvfUhWEzxrda1LrTQ9lj8CMjGDl0RbNoscnhTrhV+41iJDaVBt3woPtSdxfr1RJdbL2AvzY=
X-Received: by 2002:a05:6402:40c2:b0:44f:963d:1ab4 with SMTP id
 z2-20020a05640240c200b0044f963d1ab4mr7425439edb.319.1664534989283; Fri, 30
 Sep 2022 03:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <29d456ed-620c-8dc9-01f0-54f96b670b94@linaro.org> <YysHAkWBfTTAJF3E@pendragon.ideasonboard.com>
 <ba436dd5-2ea2-b2e0-7056-5bae6b4c7bb4@linaro.org> <YytJ/oJK9s2mfqPL@pendragon.ideasonboard.com>
 <bba1ed72-d691-b51c-dce8-ab9a2e45fe86@linaro.org> <YyxnJ/Ho5rZQzDDN@pendragon.ideasonboard.com>
In-Reply-To: <YyxnJ/Ho5rZQzDDN@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 30 Sep 2022 11:49:22 +0100
Message-ID: <CA+V-a8vaHPbXQWyMeVWsFaf3mUSAECcJiiww5xmhC99+zm3SuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: dt-bindings: Document Renesas RZ/G2L CRU block
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent and Krzysztof,

On Thu, Sep 22, 2022 at 2:46 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Sep 21, 2022 at 08:58:26PM +0200, Krzysztof Kozlowski wrote:
> > On 21/09/2022 19:29, Laurent Pinchart wrote:
> > >>>>> +  clock-names:
> > >>>>> +    items:
> > >>>>> +      - const: vclk
> > >>>>> +      - const: pclk
> > >>>>> +      - const: aclk
> > >>>>
> > >>>> Drop the "clk" suffixes. Remaining names could be made a bit more readable.
> > >>>
> > >>> These names come from the documentation, isn't it better to match the
> > >>> datasheet ?
> > >>
> > >> If datasheet calls it "vclk_really_clk_it_is_clk_clk", it's not the
> > >> reason to use it. :)
> > >>
> > >> The "clk" is redundant even if the hardware engineer thought different.
> > >>
> > >> The same for IRQs ("tx" not "txirq"), for dmas ("tx" not "txdma").
> > >
> > > I'd argue that naming clocks "v", "p" and "a" would be less readable and
> > > more confusing. Is this a new rule ?
> >
> > Not really, but also it's only a style issue.
> >
> > Indeed "v" and "p" are not much better... but still "vclk" does not
> > bring any additional information over "v". It's redundant.
> >
> > You can also drop entire entry - unless it helps in particular
> > implementation.
>
> There are multiple clocks, so I think names are better than indices. If
> you really insist we could name them "v", "p" and "a", but I think the
> clk suffix here improves readability. If those clocks were named
> "videoclk", "pixelclk" and "axiclk" I'd be fine dropping the suffix, but
> that's not the case here.
>
I have got the below details from the HW  team:

CRU_SYSCLK -> System clock for CSI-2 DPHY
CRU_VCLK -> video clock
CRU_PCLK -> APB clock
CRU_ACLK -> AXI clock

So I'll rename the clocks to below respectively:

+  clock-names:
+    items:
+      - const: system
+      - const: video
+      - const: apb
+      - const: axi

Does the above sound good?

Cheers,
Prabhakar
