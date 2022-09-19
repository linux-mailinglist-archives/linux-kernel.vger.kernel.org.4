Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730065BC44D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiISI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiISI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:29:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802682019B;
        Mon, 19 Sep 2022 01:29:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sb3so33076261ejb.9;
        Mon, 19 Sep 2022 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4zcyc92OG48ogsdYCIfTilNt+HWdmHS2QUl5rmdNbKQ=;
        b=Mbyaea9joV5Z04uUaXOey5blWnFhyLpUFH2zbj0XzeuPVaY1YxWOI312oZxAKd4+p3
         ZIPeUaS6OVmp86SoVDJvEmkuClmMWPbjAS0wH85ZLnSFOMvLwKynBbenF7Dg2MZbxoLy
         PK33G9xHWSSX5o6dP6S3kazUralBCJ1ZBqSSAZDkQneZP2+gHZih8sPfbP9O8wDVpdO1
         lu1T+HudfjVIZg0EdahYT3MCknBf1CyG3yIEkYfueC/2DwWP+kSVvayWpT2vDmlvLIw/
         FQkaVRUP0WcZ9OlO2vp7hSK8X7veOqJlv3vapU/WJcDqMEX06WIc2bz7tNGNJMqJEmdU
         pYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4zcyc92OG48ogsdYCIfTilNt+HWdmHS2QUl5rmdNbKQ=;
        b=nanR2Ds1A7pGN21HdF/+iVVV1+eolqdi8yfmOmIVWMtRHQHmOVXUiL4VQUoGPZ8+qK
         tX47PqjdUrPClER0+/IcyWoHv04PXBYRsozYldcjui+7NWiLRTw9iA7SkiSm/7eFAv2X
         UtvbceSSwQ6Aj571HzrvMbCM4csJ9sGbz6QIPl1furkt8VhLxv8IAmCPveEl8hOP5QoQ
         f96BLIgixmBy7DbT9Jicqr+LVbW9I1TRKPFOhtI+FXZc6hKRgnyN5ivimJ30Wla49P7N
         9bgpGpSC8/SVaDOLICzHYTWZFoks0j6sdD4Egc8VApyd7FhYDwZVms95vE5VrDjx6YMo
         gzog==
X-Gm-Message-State: ACrzQf3bEO5oF88/Fu8bqNS6Rdh6Lh3JdJEjeqn+wo3c5RGcxKtWPNgr
        AgYyK4ZRJ93QaCto3GhpZPBCYrAjhCdlPCdZE3Q=
X-Google-Smtp-Source: AMsMyM7/hjerL0W6LJrp0rFq9iZ0Mgo7LX65TfbIFF5E+HnImfL99FE74Bd+G9W3/XFCs/bEjpv84UribM8ShNF3JjA=
X-Received: by 2002:a17:906:591:b0:73d:c3ef:84ae with SMTP id
 17-20020a170906059100b0073dc3ef84aemr12149565ejn.155.1663576141043; Mon, 19
 Sep 2022 01:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915165256.352843-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVKYqHu-mmviwO5oLS-F8nEg5wynLmy=+tJrQ26=VfV2g@mail.gmail.com>
In-Reply-To: <CAMuHMdVKYqHu-mmviwO5oLS-F8nEg5wynLmy=+tJrQ26=VfV2g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 09:28:33 +0100
Message-ID: <CA+V-a8ut=bNA_tD5n+Gv-w6=o0EDcKL+QRDaH42kBini-Kybug@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI
 into board DTS
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Geert,

Thank you for the review.

On Sun, Sep 18, 2022 at 10:21 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Sep 15, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Move including the rzg2ul-smarc-som.dtsi from the carrier board
> > rzg2ul-smarc.dtsi to the actual RZ/G2UL SMARC EVK board dts
> > r9a07g043u11-smarc.dts. Also move the SW_SW0_DEV_SEL and
> > SW_ET0_EN_N macros to board dts as they are used by SoM and carrier
> > board DTS/I.
> >
> > This is in preparation of re-using the SoM and carrier board DTSIs
> > for RZ/Five SMARC EVK.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.1.
>
> For consistency, you may want to do the same with rzg2lc-smarc-som.dtsi.
>
Agreed, will do.

Cheers,
Prabhakar
