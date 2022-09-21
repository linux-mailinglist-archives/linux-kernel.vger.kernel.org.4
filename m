Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B445BF965
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiIUIgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiIUIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:35:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1443A8304C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:35:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h3so6109066lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fCr8MwFtbbcSDSvMf2AcQISoeqvfzG7FR3I7vOSbQlM=;
        b=wAeXEwMmcxP8dYzsCAJu8G0NMnxMRwO60uRgR9N9iiGOFayIzZwDJM2g380S0Lp+MY
         uBXAz4orsz/bBwjRsRDuasi+pYMQSS45VabIyqiQbhXk4nNPLM7qc0IZ4OEg50do/rwj
         iSTIRdX+w1T3dbcWGdI6ZBKWQQgtV2cSf/pR1oSgR6gXVshQ1Ilk8EVUXiDrOki6lRVF
         cIG1nyrqMUSQyO3FxvhbkEk9eU+EI9baXpBk9bpayMn/Qa0gfFJBUU8PHa4AylhVqYRM
         tOZ/yyJcBE7QVXf+0Z92YP9BSBa1BAbZ3j3IBoykz+p5HW0XYjdAws+ZZFbqWmlx6mCw
         xXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fCr8MwFtbbcSDSvMf2AcQISoeqvfzG7FR3I7vOSbQlM=;
        b=vtC3lRQWJfv6yCTvNghvmzC3IhUimT/puLlYsVNffQP5XQETJkPR4rxQrfmd/N6MQF
         /mPb4t5jX8X2wploie9irfheZS3gMOAzBaHLnWnUZR2g/LM8jD1naeFE1L4OoMK7h+Zp
         AcTuAmkBNRoDTRLEdbmpl9XRFvIrko7zAEe8U1zjohdNrxXIVltW4cFz9Qr+NsuM+JCW
         zH0MAYo4AnfZlhHZZPE2raRE9SdvV232xSWlCqpX6UtAa30gkZ4xXu0L0aOL6KzZ+409
         YP/yaON0KxhTgqS3bPxw9RVe8oM81A/xnwAq9FBDwJsHuJddEtNCXPhZF78unJiUtwRf
         pEjQ==
X-Gm-Message-State: ACrzQf1QLPp66QNVv1f7W4zbVEt7IUucSdl5Q4QOYNswnBxby5qit86G
        Snpaks6YGL5WJWidkE09kM625g==
X-Google-Smtp-Source: AMsMyM5cQD2qKn16V2w8tpEVl6X83BD1sDdLGMgpXAhpSINiKNmYTE9cE/g9dYyZGiHAZHwKsIHvww==
X-Received: by 2002:a2e:998b:0:b0:26c:4ef4:e4d7 with SMTP id w11-20020a2e998b000000b0026c4ef4e4d7mr4958579lji.42.1663749356227;
        Wed, 21 Sep 2022 01:35:56 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w11-20020a0565120b0b00b00498fd423cc3sm326358lfu.295.2022.09.21.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:35:55 -0700 (PDT)
Date:   Wed, 21 Sep 2022 10:35:54 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: remoteproc: qcom: wcnss: Add
 compatible for pronto v3
Message-ID: <20220921083554.3zs7xdj6n3pv7zdq@krzk-bin>
References: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
 <20220921043648.2152725-5-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921043648.2152725-5-sireeshkodali1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 10:06:48 +0530, Sireesh Kodali wrote:
> The pronto v3 remoteproc is similar to pronto v2. It is found on the
> MSM8953 platform, which is used by SDM450, SDM625, SDM626, APQ8053 and
> other SoCs. Since the configuration is same on all SoCs, a single
> compatible is used.
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  .../bindings/remoteproc/qcom,wcnss-pil.yaml      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


remoteproc@fb21b000: 'power-domain-names' is a required property
	arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb

remoteproc@fb21b000: 'power-domains' is a required property
	arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb
