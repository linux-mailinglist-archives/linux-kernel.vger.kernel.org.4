Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E32F6DF98E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDLPRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDLPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:17:00 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB4DE5D;
        Wed, 12 Apr 2023 08:16:55 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-18447b9a633so11446298fac.7;
        Wed, 12 Apr 2023 08:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312615; x=1683904615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wKru0WHKz9lla0bQ2KTxXkrm6t5fjF1n1Z1MeP928g=;
        b=vEFVujDGDYxZvUlY+662Wxlryk1xFWUyhhwgC4qYmvakdxfZAkD+4Nq40FZHol/tw/
         7HgqrPWsdDnVg5BXm9W9/Ms8AxxX4MYnetOPldcJHcdCYZ39GNzKUlGzd1pslHZtjU7S
         hyyS1L0McgWWbp0HQ+nDZL9+QfoCaez1n8Tb25lzJi2VopV+RgXU1UVq1GWKVpd3NpwT
         l5VquGI3nCeAFY75EUc9aRTomt4WO7MZuOpZHAI4dYTtQ5ZWjxxw4nTTNipcaPWAv7rB
         wsHs3CmYALNlKtjfJlWbqt719GgqmaMcg0PA13LDKj4UkeY6guP+aD+lg5fO5+7KEbd/
         4KVw==
X-Gm-Message-State: AAQBX9dbO3imCHLm/MH2RHpQdmZrqF7hXNn6S090RuP+p7KblCuNJhdP
        RK7pJe3Wl1YcKiOsMOsGxoA6Rxqyqw==
X-Google-Smtp-Source: AKy350Zx+0x3HRXfJI07ip38UMKg4qTIVfNukGaSt8LDDe9Y5tJ+76tCbJGo+RgHn5n5j//gIHoEQQ==
X-Received: by 2002:a05:6871:892:b0:17a:e416:b0df with SMTP id r18-20020a056871089200b0017ae416b0dfmr10249342oaq.3.1681312614782;
        Wed, 12 Apr 2023 08:16:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j48-20020a4a9473000000b0053dfd96fa61sm7109248ooi.39.2023.04.12.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:16:54 -0700 (PDT)
Received: (nullmailer pid 2450825 invoked by uid 1000);
        Wed, 12 Apr 2023 15:16:53 -0000
Date:   Wed, 12 Apr 2023 10:16:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: clock: qcom,gcc-sc7180: document CX
 power domain
Message-ID: <168131261307.2450765.14734460814310298144.robh@kernel.org>
References: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
 <20230408134820.76050-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408134820.76050-2-krzysztof.kozlowski@linaro.org>
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


On Sat, 08 Apr 2023 15:48:19 +0200, Krzysztof Kozlowski wrote:
> The GCC clock controller needs CX power domain, at least according to
> DTS:
> 
>   sc7180-trogdor-pompom-r3.dtb: clock-controller@100000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

