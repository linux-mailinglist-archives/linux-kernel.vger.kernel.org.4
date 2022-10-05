Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3876D5F555C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJEN1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJEN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:27:18 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5CE7A51E;
        Wed,  5 Oct 2022 06:27:11 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-127dca21a7dso19820163fac.12;
        Wed, 05 Oct 2022 06:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7JOyiMeq4tlFbVy4eYXRJu+Hg4V/59vL9/gbaEMCds=;
        b=z6oB129DAZhQ4jhlIA4rvSOhEI3vx1Egv6Bdf+KY+sDdFRXwKptmHQo2g0BIdBe21c
         wWqeXAMGcKiNCtN1TVleioHOfs1Jb4s9pVawsSussrzvyoupDWVwwtCFqWhQUCLQSqhQ
         EnSWtRrEAzG/ZAbfAFSaq0YPCi+1p2yxeO0mmHuD2FcVRFJ/f8Oc15RlzTm7N4ldvmVG
         wE5+EIXRLKaLs8+/XCHzJQO5Ch4DC+xgwhQPJk2WVhzI798+y1rpip3NrEjifd1FjR4H
         ukVLrycfAxTPNoXvPrfBMO+GT/0xcDKfQdFCAqfkcZD2A4T3LvI/zYK1UgCB/zG/GVzR
         Cc2Q==
X-Gm-Message-State: ACrzQf3++KyQvUcwvK2VxXvRDPblbwaha1wgt+SFTwZxbrv2N9t+JXhE
        XbY4zS4wUxAeEezI9RGH7A==
X-Google-Smtp-Source: AMsMyM7Xr6TcJ+85rcsT50K5/h1WcCPOmgNiADQotOzZ/YEU7BbZKRp9p+xIPdoi5JjKj0WlfZVtkw==
X-Received: by 2002:a05:6870:ac0e:b0:132:f230:7f9b with SMTP id kw14-20020a056870ac0e00b00132f2307f9bmr352504oab.253.1664976430565;
        Wed, 05 Oct 2022 06:27:10 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id c24-20020a9d6c98000000b0061c9ab1032dsm4118359otr.18.2022.10.05.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:27:10 -0700 (PDT)
Received: (nullmailer pid 3271235 invoked by uid 1000);
        Wed, 05 Oct 2022 13:27:08 -0000
Date:   Wed, 5 Oct 2022 08:27:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Nishant Malpani <nish.malpani25@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Pop <cristian.pop@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        devicetree@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>
Subject: Re: [PATCH 7/8] dt-bindings: iio: proximity: ams,as3935: use
 spi-peripheral-props.yaml
Message-ID: <166497642754.3271169.18231586894543870563.robh@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
 <20221004115642.63749-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004115642.63749-7-krzysztof.kozlowski@linaro.org>
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

On Tue, 04 Oct 2022 13:56:41 +0200, Krzysztof Kozlowski wrote:
> For devices connectable by SPI bus (e.g. already using
> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> schema to allow using all SPI device properties, even these which device
> bindings author did not tried yet.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/proximity/ams,as3935.yaml        | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
