Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFD6437B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiLEWIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiLEWI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:08:29 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C766AE7A;
        Mon,  5 Dec 2022 14:08:28 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso8162239otb.2;
        Mon, 05 Dec 2022 14:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La6nfqN3ZBUuSu3HPW5QNxYpkhdeT1Kpud3YY7oUeJY=;
        b=MTdUzOECruRmgacwLnj3+eGpK1vnZlJPuPjQ+sG/8MOanqiDKy+Lcpox4BrmfCHnSZ
         8vVU8zqQWr3C6y2QR4VMAyVktsUPF1cvdBQf6Vv5DUewiWI29FvikU07PH0spNN1y8mr
         M6F+MkgDwZ4c40PiNrECASwkMJP1fo3ayCg8eSjFSIIdb2KwrjFemKezKSoVaAMZzZMi
         OYuvpweFX2/+8JG3d7XEnpXlndI5IPXxVpF0Fab6Mux1rPmoP7PPyUrFAXizlCLzik7r
         lJM9jXo25jv5AaYg8bzmmBOxLZ0uE8a+lv3ZxjDnoCP+wXBtkrSUSXx5cKgB68tWJ4Xo
         1vgw==
X-Gm-Message-State: ANoB5plJR4xuJu5ZX4sAuQsUIGsIHF3QJMs8O9hBxqgs6a8mztffG2dq
        pd9L9OPPBJnFtTloByRs6g==
X-Google-Smtp-Source: AA0mqf6WQoqpmq65YPLVcN02AAgP1XPQyjXGI8F3jmOc2Gh9PE5P05vI059K5zJswpb/4/vZfu3+rg==
X-Received: by 2002:a9d:6486:0:b0:66d:ca7a:8b1a with SMTP id g6-20020a9d6486000000b0066dca7a8b1amr32909767otl.55.1670278107499;
        Mon, 05 Dec 2022 14:08:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eo7-20020a056870ec8700b001446a45bb49sm4836134oab.23.2022.12.05.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:08:27 -0800 (PST)
Received: (nullmailer pid 2741475 invoked by uid 1000);
        Mon, 05 Dec 2022 22:08:26 -0000
Date:   Mon, 5 Dec 2022 16:08:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     abel.vesa@linaro.org, linux-mmc@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/5] dt-bindings: mmc: sdhci: document sdhci-caps and
 sdhci-caps-mask
Message-ID: <167027810532.2741118.8277664108645595118.robh@kernel.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 04 Dec 2022 10:47:13 +0100, Krzysztof Kozlowski wrote:
> The Linux SDHCI driver core reads 'sdhci-caps' and 'sdhci-caps-mask'
> properties and few devices already use it (e.g. Qualcomm SM8450), so add
> them to a shared SDHCI bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-am654.yaml  |  4 +--
>  .../devicetree/bindings/mmc/sdhci-common.yaml | 32 +++++++++++++++++++
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    |  2 +-
>  MAINTAINERS                                   |  1 +
>  4 files changed, 35 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
