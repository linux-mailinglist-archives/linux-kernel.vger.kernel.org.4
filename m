Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359E85F6EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiJFUZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiJFUZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:25:08 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD994A828;
        Thu,  6 Oct 2022 13:24:57 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-132e9bc5ff4so3486277fac.7;
        Thu, 06 Oct 2022 13:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xNma0HEzU+NXcHVYqyXs26S0NgCxqUeIN7v6b11b3w=;
        b=rIUbx/MGF4463pRa3hf/aThhWx/bGyYTimwNHN4XCkGuToJcjZ2zvrqAg4SPbzRrVs
         QP7D7Twq+QJXUGi4vm6omkgUQ84gt3oVwR4Gs+9pquND4f8ax4M9jr+IQXmbQHqlL4aI
         2Ze9m+3s51sKptt8dDMg9Yy2GKaT05FnD8CJ5jkcJASu8spD4BrJo81vFG9rCiPbmH6G
         r7Qr3+Pm8ac/lsMmk0ULBVnVXuK5ho7peekcsUk25F0XKmN3pwXxo+1kN2i95G3CVJAf
         aDTkb/5dkwfNWEjznIb0MyX1fM9AXObSVvBYzwtkCeQOwKVRLPiUpgz0ib/mCbjfxA0x
         27nA==
X-Gm-Message-State: ACrzQf1i4b3qCOk3gzzw0c4EKd9xEJs4AhvbYQ3O+kqdR/VBST4c9GxH
        J1TPygg7tkQDVqSJGSofRw==
X-Google-Smtp-Source: AMsMyM7NPQv0h+lvPtdcH2GSCwq8P3VSVCMbAo5eTvXEan30H8R0kCgToZi3LDuLFI0lxLYO6VMbVg==
X-Received: by 2002:a05:6870:d6a6:b0:127:ef52:75db with SMTP id z38-20020a056870d6a600b00127ef5275dbmr6450627oap.232.1665087896096;
        Thu, 06 Oct 2022 13:24:56 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id p25-20020a056830131900b0061c9ab1032dsm290869otq.18.2022.10.06.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:24:55 -0700 (PDT)
Received: (nullmailer pid 104143 invoked by uid 1000);
        Thu, 06 Oct 2022 20:24:54 -0000
Date:   Thu, 6 Oct 2022 15:24:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 06/34] dt-bindings: pinctrl: qcom,sm6115: use common TLMM
 schema
Message-ID: <166508789426.104098.15401892863224042656.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-7-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:09 +0200, Krzysztof Kozlowski wrote:
> Reference common Qualcomm TLMM pin controller schema, to bring common
> properties, other pinctrl schemas and additional checks, like function
> required only for GPIOs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml | 44 +++----------------
>  1 file changed, 6 insertions(+), 38 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
