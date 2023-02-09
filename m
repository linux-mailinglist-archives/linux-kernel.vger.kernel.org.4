Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB21F690FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBISDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjBISDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:03:21 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2683346D;
        Thu,  9 Feb 2023 10:03:19 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1685cf2003aso3532945fac.12;
        Thu, 09 Feb 2023 10:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el29K1onL5teh/SyUVO3DFE6M+GR2+jlsIc+fzWBWGc=;
        b=rvI5ikuQWhr+oqWGDLyE/COu8qnbBYCpTRVDbsGRrbIvVc4PXhd78l+HHXWfowYTu0
         lNhZ/dXXM92QT7fKsb2Gj90s0FxuOW7VScZCs9F4ZURk+2ri9IJZcRvU4xJsSvphPckZ
         PRPs6eis0QRbHZ4weJ6sLlyIF0pKjlaxEMceWf4K9ArVljkuxp6UdnMKGgJoEu1c4PpV
         +HdLvLbTO4r3GJBM6yvcW++WUFnBvDJJXhznFMBIMlXVGNszDIT47UqUAxLKarufAq8W
         rVYldLSRiwyuCm4n2vXQBx1BU3uqIOQ0nF3MeE9IMtE8va6tpw/4EEu6dlvch1RogikT
         e5jQ==
X-Gm-Message-State: AO0yUKXncaetEwea2y1w6A+Yk+Z82LUIEpnFjrmCbadPtGIXTA3Kl+YN
        /aOZSdq11g80aVLbyhKjLaCgNUoQaw==
X-Google-Smtp-Source: AK7set8WUgE0NQMjMBaBstBG0JR+aa8X4O/nx8En9XwR7htZ7gJVD3rGgSEa0Fj21MeQn+9Yn3NV3g==
X-Received: by 2002:a05:6870:ac0c:b0:163:b8fe:1e5e with SMTP id kw12-20020a056870ac0c00b00163b8fe1e5emr6546220oab.6.1675965798635;
        Thu, 09 Feb 2023 10:03:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n2-20020a056870844200b0010c727a3c79sm205619oak.26.2023.02.09.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:03:18 -0800 (PST)
Received: (nullmailer pid 575369 invoked by uid 1000);
        Thu, 09 Feb 2023 18:03:17 -0000
Date:   Thu, 9 Feb 2023 12:03:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        alsa-devel@alsa-project.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 7/7] dt-bindings: remoteproc: qcom,glink-edge: correct
 label description
Message-ID: <167596579699.575308.1762809433746364701.robh@kernel.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
 <20230208101545.45711-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208101545.45711-7-krzysztof.kozlowski@linaro.org>
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


On Wed, 08 Feb 2023 11:15:45 +0100, Krzysztof Kozlowski wrote:
> Correct the description of 'label' property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---
>  .../devicetree/bindings/remoteproc/qcom,glink-edge.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

