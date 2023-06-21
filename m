Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D7739079
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjFUT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFUT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D4186;
        Wed, 21 Jun 2023 12:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 498C5616C3;
        Wed, 21 Jun 2023 19:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D45FC433C0;
        Wed, 21 Jun 2023 19:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687377576;
        bh=ANN19t3alAM1TARadv37+ChXZ5nuIRFQHI8urfbJW8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nx5Izjpj9P8xdX6AvBmnv3mcfjSS3km1o30ZPztOTbbNK5cR/5HI+gxVoSVWbb+5S
         oZ9DNDtBvDE6eczTmbRHGgk2NL9xNSAud0loiPCkFPZdS28P+peq3Ruk2SiFPvTBx5
         U1eb+ROuqhKDUg4/FW/eeVsll/7RXPdmYr3S821w3T1YgC8fMkxz+TCEkFEyM3E/Cg
         1WtbI/bEri6mVsrHRR2KkTnFO4d+1BX6oUbUHx38nvJhK1p/C0nPWA7c06NQz7b/tL
         FNdORcVZV9jF19mpS/GM7+8tgyymVGJaWoupQJqO8vaPJfr/D8G/iZJlRvFQaxRDHb
         WVjFKounFch5Q==
Date:   Wed, 21 Jun 2023 20:59:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
Subject: Re: [PATCH 2/9] mfd: atmel-hlcdc: Add compatible for SAM9X7 HLCD
 controller
Message-ID: <20230621195929.GV10378@google.com>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-3-manikandan.m@microchip.com>
 <20230621175645.GR10378@google.com>
 <20230621-pampers-dial-07b6c3e7602a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621-pampers-dial-07b6c3e7602a@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023, Conor Dooley wrote:

> On Wed, Jun 21, 2023 at 06:56:45PM +0100, Lee Jones wrote:
> > On Tue, 13 Jun 2023, Manikandan Muralidharan wrote:
> > 
> > > Add compatible for SAM9X7 HLCD controller.
> > > 
> > > Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> > > ---
> > >  drivers/mfd/atmel-hlcdc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Applied, thanks
> 
> Hmm, Nicolas pointed out that this compatible is likely insufficient,
> and it'll likely need to be sam9x70 & sam9x75 as there are differences
> between what each of these SoCs support.
> https://lore.kernel.org/all/ef09246c-9220-4c71-4ac2-2792d9ca519d@microchip.com/
> I guess it doesn't really matter, since the binding didn't get applied
> and what's in the driver can be arbitrarily changed?

Unapplied, thanks. :)

-- 
Lee Jones [李琼斯]
