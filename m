Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC5568E23F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBGUxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBGUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:53:37 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE39F3FF12;
        Tue,  7 Feb 2023 12:53:27 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id c15so13600768oic.8;
        Tue, 07 Feb 2023 12:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PJSm9CilBHFyIsWRbAHYLGlD4Zqx4Jlnh/4qUPzl5M=;
        b=019KknTRF8K6bC4o6W5r6VJsvzfeHYnodkcSX6q0mpNwToWYHk/tE1MQtpowpP8naf
         F2rb5NlJZ6HEfWg73Drqhj5WWwXd9BhjxstV6UfHNk04nmNbJVQs3mW+3kG2aDC8nDsh
         GJc1U1F5tQXJc7nqVOzX48zkS8wYP90ZqaBrMUP96AK5IvN/WSJMENdWKqjf//9f0CIw
         TewJjGyIXBL+9EidemOsP1q+kOLiQVXa1SnlxsHzeARNsZNwcF/f9JOGl69H6GCYX8QV
         oxgzqUNaI7MMDcpCz/nzz5I7G8do194NwFhnDlnWs7GVaIEr7SiJb7FFXAT/2HVvxM3L
         sVPQ==
X-Gm-Message-State: AO0yUKXpWZfeIfG5QXRVPrYmlf7Mn+XOafN3e90DRejGnW1TD6s8ol0W
        EFTYQ1Wa2kjpPN4Av8dCzA==
X-Google-Smtp-Source: AK7set/z//YA/7nJzXqqCVgcdIIk5jn7+70eSAIqLW/fE6APlY4qVBeuPVuP8TVksPd0GAoMBckujg==
X-Received: by 2002:a05:6808:7da:b0:36c:d1c7:ba37 with SMTP id f26-20020a05680807da00b0036cd1c7ba37mr1766812oij.41.1675803206680;
        Tue, 07 Feb 2023 12:53:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a26-20020a056808099a00b00378ce4197casm6114632oic.8.2023.02.07.12.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:53:26 -0800 (PST)
Received: (nullmailer pid 4136611 invoked by uid 1000);
        Tue, 07 Feb 2023 20:53:25 -0000
Date:   Tue, 7 Feb 2023 14:53:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linusw@kernel.org>, - <devicetree@vger.kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-serial@vger.kernel.org, Krzysztof Halasa <khalasa@piap.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ide@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: intel,ixp4xx-expansion-bus: split
 out peripheral properties
Message-ID: <167580320367.4136537.4626987585773695329.robh@kernel.org>
References: <20230206092624.22922-1-krzysztof.kozlowski@linaro.org>
 <20230206092624.22922-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206092624.22922-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 10:26:22 +0100, Krzysztof Kozlowski wrote:
> The properties of devices in IXP4xx expansion bus need to be also
> applied to actual devices' bindings.  Prepare for this by splitting them
> to separate intel,ixp4xx-expansion-peripheral-props binding, just like
> other memory-controller peripheral properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
> 
> Changes since v2:
> 1. Add tags.
> 2. Move intel,ixp4xx-expansion-bus-controller.yaml to memory-controllers (Rob).
> 3. Drop | in intel,ixp4xx-expansion-peripheral-props.yaml (Rob).
> ---
>  ...intel,ixp4xx-expansion-bus-controller.yaml | 66 +--------------
>  ...tel,ixp4xx-expansion-peripheral-props.yaml | 80 +++++++++++++++++++
>  .../mc-peripheral-props.yaml                  |  1 +
>  MAINTAINERS                                   |  2 +-
>  4 files changed, 84 insertions(+), 65 deletions(-)
>  rename Documentation/devicetree/bindings/{bus => memory-controllers}/intel,ixp4xx-expansion-bus-controller.yaml (57%)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml
> 

Applied, thanks!

