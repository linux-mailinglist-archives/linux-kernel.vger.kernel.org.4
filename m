Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973EE731EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFORZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFORZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:25:50 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EA0270C;
        Thu, 15 Jun 2023 10:25:49 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-77acb04309dso443072539f.2;
        Thu, 15 Jun 2023 10:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686849948; x=1689441948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC933hKpQF5JdEINIqEGLBBb4JoET4B1krk6QuWZQ8E=;
        b=HHIJWlwoV4jlzMm27F+jYRkJkVVXkugLl/28qxpwO9ZcZB5UXYUpQMJ7y6R8ZZCykN
         vlggdqPFGj2x04BX3cFTzqETNoYrejwts6S70iOji6+q+TuOp4vC1qT86Rvej8A0Ogfb
         r9+JT0MIWgsSVtem0wZKFF+zGiI78kNGcqvhTmlXwKs6nEYD7W69bNOrAwXgmJ8qwPsm
         R6XaxyHzMApam/12Hsq9GWtwOX1SipgsYggx/iJ6DOKQRVNPAWOxxFqBDykq00mW1OXN
         eagLIIQVnG690bs1z/1gZYqe3V4tEVGNEtrTr0mLOKWTrGp+7GPiGYAy0PCsizHYSJgy
         gd2Q==
X-Gm-Message-State: AC+VfDzgfIObM1ZJ6WvmyykBRNdSf5seSjHGEqSfUWjCuc5ZAP5vrNpk
        v6Y7RJyhGD24NzWkl3x7oA==
X-Google-Smtp-Source: ACHHUZ6vs7uk1ULtYa9QZ49T2/R1dqPfF8wGisKxyfr+XOX8cDo1AmtTtASS3XLY03uvk3cJHKySXw==
X-Received: by 2002:a92:c989:0:b0:335:9303:4345 with SMTP id y9-20020a92c989000000b0033593034345mr30929iln.25.1686849948572;
        Thu, 15 Jun 2023 10:25:48 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y9-20020a926409000000b0033a9ba8747dsm6129695ilb.30.2023.06.15.10.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:25:47 -0700 (PDT)
Received: (nullmailer pid 1228844 invoked by uid 1000);
        Thu, 15 Jun 2023 17:25:46 -0000
Date:   Thu, 15 Jun 2023 11:25:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: example-schema: don't use enum as fallback,
 explain clock-names
Message-ID: <168684994509.1228771.14931709897823421899.robh@kernel.org>
References: <20230612092611.12385-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612092611.12385-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 12 Jun 2023 11:26:11 +0200, Krzysztof Kozlowski wrote:
> Compatibles with multiple entries should have usually only one fallback
> compatible thus enum followed by enum is not a common case.  Use 'const'
> as second compatible to show the recommended approach.
> 
> Explain also when clock-names are not really necessary.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/example-schema.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks!

