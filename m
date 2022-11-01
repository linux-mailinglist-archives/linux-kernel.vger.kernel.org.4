Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9AA61524E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiKATbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiKATbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:31:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BA1DA69;
        Tue,  1 Nov 2022 12:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50C60CE189F;
        Tue,  1 Nov 2022 19:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C577C433C1;
        Tue,  1 Nov 2022 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667331094;
        bh=WyIzLEcN50Fw5PFe9SKdT3KJdU4GGa4/iSjE4+abfmc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iy0cKseHZkLThuvTOkeIMgCEC+VZO0kEfgA5718SGnMx7DWcmz947Jm3aVE7bAbYA
         8jGiq/FqZIAoDgWVuyFXpRwEazh63/R8DcTvJcf/muxytxnWDMJo5RfzlH3z2X05Rj
         VZyFaeUSUzTQC2LT7z8sct2V7pm7fVFEe4ZfvA4eLXjH/UVMKI6g0fcXTu1ekxtsTV
         ThBeBX8nPbbnhgN4EiA94iVxIXHp10RYi4ckwZ/IIM1YoZCZlBK310/xD9WhexCQ1v
         CiZdBAHHoCKVGOgqwgZv5cY1+dZLgHHQJA2zPqJTuLgRDNLExYKQIU5U+c3zYQPlZm
         +Peul+4PXO1Vw==
Received: by mail-lf1-f53.google.com with SMTP id bp15so24763888lfb.13;
        Tue, 01 Nov 2022 12:31:34 -0700 (PDT)
X-Gm-Message-State: ACrzQf1MLNW2LzbCg+LtEjTT2vMeHMYfiOH1jTis/4iGuZ0/UHyRRJ+X
        QG9oSV+m81XXyXEcJXSyZ8tPN7YoBf/q/f2ngQ==
X-Google-Smtp-Source: AMsMyM56o6ehUTqHNJex/6nPD6TozwNOv5iAUrQfO3Tq4EY2MBqu+fisAt2c5ELx7fLLoUJJ/1LYXLFBfHigj58hF3U=
X-Received: by 2002:a05:6512:3e10:b0:4a2:48c1:8794 with SMTP id
 i16-20020a0565123e1000b004a248c18794mr7516415lfv.17.1667331092636; Tue, 01
 Nov 2022 12:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221027044920.23194-1-hayashi.kunihiko@socionext.com>
 <20221027044920.23194-3-hayashi.kunihiko@socionext.com> <20221028193859.GA2188803-robh@kernel.org>
 <0d7636f6-2c51-587d-1961-face98dfa056@socionext.com>
In-Reply-To: <0d7636f6-2c51-587d-1961-face98dfa056@socionext.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 Nov 2022 14:31:23 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+8Rm9v4megza14JPyamV-9Yr4iAa5r+HhM6qtdHRWEBw@mail.gmail.com>
Message-ID: <CAL_Jsq+8Rm9v4megza14JPyamV-9Yr4iAa5r+HhM6qtdHRWEBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: phy: Fix UniPhier SATA controller node
 names in example
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 4:10 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Rob,
>
> On 2022/10/29 4:38, Rob Herring wrote:
> > On Thu, Oct 27, 2022 at 01:49:20PM +0900, Kunihiko Hayashi wrote:
> >> The word "glue" is ambiguous for the controller node name. Should put
> >> "sata-controller" instead of "ahci-glue" on the controller node.
> >> And rename a phy node to "sata-phy".
> >>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >> ---
> >>   .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml  | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git
> > a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> > b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> >> index a3cd45acea28..89b8b133777a 100644
> >> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
> > yaml
> >> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
> > yaml
> >> @@ -117,14 +117,14 @@ additionalProperties: false
> >>
> >>   examples:
> >>     - |
> >> -    ahci-glue@65700000 {
> >> +    sata-controller@65700000 {
> >
> > But is this really the SATA controller aka AHCI?
> >
> > In cases where we don't have a standardized name, I don't think it makes
> > sense changing node names from one non-standard name to another.
>
> I see. This can't be named generic, so this change will drop.
> And "sata-phy" in the same way.

I think sata-phy is fine. It may not be added, but usb3-phy or
pcie-phy are common already.

Rob
