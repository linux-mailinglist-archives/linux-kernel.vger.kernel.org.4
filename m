Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6685D66BC65
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjAPLFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjAPLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:05:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1B510E8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:05:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x10so37335131edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DkTQIvOTy2Q+K4dJuv6vPdsOqGOw58PTiozdPxfZn3I=;
        b=ED6QSrMSUPNHwFiTOrKroYXFmam4lacEgtZHDTlJNUpWMEL4jpdoM2kBWOqUELlHw7
         2bj5P3opYT0PPSSfaBzk0RpDdc6EdHW1T4R6kSoYMYNRAEtssW4RBLnmttw/IKapOJPb
         PH2E2tvWImw0CwO1A72ACqZlVvDAQMEXcnJxXA2kG6pxV/xxo4xx8MBKiVYrdj4N3v44
         EL826unFaCLt1nrKeMeZOKGrxJgM+Ado/7w0WF1WTUV/X7PGpRnfdZlZIHoFucFLE+FG
         NyoBr7BrCkbIOhbY8fLkIk60R/SBtZoTeW3ktTExq1t6OAwVN3ifO2Psev+/84LyyDvg
         xjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkTQIvOTy2Q+K4dJuv6vPdsOqGOw58PTiozdPxfZn3I=;
        b=NWgFUxg6H/IlvKO8nJjbj51mHBObvgYs5An9Apzt/XClw4Aty8kH47oOfwhl2Bioix
         7WOHleOhjgPbthIhK9Ou/LeAHIVO2G9Ftd4Y9cqcVKkjep56nP13AypFGQXs1T9Fi+yA
         NO/mv4Nf4cMNvbP4dhND7ibPEUdiVBovCSlw2qdbaKw4ikRoQxzhezXhSBRiVv+L4FGE
         zBSyTMbK6i9hueJSaKmrsH7pba/gFNWXnDZB35SEfJAvxr/NKLNHeAfmFCmf0p54G8lq
         SF0WQK3Rr7HjZrXLmqcyZgko/+jyauOVKGWY+GwZFxQU3jb3Ihe49ZRndRQCkJmpweYw
         ICgw==
X-Gm-Message-State: AFqh2kpF9GAw+3FMKl3sg+YvN8/jhVQ7o8hJDuGE4BO/+c4VjF5+vEjo
        Zj6FMiErpQRYJuoArUgR7DbXtNROqkY5W+B+32Psbw==
X-Google-Smtp-Source: AMrXdXusX6CCt6i+1zaot2H1Rxeu6HDMPxop2j94acllkt+bi9QBmrv2MyabXzFTmvM+wRwke6z0eFz0cOXpsGJoQa4=
X-Received: by 2002:a50:ab4b:0:b0:46a:b1a9:c34e with SMTP id
 t11-20020a50ab4b000000b0046ab1a9c34emr12264339edc.212.1673867142735; Mon, 16
 Jan 2023 03:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20230112152855.216072-1-bchihi@baylibre.com> <20230112152855.216072-3-bchihi@baylibre.com>
 <256c2328-a426-a1bf-4f47-1d6c9e706f63@collabora.com>
In-Reply-To: <256c2328-a426-a1bf-4f47-1d6c9e706f63@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Mon, 16 Jan 2023 12:05:07 +0100
Message-ID: <CAGuA+orQ333LxJYw9Gws=uLXxewM2z_nX5QH1CfhOk06ViJrMg@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] dt-bindings/thermal/mediatek: Add dt-binding
 document for LVTS thermal controllers
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:38 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 12/01/23 16:28, bchihi@baylibre.com ha scritto:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add dt-binding document for mt8192 and mt8195 LVTS thermal controllers.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >   .../thermal/mediatek,lvts-thermal.yaml        | 140 ++++++++++++++++++
> >   1 file changed, 140 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> > new file mode 100644
> > index 000000000000..43b8777fc1b2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/mediatek,lvts-thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek SoC Low Voltage Thermal Sensor (LVTS)
> > +
> > +maintainers:
> > +  - Balsam CHIHI <bchihi@baylibre.com>
> > +
> > +description: |
> > +  LVTS is a thermal management architecture composed of three subsystems,
> > +  a Sensing device - Thermal Sensing Micro Circuit Unit (TSMCU),
> > +  a Converter - Low Voltage Thermal Sensor converter (LVTS), and
> > +  a Digital controller (LVTS_CTRL).
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt8192-lvts-mcu
> > +      - mediatek,mt8192-lvts-ap
>
> I agree, MT8192 has LVTS... but you don't have it in the driver?
> I don't think that it would be much effort to just add it to the commit that
> adds the driver itself... otherwise, even though bindings are describing the
> hardware and not the drivers, I, personally, don't really like to see the
> binding advertising mt8192 mcu/ap while it's not really supported in the driver.

Hi Angelo,

mt8192 will be supported later,
so I totally agree with you about removing its binding description for now.

Best regards,
Balsam

>
> Regards,
> Angelo
