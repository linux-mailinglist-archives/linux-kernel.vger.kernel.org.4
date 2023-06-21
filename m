Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC558739119
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFUUxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFUUxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:53:22 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949FF10F2;
        Wed, 21 Jun 2023 13:53:21 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-341c14e495fso30952925ab.0;
        Wed, 21 Jun 2023 13:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687380801; x=1689972801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2T1b/Oa5DrhnOGEKjXXQHTZCgVCz59Fkwvf59NrZRwU=;
        b=NVNJWxHykTk060VodNnUiFnoKyo0p7x+8tGG7NCP003MPAPf+1amZyi1p6wD8OS6sf
         aSbQB7/jlCiLUsbeNuzUjAt4NTyV4ivcSUygJ533JAHaaprI2DIb7uRa7Yk/IDRM9jGX
         EiugaUBHc5LEPvsS4A5ElHF97tMQ9HP4YZha93wjk/X5i4uIHH9tanrfKBRn6R/EICEH
         KLXtHGwenHyH9YEtucHXoODyE/CfZwgm67QwnDgTM7Mh+LvGVdOtjSUWjqaATTztDAo9
         UV3cCPPJQyVAiF/hLsodiaEqW9RLK113VPgzQB0w9GP4mrmCBTxQqsy2ERoZqBOTgtZg
         mFlw==
X-Gm-Message-State: AC+VfDxU/AUz81obURwZZhsKKGHQdfJD2xKjqnC/YPvLbtBB5f5+/B/1
        aohTgqYKKTZRTOrj48XPIw==
X-Google-Smtp-Source: ACHHUZ5H150mSa88b4xttNu7JSRWw4BPqTiRV+I+rs10PLxMr8Er0uReqJbPmLW+bHZBCSLxxHMGdQ==
X-Received: by 2002:a92:4b02:0:b0:33a:adaa:d6d1 with SMTP id m2-20020a924b02000000b0033aadaad6d1mr15210307ilg.15.1687380800779;
        Wed, 21 Jun 2023 13:53:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r1-20020a92d981000000b0033ce0ef231bsm1578002iln.23.2023.06.21.13.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:53:19 -0700 (PDT)
Received: (nullmailer pid 3515661 invoked by uid 1000);
        Wed, 21 Jun 2023 20:53:17 -0000
Date:   Wed, 21 Jun 2023 14:53:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: drop unneeded quotes
Message-ID: <20230621205317.GA3493078-robh@kernel.org>
References: <20230609140709.64655-1-krzysztof.kozlowski@linaro.org>
 <20230612093315.gbabepl5qg44xf5d@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612093315.gbabepl5qg44xf5d@pengutronix.de>
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

On Mon, Jun 12, 2023 at 11:33:15AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Jun 09, 2023 at 04:07:09PM +0200, Krzysztof Kozlowski wrote:
> > Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> > checking for this can be enabled in yamllint.
> 
> in my book quoting everything instead of dropping quotes is the better
> option. While that policy adds more quotes, it prevents surprises like:
> 
> 	$ yaml2json << EOF
> 	> countrycodes:
> 	>  - de
> 	>  - fr
> 	>  - no
> 	>  - pl
> 	> EOF
> 	{
> 	  "countrycodes": [
> 	    "de",
> 	    "fr",
> 	    false,
> 	    "pl"
> 	  ]
> 	}
> 
> And if you use the "only-when-needed" rule of yamllint you have to write
> the above list as:
> 
> 	countrycodes:
> 	 - de
> 	 - fr
> 	 - "no"
> 	 - pl
> 
> which is IMHO really ugly.

Agreed, but "no" and "yes" are unlikely values in DT.

> 
> Another culprit is "on" (which is used e.g. in github action workflows),
> so yamllint tells for example for
> https://github.com/pengutronix/microcom/blob/main/.github/workflows/build.yml:
> 
> 	  3:1       warning  truthy value should be one of [false, true]  (truthy)
> 
> and there are still more surprises (e.g. version numbers might be
> subject to conversion to float).

I'll add a meta-schema check for this. 'const' is already limited to 
string or integer. That's missing from 'enum'. I think we can also check 
that all items are the same type as well.

> So at least in my bubble the general
> hint is to *always* quote strings. Note that required: true is also the
> default for yamllint's quoted-strings setting, proably for pitfalls like
> these.

We're so far gone the other direction from quoting everything, that's 
not going to happen. Plus, if I liked everything quoted, I would have 
used JSON.

My preference here is I don't want to care about this in reviews. I want 
yamllint to check it and not have to think about it again.

Rob
