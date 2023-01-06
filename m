Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162BD660732
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjAFTeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjAFTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:34:10 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFD671897;
        Fri,  6 Jan 2023 11:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+/GD8PRl+jyl3wTiMZAp9rcLOar4g14C13jzDgJg/Mk=; b=Y08UrcZINgykpAfN/XOYJlNenG
        7iRZP0/+vD80IcmcIiFvLMVB4jecfgBFDY/9PpTb1LxhMJ4Amyrq4q9WBl/fuZO7sJmOQ7TjJaoX3
        ouYW9IDjciXV0ep2Y/NHv9SzRuPYJXGCt9qRe45M87uounVerUcFM5OdjaEZkg8BXhel6ZEaeBHMB
        d656BJUCcEh28YYMlgr5JblevdbwE2QcYsd950FLgVccD/YezIF5hx/ArmJ4PDJLSCyRQZJyhDOg8
        6hT41t0/5gHoyhzJbbTlXovPj2c1Zat7KwrYQFqO6bD6s+3yvdgZAI4nMzIPfGSWKp3V2RM8vyh5T
        f48T+wQA==;
Received: from p200300ccff08c9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:c900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pDsTY-0003X1-2R; Fri, 06 Jan 2023 20:34:00 +0100
Date:   Fri, 6 Jan 2023 20:33:58 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Message-ID: <20230106203358.14878660@aktux>
In-Reply-To: <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
References: <20230105213856.1828360-1-andreas@kemnade.info>
        <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2023 09:41:01 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 05/01/2023 22:38, Andreas Kemnade wrote:
> > Currently make dtbs_check shows lots of errors because imx*.dtsi does
> > not use single compatibles but combinations of them.
> > Allow all the combinations used there.
> > 
> > Patches fixing the dtsi files according to binding documentation were
> > submitted multiple times and are commonly rejected, so relax the rules.
> > Example:
> > https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
> > 
> > Reason: compatibility of new dtbs with old kernels or bootloaders.
> > 
> > This will significantly reduce noise on make dtbs_check.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../bindings/mmc/fsl-imx-esdhc.yaml           | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > index dc6256f04b42..118ebb75f136 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > @@ -37,6 +37,30 @@ properties:
> >            - fsl,imx8mm-usdhc
> >            - fsl,imxrt1050-usdhc
> >            - nxp,s32g2-usdhc  
> 
> You must drop the items from enum above. Binding saying:
> compatible="A"
> or:
> compatible="A", "B"
> 
> is not correct. Either A is or is not compatible with B.
> 
hmm, here we have A = B + some additional features
or
A = B + some additional features and additional quirks required.

For the latter we have e.g.
A=
static const struct esdhc_soc_data usdhc_imx6sx_data = {
        .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
                        | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
                        | ESDHC_FLAG_STATE_LOST_IN_LPMODE
                        | ESDHC_FLAG_BROKEN_AUTO_CMD23,
};
B=
static const struct esdhc_soc_data usdhc_imx6sl_data = {
        .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
                        | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
                        | ESDHC_FLAG_HS200
                        | ESDHC_FLAG_BROKEN_AUTO_CMD23,
};

so there is the difference in ESDHC_FLAG_STATE_LOST_IN_LPMODE.
That might make no difference in some usage scenario (e.g. some bootloader
not doing any LPMODE), but I wonder why
we need to *enforce* specifying such half-compatible things.

Regards,
Andreas
