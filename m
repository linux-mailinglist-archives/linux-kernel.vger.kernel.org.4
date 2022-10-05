Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A25F5548
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJENZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJENZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:25:31 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8FB79605;
        Wed,  5 Oct 2022 06:25:29 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id w70so3413455oie.2;
        Wed, 05 Oct 2022 06:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na4FX+rHqiTFtvph5ofjqGqqLHdHSt2Uvpf7CjM1iqU=;
        b=dEoyTCFrt+LpoTEJIbSGiJPPnUMkqRRaiAknS6N4KRAit/ME2z/8ZWe3BRbSxLt9Z/
         F7qak0w+R6adIpXpoD4m0hEMUawD9DtrB70RgrjOoELpfpP3P7FF86sFPp7MlEf3xSGb
         vaJxX3PbCIz6wrfXlleJ716SXKbuVUecLpb0DAdgKCtcvtt4tfRzTtxsAWRGjoDxzIiQ
         WI6FJC9AY8wM808EhCv7iLXPzNhnusLF6Jgbm1nzODjcDG4k6d38qckZCnZra59dI9Yk
         5cCPvISvERydUS1o5I8ap07CHFag11og5+Esi1XR+tj72/QyKDYCc6e4+anOpU195z8y
         k/xg==
X-Gm-Message-State: ACrzQf3Zdnx8ndDXgk+RVjfD2An3+tcBuNMgqYgO0tkAWvmGVjuZKoTA
        sz6rTblJtbzSI+88mxLboA==
X-Google-Smtp-Source: AMsMyM6yD/PlbmzhxJK1xD7IA5YnuCa01OgGC1cyrDatorPr19LUNXjCTmZ0HWc0Bz7x9SV+psT5BA==
X-Received: by 2002:aca:d06:0:b0:353:f533:c390 with SMTP id 6-20020aca0d06000000b00353f533c390mr1286952oin.123.1664976329182;
        Wed, 05 Oct 2022 06:25:29 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id m13-20020a056870030d00b00132693419desm3046589oaf.3.2022.10.05.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:25:28 -0700 (PDT)
Received: (nullmailer pid 3268738 invoked by uid 1000);
        Wed, 05 Oct 2022 13:25:27 -0000
Date:   Wed, 5 Oct 2022 08:25:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Cristian Pop <cristian.pop@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: iio: addac: adi,ad74413r: use
 spi-peripheral-props.yaml
Message-ID: <166497632690.3268685.6335632613671776795.robh@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022 13:56:35 +0200, Krzysztof Kozlowski wrote:
> Reference the spi-peripheral-props.yaml schema to allow using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
> 
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/addac/adi,ad74413r.yaml        | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
