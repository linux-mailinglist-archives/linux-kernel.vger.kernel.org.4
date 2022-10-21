Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147D5608180
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJUW3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJUW2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:28:55 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD845219FE5;
        Fri, 21 Oct 2022 15:28:54 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id w196so4786533oiw.8;
        Fri, 21 Oct 2022 15:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W/EsYTY5jdD6CkHwPmekFERVmm/c7GuTjsbXW/lK6E=;
        b=yCZLL/SRObSHn3xNPhBa27hX9cSDnvep46zJMmEQqR3nVOD1WPPSpmoyKk8UX5kNI7
         pm4lK7M76Jzd1C8WFP+gCxGwc3lLu3B6UMtrWvOutC2F9uGSy2i28S29mz/zW5iPhj+1
         TFE2xA5KF8FeJlnHzhspMJdmRgjRUIUNxI7CGpQNOcp36Hdnl3Hg84bUlj4oKAPdUKXs
         zytP/7SdvqTlWEMDaZAQKfJfIGwgGI8Rkl76QnU3emCEKf2B+x2NgW5e/V+aR0tFzmCL
         uQwIxnfR5cZ1gfnk8AlF5n663d5Kx4CZX6RuXpsRvA/zQdvB6J1DM1aoF6d6Nm0s/Cj9
         HZ0w==
X-Gm-Message-State: ACrzQf1MIELgSUyICKF7e/zYEqgslqh6mtrFikZX6b+AvvWDtAgB2dXl
        PhpAgaYLewu0zN1V5wcNmX0poHIeSg==
X-Google-Smtp-Source: AMsMyM4YA0de+6SjzDDYgOZS+mKkxyMgUlhslIATt3PuNt1GNVmMhSQWt5/G6qFD2Jvwq5ECkwGbzw==
X-Received: by 2002:aca:2b0d:0:b0:355:200f:b5c4 with SMTP id i13-20020aca2b0d000000b00355200fb5c4mr10298209oik.39.1666391333956;
        Fri, 21 Oct 2022 15:28:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z36-20020a056870d6a400b0012b298699dbsm11077055oap.1.2022.10.21.15.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:28:53 -0700 (PDT)
Received: (nullmailer pid 573215 invoked by uid 1000);
        Fri, 21 Oct 2022 22:28:54 -0000
Date:   Fri, 21 Oct 2022 17:28:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Message-ID: <166639133391.573161.13030451062658991334.robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v3-3-e5e045644971@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v3-3-e5e045644971@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 17:27:55 +0200, Neil Armstrong wrote:
> Convert the non-SMD Regulators bindings to dt-schema, the old text based
> bindings will be deleted later since the RPM bindings are not yet converted.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 128 +++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
