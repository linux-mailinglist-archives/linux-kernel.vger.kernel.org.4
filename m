Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB746F8A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjEEUNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjEEUNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:13:38 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357302125;
        Fri,  5 May 2023 13:13:37 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-192cd5579faso1893946fac.1;
        Fri, 05 May 2023 13:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683317616; x=1685909616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zChV03MNSLk+RhkKNi4v4/pkoAVSaYc302EiptBzpnA=;
        b=ZmsIIcJO0/V2LWrmdOgGztFG08LXBix9axEM+dpvji8qsG8Bvum0S1nZq7XR7axEGE
         eZbX4M6VS9Z+WEMSlHX7M9rmYPGrQpOBR7bu/6Y2Kn2twRpG9I0bz6WyMChwFVsxlvOb
         nv72XZN2BX07lpa+ahNpoZbMt/rBr3bhQS0/6fpUQWnDfFzfOGvlNu9iGqabNx/a5Wsv
         T6KEyXxIrAiPN/zKHRIcffcUR/agCJbcI4228lYGN2f6XuDRlRiN5KsK24Nu1eZvDPH8
         abVkGi0OH0xenAJknnE1Ns+SwLKdnp+npyhig1JT6S09IO+oyMF1ytVnh7vfmD9laQh8
         7Ysw==
X-Gm-Message-State: AC+VfDzUsdqVtWE0ssYnne1hyk2RapvMvaho/HTy+vCpdcL+2tpZuv+T
        maFh3iO1K2jZo51aRZGjvA==
X-Google-Smtp-Source: ACHHUZ7FHdb4xmSJ49+Ps7Ok9SKUjtmJ9rgSQNnXgthb1aSzSkjNDQnTk4ST208PhuNdviNurDwg8Q==
X-Received: by 2002:a05:6870:9571:b0:18b:2238:5abe with SMTP id v49-20020a056870957100b0018b22385abemr1680146oal.9.1683317616431;
        Fri, 05 May 2023 13:13:36 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r1-20020a056870734100b00177ba198612sm2198657oal.53.2023.05.05.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 13:13:35 -0700 (PDT)
Received: (nullmailer pid 3492366 invoked by uid 1000);
        Fri, 05 May 2023 20:13:34 -0000
Date:   Fri, 5 May 2023 15:13:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
Message-ID: <20230505201334.GA3459327-robh@kernel.org>
References: <cover.1682636929.git.jahau@rocketmail.com>
 <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
 <1d187f41-ad9a-4e82-8557-20694a8294d0@linaro.org>
 <e9d75e57-bdea-593d-7b05-136c9ad2e2fe@rocketmail.com>
 <14daa006-5260-81a8-8ba0-4122e0c0509a@rocketmail.com>
 <a0f4252d-7f27-6dd9-dea0-f8d242011f70@linaro.org>
 <73c02d98-c306-5e9d-2737-ff2d4a7393d1@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c02d98-c306-5e9d-2737-ff2d4a7393d1@rocketmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 09:33:49PM +0200, Jakob Hauser wrote:
> Hi Krzysztof, Hi all,
> 
> On 02.05.23 12:59, Krzysztof Kozlowski wrote:
> ...
> > Apologies for this, just very busy times. :)
> > 
> 
> Thanks for letting me know. Take the time you need.
> 
> Writing towards the list:
> 
> I think there is a misunderstanding here.
> 
> The connector node provides information about the installed USB hardware.
> E.g. property "usb-role-switch" means "Indicates that the device is capable
> of assigning the USB data role (USB host or USB device) for a given USB
> connector [...]" [5]. To my understanding, in relation with a port node this
> actually says that this port has this capability. This is not relevant to
> the rt5033-charger driver.
> 
> The rt5033-charger driver needs to pair with the extcon chip because it
> needs the information about *external* connectors being attached [6].
> 
> Extcon devices like SM5502 or SM5504 are real hardware. I'm not adding new
> properties. The way of getting an excton device from the devicetree by
> phandle is part of the extcon subsystem:
>  - function to get the excton device by phandle: [7]
>  - line that's looking for the property "extcon": [8]

extcon as a binding is inadequate for handling the increasing 
complexities of connectors. Whether we need another property to link 
things to connector nodes, perhaps.


> The connector node is the wrong approach, as far as I can tell on my current
> state of knowledge. It doesn't provide the information needed by the
> rt5033-charger driver.

What information is that?

You need information from the DT or run-time information from the 
'extcon chip driver'? In the latter case, I'd expect the charger driver 
to get its connector node (either TBD phandle or search the DT if 
there's only 1 possible connector), and from that get the driver 
controlling the connector.

Rob
