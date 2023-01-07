Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54680660F3E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjAGNnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjAGNnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:43:49 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E6B5D401;
        Sat,  7 Jan 2023 05:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rhaXr6GbOx+3CahNm/sgr9dXyzOz+6l2HYeP10Q0JCo=; b=0HD//aWyUXHWC/PtcsWpiO+njm
        ORFj8Y4ymtQ8wwbCW1e0Ko/p+SJ7o6Xtp9VaI45hRENihlYiqcm6UyyqGmnukU44be1hgvNui4qLT
        r8M3KnDCiiun4kGudz3IT8DrotWYMgSTze2YnGYRQTS99KlJy07Z4FD9mHDBYbaf1jiNVmrNMvpiv
        jEJD+i35qnjuwD75LOvDCPjdSNjRMQZqirPo7g57Gz5ii6e6cp21WgPWVVqRCJ+fADWKXerC0XDhx
        1FPU2hGhROuiXTIaBPDuIPjFbIW9YsuzKwAAfznwTwTOTODg4jgOYpbkx6Cr8DZ6PtDTwbf8+wRDV
        +cznRC1Q==;
Received: from p200300ccff2fec001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2f:ec00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pE9U1-00056m-DU; Sat, 07 Jan 2023 14:43:37 +0100
Date:   Sat, 7 Jan 2023 14:43:36 +0100
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
Message-ID: <20230107144336.2ecff4f9@aktux>
In-Reply-To: <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
References: <20230105213856.1828360-1-andreas@kemnade.info>
        <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
        <20230106203358.14878660@aktux>
        <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
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

On Sat, 7 Jan 2023 14:23:08 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/01/2023 20:33, Andreas Kemnade wrote:
> > On Fri, 6 Jan 2023 09:41:01 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> On 05/01/2023 22:38, Andreas Kemnade wrote:  
> >>> Currently make dtbs_check shows lots of errors because imx*.dtsi does
> >>> not use single compatibles but combinations of them.
> >>> Allow all the combinations used there.
> >>>
> >>> Patches fixing the dtsi files according to binding documentation were
> >>> submitted multiple times and are commonly rejected, so relax the rules.
> >>> Example:
> >>> https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
> >>>
> >>> Reason: compatibility of new dtbs with old kernels or bootloaders.
> >>>
> >>> This will significantly reduce noise on make dtbs_check.
> >>>
> >>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>> ---
> >>>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 24 +++++++++++++++++++
> >>>  1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> >>> index dc6256f04b42..118ebb75f136 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> >>> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> >>> @@ -37,6 +37,30 @@ properties:
> >>>            - fsl,imx8mm-usdhc
> >>>            - fsl,imxrt1050-usdhc
> >>>            - nxp,s32g2-usdhc    
> >>
> >> You must drop the items from enum above. Binding saying:
> >> compatible="A"
> >> or:
> >> compatible="A", "B"
> >>
> >> is not correct. Either A is or is not compatible with B.
> >>  
> > hmm, here we have A = B + some additional features
> > or
> > A = B + some additional features and additional quirks required.  
> 
> So why do you allow A alone?
> 
because A is full-compatible, and B is half-compatible, because
the additional required quirks are not applied.
> > 
> > For the latter we have e.g.
> > A=
> > static const struct esdhc_soc_data usdhc_imx6sx_data = {
> >         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> >                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> >                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE
> >                         | ESDHC_FLAG_BROKEN_AUTO_CMD23,
> > };
> > B=
> > static const struct esdhc_soc_data usdhc_imx6sl_data = {
> >         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> >                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
> >                         | ESDHC_FLAG_HS200
> >                         | ESDHC_FLAG_BROKEN_AUTO_CMD23,
> > };
> > 
> > so there is the difference in ESDHC_FLAG_STATE_LOST_IN_LPMODE.
> > That might make no difference in some usage scenario (e.g. some bootloader
> > not doing any LPMODE), but I wonder why
> > we need to *enforce* specifying such half-compatible things.  
> 
> I asked to remove half-compatible. Not to enforce.
> 
well B is half-compatible, I (and others) have sent patches to remove,
but they were rejected. I consider these patches the way to go.

Regards,
Andreas

