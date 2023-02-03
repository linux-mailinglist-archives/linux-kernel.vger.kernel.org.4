Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C2C68A437
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjBCVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjBCVGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:06:53 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA7CAFCA3;
        Fri,  3 Feb 2023 13:04:49 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1685cf2003aso8087364fac.12;
        Fri, 03 Feb 2023 13:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9DsV+GpUSG5K40P5vIf0u8s8dNBGuvmfSfJfQosfTM=;
        b=UwYs63lDs7csI70hVmMSziEZJDHiSOYm1SCdI+LEjRWYNR0G3ATNN+UK1LK1pqnsoe
         QKvTZ9o7lgwKmG5WoaOz2dBmn0TeJ74cdUBC2+LA1ju+D+UiixNV79Bjt4AQdOvuy/mR
         ShX7c+MQYUnT2Q9d4MtC8TfgCFiusvgpL9vv2MNoh+g0nGt0njVs8le5ZaT0UltHDJr1
         v0KCOhl8dIe5OlyUaWq1jeZdou6JkJdNb0li/ukVJDkNXhet/3BJrqfsu5vG/RiItqcY
         pinblhbiN/PvtA1qtJfqTgotAbUhiFbqBRB2E1ToP7tyKklhEjkkE4RSE1OZQuxmTFQm
         cBxQ==
X-Gm-Message-State: AO0yUKWAzxV/DrjPCU86p/4Fzzc3Zp7Jm6UgVGaScitlQGie8Cikrnj9
        Gd8ELI0PuqPaSM6XQdg9Pw==
X-Google-Smtp-Source: AK7set9nffw86aZcXsqOSnKqjQ53iPGhK+2Ncg9gtRaOBTs+OmT7EZl91Tn+vQ+ipd7KT9K9/lfwUQ==
X-Received: by 2002:a05:6870:4724:b0:163:3b49:433d with SMTP id b36-20020a056870472400b001633b49433dmr7025317oaq.18.1675458205677;
        Fri, 03 Feb 2023 13:03:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n4-20020a056870880400b0014866eb34cesm1202985oam.48.2023.02.03.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:03:25 -0800 (PST)
Received: (nullmailer pid 880473 invoked by uid 1000);
        Fri, 03 Feb 2023 21:03:24 -0000
Date:   Fri, 3 Feb 2023 15:03:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: soc: qcom: Introduce PMIC GLINK
 binding
Message-ID: <167545803514.877251.9583536379585370837.robh@kernel.org>
References: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
 <20230201041853.1934355-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201041853.1934355-2-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Jan 2023 20:18:50 -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The PMIC GLINK service, running on a coprocessor on some modern Qualcomm
> platforms and implement USB Type-C handling and battery management.
> This binding describes the component in the OS used to communicate with
> the firmware and connect it's resources to those described in the
> Devicetree, particularly the USB Type-C controllers relationship with
> USB and DisplayPort components.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v3:
> - Dropped the additional endpoint from port@1 after discussions with
>   Rob.
> 
>  .../bindings/soc/qcom/qcom,pmic-glink.yaml    | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> 

Still hope to see some sort of design doc for how Type-C bindings fit 
together, but I guess now there is really nothing new in this binding.

Reviewed-by: Rob Herring <robh@kernel.org>

