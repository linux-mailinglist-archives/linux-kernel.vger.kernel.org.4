Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD668E24E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBGUyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBGUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:54:12 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1313FF3D;
        Tue,  7 Feb 2023 12:53:59 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id p24-20020a056830131800b0068d4b30536aso4624681otq.9;
        Tue, 07 Feb 2023 12:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=907sHulvoF8neoDNe5yAkdaGfb+ehLMcUUS+7y6XLyY=;
        b=lAo6emSRTfY0j+dpZeZgujisLVkETsdrbcVEvduerwOaJ6rFfeoPoo60/H3yODVex9
         jOy4nvg1ICAB2lPVWRByrI6W6O+9vqkqkCXDceDZahIhzVtSKHp67vujrs7SBU3EV5Ln
         6S8/XbyK9TBiseziw/UkV5h6DSgVaZTdzLYboamD/nkWagHYQzqm9PnFc3P1h4sTwmJr
         MUbiTbgMDXpQSAg5GkDEKXN3sRj4bCqIOUU8jBiu5K2tu3ShNkbo14HYg9ZMjBJdTzEp
         HgrXlKtP/0C13CiwoMcl08scKqdXs7FJ0nKd0MvDXPg/ivrAiwjjqruCAlsmTsrKsP57
         uJcg==
X-Gm-Message-State: AO0yUKV5OiLM47LTgu/3BNGX9LsoC3tlpcJ/b75CzSQzqCN0Dk8QXDn5
        EeroR5FU34TwCmiwmGKJzg==
X-Google-Smtp-Source: AK7set/fOQVEpQW3hMQDSrruhbgbX3P3rL9zsI3we2gs+uwqyb4nXwNhkr6oeYGTlz4aYRQ5QItAeA==
X-Received: by 2002:a05:6830:68c4:b0:68d:9dce:b59b with SMTP id cw4-20020a05683068c400b0068d9dceb59bmr2452765otb.3.1675803238308;
        Tue, 07 Feb 2023 12:53:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05683063ca00b00684a10970adsm7083602otb.16.2023.02.07.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:53:57 -0800 (PST)
Received: (nullmailer pid 4137580 invoked by uid 1000);
        Tue, 07 Feb 2023 20:53:56 -0000
Date:   Tue, 7 Feb 2023 14:53:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        Linus Walleij <linusw@kernel.org>, linux-ide@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, linux-mtd@lists.infradead.org,
        Krzysztof Halasa <khalasa@piap.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Richard Weinberger <richard@nod.at>,
        - <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marc Zyngier <maz@kernel.org>, Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: serial: restrict possible child node
 names
Message-ID: <167580323532.4137506.13064088667949445777.robh@kernel.org>
References: <20230206092624.22922-1-krzysztof.kozlowski@linaro.org>
 <20230206092624.22922-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206092624.22922-4-krzysztof.kozlowski@linaro.org>
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


On Mon, 06 Feb 2023 10:26:24 +0100, Krzysztof Kozlowski wrote:
> The re-usable serial.yaml schema matches every property with ".*"
> pattern, thus any other schema referencing it will not report unknown
> (unevaluated) properties.  This hides several wrong properties.  It is
> a limitation of dtschema, thus provide a simple workaround: expect
> children to be only of few names matching upstream usage (Bluetooth,
> GNSS, GPS and MCU).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

