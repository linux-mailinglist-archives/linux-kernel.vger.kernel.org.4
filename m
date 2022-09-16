Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE65BB244
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIPSix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiIPSit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:38:49 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D9B7EDC;
        Fri, 16 Sep 2022 11:38:47 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id w10-20020a056830410a00b00655d70a1aeaso3053309ott.3;
        Fri, 16 Sep 2022 11:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xo/d/N34lTwigjgh8R+6n/VWTdyA9uD8vMADayXwoxU=;
        b=xwaLEnv1mDSreZT62CC9tqvSi8ZhVfouRT2dBBCjOW/mLaIOOK+aXHCpfaQwVJQzn4
         ffdjz4FNZURPuiSs2c3kSR2y5CRAlmSprpyQS9zEuX9IhN181W+zCuhgLAK++ktw7QW4
         ttOYnUZ0AdIWSrEighe6Md/J7k5KAtCrMNOn+rQNRS+XVOnHJOifN/CJZsqOUxXhR0CA
         T6TA1oORke4YpF5SpU5hu3fNy47GvCmj5ob0js+ienEtKb5tDUg475O0Tb4QnI2w2qCM
         WyDE6lyMIhWfG+g1wBXJaUb9i2wB/pEXL0AUNXsJd3iCrga4/M7tSE9uzQmSYt/dvRPe
         FsRw==
X-Gm-Message-State: ACrzQf2XmvSQCWPgaSfXaNL/gY+JB2dRuE6JbmIT+VMI4a23cZ6rhYQx
        GQelCvWdnhwsIB5a8cX7og==
X-Google-Smtp-Source: AMsMyM7LURM228JuPzwCGullRsDqUgiNrVGRngnC/lcXYvPwciH2Tsmaug3XlkralOAWGjBBT+qolw==
X-Received: by 2002:a05:6830:244d:b0:655:e902:7e47 with SMTP id x13-20020a056830244d00b00655e9027e47mr2980448otr.66.1663353527029;
        Fri, 16 Sep 2022 11:38:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w19-20020a056830145300b0063725d33561sm10214318otp.73.2022.09.16.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:38:46 -0700 (PDT)
Received: (nullmailer pid 1043197 invoked by uid 1000);
        Fri, 16 Sep 2022 18:38:45 -0000
Date:   Fri, 16 Sep 2022 13:38:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v1 02/10] dt-bindings: apple,aic2: Add CPU PMU per-cpu
 pseudo-interrupts
Message-ID: <20220916183845.GA1043137-robh@kernel.org>
References: <20220916142550.269905-1-j@jannau.net>
 <20220916142550.269905-3-j@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916142550.269905-3-j@jannau.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 16:25:42 +0200, Janne Grunau wrote:
> Advertise the two pseudo-interrupts that tied to the two PMU
> flavours present in the Apple M1 Pro/Max/Ultra SoC.
> 
> We choose the expose two different pseudo-interrupts to the OS
> as the e-core PMU is obviously different from the p-core one,
> effectively presenting two different devices.
> 
> Imported from "apple,aic".
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> ---
> 
> Changes in v1:
> - Added Krzysztof's and Marc's ack
> 
> 
> ---
>  .../interrupt-controller/apple,aic2.yaml      | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
