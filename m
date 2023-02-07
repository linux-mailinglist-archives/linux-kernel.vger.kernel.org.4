Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A248468E1F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBGUhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBGUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:37:19 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2166F3B0CD;
        Tue,  7 Feb 2023 12:37:18 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r28so13725747oiw.3;
        Tue, 07 Feb 2023 12:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sF5RkIuECxkMvmcFPNdqGchQ0B4cLoOA3/te7YcOjE=;
        b=F098Wr3kdi6GIMINRs/zleH96a009WV6JG6NqeBGR2hqQCaleydT8SPTjYoUkrUkr8
         z8uGpAXGgZWkqUXmGsLQ4JOPno/dkEsyUH/N+zYcPHzUagSj561rUF2xJ3e5wcHwzRTt
         DE+gK/xqTF7ZHHhG9x7So0wLzKfCFXRWzzRTONQDxJDIbjD/1rhT0slDFOU3qhTQYx51
         wV2hwU/qKReSwVrBcIU6p74t5b6v4MmSSjIf4u+F2Pv4rEtATJPiPFBTO/mTulOeC4kw
         AeDBb5t14ssZCFiwB0IJzVbIP4cTsEvHkTBgf3w4MRLdAZddDuunQ3dAuWsidTjSHnP4
         eZ6w==
X-Gm-Message-State: AO0yUKVBNX5XllwhI6R15/CfFw/GxxKXU3RH0JbyvAhXc/pFFfzYsHiq
        L5FW4yghZ8PdJFoa48DFMQ==
X-Google-Smtp-Source: AK7set/B4ylgU1A5htRkefbyGbhW6WJBI6o253nOAnJexKv2HHGfEtibv9DgFl2VyHQPuILgCzC9VQ==
X-Received: by 2002:a05:6808:30c:b0:35e:d787:ec7f with SMTP id i12-20020a056808030c00b0035ed787ec7fmr2022331oie.50.1675802237344;
        Tue, 07 Feb 2023 12:37:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o66-20020acaf045000000b0037af1a17692sm3717631oih.27.2023.02.07.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:37:16 -0800 (PST)
Received: (nullmailer pid 4113072 invoked by uid 1000);
        Tue, 07 Feb 2023 20:37:16 -0000
Date:   Tue, 7 Feb 2023 14:37:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel: visionox,vtdr6130: add
 missing reg property
Message-ID: <20230207203716.GA4104426-robh@kernel.org>
References: <20230207-topic-sm8550-upstream-vtdr6130-bindings-fix-v1-1-0ba2323420c5@linaro.org>
 <Y+KaEPO7he39Gmd5@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+KaEPO7he39Gmd5@ravnborg.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 07:36:00PM +0100, Sam Ravnborg wrote:
> Hi Neil.
> 
> 
> On Tue, Feb 07, 2023 at 11:04:36AM +0100, Neil Armstrong wrote:
> > Add missing reg property and update example to add dsi top node.
> > 
> > Fixes: ef85db911134 ("dt-bindings: display: panel: document the Visionox VTDR6130 AMOLED DSI Panel")
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  .../bindings/display/panel/visionox,vtdr6130.yaml  | 34 ++++++++++++++--------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
> > index 49e2fd4b4e99..84562a5b710a 100644
> > --- a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
> > @@ -16,6 +16,10 @@ properties:
> >    compatible:
> >      const: visionox,vtdr6130
> >  
> > +  reg:
> > +    maxItems: 1
> > +    description: DSI virtual channel
> > +
> Other panels using dsi uses a simple
> "	reg: true"
> 
> I think that would suffice here too.

Yes, because dsi-controller.yaml restricts it to a single entry. 
However, it's description says there can be more than 1 virtual channel 
for a device. In that case, it shouldn't be restricted in 
dsi-controller.yaml and the above with 'maxItems: 1' would be correct. 
So I'd keep this as-is.

Acked-by: Rob Herring <robh@kernel.org>

Rob
