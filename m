Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB36BDC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCPXCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCPXB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:01:58 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE60B2544;
        Thu, 16 Mar 2023 16:01:52 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id h7so1869860ila.5;
        Thu, 16 Mar 2023 16:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06lCH5X+/2ktLi7UZAedLY+z6qnYJzrh1ZZ0qiMJwLY=;
        b=dfwgHmOxq7SPYesx2MCtSsAHuJAGOfEHYdhlAcDm+TQqfFsuukIZxShKkQZRCX93Gf
         Fr5BKl5OXls1IuXxoZHqEg0uaqKU8S4ZjQ+tQ5Lv3UWA2gu3PNdLk9TbxH30OVuTjxJf
         HQlONBV/B3nxea6TVQ/KohaZCAResEUg0zYU809zBdADO0a33pXOolsE4+2ZotXIX6M3
         ZkZk3OTo+t+F81SMZPdZn/ADDSFFhPyEGyLXhWHoSbfilEzhM3zKJnaiFm5Wt2RnoEx0
         8UwZqszDJN569n7w+vLO6xRFIlMb4tWM6InIw7tc7VmE521OxDU+pmF0SiCVr2jcYlOg
         /hgA==
X-Gm-Message-State: AO0yUKXIrSsPrA8+Ny5GvrGRSXq3yZJCzFgvFTWAvsuy55jg/Jf4soy7
        qJpZtFvDmyHv6pU6jhB2HoXmjyTWKQ==
X-Google-Smtp-Source: AK7set9bS1Np+BTwgHkJFdCjppLx8hnSdQLc2Mqz1H+LZQojmGyhVqcJh+2jyJBeB6iR5Tsyhp5Z1Q==
X-Received: by 2002:a92:c210:0:b0:323:338:cc3c with SMTP id j16-20020a92c210000000b003230338cc3cmr7403233ilo.6.1679007711397;
        Thu, 16 Mar 2023 16:01:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 71-20020a020a4a000000b0040474ab909fsm178402jaw.36.2023.03.16.16.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:01:50 -0700 (PDT)
Received: (nullmailer pid 4047863 invoked by uid 1000);
        Thu, 16 Mar 2023 23:01:48 -0000
Date:   Thu, 16 Mar 2023 18:01:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: qcom,pas: correct
 memory-region constraints
Message-ID: <167900769556.4046079.3396885204765671138.robh@kernel.org>
References: <20230309082446.37362-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309082446.37362-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Mar 2023 09:24:44 +0100, Krzysztof Kozlowski wrote:
> Qualcomm PAS devices expect exactly one memory region, not many.  Also,
> the memory-region is now defined in device specific binding, not in
> qcom,pas-common.yaml, thus also require it in the same place.
> 
> Fixes: cee616c68846 ("dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Following dtbs_check errors are expected (not related):
>  - qcom,halt-regs:0: [142] is too short
>  - clocks: [[24, 222], [24, 223], [24, 157], [16], [24, 229], [24, 224], [24, 225], [27, 2], [27, 8]] is too short
>  - 'px-supply' is a required property
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml    | 1 +
>  .../devicetree/bindings/remoteproc/qcom,pas-common.yaml        | 1 -
>  .../devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml        | 3 ++-
>  .../devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml        | 3 ++-
>  .../devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml       | 3 ++-
>  .../devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml      | 3 ++-
>  .../devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml         | 3 ++-
>  .../devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml        | 3 ++-
>  .../devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml        | 3 ++-
>  .../devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml        | 3 ++-
>  10 files changed, 17 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

