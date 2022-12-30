Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DCC65957F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 07:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiL3Gm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 01:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiL3Gmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 01:42:54 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D78186A9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 22:42:51 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id 3so20473468vsq.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 22:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XrpQaBNpbz5C7gEc30JXJD4ksBAoVukkRs4REF7J3cA=;
        b=ieXRxqKlr8oyA7r8oWv5vNjeFdB1A3ZleV0nsNDeN+cCb+ZLeuFA5X93VFGh/jXSpy
         8vhLveMu+xVU3utEC/s5ogI75eX3T82AglX1Uu2BHmrdqEb5fqhkuelWB5l3GEOzeI0i
         GFlJcKDDe2AAgKzGmoaCY8hHz4nCxh5d6ERJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrpQaBNpbz5C7gEc30JXJD4ksBAoVukkRs4REF7J3cA=;
        b=vhcgB+Y4BWrQxxRil2q4cdoZhaObkjzjCMJUDr4VsqNIIUKvbBxf4W/IRnpaNcnA+F
         t4a7UTwMPYc+k1vMPKAxPgBbn6aR2gV4bzDCW0fU06kpH3AErU95nB1L6BxNyBTu8XPP
         eEp7GQdlW6fxzrrtIX1WknNQgiXLjxeTP79/ao/puMHWsr1xWrw2fvb2A1b5wVCmxw+j
         Ln+wsWXY1YELDOI+YBIS5z/MgJfzzV5/36px+5izOywV2s3A7UirIQyItch0ExlZW7SV
         gCg6oaVXFwHLqCf23ITGB9IYahP/+4PE/3DiIRLSMXaJwD0iXI2v2Mn/Zv4Jz7oeHtPG
         /J1A==
X-Gm-Message-State: AFqh2kreEGm/iIWTGRB9Zei0LUJKwvWVPCad0pggXh61edGoAGrBZNJz
        vLflQ/MhaoOrZXlcM3blmtCxp+po7Hzi2VcD06TRCg==
X-Google-Smtp-Source: AMrXdXvrIUXju3J24bym43P+d+BGgTRL65FUNwwpDeRTxYGdxEQI/sLV9PJ9RkGhzNeKQ2VL0EKFXN2ejtTMxQEBC1c=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr2656935vsv.9.1672382570811; Thu, 29 Dec
 2022 22:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221230061309.16643-1-miles.chen@mediatek.com>
In-Reply-To: <20221230061309.16643-1-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 14:42:39 +0800
Message-ID: <CAGXv+5HqLc2xsz6b_d5hrPiAu363aMcJkQrqX32ukA2pcsj6kQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] MediaTek clocks cleanups and improvements
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        devicetree@vger.kernel.org, fparent@baylibre.com,
        ikjn@chromium.org, johnson.wang@mediatek.com,
        jose.exposito89@gmail.com, kernel@collabora.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, msp@baylibre.com, mturquette@baylibre.com,
        nfraprado@collabora.com, pablo.sun@mediatek.com,
        rex-bc.chen@mediatek.com, robh+dt@kernel.org, ryder.lee@kernel.org,
        sam.shih@mediatek.com, sboyd@kernel.org, weiyi.lu@mediatek.com,
        y.oudjana@protonmail.com, yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 2:13 PM Miles Chen <miles.chen@mediatek.com> wrote:
> > Changes in v2:
> >  - Moved dt-bindings CLK_DUMMY to clk-mtk.h instead
> >
> >
> > This series performs cleanups and improvements on MediaTek clock
> > drivers, greatly reducing code duplication (hence also reducing
> > kernel size).
> >
> > There would be a lot to say about it, but summarizing:
> >
> > * Propagates struct device where possible in order to introduce the
> >   possibility of using Runtime PM on clock drivers as needed,
> >   possibly enhancing reliability of some platforms (obviously, this
> >   will do nothing unless power-domains are added to devicetree);
> >
> > * Cleans up some duplicated clock(s) registration attempt(s): on
> >   some platforms the 26M fixed factor clock is registered early,
> >   but then upon platform_driver probe, an attempt to re-register
> >   that clock was performed;
> >
> > * Removes some early clock registration where possible, moving
> >   everything to platform_driver clock probe;
> >
> > * Breaks down the big MT8173 clock driver in multiple ones, as it's
> >   already done with the others, cleans it up and adds possibility
> >   possibility to compile non-boot-critical clock drivers (for 8173)
> >   as modules;
> >
> > * Extends the common mtk_clk_simple_probe() function to be able to
> >   register multiple MediaTek clock types;
> >
> > * Removes duplicated [...]_probe functions from multiple MediaTek SoC
> >   clock drivers, migrating almost everything to the common functions
> >   mtk_clk_simple_probe();
> >
> > * Adds a .remove() callback, pointing to the common mtk_clk_simple_remove()
> >   function to all clock drivers that were migrated to the common probe;
> >
> > * Some more spare cleanups here and there.
> >
> > All of this was manually tested on various Chromebooks (with different MTK
> > SoCs) and no regression was detected.
> >
> > Cheers!
>
> I tested this v2 series on mt6779 and mt8192 without any problem.

Please give Tested-by. :)
