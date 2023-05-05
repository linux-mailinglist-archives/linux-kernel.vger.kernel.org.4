Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810FA6F7DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjEEHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjEEHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:18:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDB317DCE;
        Fri,  5 May 2023 00:18:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3075e802738so1033998f8f.1;
        Fri, 05 May 2023 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683271104; x=1685863104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzWyvblqfilGBcUvRYaPuQZCVXt9S+B5Ox3Rgl5tdiY=;
        b=Sif3uOWip9fRtda5rVF5altRdEq8+Shi/lYVnRwsCHiFd0KpCNWFHy7Bx3V0k//g6/
         +wD6ylLJiGr13OtqIog/ELlV5TP45kWhnllNMbfFOSsENTtNZHSXlhyR3onz9ggoZ+HI
         QlMtqV3juHlTybMgMhoUrrYdgouOHQcN8BjB7N1eOiMm3jRN2FK5c4NV4wMW1FsAZrF7
         x8qWWMqsesXdFBzMZR+E4xKKeEWTsd/K+lQ5WUHeJuVF+jFf6MRisLjKfiuWXW2atf+q
         XNzh3hFUZ3Qn73XCqXHHUEKqFG5yMOK6APVBKEq1ogF1OAJF0VYZ4y5wmvdC4xxG7o49
         PSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683271104; x=1685863104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzWyvblqfilGBcUvRYaPuQZCVXt9S+B5Ox3Rgl5tdiY=;
        b=RYkx9crmQVBTNhr3LNFNkUBGeizR/MT9+bwrPtLnUM8gt+E4H/OcNsWyF22vn3i8yO
         PNoazxhdkwMWGLXWv7oym8d5QwdBAmjWbrlbwcaLAAMcT3ngAR9QbqTY+xtxU2bdnlg2
         YcBNQ6bNMsOXqLDEIL6UsSDZf7ft2QwrSxcCTd6dZNjAN4BBWRN05nPxonJzC/ixHIDi
         IQ6f+xCPxpvdBtnEmx9rEtEg95BwLR28qxT11RrsKUyhJxnEncbkDMgR/3LHXTQsUJDh
         XGoMTKdbhFWWvfdount5iI/wNUtgUHzozZy5Iil9tL3Dcwihj2Gu8OEGtwKBjqFzFhgb
         umnw==
X-Gm-Message-State: AC+VfDxyld3GU/LbeSvZOPXm9COpkQiI6Px9kHsf+ixinjGACSS153PZ
        fgzhfZ3siaCWQ2b/spg58eI=
X-Google-Smtp-Source: ACHHUZ6ZBH8i0QtpKviFoyCrsF99lLGYiqDUsryIlE3yrjEiV9l9QOLubqLAxnW6gQdCz9Ijd+eYvw==
X-Received: by 2002:a5d:5512:0:b0:306:41d3:fcb7 with SMTP id b18-20020a5d5512000000b0030641d3fcb7mr624935wrv.52.1683271104049;
        Fri, 05 May 2023 00:18:24 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id z6-20020adff746000000b002f103ca90cdsm1408741wrp.101.2023.05.05.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 00:18:23 -0700 (PDT)
Date:   Fri, 5 May 2023 09:18:22 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: brcm,kona-smc: convert to YAML
Message-ID: <20230505071822.GA3236@standask-GA-A55M-S2HP>
References: <20230504190250.GA10108@standask-GA-A55M-S2HP>
 <30ee7d92-cc95-ba83-89e9-a2465cbd2fb7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ee7d92-cc95-ba83-89e9-a2465cbd2fb7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 08:49:55AM +0200, Krzysztof Kozlowski wrote:
> On 04/05/2023 21:02, Stanislav Jakubek wrote:
> > Convert Broadcom Kona family Secure Monitor bounce buffer bindings
> > to DT schema.
> > 
> > Change during conversion:
> >   - add used, but previously undocumented SoC-specific compatibles
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> >  .../bindings/misc/brcm,kona-smc.txt           | 15 -------
> >  .../bindings/misc/brcm,kona-smc.yaml          | 44 +++++++++++++++++++
> 
> Please put SMC stuff in firmware subdirectory.

Ok, will move it there in V2.

> 
> >  2 files changed, 44 insertions(+), 15 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
> >  create mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt b/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
> > deleted file mode 100644
> > index 05b47232ed9e..000000000000
> > --- a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
> > +++ /dev/null
> > @@ -1,15 +0,0 @@
> > -Broadcom Secure Monitor Bounce buffer
> > ------------------------------------------------------
> > -This binding defines the location of the bounce buffer
> > -used for non-secure to secure communications.
> > -
> > -Required properties:
> > -- compatible : "brcm,kona-smc"
> > -- DEPRECATED: compatible : "bcm,kona-smc"
> > -- reg : Location and size of bounce buffer
> > -
> > -Example:
> > -	smc@3404c000 {
> > -		compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
> > -		reg = <0x3404c000 0x400>; //1 KiB in SRAM
> > -	};
> > diff --git a/Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml b/Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml
> > new file mode 100644
> > index 000000000000..ba0312a20083
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/brcm,kona-smc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom Kona family Secure Monitor bounce buffer
> > +
> > +description:
> > +  A bounce buffer used for non-secure to secure communications.
> > +
> > +maintainers:
> > +  - Florian Fainelli <f.fainelli@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - brcm,bcm11351-smc
> > +              - brcm,bcm21664-smc
> > +              - brcm,bcm23550-smc
> > +          - const: brcm,kona-smc
> > +      - items:
> > +          - const: bcm,bcm11351-smc
> > +          - const: bcm,kona-smc
> > +        deprecated: true
> 
> That's not correct. You deprecate the same set as you allow before. I
> think you wanted to deprecated kona-smc alone.

What I'm trying to do here is to deprecate both compatibles with the
"bcm" vendor prefix, as these were initially introduced in [1]. bcm11351 is the
only one that ever had the "bcm" prefix, both bcm21664 [2] and bcm23550 [3]
were introduced with the "brcm" prefix (though they were never documented).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=7f6c62e2695bcb1547afdeb4ad3bcdf8c610be2c
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=2eba905e860f8aed5f2743b45259bb2e92548a55
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=fcd4138653f049c8fa45b48dc5f2806ced68e304

Regards,
Stanislav

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> Best regards,
> Krzysztof
> 
