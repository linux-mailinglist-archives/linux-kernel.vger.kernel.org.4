Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E175F6F08
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiJFU0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiJFUZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:25:57 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5837C14A7;
        Thu,  6 Oct 2022 13:25:44 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id o64so3305208oib.12;
        Thu, 06 Oct 2022 13:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTS88trrEQJtCmq3QI1h9ZZ2XEQSNnnN9U4ukad9J3E=;
        b=wFcQ+nzWQsAe46okxSffVm2IBmY5tuEw3+2Q4sOjBgeJxvDJn4SJ0a3c5fNu2hy/XF
         quqltlFfKn/z6BelaIIyqxyd392sW0BIYUta27HLEAOzcGy9scsY5tiTfaNhA97fUAru
         QUyovoAxJUuFHu5ZROf9hQZjdNcP+p3qm1+++K/ahrfdcED+Oh9YB2V9eYfNRjUmOTO9
         6bo3c/HYIqIE69gmqZjbQxFgR5fEyl8kyyzLfZJaqjTIkWwBlXpnoD70cUDRAx8+dO0x
         6bPTvqcYlNj0nqRe5pkfOx0Nfl3yx6eUj3BaVZX7H/mhDEjZ+hGNtYiYngCV+Zdc4l9I
         IuRg==
X-Gm-Message-State: ACrzQf3W8LugitBwUp/azaeISbDO2KkoLh3Y/YSQhbBggaHsjNEh//A6
        S57GgLy/8khgCJsDLnQfdWozbpxazw==
X-Google-Smtp-Source: AMsMyM6SNRQbsjdKflSmVgLRVBDPBTsZ9xCg+tykKyEs5aXs5NqVST7xdRn92jvPPE7SJ3pS5RfVRg==
X-Received: by 2002:aca:904:0:b0:34f:8e77:4d9c with SMTP id 4-20020aca0904000000b0034f8e774d9cmr5924301oij.87.1665087943747;
        Thu, 06 Oct 2022 13:25:43 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id bg2-20020a056808178200b0033b31480f38sm66495oib.34.2022.10.06.13.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:25:43 -0700 (PDT)
Received: (nullmailer pid 105029 invoked by uid 1000);
        Thu, 06 Oct 2022 20:25:41 -0000
Date:   Thu, 6 Oct 2022 15:25:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: Re: [PATCH 08/34] dt-bindings: pinctrl: qcom,sm6125: drop ref to
 pinctrl.yaml
Message-ID: <166508794032.104974.8007780676365474282.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-9-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:11 +0200, Krzysztof Kozlowski wrote:
> The binding references common Qualcomm TLMM pin controller schema, which
> references pinctrl.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml         | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
