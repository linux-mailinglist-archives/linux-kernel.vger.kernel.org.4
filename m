Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2685F551F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJENOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJENON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:14:13 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417E792E3;
        Wed,  5 Oct 2022 06:14:12 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso10774046ooq.6;
        Wed, 05 Oct 2022 06:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us1gbC0HCIGjXgoBGtMUQS365+04o6By1VntKrKN464=;
        b=Sun6GD+miNNsQW6w7TMvH/NdjSyz40tCEzaF3oqGKdSVamE2khdBcFknO21YkhJPK4
         kG0YNVwHch0IhPgu0rQrn9JBGe8hDbJ6CoRCWqN0HDUoJBVrkgDyFLU4uZNcaJwNoDxq
         QxiSAyqjdD28ymegwtHtOP/jhHmdS8GkWnNQHvHwKH3nqgGD7+ef5V3dVZYycLCDI69L
         EAJCwpjyPdL1XASGRdRfFir14jrHGpLHQBKsnUv0MP9rfVenCePRiT/IuGVjipo+OJZP
         tGQaba3E02Sp8TJUk2E2eRtv+T1bULfTOetXItewUWS1Ji2AwRuMPIf7OR91di6lohlt
         v4ZA==
X-Gm-Message-State: ACrzQf0dUJkpulFoPuBzgoUCVfwPhcLrQKHm3POnsAufLFnuYkkZ0HeE
        p6H2cjU3shQmLMhs/ZjN+A==
X-Google-Smtp-Source: AMsMyM4yGZNVEZO0gUm6Y1ZYmOt9sQSiHOUHoREsWyfAZ4rDf7s5fnnpasq/0f77SctWwdx487lmtw==
X-Received: by 2002:a05:6830:3115:b0:658:ea61:249c with SMTP id b21-20020a056830311500b00658ea61249cmr12204357ots.225.1664975651409;
        Wed, 05 Oct 2022 06:14:11 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id p189-20020acabfc6000000b00350f17527fesm4170243oif.28.2022.10.05.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:14:09 -0700 (PDT)
Received: (nullmailer pid 3256258 invoked by uid 1000);
        Wed, 05 Oct 2022 13:14:08 -0000
Date:   Wed, 5 Oct 2022 08:14:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-crypto@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        "Chia-Wei Wang --cc=linux-kernel @ vger . kernel . org" 
        <chiawei_wang@aspeedtech.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 3/4] dt-bindings: crypto: add documentation for Aspeed
 ACRY
Message-ID: <166497564756.3256206.1489547324996590627.robh@kernel.org>
References: <20221004032841.3714928-1-neal_liu@aspeedtech.com>
 <20221004032841.3714928-4-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004032841.3714928-4-neal_liu@aspeedtech.com>
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

On Tue, 04 Oct 2022 11:28:40 +0800, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed
> ECDSA/RSA ACRY Engines Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../bindings/crypto/aspeed,ast2600-acry.yaml  | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
