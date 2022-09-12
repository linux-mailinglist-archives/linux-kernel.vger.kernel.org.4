Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA6D5B6227
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiILU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILU3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:29:24 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2031DC5;
        Mon, 12 Sep 2022 13:29:23 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id h1-20020a4aa741000000b004756c611188so684284oom.4;
        Mon, 12 Sep 2022 13:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=r+lEbarQretWvqhH9YbjjoGlZlvLBff7mmAaSicERdk=;
        b=bqOpFtkGX8BSOmDeNLKivBPx0UlgjIcaw9TcFgG5WRv9Vnoii0yzGEzeqOP6QBbzHU
         M7aV2EFDR1CjjB835hJqwoIhVSc0mz9wbvKYwsHtRiuoPX501NB8PE/rzteDJ44gan8+
         reSC1PkQoQ93rpvt/kK5VA7aXVZmlmo+akaoWaDt2O887D5doR3ywfvlCU5xZiYfNIC+
         ji7ZfBnaUREBZL0yqcoeudz7M0AQ/aVKCUok6JjKfqUJXwftVj5cr9rHr21mIi46blvg
         iClvmQX9oYM00Ver17M7e5urgUa3TFkrOdBRu2lhHStN/UbB3OtDNoAyzzWJjfvB/0xD
         Cn2A==
X-Gm-Message-State: ACgBeo2tsuB2uyAIp6yORhKEI4UJTZUpPuaQvlQYePXCE/20knLGToc6
        VTR/IHdFG4YJDX9mfmaANs2CdO4W9w==
X-Google-Smtp-Source: AA6agR43zBMpwnGoNh5pIC/oHpRm9Tjm5HVsLU4wSjy6QU0USVX4hwO+ipatHU0FO6XiE7KdcgIYEQ==
X-Received: by 2002:a4a:e2d2:0:b0:475:6f34:9590 with SMTP id l18-20020a4ae2d2000000b004756f349590mr2412931oot.30.1663014563051;
        Mon, 12 Sep 2022 13:29:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d75c3000000b0063b2251a78asm5108409otl.12.2022.09.12.13.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 13:29:22 -0700 (PDT)
Received: (nullmailer pid 1780234 invoked by uid 1000);
        Mon, 12 Sep 2022 20:29:22 -0000
Date:   Mon, 12 Sep 2022 15:29:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom,adsp: enforce smd-edge
 schema
Message-ID: <20220912202922.GA1780126-robh@kernel.org>
References: <20220906121358.302894-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906121358.302894-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Sep 2022 14:13:58 +0200, Krzysztof Kozlowski wrote:
> The smd-edge child node references respective schema which allows
> additional properties, so the ADSP needs to further restrict them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
