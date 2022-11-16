Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08C62C749
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiKPSLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiKPSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:11:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ACB6176A;
        Wed, 16 Nov 2022 10:11:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s5so11583157edc.12;
        Wed, 16 Nov 2022 10:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2yhRXVWHTwKqB0FAJ5JUXE/Hz7ioVpMavCshhyMXsA=;
        b=RPE8BLJERTy3CP/G8HJ1kDaEpVIZsegVbKYnKx/AsCuLJM4ebPoHnNLJdGYsLQGA5j
         HiQ1nbJMi6MP66u3GGqNocQJFZV42ApmRmmXLV5DlO5eRvjykAWwU7OZDzdORScHJMuy
         0QBgsp73dq2+23N0GSicJ7YrVPGatFPWaSs6+4nMO0tdY0RICfRt4B4gJZPEN8l400ty
         FGBphV6hwkp2pmtZyUcdj5qu+NDPEDhgAJQgUwcy7qXY3PRwZ9mQu/Xbbh7SYDMRHLjl
         PsCqL6kUbodcXQpdoJmlD2YPZTKCO6gVkVtQGSoT7/4cNlg377eVFay+bUuWqdi9YDKv
         Mf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2yhRXVWHTwKqB0FAJ5JUXE/Hz7ioVpMavCshhyMXsA=;
        b=dwhcihbE4eqjRnTY0u+OsAKaZFTKUYo8ybANvyI/K0zw1BLlu/OFThaJZwBUJYAKL4
         ksxoZ49Kox3Gmu1CYYutZM4objBKLIOSle+EWlndabXO5MtMWytzvgxYd5QZwF8eODlS
         LeeI1zhn3p6rVX/RSK/c6SkLU+ypdqvYzKtFboeduxZbXLlMD8eFD8LqbNfM1woannav
         W8WDbVMGLchVFEg6R4U6Tn5/a6sZh4dSJPYcQC6QlxsGXBpPC1X5l9fu235//QvBN8Ey
         gkWvQdul1WPvFUTDc5FeSevhE8IzAcprBOmsS/ZZTig+onkWdH1RE8vR/AKPXNbfvhQy
         ErwQ==
X-Gm-Message-State: ANoB5plIyzbQVjsVVKivOVZJCU8g/dMtbNg/FZmJS8X8TdH2StbLC5N3
        iGEXB6Hd7spkQN0dYlbpN/it9sc0lrPtCrMKrXk=
X-Google-Smtp-Source: AA0mqf6gDG3miNAiZS+xe0nj1OeHIg9P1WFIChg40NgZQaIuVQPE7S24TE+7gcWVGhg13lPy618bdkXQL5++ztKW7wg=
X-Received: by 2002:a05:6402:f19:b0:461:a1c1:b667 with SMTP id
 i25-20020a0564020f1900b00461a1c1b667mr20586171eda.191.1668622283369; Wed, 16
 Nov 2022 10:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20221111094238.1640-1-linux.amoon@gmail.com> <CAMdYzYp2wSrkOEh-v6Wye32TA9imfNF4CrUdKL7q8pOCQU307g@mail.gmail.com>
In-Reply-To: <CAMdYzYp2wSrkOEh-v6Wye32TA9imfNF4CrUdKL7q8pOCQU307g@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 16 Nov 2022 23:41:07 +0530
Message-ID: <CANAwSgTNYDrkvUw_r_CQbgQ9KpzMqi9NP5Wfx5UvJeDvsyrTcQ@mail.gmail.com>
Subject: Re: [linux-next-v1 1/3] arm64: dts: rockchip: Fix gmac phy mode to
 rgmii on Rock 3A sbc
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

 Hi Petter / Michael.

Thanks for your review comments.

On Fri, 11 Nov 2022 at 18:26, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Fri, Nov 11, 2022 at 4:43 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > On rk356x ethernet phy support reduced media independent interface (RMII)
> > and reduced gigabit media independent interface (RGMII).
> > So set the phy mode to rgmii.
>
> The RTL8211 supports rgmii-id just fine, you only need to go to rgmii
> on these boards if you need to tune the delays manually.

Ok rgmii supports internal rx and tx clock delay
whereas rgmii-id does not supports internal clock delay.

>
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > index ea74ba32fbbd..72e410e3aca8 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > @@ -253,7 +253,7 @@ &gmac1 {
> >         assigned-clock-rates = <0>, <125000000>;
> >         clock_in_out = "output";
> >         phy-handle = <&rgmii_phy1>;
> > -       phy-mode = "rgmii-id";
> > +       phy-mode = "rgmii";
>
> You should be setting the delay tuning in this patch as well.

I will try to fix this in the next version.

>
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&gmac1m1_miim
> >                      &gmac1m1_tx_bus2
> > --
> > 2.38.1
Thanks


-Anand
