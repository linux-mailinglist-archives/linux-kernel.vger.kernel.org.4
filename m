Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A685FC8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJLQLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJLQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:11:30 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D67A033F;
        Wed, 12 Oct 2022 09:11:30 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so12454995ooi.5;
        Wed, 12 Oct 2022 09:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J7x9zN0OClxgUpHT1aRD0SP13D4n7eAdvmXv478zN0=;
        b=x2ex/H+BoZBnL6sZWtvuIVNhwJn9oVhnz6GzhThc9SSQJCiIBDB/CcgEqrBZwZazrX
         WlBWg5SIe6jaTz+yDvXSeDUvsk3a7nRDzm1qY/nGmWQgq1AqVmwAAkGQ8l2l4SpmEU6G
         LfrepGAAhX8WUc/SZWphYRsskIOtL+F0BfAp8tKC0Bw983bfqIyJR0pqv3FHDiehvG8H
         cVDiNd9Uglceliw+x6InhRItJ3/mHwyinHnfsPruEfhVwLhYIEdyi/KbVuiTCWxOZQea
         VYd3bzwWdygqfDB3MSPXlfUJWOvBivAyLN8oYWQQ9BQTzlJT7wHyzt/y1tYnrAz342De
         6buA==
X-Gm-Message-State: ACrzQf0yEM/he/sPNRkkkyLKGdBMxTuy8q20BIrihEVu5/g+Epm3gCxn
        qwwpbKB4qFr+vGXK5SDCBhNYb2gSjw==
X-Google-Smtp-Source: AMsMyM7wW7pmkLQ/s8EMhQ0+P97Btqh8AR7UaS1Tkj2OpwWjhdoIQDU1UlMTqzbG25b7Byn/JCsZLg==
X-Received: by 2002:a9d:68d9:0:b0:661:9e75:af9b with SMTP id i25-20020a9d68d9000000b006619e75af9bmr6591581oto.293.1665591089162;
        Wed, 12 Oct 2022 09:11:29 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h13-20020a9d554d000000b006619f38a686sm3491517oti.56.2022.10.12.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:11:28 -0700 (PDT)
Received: (nullmailer pid 2270880 invoked by uid 1000);
        Wed, 12 Oct 2022 16:11:30 -0000
Date:   Wed, 12 Oct 2022 11:11:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,msm8998-bwmon: Correct
 SC7280 CPU compatible
Message-ID: <166559108971.2270830.13074268044998349307.robh@kernel.org>
References: <20221011140744.29829-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011140744.29829-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 11 Oct 2022 10:07:44 -0400, Krzysztof Kozlowski wrote:
> Two different compatibles for SC7280 CPU BWMON instance were used
> in DTS and bindings.  Correct the bindings to use the same one as in
> DTS, because it is more specific.
> 
> Fixes: b7c84ae757c2 ("dt-bindings: interconnect: qcom,msm8998-bwmon: Add support for sc7280 BWMONs")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
