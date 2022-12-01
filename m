Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A742F63FA0B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiLAVuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLAVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:50:48 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A33C23C7;
        Thu,  1 Dec 2022 13:50:47 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso1823503otq.11;
        Thu, 01 Dec 2022 13:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jgJgRNaHld9gb5rSZvL/PyTZHu4sldrsMLvOaIfMsg=;
        b=k7kgy+xTRFhvzOCJkP/+QqJQeTngry3sI0ciNfq94n7lniD2iLNiM/b/CRcoyGTUWH
         BBX3aOpy9Nctue8dNSieIhveIO84wBq1wxhDgZpdI3CR1v1wBJoOLSRGN6AdUC0hyPWh
         PDP7aHtHp3zKbLFILT7/yACRJTYmpYYnEwFXkgBREKDfxd0G/5ptQ8Vc4Z64jDSYLO0x
         dRoqT2KuClLJQCtqsUJJSCLO82a90AOzuT0RMauclSt7kMvS+r5x/qbez6yX2UQPeDh6
         bcjPfGrqoLkb0RmbbMmAwIVOlA+224Vpa8DxxUF5vm96kdOfJjRVT/E8yIpMLD+rGUK2
         ANkQ==
X-Gm-Message-State: ANoB5plzLTNbJiyY3TlXOWbdZjTXYeqLCTykRejtsKctBPp5fT15HlxO
        QwkYfrihadvDW0Ri8z2bng==
X-Google-Smtp-Source: AA0mqf7a9CN/VqTUx6wJBV9AMr7VW+Ph/y/VwY25+fBiEyLCO+i5U4ofRL+QIWVprk48N1V9XxM1Rw==
X-Received: by 2002:a05:6830:18f1:b0:66b:99a2:feb9 with SMTP id d17-20020a05683018f100b0066b99a2feb9mr34385584otf.359.1669931447052;
        Thu, 01 Dec 2022 13:50:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d2-20020a4aa582000000b0049e9a80c690sm2233176oom.1.2022.12.01.13.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:50:46 -0800 (PST)
Received: (nullmailer pid 1508234 invoked by uid 1000);
        Thu, 01 Dec 2022 21:50:45 -0000
Date:   Thu, 1 Dec 2022 15:50:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: samsung: exynos-sysreg: split
 from syscon
Message-ID: <166993144474.1508149.1523006540100879286.robh@kernel.org>
References: <20221127123259.20339-1-krzysztof.kozlowski@linaro.org>
 <20221127123259.20339-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127123259.20339-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Nov 2022 13:32:57 +0100, Krzysztof Kozlowski wrote:
> Split Samsung Exynos SoC SYSREG bindings to own file to narrow the
> bindings and do not allow other parts of syscon.yaml.  This allows
> further customization of Samsung SoC bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Lee Jones <lee@kernel.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Sriranjani P <sriranjani.p@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. Add Rb tags.
> 
> Cc: Sriranjani P <sriranjani.p@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../devicetree/bindings/mfd/syscon.yaml       |  6 ---
>  .../soc/samsung/samsung,exynos-sysreg.yaml    | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
