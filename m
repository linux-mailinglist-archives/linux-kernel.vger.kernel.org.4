Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA36561CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 11:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiLZKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 05:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLZKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 05:21:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3CC0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 02:21:10 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso14473718pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 02:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WASqzSCgjeGT/fukiuS6QON6/I6X0QmINUoYRtI17JY=;
        b=osa9H8a2saD9qFdVr+mysKOx/tnQaHlyzQXXRSGAIS2ixIJ2KrxjTCn7vxcuAZK+Ip
         OIgXvqHMcXFbaSqqiOQsbWYvxVrd2F3sDLcNScOGK/1lE9zuH5R3zYj9+8OBNX2Emv/1
         UJM35rjr7UbrHIUzXkxjw9BfDsMr6oq9d5Lvnnkh08WPXdFT87tYqYQoWjzJytvrLmsk
         yv422BcRzTjF+q3fn3XsbMStMgqjj1tp/RxjBIcoWTIeh9xiLBCrtTITmSlfVxB5FT+v
         GsQMpF0ecifaTP1hryKuOqq0VNwSoXN+zzCSSnbH/HynkGH5OuhmRyp+IIV4eITqQuO7
         TiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WASqzSCgjeGT/fukiuS6QON6/I6X0QmINUoYRtI17JY=;
        b=CemtLfSWNuD198pnGn9TxMNpMsRxqfNpl10HnnX4K16ei/uq79zLjWfx0RncZrjtc3
         //sapVoz8P/zNrwPzLQ0lwFS6eTaYzsgGx3cRpb0lGUZpDC9+cTmnEQgBO4i7QRWmKyq
         F9mgoMI+8f8Z9IxY7y4bAniV3DKE765QrlDPsNdg03q/MFoy13y19pav2rYDJdDtnZ24
         oBcp00axw8r2FmMocTLUiLZ3St2/ExESJht8IzjLGRUXTUHb9+lUHwi1aTBtsqcqejfW
         ivBP2Tg/HVt+LKoPyr78rAINPaK1D1+LTHu5hP07S17RlcXyKdg3/q8mgdXTrx3oA57R
         fgxw==
X-Gm-Message-State: AFqh2kqB8MuYA8Lk0nloZSrKk5XO4+xMWvkcAnCDazv2BkMEAxIXLefF
        aGa/S/zSOQnkgg6r++fEVW+SSEGuy2zKWclqIr/k6A==
X-Google-Smtp-Source: AMrXdXvdKwcLsuJS3kb5PPVbhahfhIzd1JkGVuX5RoTbk+ukjSOnB8pJu2t1iBGNfLjl9R2ATsYkspQGHhdv8HEX7JA=
X-Received: by 2002:a17:90b:1955:b0:224:0:8766 with SMTP id
 nk21-20020a17090b195500b0022400008766mr1785678pjb.199.1672050069589; Mon, 26
 Dec 2022 02:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20221226063625.1913-1-anand@edgeble.ai> <20221226063625.1913-4-anand@edgeble.ai>
 <CA+VMnFz3JTJt7pYsMcKgt+cqbHNg=f0Tofrp-wgcj-51wkdxUQ@mail.gmail.com>
In-Reply-To: <CA+VMnFz3JTJt7pYsMcKgt+cqbHNg=f0Tofrp-wgcj-51wkdxUQ@mail.gmail.com>
From:   Anand Moon <anand@edgeble.ai>
Date:   Mon, 26 Dec 2022 15:50:58 +0530
Message-ID: <CACF1qne=B535bH1aqjUa6MY72kML4zjvf61_LuE1jTrjEfW_eg@mail.gmail.com>
Subject: Re: [PATCHv2 linux-next 4/4] ARM: dts: rockchip: rv1126: Enable
 Ethernet for Neu2-IO
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Thanks for your review comments.

On Mon, 26 Dec 2022 at 15:22, Jagan Teki <jagan@edgeble.ai> wrote:
>
> On Mon, 26 Dec 2022 at 12:08, Anand Moon <anand@edgeble.ai> wrote:
> >
> > Rockchip RV1126 has GMAC 10/100/1000M ethernet controller.
> > Enable ethernet node on Neu2-IO board.
> >
> > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > ---
> > drop SoB of Jagan Teki
> > ---
> >  arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts | 37 ++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> > index dded0a12f0cd..bd592026eae6 100644
> > --- a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> > +++ b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> > @@ -22,6 +22,43 @@ chosen {
> >         };
> >  };
> >
> > +&gmac {
> > +       clock_in_out = "input";
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&rgmiim1_pins &clk_out_ethernetm1_pins>;
> > +       phy-mode = "rgmii";
> > +       phy-handle = <&phy>;
>
> arch/arm/boot/dts/rv1126-edgeble-neu2-io.dtb: phy@0: '#phy-cells' is a
> required property     From schema:
> /home/j/.local/lib/python3.8/site-packages/dtschema/schemas/phy/phy-provider.yaml
>
Ok, I will update this in the next version.
> > +       assigned-clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
> > +                       <&cru CLK_GMAC_ETHERNET_OUT>;
> > +       assigned-clock-parents = <&cru CLK_GMAC_SRC_M1>, <&cru RGMII_MODE_CLK>;
> > +       assigned-clock-rates = <125000000>, <0>, <25000000>;
>
> Keep them in sorting order.
ok,
>
> Jagan.

Thanks


-Anand
