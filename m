Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6515872A631
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjFIWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFIWOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:14:08 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0FC35BE;
        Fri,  9 Jun 2023 15:14:07 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33b0cae115bso9873185ab.3;
        Fri, 09 Jun 2023 15:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686348846; x=1688940846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t6u+Mrz/1dBbbMkBNyrqyoA02iIWmNZLtRYGVEXPGQ=;
        b=dw7pu6nZa3HCFs0KL3EIjUL80owqSiyg/0giU0qqwubIAh3PB2LLnSOYoEUrQh3wB/
         hDAJMYlxdc4wV1N0MkgSLECw2ZX8+y/LiJhij6JwS7Z5M1NlXQRGlnsavMTXqhFZDvhv
         j+QR7mhBGo+sauVMnXlmr7hKjdk3xd9zDQJ3sx9rhxZUWPutzV25jOaP/0b0mMIR6eXk
         nb537IHPQU2HD8rbUnpASwenZMvhAjS7n61jro7BuKauFEpwL93ImsfurMuhrYTQzT7W
         KJNH1ExIKkIQQyVuTzsUBhn0klyLCVODZvGcr3YECLa5RXQm5+9AT1pgs72za8CEU7xC
         JGYw==
X-Gm-Message-State: AC+VfDzS/Fqk6m0/y+3p9u1WXFqrqae3Ar+nhKuDKSjYpPt63HiaNQ1h
        P1gF3Lwrl7QADEpChbcJ8Q==
X-Google-Smtp-Source: ACHHUZ7spV28QOx9P+mLMSMdbxJijLJ+sPQyGMPcKYjCMQj+2YQfFp/o0NoxbuCC5Gm3FxS/L55XwA==
X-Received: by 2002:a92:c52d:0:b0:335:25e7:1897 with SMTP id m13-20020a92c52d000000b0033525e71897mr2493119ili.32.1686348846262;
        Fri, 09 Jun 2023 15:14:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ep27-20020a0566384e1b00b0041855b3a685sm1177478jab.150.2023.06.09.15.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 15:14:05 -0700 (PDT)
Received: (nullmailer pid 2555446 invoked by uid 1000);
        Fri, 09 Jun 2023 22:14:03 -0000
Date:   Fri, 9 Jun 2023 16:14:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-i3c@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i3c: silvaco,i3c-master: fix missing schema
 restriction
Message-ID: <168634884066.2555331.39755837725706368.robh@kernel.org>
References: <20230609141107.66128-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609141107.66128-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 09 Jun 2023 16:11:07 +0200, Krzysztof Kozlowski wrote:
> Each device schema must end with unevaluatedProperties: false, if it
> references other common schema.  Otherwise it would allow any properties
> to be listed.
> 
> Fixes: b8b0446f1f1a ("dt-bindings: i3c: Describe Silvaco master binding")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

