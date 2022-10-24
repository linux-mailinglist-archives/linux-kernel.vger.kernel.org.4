Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8689660BA56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiJXUfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbiJXUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:34:10 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CF127BC7;
        Mon, 24 Oct 2022 11:45:17 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13ba9a4430cso4164288fac.11;
        Mon, 24 Oct 2022 11:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4upE6rPkUg1Kk48qduhvrFmJwYjPpk30APYeg6GV6w=;
        b=CKJlPV8ahMSiKzeAcCg/WTD9qH4RiE1jT6ijXXH16wL8uyqEZr88ZJcLsS0jFu/hxy
         GN3Yy2TpiN9Flv8BAMbBJxJhee2ySKWoR3nCp6WYtZlZ7RV9R3lLLxxDQA4dh49iwNxk
         s/uWtlnM1uQiI0rGB0tUWYotOpeFlA4fJxZG3Y6xSJ5S4h48jUtkH5eHGV7GPanmb8VK
         TtZvDg4Kr1UbmRhrdOTTNdrXdVHXnoB3QW9nWnaToutSpYf2CqsHp+8e0KZZWYdWEnEi
         Rf3J9Z9kyIn+6hhdhJysZKNfWOrXmYS0snsCFmGTvnKgjSPacf90mzuXZw8JtSSAHguV
         Lm2g==
X-Gm-Message-State: ACrzQf2Ds/E0gBmmzMwg6/Kl1zx3ijrc+4i0VVJE6rTLxahxqSvoTTA1
        Bf24BealZsBrhrkaQFw/0w==
X-Google-Smtp-Source: AMsMyM6cky/yW1ZgEHaZQNSvu4CwhoYu/Fp9DZ/gEyYJFP3Btfjl8wSbjLryLSStc/QbxTWG7tZnMQ==
X-Received: by 2002:a05:6870:3052:b0:131:932c:3316 with SMTP id u18-20020a056870305200b00131932c3316mr20789918oau.288.1666637062744;
        Mon, 24 Oct 2022 11:44:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q14-20020a4adc4e000000b00480b7efd5d9sm307974oov.6.2022.10.24.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:44:22 -0700 (PDT)
Received: (nullmailer pid 2030017 invoked by uid 1000);
        Mon, 24 Oct 2022 18:44:23 -0000
Date:   Mon, 24 Oct 2022 13:44:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-watchdog@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, andrew@aj.id.au, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: aspeed: Document
 aspeed,pre-timeout-irq-us
Message-ID: <20221024184423.GA2023764-robh@kernel.org>
References: <20221021151559.781983-1-eajames@linux.ibm.com>
 <20221021151559.781983-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021151559.781983-3-eajames@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:15:59AM -0500, Eddie James wrote:
> Document this new property for the pre-timeout interrupt.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> index a8197632d6d2..81d2c35ca7e3 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -40,12 +40,17 @@ Optional properties:
>  			specified no external signal is sent.
>   - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
>  
> -Optional properties for AST2500-compatible watchdogs:
> +Optional properties for AST2500 and AST2600 compatible watchdogs:
>   - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
>  			 drive type to push-pull. The default is open-drain.
>   - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
>  			   is configured as push-pull, then set the pulse
>  			   polarity to active-high. The default is active-low.
> + - aspeed,pre-timeout-irq-us: If aspeed,pre-timeout-irq-us is non-zero, the
> +			      pre-timeout interrupt will be enabled for the
> +			      watchdog. The interrupt will fire the specified
> +			      number of microseconds before the watchdog expires
> +			      and trigger a kernel panic.

A pre-timeout interrupt is fairly common. Come up with a common property 
please. You'll need to be clear if the time is from wdog restart or time 
before final timeout. 

Rob
