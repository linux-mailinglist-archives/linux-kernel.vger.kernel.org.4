Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3226EE623
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjDYQxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjDYQxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:53:18 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879B1D307;
        Tue, 25 Apr 2023 09:53:12 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-38e2740958aso2235765b6e.1;
        Tue, 25 Apr 2023 09:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441592; x=1685033592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsSaFPoEnp1cGsorTT7ZaH8aG8h2ymJ3AbL8g9oAX2c=;
        b=cjW8wW9V34uotDp0F3DfgWyO4QJ8Kzxa8C9LmcfFRlvEq4+vJgN3v4APp9Uktv8ZNd
         Ok704JoruZrTDrp1J4zdp4PffbO60iMG096h7Wg0OWCsmuW4JZrX3eMQjWSrL7myzrie
         40hEoNjOzKiNASjaHRqUZPYBqjX0NmD+gGZ8yfYEiqKxsa0AB7qjXutSe4N6R4pKCg+Z
         ki12G05LXS767LmtLmw1uc0TX+G7D/4pC6BbpfWcd54QpGAqV3KXEHgI91o3Ci3PVirb
         XKbPG3AN0PJtjC+vx9XSJt+MDpl0nfSnS8oCBi92mBzNsjnAuw8BABeiGUVuyhDsn/Cx
         ZbMg==
X-Gm-Message-State: AAQBX9ejuv3mE8vTgIqd0Zy0kgfJjfVOXj5ZSKSlvQlkPD9HrN7PGX8C
        n06J+Dwrjmfd/nDfBNNaOw==
X-Google-Smtp-Source: AKy350bfrDTwQxvMUyap3y3hJHSKG/gULg481X3pOZQCJmRNZ5VYkfUL4Idx8sx5O25r4MyufQ1RvQ==
X-Received: by 2002:a05:6808:1392:b0:387:14b7:f8e7 with SMTP id c18-20020a056808139200b0038714b7f8e7mr10106662oiw.38.1682441591645;
        Tue, 25 Apr 2023 09:53:11 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a056808048900b0038dd5bf922bsm5772958oid.22.2023.04.25.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:53:11 -0700 (PDT)
Received: (nullmailer pid 1931342 invoked by uid 1000);
        Tue, 25 Apr 2023 16:53:10 -0000
Date:   Tue, 25 Apr 2023 11:53:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v2 03/13] dt-bindings: display/msm: Add SM6350 DPU
Message-ID: <20230425165310.GA1928942-robh@kernel.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-3-5def73f50980@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-3-5def73f50980@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 12:31:12AM +0200, Konrad Dybcio wrote:
> Document the SM6350 DPU.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6350-dpu.yaml      | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-dpu.yaml
> new file mode 100644
> index 000000000000..979fcf81afc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-dpu.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6350-dpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display DPU dt properties for SM6350 target
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +$ref: /schemas/display/msm/dpu-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,sm6350-dpu
> +
> +  reg:
> +    items:
> +      - description: Address offset and size for mdp register set
> +      - description: Address offset and size for vbif register set

Drop 'Address offset and size for '

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
