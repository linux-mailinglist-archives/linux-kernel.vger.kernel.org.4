Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B086D728933
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjFHUHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjFHUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:07:21 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7BB9;
        Thu,  8 Jun 2023 13:07:19 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77703f20aa9so50155139f.1;
        Thu, 08 Jun 2023 13:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686254839; x=1688846839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCE7xocRBkEwXdhay/uk+7t0tswMRd2eea3cgJIDzvo=;
        b=LYHhKDq7gYK2Pg8UvFlzDprXphJjtdKDejQttxbVjpAQV0+csgaOo918Ne3CNMue/G
         3FDJpQ/gkFZyluflfxMhMnydZV9uG10URVZL77EKtILDHsPuTNK62pwIOZMC+vqHAIsh
         9MAlduQNk+cf71jRqkbPm5Hy64Rl08RSEcsGebaDWPvfSBixUioxecHQOIqxkFJPJL8h
         KL6wYx08fFRTe6t+pvijK2+KFhWAFVGd11t03rOHAIQVnstFQVW0QBkjaQnqBvIT+HxW
         nNvM4sPG0JHLJ5SnlQrGBe6Ge6SNGJJW5fRglBgu4SATfxxZWxRo+9hV4N2uFgZhj2kT
         s+HQ==
X-Gm-Message-State: AC+VfDzS5FUtHlMG5DKbSzqYhlDt4PL83WOiPtNwYfFRKPakVZTFqse8
        BelXMqLECzl4hAsidLrbLw==
X-Google-Smtp-Source: ACHHUZ7Y/jQXG5jEUVhxK/gjEsU7RfT8KIAq/soUUNL8XKN2A7miMtfO/lnuGVj1MrM9HipcTArYmw==
X-Received: by 2002:a6b:6d03:0:b0:76c:6d91:d293 with SMTP id a3-20020a6b6d03000000b0076c6d91d293mr11838245iod.2.1686254838828;
        Thu, 08 Jun 2023 13:07:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k8-20020a02c768000000b00416650ba62esm476861jao.76.2023.06.08.13.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 13:07:17 -0700 (PDT)
Received: (nullmailer pid 3317123 invoked by uid 1000);
        Thu, 08 Jun 2023 20:07:15 -0000
Date:   Thu, 8 Jun 2023 14:07:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 22/25] dt-bindings: devfreq: event: rockchip,dfi: Add
 rk3588 support
Message-ID: <20230608200715.GA3315970-robh@kernel.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-23-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-23-s.hauer@pengutronix.de>
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

On Wed, May 24, 2023 at 10:31:50AM +0200, Sascha Hauer wrote:
> This adds rockchip,rk3588-dfi to the list of compatibles. Unlike ealier
> SoCs the rk3588 has four interrupts (one for each channel) instead of
> only one, so increase the number of allowed interrupts to four and also
> add interrupt-names.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v4:
>     - new patch
> 
>  .../bindings/devfreq/event/rockchip,dfi.yaml       | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> index e8b64494ee8bd..4e647a9560560 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - rockchip,rk3399-dfi
>        - rockchip,rk3568-dfi
> +      - rockchip,rk3588-dfi
>  
>    clocks:
>      maxItems: 1
> @@ -23,7 +24,18 @@ properties:
>        - const: pclk_ddr_mon
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
> +
> +  interrupt-names:
> +    oneOf:
> +      - items:
> +          - const: ch0
> +      - items:
> +          - const: ch0
> +          - const: ch1
> +          - const: ch2
> +          - const: ch3

Names that are just an index are generally pointless.
