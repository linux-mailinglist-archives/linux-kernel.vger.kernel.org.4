Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4839C6F5E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjECSvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjECSvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:51:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247A83FF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 11:51:12 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puHZ8-0003zL-MR; Wed, 03 May 2023 20:51:02 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puHZ8-00045L-1s; Wed, 03 May 2023 20:51:02 +0200
Date:   Wed, 3 May 2023 20:51:02 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add i.MX8MM-EVKB
Message-ID: <20230503185102.bmlueeu7hptgopch@pengutronix.de>
References: <20230503-b4-v6-3-topic-boards-imx8mm-evk-v1-0-1e15a371d374@pengutronix.de>
 <20230503-b4-v6-3-topic-boards-imx8mm-evk-v1-1-1e15a371d374@pengutronix.de>
 <08a20847-bf6a-20bc-4e80-1b74030ed80d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a20847-bf6a-20bc-4e80-1b74030ed80d@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-03, Krzysztof Kozlowski wrote:
> On 03/05/2023 17:20, Marco Felsch wrote:
> > From: Johannes Schneider <johannes.schneider@leica-geosystems.com>
> > 
> > Add DT compatible for the imx8mm EVKB [1].
> > 
> > [1] https://www.nxp.com/design/development-boards/ \
> > 	i-mx-evaluation-and-development-boards/ \
> > 	evaluation-kit-for-the-i-mx-8m-mini-applications-processor:8MMINILPD4-EVK
> > 
> > Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
> > [m.felsch@pengutronix.de: Adapt the commit message]
> > [m.felsch@pengutronix.de: Adapt the yaml comment]
> 
> I don't see any differences. The comment is exactly the same as before.

I fogot to say that I used V8 as base which caused problems on Shawns
side and there was a difference.

> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions. However, there's no need to repost patches *only* to add the
> tags. The upstream maintainer will do that for acks received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> 
> If a tag was not added on purpose, please state why and what changed.

As said above..

Regards,
  Marco

> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
> 
> 
