Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367F86C3BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCUUWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCUUWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:22:00 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AFC559E3;
        Tue, 21 Mar 2023 13:21:11 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id k14-20020a056830150e00b0069f156d4ce9so4624090otp.6;
        Tue, 21 Mar 2023 13:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679430070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqU2hX/Czp8RXtnO9E4pSJ56fLHVN7ssEfvZw768KMw=;
        b=THaZR5DAz1STbI3gQrnYxv6SeqPt3J8jbBa6JCP+73Ak4MQzisvY9wH+3LRRSUh1cc
         V6jCb5itDg+CX1OU9JBRW9SEDb2eLLi8LcWNQVE9B9vv5MbPk6S3nK5CWmKgb+D7qGw2
         2N2B4cV5dNOv279kQTIiXdEswP6q9JGpZvEHlDzKYuPUjPRPQUTKSG0zjDqhMWTeXvJL
         l1uOe3ovvogSBCzYhdRJCjHXuvZjWI+iDap6C8c9MfYzVr77vBh/NGcvxiAia4+XUACo
         rFEj7OVxL0bLSX+1cTVz/2pu6GQXM13HK0SiUNQ1x2ChimP3iM3uB/EthBBvFlis8Oev
         fJ4g==
X-Gm-Message-State: AO0yUKUcsckh13HVwPAzLuRJgXYK9Cm5QhxoGsFnpRjkotB6cok7YhEv
        ptyT03bCWVCQnixTh8M2Tw==
X-Google-Smtp-Source: AK7set+ZNfr6buefBxIqeIVW8a6iodeZYm1nbE77VjFL/gTQ2kB+Ig3dNXMuYx1X8BT5TFqpzmwvRA==
X-Received: by 2002:a9d:7ac7:0:b0:69f:1632:4085 with SMTP id m7-20020a9d7ac7000000b0069f16324085mr242511otn.27.1679430070537;
        Tue, 21 Mar 2023 13:21:10 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id do6-20020a0568300e0600b00690e6d56670sm5532308otb.25.2023.03.21.13.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:21:10 -0700 (PDT)
Received: (nullmailer pid 1504246 invoked by uid 1000);
        Tue, 21 Mar 2023 20:21:09 -0000
Date:   Tue, 21 Mar 2023 15:21:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: snps-dw-apb-uart: correct number of
 DMAs
Message-ID: <167943006890.1503314.6357127595864690207.robh@kernel.org>
References: <20230317155712.99654-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317155712.99654-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Mar 2023 16:57:12 +0100, Krzysztof Kozlowski wrote:
> The "minItems" alone does not impose any upper limit of DMAs, so switch
> it to "maxItems" which also implies same value for minItems.
> 
> Fixes: 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma & dma-names properties")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

