Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440DB6E55A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjDRAOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDRAOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90B40EF;
        Mon, 17 Apr 2023 17:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0852D625AD;
        Tue, 18 Apr 2023 00:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A31C433EF;
        Tue, 18 Apr 2023 00:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681776889;
        bh=hCnAMgracnaMWnyimoPLYpmDd+TChHfuJQ/Cc2RYEOQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fvOfJr+Tr1PEclqHfq4GKHtrP0oL60L8GpqkMQ6umKWd7ejucFxregZcYig52mMui
         Ue7inDUYRiuegsTeoRuItwCKFB1LaoRbGxIKTNBpJVUs94AvDUYjHiL7pt5vdsckF7
         saKk0sZKlot5MjvIjaY1scLfhaLHxOWuz059K2JtE3ov/Um9Q4TYWiW9PbEatRPVLT
         LaqTyVkGmYFWGxSeFMW1vj7gcQsmLhgeQRyD3kAxT0EWoPcwgmd3RRaNuShbJvZ0zO
         1FngLk3e4FJAdCVnSHlbR0HtZqPet9FRpDqw9DaKUTrSa6g5etEOdePpCEs0njboO4
         lpHHympB0H2ZA==
Message-ID: <4dc69da7d894621817e74697fccf36a1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAXyoMOuNx_3eJyPHt4TYOtpzh0U5opWBPgEEeXF7izw==pNFQ@mail.gmail.com>
References: <20230414181302.986271-1-mmyangfl@gmail.com> <20230414181302.986271-2-mmyangfl@gmail.com> <20230417204934.GA3334964-robh@kernel.org> <CAAXyoMOuNx_3eJyPHt4TYOtpzh0U5opWBPgEEeXF7izw==pNFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add reg-clock-controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Rob Herring <robh@kernel.org>, Yangfl <mmyangfl@gmail.com>
Date:   Mon, 17 Apr 2023 17:14:47 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangfl (2023-04-17 14:39:23)
> Rob Herring <robh@kernel.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=8C 04:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sat, Apr 15, 2023 at 02:12:59AM +0800, David Yang wrote:
> > > Add DT bindings documentation for reg-clock-controller, collection of
> > > basic clocks common to many platforms.
> > >
> > > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > > ---
> > >  .../bindings/clock/reg-clock-controller.yaml  | 245 ++++++++++++++++=
++
> > >  1 file changed, 245 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/reg-clock=
-controller.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/reg-clock-contro=
ller.yaml b/Documentation/devicetree/bindings/clock/reg-clock-controller.ya=
ml
> > > new file mode 100644
> > > index 000000000000..a6a7e0b05821
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/reg-clock-controller.ya=
ml
> > > @@ -0,0 +1,245 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/reg-clock-controller.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Simple straight-forward register-based clocks
> >
> > 'simple' means extended one property at a time with little foresight. In
> > the end, 'simple' bindings are never simple. s/simple/generic/ as well.
> >
> > When we first started the clock binding, we had exactly this. There's
> > still bindings for at least some of it. It turned out to be a bad
> > idea because it was difficult to get correct and complete. So this
> > binding is exactly what we don't want.
> >
> > Rob
>=20
> Thanks. So in the next version v2, clock-controller are made merely
> container of clocks. The real jobs are done by sub clock nodes, so
> that clocks, with or without hardware-specific clock types
> "compatible", can be declared independently and individually as dt
> nodes, instead of hardware clock "controllers" with quite arbitrary
> clock identifiers listed under include/dt-bindings/clock/.

No. Write actual drivers and actual bindings for real devices.
