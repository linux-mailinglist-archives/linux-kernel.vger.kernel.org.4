Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD49661753
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjAHRWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjAHRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:21:20 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DCEFD01;
        Sun,  8 Jan 2023 09:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TCp6tJCAXorQS+hyqzrROi+oUu1HjiFY2abUnTeE8X0=; b=6zuAI8OxvnD/VOjsgvYLfcK2zF
        HnkF8RtEh56tmkiwq7wysye22+rZXem89Cw54fnc1bxTxP1RNGmylxQY0MjrrvJr5j8MwY0xquxx6
        y0jQlgxZgZZaLFGfXD4VhKc9+M85A0TuzprQhaA/C0PZEKNTAfV03JLo+y/OgBlvzSiR/yEiWP94+
        JCTBiZolAlnQLbaRgsCZgHqy3IukuAFtBUN8epvPXGg3yDpfEiyF0DWS5FhI8bY0s/msyiD4ARKqE
        RZKL9qZHnCKuRz9gTWXfnCo20e/1ce2JWlh2fkoCH58wQRLGJQOl73SIwk4qsxFe/u2PUiuQfzEYO
        kjnqSO9g==;
Received: from p200300ccff436a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff43:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pEZLm-0008En-4k; Sun, 08 Jan 2023 18:20:50 +0100
Date:   Sun, 8 Jan 2023 18:20:49 +0100
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
Message-ID: <20230108182049.679de9f9@aktux>
In-Reply-To: <70474070-404b-2fbe-2575-4810f6fbda91@linaro.org>
References: <20230105213856.1828360-1-andreas@kemnade.info>
        <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
        <20230106203358.14878660@aktux>
        <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
        <20230107144336.2ecff4f9@aktux>
        <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
        <20230107150740.0ba34aa1@aktux>
        <0ab84fb8-6173-54e0-abad-a0e0e4ba82e7@linaro.org>
        <20230107160105.66df4136@aktux>
        <e1b1450b-9421-3732-2d74-50c47b5afb0e@linaro.org>
        <20230107165457.30f4dddf@aktux>
        <70474070-404b-2fbe-2575-4810f6fbda91@linaro.org>
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

On Sun, 8 Jan 2023 15:45:44 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 07/01/2023 16:54, Andreas Kemnade wrote:
> > On Sat, 7 Jan 2023 16:07:35 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> On 07/01/2023 16:01, Andreas Kemnade wrote:  
> >>> On Sat, 7 Jan 2023 15:09:24 +0100
> >>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>>     
> >>>> On 07/01/2023 15:07, Andreas Kemnade wrote:    
> >>>>> On Sat, 7 Jan 2023 15:00:56 +0100
> >>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>
> >>>>> [...]      
> >>>>>>>> I asked to remove half-compatible. Not to enforce.
> >>>>>>>>        
> >>>>> so you are saying that allowing
> >>>>> compatible = "A", "B" 
> >>>>> is not ok, if B is not fully compatible. I agree with that
> >>>>> one.      
> >>>>
> >>>> I did not say that. It's not related to this problem.
> >>>>    
> >>> You said "I asked to remove half-compatible" that means to me
> >>> remove "B" if not fully compatible with A which sounds sane to me.
> >>>     
> >>>> Again - you cannot have device which is and is not compatible with
> >>>> something else. It's not a Schroedinger's cat to be in two states,
> >>>> unless you explicitly document the cases (there are exception). If this
> >>>> is such exception, it requires it's own documentation.
> >>>>    
> >>> so conclusion:
> >>> If having A and B half-compatible with A:
> >>>
> >>> compatible = "A" only: is allowed to specifiy it the binding (status quo),
> >>>   but not allowed to make the actual dtsi match the binding documentation
> >>>   https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
> >>>   and
> >>>   https://lore.kernel.org/linux-devicetree/20210924091439.2561931-5-andreas@kemnade.info/
> >>>
> >>> compatible = "A", "B" in the binding definition: is not allowed ("I asked to remove
> >>>    half-compatible" (= removing B))    
> >>
> >> No, half compatible is the A in such case.
> >>  
> > I think that there is some misunderstanding in here. I try once again.
> > 
> > Define compatible with "X" here:
> > To me it means:
> > 
> > device fully works with flags defined in:
> > 
> > static const struct esdhc_soc_data usdhc_X_data = { ... };
> > 
> > with usdhc_X_data referenced in
> >         { .compatible = "X", .data = &usdhc_X_data, },
> > 
> > 
> > So if there is only "A" matching with above definition of compatibility
> >   compatible = "A" would sound sane to me.
> > 
> > And scrutinizing the flags more and not just wanting to achieve error-free
> > dtbs_check, I think is this in most cases where there is only "A". 
> > 
> > If there is "A" and "B" which match that compatibility definition, you
> > say that only compatible = "A", "B" is allowed, but not compatible = "A".
> > In that case I would have no problem with that.
> > 
> > But if there is only "A" but no "B" matching the above definition, I would expect
> > that only compatible = "A" is allowed but *not* compatible = "A", "B".  
> 
> Sorry, I don't follow. I also do not understand what "matching" means in
> these terms (binding driver? of_match?) and also I do not know what is
> the "above definition".
> 
> Devicetree spec defines the compatibility - so this is the definition.
> There will be differences when applying it to different cases.
> 
Ok, lets stop talking about A and B, lets be more specific.
Hmm, I try to insert the missing bits here:

I am not convinced anymore that my patch is correct
- for dtb compatible formality
- for pure technical reasons

I am not convinced that your proposal is correct either.
- for pure technical reasons (for same resan as you state)

Especially this part I consider faulty:
+      - items:
+          - const: fsl,imx6sx-usdhc
+          - const: fsl,imx6sl-usdhc

Keyword: ESDHC_FLAG_STATE_LOST_IN_LPMODE (detailed that in
an earlier mail).

Regards
Andreas
