Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC661E4F3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiKFRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:39:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D163D5;
        Sun,  6 Nov 2022 09:39:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D754B80C7E;
        Sun,  6 Nov 2022 17:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB744C433C1;
        Sun,  6 Nov 2022 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667756384;
        bh=+Z+VFK9uwo8rXQGuAGrs3LDCWmJz79959MQPWjHFGEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S4kFCxfqKAiM1pOUXQwa3dPqGFz2Pdsqu/lY3B3WRZRxF2GLgWUGuoXGbLdxqFlBU
         cEawzkYgteh7q9R3BaIx+dFabeehiqGutouUnDe112z0kzlxNnAzJDIWQ54WIzqHjc
         Fg9oORtz9RRw612hu+KZWZEm6SU0KVSM90ELBw7uJg16o2Oea4KrB1PgnFp3hT7Weq
         8IvlyYngiqi4pmekXRVb+PgfBcgWWlTBCxrk9V+kwPJiEcEcNVyk/9564bEzNn6IAY
         X7VBz0di6tikurD8AbEhCfpt1r8V1j743PqDAGVfEwlIKtLM4nDuULBhODQO6BI2Ym
         qqG9R8IlQngLQ==
Date:   Sun, 6 Nov 2022 17:39:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: frequency: add adf4377 doc
Message-ID: <20221106173937.37c00e0a@jic23-huawei>
In-Reply-To: <f551f177-8163-283d-cf1e-23b09ff35489@linaro.org>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
        <20221104092802.90725-2-antoniu.miclaus@analog.com>
        <f551f177-8163-283d-cf1e-23b09ff35489@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  
> 
> allOf with reference to spi-peripheral-props.yaml
> 
> > +additionalProperties: false
switch to unevaluatedProperties: false
as well when you do the spi-peripheral-props.yaml addition.

Easy to forget.

Jonathan

> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        frequency@0 {
> > +            compatible = "adi,adf4377";
> > +            reg = <0>;
> > +            spi-max-frequency = <10000000>;
> > +            clocks = <&adf4377_ref_in>;
> > +            clock-names = "ref_in";
> > +        };
> > +    };
> > +...  
> 
> Best regards,
> Krzysztof
> 

