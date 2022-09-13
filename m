Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455E05B7574
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiIMPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiIMPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:43:34 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B04185FD8;
        Tue, 13 Sep 2022 07:47:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id z26-20020a05683020da00b0065661b40997so1224736otq.2;
        Tue, 13 Sep 2022 07:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xD+cIArTBa7fVBRdEjR/+V87yxIC1vBaLkxPyYv0Th0=;
        b=qGMWxoBrEeq96FwkJR6fpDP16+DI3ErjuBP3kl2DdkcKEp7sUjTH7Ne8i6Doxy2OiS
         msqzeLXQDVVaSpOX3lXVi+m122hMli1NskPslYNwaCQXjSAYqCD37/QM6CGzWA5L/54m
         q0yniHpebL6OwKgmjW1vfJDTG6tCaJ/jjytOQluB/O9tKz9NQvwElFcR9d7iW4/nN0dL
         JLBTXOwZIHXC0guZlCBafCmGLiRw5/ij5ZS3uWKkgFpOmvng/kCU3gGmFQqhHKMEJmt6
         GPbrp4yo6ilo1DbJb02ADcQNkB3FeeUS+N/5O62R0u5nNYNrv1aNrh6X0P0XFN9gjvc9
         suGA==
X-Gm-Message-State: ACgBeo2U4VQz6KZhVkCEoptrzoieOag51ZsVAqYGD6hwkiG7Qku7zzXZ
        vRaDmyjdlUsYSMvcmPfHxZDXF2jYeA==
X-Google-Smtp-Source: AA6agR4nLyXa50aImdwEZSQdv3+eOb+hOyj5GXYnsnCdxRmF2RaS6mIFx4dObfBoRtnCV01fWl/P6Q==
X-Received: by 2002:a05:6830:2684:b0:638:8768:238a with SMTP id l4-20020a056830268400b006388768238amr12851007otu.230.1663080306873;
        Tue, 13 Sep 2022 07:45:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x126-20020acae084000000b0034480f7eec4sm5175163oig.12.2022.09.13.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:45:06 -0700 (PDT)
Received: (nullmailer pid 3646146 invoked by uid 1000);
        Tue, 13 Sep 2022 14:45:05 -0000
Date:   Tue, 13 Sep 2022 09:45:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,q6afe: remove binding
Message-ID: <20220913144505.GA3646113-robh@kernel.org>
References: <20220910090856.49271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910090856.49271-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2022 11:08:56 +0200, Krzysztof Kozlowski wrote:
> qcom,q6afe is already documented in soc/qcom/qcom,apr.yaml.  The
> version-based compatibles ("qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>")
> are not used (neither in upstream nor in downstream DTS).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6afe.txt  | 20 -------------------
>  1 file changed, 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
