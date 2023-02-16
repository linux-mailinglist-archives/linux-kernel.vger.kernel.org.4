Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF36999FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBPQ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBPQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:26:59 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C644AE;
        Thu, 16 Feb 2023 08:26:56 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pSh5w-0004pf-1E;
        Thu, 16 Feb 2023 17:26:52 +0100
Date:   Thu, 16 Feb 2023 16:26:49 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: add mt7981 pinctrl driver
Message-ID: <Y+5ZSUURaK/hq1iq@makrotopia.org>
References: <cover.1674693008.git.daniel@makrotopia.org>
 <ef5112946d16cacc67e65e439ba7b52a9950c1bb.1674693008.git.daniel@makrotopia.org>
 <88ef812b-b8e8-f640-f9f7-a1579ea69d31@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88ef812b-b8e8-f640-f9f7-a1579ea69d31@arinc9.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:50:57PM +0300, Arınç ÜNAL wrote:
> Hi Daniel,
> 
> On 26.01.2023 03:34, Daniel Golle wrote:
> > Add pinctrl driver for the MediaTek MT7981 SoC, based on the driver
> > which can also be found the SDK.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >   drivers/pinctrl/mediatek/Kconfig          |    5 +
> >   drivers/pinctrl/mediatek/Makefile         |    1 +
> >   drivers/pinctrl/mediatek/pinctrl-mt7981.c | 1048 +++++++++++++++++++++
> >   3 files changed, 1054 insertions(+)
> >   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7981.c
> > 
> > diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> > index fed02c6fea062..f20c28334bcbf 100644
> > --- a/drivers/pinctrl/mediatek/Kconfig
> > +++ b/drivers/pinctrl/mediatek/Kconfig
> > @@ -127,6 +127,11 @@ config PINCTRL_MT7622
> >   	default ARM64 && ARCH_MEDIATEK
> >   	select PINCTRL_MTK_MOORE
> > +config PINCTRL_MT7981
> > +	bool "Mediatek MT7981 pin control"
> > +	depends on OF
> > +	select PINCTRL_MTK_MOORE
> > +
> 
> Is there a reason why you removed these lines from v1?

Oh, that seemed to have happened by accident. Imho it'd be better
to have these two lines there as well.
