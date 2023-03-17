Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7E6BF387
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCQVHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCQVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:07:36 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51004E5D3;
        Fri, 17 Mar 2023 14:07:35 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id w4so3435595ilv.0;
        Fri, 17 Mar 2023 14:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679087255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENb2cF3/oxNm3cDtIbYZNxgm7Nl+24DadvWOeqwmzEE=;
        b=r4f6YMa9fYwl0Xfbk77OOs+ete67sm0d9aJ1PsSTL++pSe/m5+C3VwVauPj8eA8x8c
         TaQlDPAcxwvOaNWLy4V/Abfc84GqSw6Jok4xOk5MTDqKAul/tn463CzwRClhDFfd5hgP
         /UD7mN4Q0+nBDuu1T1ooI6E48qKJt2PGk8D/U4AOBe60xHayzRSxgzII3UuVUhuV4S4P
         y45pNfuU97nO80sb+SfHjFFBHHlqGApe/r27InyIoVfBJls8OEMnhtUQRPJw/mi4+vzs
         pwK8VjS4ZX2FPGDR7OguTL7cEB8pJ7sz9QzPRZ5JKbvgXUByf4KoxT3ro2uV+D/ndWqk
         nZ5w==
X-Gm-Message-State: AO0yUKW0cFXJ5eVqQTulWTBojKLlZXG1NGomPcjJGNUIasnxYpo307fv
        E9nziB4f14VPaAl5NXgnSHf7LR+4zg==
X-Google-Smtp-Source: AK7set+dQlQk1gqqm3GKkRuXujJNX8NXzSoGDnj2WP1pYFYiBTbkaj4amccfZTDpunK7leetxJmx8g==
X-Received: by 2002:a92:c010:0:b0:316:f93f:77a5 with SMTP id q16-20020a92c010000000b00316f93f77a5mr33495ild.9.1679087254746;
        Fri, 17 Mar 2023 14:07:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id d42-20020a023f2a000000b004063e9acb00sm795063jaa.127.2023.03.17.14.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:07:34 -0700 (PDT)
Received: (nullmailer pid 2806856 invoked by uid 1000);
        Fri, 17 Mar 2023 21:07:33 -0000
Date:   Fri, 17 Mar 2023 16:07:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 01/13] dt-bindings: mailbox: qcom,apcs-kpss-global:
 correct SDX55 clocks
Message-ID: <167908725235.2806770.17614532492426166032.robh@kernel.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
 <20230314080917.68246-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314080917.68246-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Mar 2023 09:09:05 +0100, Krzysztof Kozlowski wrote:
> SDX55 and SDX65 DTS takes clocks in a bit different order.  Adjust
> bindings to the DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

