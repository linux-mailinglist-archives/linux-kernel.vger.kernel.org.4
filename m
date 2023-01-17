Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5F366E815
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjAQVBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjAQVAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:00:30 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2465E4A1D9;
        Tue, 17 Jan 2023 11:27:26 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id d6-20020a056830138600b0068585c52f86so3784806otq.4;
        Tue, 17 Jan 2023 11:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BTquYHamd8yY9RObnEinrCsM0HQYTFZPUAO2Z2hiGw=;
        b=wUxwHsahrX5a9mPoWOUbVCRfUU4ivVc8AA4So2et7MDQ/emahFjdUSEPPGJ4KxuqNP
         x2U3DCoq9SQ9X/rOHe7Sdfhrm4Znv+KjDQ2cssWiWsO4nJNTGlO14wjmYwjPn5QL2dCj
         YSQ+2uC9WcIykdvgeHciEh0gpODcQU3ITNZsX2jcXJSYZgCyfvBhqUNQEItTSd8QKI1C
         86EdmcxEfOil69HkxG2xCIaPVyTVBbF9Gdcp5/Mq9d5VHgX+wn9gtoCg4Yl+/v/69Wft
         WhZNQuMmlBAL3yuxu9ERPNPTdmgJR7o2KX0nXl19OqZcByAn+tvCTfmBx7eNuNOdFIF+
         8Xmg==
X-Gm-Message-State: AFqh2kp3ALXhP+ld0V9On29zuQffoFh9Jent0LHh5wC55qZ/Fp3WhNPA
        +fxBB1nYom20HuY5LXZ7fA==
X-Google-Smtp-Source: AMrXdXup/GjCMKAAMwBR12RckeeuXA6GYe+ILgLNJSKyingY0Wtc71tweIPPGZAZ93TxKYSeH0rjMg==
X-Received: by 2002:a05:6830:150a:b0:670:69ac:bb49 with SMTP id k10-20020a056830150a00b0067069acbb49mr2069239otp.15.1673983645371;
        Tue, 17 Jan 2023 11:27:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e4-20020a9d63c4000000b006864a3b00a8sm1310485otl.4.2023.01.17.11.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:27:25 -0800 (PST)
Received: (nullmailer pid 3496235 invoked by uid 1000);
        Tue, 17 Jan 2023 19:27:24 -0000
Date:   Tue, 17 Jan 2023 13:27:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: qcom,wcd934x: Describe
 slim-ifc-dev
Message-ID: <20230117192724.GA3489389-robh@kernel.org>
References: <20230113162214.117261-1-krzysztof.kozlowski@linaro.org>
 <20230113162214.117261-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113162214.117261-2-krzysztof.kozlowski@linaro.org>
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

On Fri, Jan 13, 2023 at 05:22:13PM +0100, Krzysztof Kozlowski wrote:
> The "slim-ifc-dev" property should not be just "true", because it allows
> any type.

Yes, but it is common, so it should be in a common schema. Though 
there's only one other binding using it (wcd9335.txt).

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> index 184e8ccbdd13..39b27126cfc1 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> @@ -28,7 +28,9 @@ properties:
>      description: GPIO spec for reset line to use
>      maxItems: 1
>  
> -  slim-ifc-dev: true
> +  slim-ifc-dev:
> +    description: IFC device interface
> +    $ref: /schemas/types.yaml#/definitions/phandle
>  
>    clocks:
>      maxItems: 1
> -- 
> 2.34.1
> 
