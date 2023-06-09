Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E970072A647
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjFIWde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFIWdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:33:33 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415E8359D;
        Fri,  9 Jun 2023 15:33:32 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-77493b3d18cso105554239f.0;
        Fri, 09 Jun 2023 15:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686350011; x=1688942011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0WBoWxkI9nrxvhvZXw6n4SD+pmXcoSXL1lzwCeKXhE=;
        b=hcyOIVvtIDrPvAdBX/veNnymtId7cyHhm5UZ7LfkuSGyp7IMzHcI9B1ofXx38VloZR
         DdcwVQXfV8xN1uJPLRBrQV0raxM16w/egOgMJ/gJ3yeddGwz8XAN4R8iX8lY++j56Xae
         oFzSflfvP3TjzhiukcbtsqfL8mP/KswbhFvbQURdzhZXuBMVASAB2w/JYDw5AMrEeDrv
         NLowlZcpwru809vTwgn/f2ZOHcCXNnXEehdtYEI/wp3lh319B79UWoALS7rf45RbgXJM
         EjxEVT2OP1IAgaZ6pG8bd1RwWJz2Kyf53j/4ANXB/WiDeSb9yC7YfodWZIkqxctbOPjR
         6amw==
X-Gm-Message-State: AC+VfDxWAeaTGBp2CdiUjmtX4nxlLsrPjPTznDpJWrivn+btbWsk85MZ
        nXHnUKm98rQnmaaYoZ9E+SDCsP8C9g==
X-Google-Smtp-Source: ACHHUZ6BbkVRmVkwVKhgORRjLQOSvJ9FIaFA+aBYpozVeu1HCvclY8YaJL+qMwALQkj3LV8EdO6XfA==
X-Received: by 2002:a6b:f101:0:b0:777:b493:beb4 with SMTP id e1-20020a6bf101000000b00777b493beb4mr3061988iog.12.1686350011380;
        Fri, 09 Jun 2023 15:33:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q12-20020a6bf20c000000b0077acde4332fsm1333829ioh.17.2023.06.09.15.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 15:33:30 -0700 (PDT)
Received: (nullmailer pid 2576630 invoked by uid 1000);
        Fri, 09 Jun 2023 22:33:29 -0000
Date:   Fri, 9 Jun 2023 16:33:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: document TeeJet
Message-ID: <168635000807.2576565.16340146117390993721.robh@kernel.org>
References: <20230515155747.499371-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515155747.499371-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 15 May 2023 17:57:47 +0200, Krzysztof Kozlowski wrote:
> Document TeeJet vendor prefix (used in am3517_mt_ventoux.dts board).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

