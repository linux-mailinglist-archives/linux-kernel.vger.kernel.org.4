Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF11E5B9798
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiIOJhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIOJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:37:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148807A74F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:37:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t7so29883410wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=u6G2iioKlhreWY72ImcY0DT52eeZwoLA0aWyklIKPjg=;
        b=cEbrbNhqzcNobA04KBL1u/IQ4BWAPADvI/6Ce2prQA0uIAUe0ML+ndU0a14rG8d+/V
         QGaGP0I4Z7Aqwa1DG1YsTTFZIDaoeIeSGiq5eH8ZAzf9Xqfh2Vng187jXOoY0VtYDhj0
         0PrewZrzJ5wFrLRM4r1G86yGcpxoCm/wjTpwrDVtxeNEabb5qkO4kc+Dgpzughnxmq/8
         GTM7qeJKJLUZ402n2R0ss7YHxC6pWZca2FAJDROgDctFyA21eG4ChfX+YQW+s3ABVq3H
         uht61gC+KQBeEv/uu6FciBh6LydZcLB/oP18R+x+ip0Q1F4Rlg/8JTMLo0/yLXTu6vMd
         KgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=u6G2iioKlhreWY72ImcY0DT52eeZwoLA0aWyklIKPjg=;
        b=l+XYL9OMK3zkQ1Lw1OPZM7ogoe76nljzJp2TadpNY8nwPB/17DciNAY/DrnQGaMFHE
         WFW4Lzp5sAIwXimAkzdNylaXHZ8ffrlUFEl6BPiW5rbVS8FS47BpXRlQivXb4bdcxnf4
         qbqBNJHy++DT/3GwrxMdItpWZqGORJuSax0D1Cv81C1B+lPYo1ezITEy6W4nNQaYzlYF
         upiBHW0WM73sRdx36c8DkVzztn0ovjGYkakZmES8U6UXfsGy9+VcsEJ/v0bcPcXBD7ZO
         sebuLCHXUCO6ba/qT7lB9aVOs7VVi7Ero8WVJ9V62xTIm5Y5RZ+EW+n3l4zeixILmQx5
         vQXw==
X-Gm-Message-State: ACgBeo3r6xvXs9GFSvI/j2WbAvPiwgk8+Gy1Z7/vcT48Qx47ql5qZzvv
        suczVLBfSPUEUOev/3tRQZJ7ww==
X-Google-Smtp-Source: AA6agR6ISKfaamT/ln5NWfJPITmBeATzBzFJyVclE62RiELJEk+ullXhxSUnMaCfeT9I5+sqnEa9ZA==
X-Received: by 2002:a05:6000:812:b0:229:4782:d333 with SMTP id bt18-20020a056000081200b002294782d333mr22796743wrb.136.1663234637615;
        Thu, 15 Sep 2022 02:37:17 -0700 (PDT)
Received: from krzk-bin ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6a45000000b00229e0def760sm1940728wrw.88.2022.09.15.02.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:37:17 -0700 (PDT)
Date:   Thu, 15 Sep 2022 10:37:15 +0100
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-kernel@lists.infradead.org, Alex Elder <elder@ieee.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        vkoul@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        devicetree@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH V9 1/7] dt-bindings: Added the yaml bindings for DCC
Message-ID: <20220915093715.ednaqtx7ko6f5zlw@krzk-bin>
References: <cover.1663173477.git.quic_schowdhu@quicinc.com>
 <41b94746e1560d63f16fb5dc965042ec496aeaf1.1663173478.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41b94746e1560d63f16fb5dc965042ec496aeaf1.1663173478.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 22:31:11 +0530, Souradeep Chowdhury wrote:
> Documentation for Data Capture and Compare(DCC) device tree bindings
> in yaml format.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: Unevaluated properties are not allowed ('dma-channels', 'dma-masters', 'dma-requests' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
