Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A906B8B81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCNGs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCNGsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:48:25 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418CA5BBF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:48:24 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id o14so456435ioa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678776503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLEwZG+K5If1XG31L81o0B8wj/oAKIdjUErA7QakB/Y=;
        b=SsS5gi6jc4SKTBaMtIUxlxwJ9fHmgIvDZdQUp4rgJjJ9YF9sCetp08MsS80solmwYR
         7j9sXVksjByPcl3HUQ3BUAgpIShQmg0PuFVlPEjSONufvTOatwv4FeDv5eZPnuv5veQI
         0xIVY5J2SobjWPlPrysORvKNKEypfO+J8obNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLEwZG+K5If1XG31L81o0B8wj/oAKIdjUErA7QakB/Y=;
        b=0ZKHfT0lNSPRYpm8VsUFW3RMOyc2bcpCWgOx1tFavqj1ukvlBlF0vuZ+1/jikYUoCL
         cJbrVUc77+NrdeHf4ez8/JBjx+ySta/BN7UvpqDCRpZlMvOuYdI+vSwSAVXweyepSBiE
         f5M/TRivu1Ukiin4+NrKMNYUPXT684rfXlQUoAmszrmq0ucray8Q4Vx9xGfQe9WgE/L8
         MI5HSnjjQmeSjaNKel3LnI9Q0kp3tydqeA3dmDiCekbZ3IH0EaAldLEgtK690NKiRk78
         21qlUBOaxxSSBWeo8Q+WJdNBA5gS7beN2OnaOtU08UAJxzy/yWqKGcpdVZybFvS2Hpgc
         jAHw==
X-Gm-Message-State: AO0yUKW61AgBlcumAw5VYVMExjlmVrlNj1KrXVga7FfLrpSQpoaF94Id
        hUlhNsysZcGaMYUibNcDyQqPmAsSUN8w7eo6cdwf0w==
X-Google-Smtp-Source: AK7set/nrtwAWWXklgEcYSS7gTcgiOAry6UysyFd30DNrr9roLVmAoH48HSI9olsf2mB8oed7L7Bg1XJFQCxDvKesy8=
X-Received: by 2002:a05:6602:115:b0:745:6788:149f with SMTP id
 s21-20020a056602011500b007456788149fmr16670096iot.0.1678776503657; Mon, 13
 Mar 2023 23:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com> <6c52bcda08b62593c541d52e269d3982.sboyd@kernel.org>
In-Reply-To: <6c52bcda08b62593c541d52e269d3982.sboyd@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 14 Mar 2023 14:48:12 +0800
Message-ID: <CAGXv+5E+SsN085WHzdLGzdWGMwpWLNhgyR5NvobOf75sPG0cRA@mail.gmail.com>
Subject: Re: [PATCH v6 00/54] MediaTek clocks: full module build and cleanups
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        daniel@makrotopia.org, fparent@baylibre.com, msp@baylibre.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhaojh329@gmail.com, sam.shih@mediatek.com,
        edward-jw.yang@mediatek.com, yangyingliang@huawei.com,
        granquet@baylibre.com, pablo.sun@mediatek.com,
        sean.wang@mediatek.com, chen.zhong@mediatek.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 7:22=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting AngeloGioacchino Del Regno (2023-03-06 06:04:49)
> >
> > This huge series adds more cleanups on top, reducing size and adding mo=
re
> > commonization for clock drivers probe/remove, which also includes a new
> > common probe mechanism for multimedia clock drivers that are usually
> > probed by mtk-mmsys instead of a dt clock node: thanks to this, it was
> > finally possible to convert almost all clock drivers to the common prob=
e
> > mechanism, which *finally again* makes us able to build all these drive=
rs
> > as modules!
> >
> > Since this looked like being *the* way forward, I went on converting so=
me
> > more drivers away from OF_CLK_DECLARE_DRIVER to full platform_driver(s)=
,
> > allowing for more (actually, almost all!) drivers to be built as module=
s.
> >
> > While at it, I also added some more consistency in macros usage by
> > removing all of the duplicated full macro declaration for MediaTek gate
> > clocks and replacing all of those with using the GATE_MTK macro instead=
,
> > producing a nice reduction in amount of lines per file but, more
> > importantly, improving readability and eventual future batch changes.
> >
> > This amount of commonization will also, in my opinion, greatly improve
> > the review process for new clock drivers, as they will be mostly just a
> > list of clocks and won't contain much new code, as it's all going to be
> > handled in the common places, which also reduces chances to see new clo=
ck
> > driver related bugs emerging on one SoC or the other.
> >
> > Since I don't own devices with all of the supported MediaTek SoCs, I
> > could not test some of the conversions on real hardware... but I am
> > confident that this will work as the drivers are *very* similar on a
> > per-generation basis.
> >
> > This series was build-tested for all (both module and built-in build)
> > and was manually tested on MT6795, MT8173, MT8192, MT8195.
> >
>
> Applied the whole series to clk-next.

Hadn't gotten around to retesting this. FWIW,

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8183, MT8186, MT8192, MT8195
