Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE343729DE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbjFIPKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjFIPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:10:32 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD4B6;
        Fri,  9 Jun 2023 08:10:29 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-777b4c9e341so84869939f.0;
        Fri, 09 Jun 2023 08:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323428; x=1688915428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgEA1Mw1A/5s3GKiOUjS2OVmsqKcYspaLT+4TG/YkK4=;
        b=DjwNmx67BeoFLM27pn5XmdbceUPDiON3563DnauYeHwea8zuquToq281cv41H+Iak3
         BouT0We4DQIMqblU63IGUlAEJmwAQCXkdWfAqTMfH/RJORQ+KVGABHBjU4CW/cdEnjnj
         xNi52lIsQPf2dqRnXBuyPkY5BEQQ2mMiCMtzGvSTVbGQyrf7KnwJsfcQp2PkYSwKRo5k
         X2yz4+pRTRgA4PCjQffFjALn4wN0QHcdxsqoc80Lt9Ms+6J3PDh5S6xDrs7PBhlZc6be
         +M0dv6G3UnM7DQctBLOUihm8hb2nssUDhKaoWDMsJLISdOMM1OX/MKppuNnCs9srr0YQ
         eOzw==
X-Gm-Message-State: AC+VfDwbJncx6FYyP1722y0fC7ojnw9SgAcibTsq3LIt2DiY02DRI+QH
        aiCOKcpSJzYwe84ichZkKg==
X-Google-Smtp-Source: ACHHUZ6GLJF9xmiCznvrkvDAHStb1dFZWwEwBO0JSyNuKSB2A4EFN0t4aWuWCLrZCT/E+UeHUSc/ew==
X-Received: by 2002:a92:ce11:0:b0:33a:56d6:d9a4 with SMTP id b17-20020a92ce11000000b0033a56d6d9a4mr2155501ilo.10.1686323428407;
        Fri, 09 Jun 2023 08:10:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l5-20020a92d8c5000000b00338a1272ce1sm1147336ilo.52.2023.06.09.08.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:10:27 -0700 (PDT)
Received: (nullmailer pid 986311 invoked by uid 1000);
        Fri, 09 Jun 2023 15:10:25 -0000
Date:   Fri, 9 Jun 2023 09:10:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-watchdog@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-spi@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-rtc@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        timestamp@lists.linux.dev
Subject: Re: [PATCH 1/7] dt-bindings: phy: intel,combo-phy: restrict node
 name suffixes
Message-ID: <168632342399.985906.12431431892707276555.robh@kernel.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 May 2023 16:48:45 +0200, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to:
> 1. Only one unit address or one -N suffix,
> 2. -N suffixes to decimal numbers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/phy/intel,combo-phy.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

