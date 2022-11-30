Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3722663D964
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiK3PYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiK3PYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:24:54 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0152171;
        Wed, 30 Nov 2022 07:24:53 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-12c8312131fso21388675fac.4;
        Wed, 30 Nov 2022 07:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlACntbArX7b3kCKVV+bhldppIYRKiicqjQCNfxe6xc=;
        b=zGju+DtcOnFTymcJpaMVe1NlsOjmOph//wD8t4ojCPXD+dU+KoWGccCvH0Ab7HIwUv
         V/qfC+rJx17dZbr3J3dlOmB2J7is9v3zPlnqXqedcRi1zD5FqJYNMqG70/YARGHaduKL
         TJ8izN1olUt5Ih/wGi/FxTbVpogAtRgFU/G1Vt+BwSh6DbL+W7RPw/c6bi2ng48mh28/
         nJbarGp+/EeJr8uiXL6pRw81weR3zo74K0uOVvb2Q2nBJvooDOnhd40NnHp7YOlZ89nK
         6yNMmK/T64sa1h3bXMS1XOh4LlN7IkhPXx999ZH/M47GvUwaK83fAzc7AAGWHzxmUBrw
         HfYg==
X-Gm-Message-State: ANoB5pndzeBmBMeaE/Fe5ROBpxoShVd0r436UvALE6fX1LONde7w2ycc
        HxcGwCSu9tR6qLLnAgFWWg==
X-Google-Smtp-Source: AA0mqf5x+OdF/baS7qLHAVmukK6f4ncA4i+9mLv9a6t8OILL4W5A/PqjSnmH4cu4Ow0KVyie+oLneA==
X-Received: by 2002:a05:6870:f592:b0:144:543:c801 with SMTP id eh18-20020a056870f59200b001440543c801mr1399989oab.201.1669821892698;
        Wed, 30 Nov 2022 07:24:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r127-20020aca4485000000b0034d9042758fsm727106oia.24.2022.11.30.07.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:24:52 -0800 (PST)
Received: (nullmailer pid 2194178 invoked by uid 1000);
        Wed, 30 Nov 2022 15:24:51 -0000
Date:   Wed, 30 Nov 2022 09:24:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] dt-bindings: power: Add starfive,jh71xx-power
 bindings
Message-ID: <20221130152451.GA2192004-robh@kernel.org>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-3-walker.chen@starfivetech.com>
 <99302e53-c0c9-cfe8-4e6a-c70e8428d9c3@linaro.org>
 <f21b0aa9-2ac8-ae28-755a-d530171f930a@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21b0aa9-2ac8-ae28-755a-d530171f930a@starfivetech.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:22:03PM +0800, Walker Chen wrote:
> On 2022/11/21 18:13, Krzysztof Kozlowski wrote:
> > On 18/11/2022 14:32, Walker Chen wrote:
> >> Add bindings for the power domain controller on the StarFive JH71XX SoC.
> >> 
> > 
> > Subject: drop second, redundant "bindings".
> 
> Will fix.
> 
> > 
> >> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> >> ---
> >>  .../bindings/power/starfive,jh71xx-power.yaml | 46 +++++++++++++++++++
> > 
> > 1st patch should be squashed here. Headers are part of bindings file.
> 
> Will be done in the next version of patch.
> 
> > 
> >>  1 file changed, 46 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/starfive,jh71xx-power.yaml
> >> 
> >> diff --git a/Documentation/devicetree/bindings/power/starfive,jh71xx-power.yaml b/Documentation/devicetree/bindings/power/starfive,jh71xx-power.yaml
> >> new file mode 100644
> >> index 000000000000..2537303b4829
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/starfive,jh71xx-power.yaml
> > 
> > Filename like compatible.
> 
> As mentioned in the previous email, the compatible in the driver should be changed to "starfive,jh7110-power".

Is the h/w block called 'power' or 'pmu'? Call it what the h/w is 
called.

Rob
