Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86E073ECDA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjFZV1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZV13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:27:29 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B7B1;
        Mon, 26 Jun 2023 14:27:29 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-345b231322fso3380655ab.2;
        Mon, 26 Jun 2023 14:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687814848; x=1690406848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avBjJWfibsZdQeCWvAjApLqo6hXIYkVIdlb5U2XqZs0=;
        b=ZOmn3yroLBzdZxb79yyXHPz65pbqJZXCMkVYVPSZjIOnKeLLjCgQtfldgcS54yGhli
         r135gVTQT59jjvDxC0YLkjrnRADKDXATWfDj1G3QunSKYS8Sp9wfTDeHH/Ia19bDwiHB
         +NLiQbpNXx83+wAsGUBa2DxoEXf6AXxLa7y1QfKPO90aWtVGJdDhuEwlDN5P5e7YSb9b
         jIa5SxIkChnTgtFWeKEPwUw2QqMz2vdBdmUs2JTupfZNN84iZZKXoYUN33N+OZmJ5HpV
         Az14/qRVv7UFy0jObawifFuZ4LJZIdLcykvN/XEOY1hM1bk32hr5tLQ+yQnk4EKxOjaP
         EHmg==
X-Gm-Message-State: AC+VfDyl/gC6qcRVPJzEarhqHPpY6xQee7Rn8TWOlq7mJ7ZEeWkxJc8d
        bGMLsNUYdd0vDgs6r3eEnZLHiduEEw==
X-Google-Smtp-Source: ACHHUZ6UkVZjSj1u1k9+RdwdmznVPLiWtyCjlufEfW5+WQVL9ireq9EnVIj4c+KH6q7zFQWZ0WYpVA==
X-Received: by 2002:a92:d651:0:b0:345:66f5:3404 with SMTP id x17-20020a92d651000000b0034566f53404mr7248388ilp.0.1687814848321;
        Mon, 26 Jun 2023 14:27:28 -0700 (PDT)
Received: from robh_at_kernel.org ([199.114.228.113])
        by smtp.gmail.com with ESMTPSA id f25-20020a056638023900b0042887e69e99sm1996354jaq.95.2023.06.26.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 14:27:27 -0700 (PDT)
Received: (nullmailer pid 3927531 invoked by uid 1000);
        Mon, 26 Jun 2023 21:27:26 -0000
Date:   Mon, 26 Jun 2023 15:27:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/7] dt-bindings: qcom: Allow SoC names ending in "pro"
Message-ID: <20230626212726.GA3924052-robh@kernel.org>
References: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
 <20230626-topic-bindingsfixups-v1-1-254ae8642e69@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-topic-bindingsfixups-v1-1-254ae8642e69@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:00:23PM +0200, Konrad Dybcio wrote:
> There are a couple of SoCs whose names end in "pro", with the currently-
> upstream examples being msm8974pro and msm8996pro. Allow such suffix in
> SoC-specific compatibles.
> 
> Fixes: 5aa332c5e7ca ("dt-bindings: qcom: document preferred compatible naming")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom-soc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> index e333ec4a9c5f..607a1cf1ef94 100644
> --- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> @@ -31,7 +31,7 @@ properties:
>    compatible:
>      oneOf:
>        # Preferred naming style for compatibles of SoC components:
> -      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$"
> +      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+(pro|)-.*$"

"(pro)?" would be slightly better than "(pro|)" IMO.

Acked-by: Rob Herring <robh@kernel.org>

>        - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
>  
>        # Legacy namings - variations of existing patterns/compatibles are OK,
> 
> -- 
> 2.41.0
> 
