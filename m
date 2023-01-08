Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7F661A92
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjAHWrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjAHWqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:46:54 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F4205;
        Sun,  8 Jan 2023 14:46:52 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id z12so6602400qtv.5;
        Sun, 08 Jan 2023 14:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP099oZSf8SCM6luMmBu6jrUsbmzqcukwkA4VfOihLg=;
        b=XdiKP1xIVldgwMzdpDgN1Lp+tIo7XlqYmX62ngYZysPNxspvOKNsDhAx4wshwF+FdF
         pId8dbXw/05YYsrlwSGThXT3OxYS0ZVLc+QYsdYilpkSE0dFWhxXuQKmpEq80ChPpZPS
         tqq4N1VAav3njoyKIwrLcWZszYKI3O1a29rVCKJn6Inqz2PZXam4TSObT8UIo6LqL8PS
         /q6g7CdvvAkjuhxx1x1FP3xSIvBgRqNxcvmY2NfI0m68kG7+K6+cAv3JvmLFgCHh/Jir
         Lf3bpBjO+HSn90hkWbePvv0h7t1/5fCDgXdZPYdSx//ENYcq2XsyAUKag5XwAbKdGC0K
         7T7w==
X-Gm-Message-State: AFqh2kopXLwH3sqhh3a8SUogOSJwstur0LUAg8/F9crUjePBhfWPnQH8
        ooWioqOslW7IThTZk6BGlA==
X-Google-Smtp-Source: AMrXdXvOfSkmlZ/ErkCntaZZxlfL3eN5OxSJXJFuKtN4wzYd5eFEzMqw13AzB8uiX/kSI3tdFJ461w==
X-Received: by 2002:ac8:6b8b:0:b0:3a7:e91e:60fd with SMTP id z11-20020ac86b8b000000b003a7e91e60fdmr85552106qts.62.1673218011726;
        Sun, 08 Jan 2023 14:46:51 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a034b00b006fa31bf2f3dsm4322656qkm.47.2023.01.08.14.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 14:46:51 -0800 (PST)
Received: (nullmailer pid 382105 invoked by uid 1000);
        Sun, 08 Jan 2023 22:46:33 -0000
Date:   Sun, 8 Jan 2023 16:46:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ulf.hansson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Message-ID: <20230108224633.GA353691-robh@kernel.org>
References: <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
 <20230106203358.14878660@aktux>
 <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
 <20230107144336.2ecff4f9@aktux>
 <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
 <20230107150740.0ba34aa1@aktux>
 <0ab84fb8-6173-54e0-abad-a0e0e4ba82e7@linaro.org>
 <20230107160105.66df4136@aktux>
 <e1b1450b-9421-3732-2d74-50c47b5afb0e@linaro.org>
 <20230107165457.30f4dddf@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107165457.30f4dddf@aktux>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 04:54:57PM +0100, Andreas Kemnade wrote:
> On Sat, 7 Jan 2023 16:07:35 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 07/01/2023 16:01, Andreas Kemnade wrote:
> > > On Sat, 7 Jan 2023 15:09:24 +0100
> > > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > >   
> > >> On 07/01/2023 15:07, Andreas Kemnade wrote:  
> > >>> On Sat, 7 Jan 2023 15:00:56 +0100
> > >>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > >>>
> > >>> [...]    
> > >>>>>> I asked to remove half-compatible. Not to enforce.
> > >>>>>>      
> > >>> so you are saying that allowing
> > >>> compatible = "A", "B" 
> > >>> is not ok, if B is not fully compatible. I agree with that
> > >>> one.    
> > >>
> > >> I did not say that. It's not related to this problem.
> > >>  
> > > You said "I asked to remove half-compatible" that means to me
> > > remove "B" if not fully compatible with A which sounds sane to me.
> > >   
> > >> Again - you cannot have device which is and is not compatible with
> > >> something else. It's not a Schroedinger's cat to be in two states,
> > >> unless you explicitly document the cases (there are exception). If this
> > >> is such exception, it requires it's own documentation.
> > >>  
> > > so conclusion:
> > > If having A and B half-compatible with A:
> > > 
> > > compatible = "A" only: is allowed to specifiy it the binding (status quo),
> > >   but not allowed to make the actual dtsi match the binding documentation
> > >   https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
> > >   and
> > >   https://lore.kernel.org/linux-devicetree/20210924091439.2561931-5-andreas@kemnade.info/
> > > 
> > > compatible = "A", "B" in the binding definition: is not allowed ("I asked to remove
> > >    half-compatible" (= removing B))  
> > 
> > No, half compatible is the A in such case.
> > 
> I think that there is some misunderstanding in here. I try once again.
> 
> Define compatible with "X" here:
> To me it means:
> 
> device fully works with flags defined in:
> 
> static const struct esdhc_soc_data usdhc_X_data = { ... };
> 
> with usdhc_X_data referenced in
>         { .compatible = "X", .data = &usdhc_X_data, },
> 
> 
> So if there is only "A" matching with above definition of compatibility
>   compatible = "A" would sound sane to me.
> 
> And scrutinizing the flags more and not just wanting to achieve error-free
> dtbs_check, I think is this in most cases where there is only "A". 
> 
> If there is "A" and "B" which match that compatibility definition, you
> say that only compatible = "A", "B" is allowed, but not compatible = "A".
> In that case I would have no problem with that.
> 
> But if there is only "A" but no "B" matching the above definition, I would expect
> that only compatible = "A" is allowed but *not* compatible = "A", "B".

A is either compatible with B or it isn't. You can look at that from 
the h/w perspective and client/OS perspective. From the h/w side, is the 
h/w interface the same or only has additions which can be ignored? On 
the client side, the question is whether a client that only understands 
B could use A's h/w without change. Looking at the match data is a 
good indicator of that for Linux. It's also possible the answer is 
different for different clients, but we only need 1 client that could 
benefit from compatibility.

Rob
