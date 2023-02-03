Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC08688B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjBCAFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjBCAFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:05:35 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADAC27985;
        Thu,  2 Feb 2023 16:05:21 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 20so2100302oix.5;
        Thu, 02 Feb 2023 16:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTL0MuLx/5c0ETGrwhMi0k3awDRVoMM6BD98MglbS1E=;
        b=IhaFnO81hhyVGV7Z/PtxKTSsbuM55eupdXM0+u+oZGvgoO1qdwamySdosUj9SYOd+Q
         ApY0r+WZu1IL7VikD6hhle05R9O/vtW2Y93DLb93WDrAmW5GQxBCd3biZVtA59uDkemF
         N0Htj557ZcQ5FM7SbTtzsD8cUfy3O/C//6eUdY+VVUPGOgxei+R/Dvr/OwuyPpamNMc5
         w96zUL7V4KgftCq43d/M5+k0BEHJQEagroHwLuwCA8umUILyNEkQMJU6xu3LU3tfw+gc
         7bE3WYLRJZIYJzaQZGKxT55FSts+LsGruGUAp2yZuGIPz8h79OInDqMPkoA+2a4rrvpc
         0YEg==
X-Gm-Message-State: AO0yUKUu60FoLT53kp2pEieb3fCLmVr8Z9CYr1CAKX9nNJmRnX9QecjP
        YHpI25ZO3BMEqRxER4uVnw==
X-Google-Smtp-Source: AK7set//llp04gTkDE/AY5s0BGv8VTvdate3dr3W+N5yMhtkxSPqC+d43UORD/ocGtovY0KBcpDGVA==
X-Received: by 2002:a05:6808:14e:b0:378:5999:ce80 with SMTP id h14-20020a056808014e00b003785999ce80mr4206373oie.27.1675382720528;
        Thu, 02 Feb 2023 16:05:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z8-20020a056830290800b006866a9b28eesm452880otu.18.2023.02.02.16.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:05:20 -0800 (PST)
Received: (nullmailer pid 2939769 invoked by uid 1000);
        Fri, 03 Feb 2023 00:05:19 -0000
Date:   Thu, 2 Feb 2023 18:05:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 06/10] dt-bindings: pinctrl: qcom,msm8994: correct
 number of GPIOs
Message-ID: <167538271866.2939715.3805113285111463001.robh@kernel.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202104452.299048-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Feb 2023 11:44:48 +0100, Krzysztof Kozlowski wrote:
> The MSM8994 TLMM pin controller has GPIOs 0-145, so narrow the pattern
> and reduce sizes of arrays with pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml   | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

