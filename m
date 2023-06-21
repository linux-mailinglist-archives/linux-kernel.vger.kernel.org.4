Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3B738DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFUR6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjFUR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:57:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D491FDC;
        Wed, 21 Jun 2023 10:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4182361645;
        Wed, 21 Jun 2023 17:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA133C433C0;
        Wed, 21 Jun 2023 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687370212;
        bh=6Opv8PDFoxGMYScl9V0RTl+vcmEJFr54mvVL6P3gfYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1M4wVL20A4ARIQZys9e9x6zRL/6jEeL5YTdrUBDpfuDeibl/JzyvaBfBPuQgvppP
         ooRd/t4+wXenCtoeBzUsqaN4cZNa9u8XsBatzPYrc8ZBxQDtB7HwqEnB+b97JV/ms+
         TEIc1yO9fj4iKCZRAtB4snBlSfNsYv7VsTlLew3Tc1Vv9CHdXZNAh8rtma5OREHPjr
         rjfvDObbE4W5sJJHw+MGXCl3iykLz9Ls3r/bkaNGW3i+SnZ0vBjUHMi1c0pPuuTymb
         25ilUsAS3sec+qwZYoMAc+TAu+p9uJjmuboOxmxlJmG3b3ZIyjxp6tWWtFwqwzfso4
         No7Op8SGQwB/g==
Date:   Wed, 21 Jun 2023 18:56:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Manikandan Muralidharan <manikandan.m@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
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
Message-ID: <20230621175645.GR10378@google.com>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-3-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230613070426.467389-3-manikandan.m@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023, Manikandan Muralidharan wrote:

> Add compatible for SAM9X7 HLCD controller.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/mfd/atmel-hlcdc.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
