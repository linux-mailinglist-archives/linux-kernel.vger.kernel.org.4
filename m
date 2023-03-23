Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4116C6CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCWQJg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCWQJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:09:32 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF1025293
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:09:21 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id n2so27202208qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQHyP3S9dw/cqbaJrddb2xMuURjIwXSBfIn2tHX4yBQ=;
        b=0pQxfibCeVzW5rReL2To20wlY+JxnYywdt2Q39cK8fX1pmmNLszHKpAHYErg6bNcSw
         FiKRTCYvP9LbB0xfBNwy6jFEIX3cffZHdgOtJRCEVyARRco9gZdSjwsnUPnnnEPp4JSi
         0tAokgZVfpicIOcnISQ2BK9nP0PJi5HJgBNrB/Bhl6TIJthX0ROH5ix+f6z9QxjzBZkb
         4CGCbPglAcDI30v8cQLwE6ZrZFmABlKdjL8JoInaXVATJvTu63pZxATC2jq0w6X71zUW
         tiOM2HGjYfId6DJOQGuubfSIC6qvGtdotrBVXe+Z9NGXRRjE12qvBXryyVEZvHSnhCuh
         Ln2w==
X-Gm-Message-State: AO0yUKXGSlXEiKlcy05X7pMyFIeb5O8hST+dpLddW5bWKShULGpanneL
        3PSOOwWXrjOw5pmmsQ3aIIzzSGR7OvAd5nQE
X-Google-Smtp-Source: AK7set+tmwWaIsAVQyBc/t7mPsjj8RZUHbqX9OB48p5KZ8R6NGY4uSC0cLKxCl1HIMoF10KnhqxBAQ==
X-Received: by 2002:ac8:7f10:0:b0:3d2:52ad:dff3 with SMTP id f16-20020ac87f10000000b003d252addff3mr13767120qtk.17.1679587760709;
        Thu, 23 Mar 2023 09:09:20 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id q17-20020a05620a025100b00746b3eab0fdsm2802455qkn.44.2023.03.23.09.09.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 09:09:19 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-544b959a971so369164877b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:09:18 -0700 (PDT)
X-Received: by 2002:a05:690c:3:b0:541:698b:7bdb with SMTP id
 bc3-20020a05690c000300b00541698b7bdbmr2516607ywb.2.1679587758539; Thu, 23 Mar
 2023 09:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230323113324.361991-1-b-kapoor@ti.com> <20230323135323.GA309305@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <20230323135323.GA309305@hu-bjorande-lv.qualcomm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Mar 2023 17:09:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUF5x=nVMKFFffbbe6S2nGWzq2UZWX36JgyXBGLBVL1rw@mail.gmail.com>
Message-ID: <CAMuHMdUF5x=nVMKFFffbbe6S2nGWzq2UZWX36JgyXBGLBVL1rw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable CAN PHY transceiver driver
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bhavya Kapoor <b-kapoor@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        dmitry.baryshkov@linaro.org, arnd@arndb.de,
        krzysztof.kozlowski@linaro.org, geert+renesas@glider.be,
        nfraprado@collabora.com, broonie@kernel.org, rafal@milecki.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:53 PM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
> On Thu, Mar 23, 2023 at 05:03:24PM +0530, Bhavya Kapoor wrote:
> > Enable CAN PHY transceiver driver to be built as a module.
>
> Please use the commit message to describe why the driver should be
> enabled. The patch and the subject already states clearly that the
> driver is being enabled.

And if no one has inspiration: I wouldn't mind "because it is needed
for CAN-FD on the Renesas White-Hawk development board" ;-)

> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -1292,6 +1292,7 @@ CONFIG_RESET_QCOM_PDC=m
> >  CONFIG_RESET_RZG2L_USBPHY_CTRL=y
> >  CONFIG_RESET_TI_SCI=y
> >  CONFIG_PHY_XGENE=y
> > +CONFIG_PHY_CAN_TRANSCEIVER=m
> >  CONFIG_PHY_SUN4I_USB=y
> >  CONFIG_PHY_CADENCE_TORRENT=m
> >  CONFIG_PHY_CADENCE_SIERRA=m

For the actual change:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
