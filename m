Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB4163FA61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiLAWNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiLAWNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:13:13 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A301231ED3;
        Thu,  1 Dec 2022 14:13:12 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so1860317otl.7;
        Thu, 01 Dec 2022 14:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwMwCnWQlAuywGhrGiFgA27josOl6UvEgGpiYfWXGVo=;
        b=hf99BqUYFjjf1OM4qqrAw8P6X9YxLm84JakML2F6gUC6SyA41/Bz9PaXl+4AQCsGOg
         Bznmqf3RnpQf5zy/YlJyjjdFn8jW72GkKXN1BBTyOyn95yMuVjoiCUeTSQp3oWrOYeex
         9diTihvNzRpPR/mjRWo0Wk1NSvepICHsuGy4TLDaILpJYG3YbiajqBhrt2wjjHVUZyWT
         PerLViRt4LUSJJKpzLG4kPUJuJGZExAQVpOhYC6BfcJyg8xl1CglPEPyUWPlWoMdsluv
         tuurtbJrHSGxKPPH8Cr7la7LC7wr7JS4EZhb8uBu+5kj2AVJSc3pMbCsfxoqPG1khl9h
         G7+A==
X-Gm-Message-State: ANoB5pmGRWo2tYLP3ZA7bSACD7GMxUuYN/OTdDIFBiNrCfJjzrrh1tj2
        bV7xm2phb4j0VEPHw6KOWoS4uDmQkw==
X-Google-Smtp-Source: AA0mqf6qnGCyPpu8ZDDQyAlodGCvcJQ/PCX60COl4++AlaSdXWwBZZtqAACnPpeZMYP6rl1o9Tw32A==
X-Received: by 2002:a9d:69:0:b0:66e:976:193f with SMTP id 96-20020a9d0069000000b0066e0976193fmr23732052ota.214.1669932791886;
        Thu, 01 Dec 2022 14:13:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q23-20020a05683022d700b0066e7b30a98bsm719976otc.2.2022.12.01.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:13:11 -0800 (PST)
Received: (nullmailer pid 1538568 invoked by uid 1000);
        Thu, 01 Dec 2022 22:13:10 -0000
Date:   Thu, 1 Dec 2022 16:13:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andrew Davis <afd@ti.com>, Gene Chen <gene_chen@richtek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Luca Weiss <luca@z3ntu.xyz>, Neil Brown <neilb@suse.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 6/6] dt-bindings: leds: ti,tca6507: correct Neil's name
Message-ID: <20221201221310.GA1518960-robh@kernel.org>
References: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
 <20221127204058.57111-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127204058.57111-7-krzysztof.kozlowski@linaro.org>
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

On Sun, Nov 27, 2022 at 09:40:58PM +0100, Krzysztof Kozlowski wrote:
> scripts/get_maintainers.pl is confused when name and family name are
> without space:
> 
>   $ scripts/get_maintainer.pl -f Documentation/devicetree/bindings/leds/ti,tca6507.yaml
>   - NeilBrown <neilb@suse.de> (in file)

I'm pretty sure it is correct as-is.

We should fix get_maintainers.pl so all the one name celebrities can be 
maintainers.

Rob
