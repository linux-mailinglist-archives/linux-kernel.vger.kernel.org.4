Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB2868FB93
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBHXuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjBHXuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:50:14 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337A630EE;
        Wed,  8 Feb 2023 15:50:14 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-15f97c478a8so527729fac.13;
        Wed, 08 Feb 2023 15:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swlj8Zg4D3ZA9hPkSkkSZIaYsGYqtBZARu8vwYQvoxY=;
        b=a/ufj0WZlamVoRQcUXHmH/ap8DsT1Mnrik/Zt5iPajlWmOBMQDjm+vMtJ5JtbJRJbh
         PPwh8G2ju9wXqwN7iPJnH7ElfkkGlVmzpSHt6fa3xqVlc3RS1XXeA5PSI0+fOEywqJN4
         vg4FBHCYc3hXH4CxR1JejkbCZXWbW0opno7t2xUgfkZMdIZd9gqGsOBZ1akwEp1bnI6z
         mxcF+fWmoE/qB6Nd73oB0He+HG0RkYl2qCruWzqHwL/oDGaRVMzD+nBrFHvNhjl9r7J9
         1nOLvsixfcaypL6RM1vi8ihxVMstZXsHrV7BdxB4aZ7H5WjXlNEwNJoVLQvDble0dXmA
         EcBA==
X-Gm-Message-State: AO0yUKUE7sn1Suhi7k3DMvrrw7ATNiqghoB4LmkpVJI9M0hhrL84RX2b
        FnQz76nEVq39eWxjoD/ApQ==
X-Google-Smtp-Source: AK7set8XmWn4nD/gLJ0/2A/sHMSobVsdiLJerGR6oGztRoF5qbOK794iOc4fZQcRYHcxFbomCi5dFQ==
X-Received: by 2002:a05:6870:3324:b0:163:92dd:a164 with SMTP id x36-20020a056870332400b0016392dda164mr5093381oae.44.1675900213424;
        Wed, 08 Feb 2023 15:50:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f7-20020a9d2c07000000b0068d4649bedasm8704968otb.67.2023.02.08.15.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:50:13 -0800 (PST)
Received: (nullmailer pid 2939151 invoked by uid 1000);
        Wed, 08 Feb 2023 23:50:12 -0000
Date:   Wed, 8 Feb 2023 17:50:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v2 1/4] media: dt-bindings: samsung-fimc: drop simple-bus
Message-ID: <167590021178.2939096.11710329935156604662.robh@kernel.org>
References: <20230207205834.673163-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207205834.673163-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Feb 2023 21:58:31 +0100, Krzysztof Kozlowski wrote:
> The FIMC camera node wrapper is not a bus, so using simple-bus fallback
> compatible just to instantiate its children nodes was never correct.
> Drop the simple-bus compatible and expect driver to explicitly populate
> children devices.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---
>  Documentation/devicetree/bindings/media/samsung-fimc.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

