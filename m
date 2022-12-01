Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91A63EB01
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiLAI0l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Dec 2022 03:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLAI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:26:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A136034D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:26:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p0etm-0004CZ-Nj; Thu, 01 Dec 2022 09:26:26 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p0etk-001WI6-TJ; Thu, 01 Dec 2022 09:26:25 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p0etk-0001Rt-Rs; Thu, 01 Dec 2022 09:26:24 +0100
Message-ID: <98517f65e600cddf585e53d1ca98cbb7b0b43aee.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/5] dt-bindings: reset: meson-g12a: Add missing NNA
 reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     neil.armstrong@linaro.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Dec 2022 09:26:24 +0100
In-Reply-To: <16c2c7e6-20bb-7593-3197-8925b40d6d77@linaro.org>
References: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
         <20221129085047.49813-2-tomeu.vizoso@collabora.com>
         <16c2c7e6-20bb-7593-3197-8925b40d6d77@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Do, 2022-12-01 at 09:22 +0100, Neil Armstrong wrote:
> Hi Philipp,
> 
> On 29/11/2022 09:50, Tomeu Vizoso wrote:
> > Doesn't appear in the TRM I have, but it is used by the downstream
> > galcore driver.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >   include/dt-bindings/reset/amlogic,meson-g12a-reset.h | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> > index 6d487c5eba2c..45f6b8a951d0 100644
> > --- a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> > +++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> 
> <snip>
> 
> Will you mind if I take this patch so I can apply the whole
> patchset at once and handle the bindings deps between my drivers and DT trees ?

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to be merged with the DT changes that depend on it.

regards
Philipp
