Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C5A7160D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjE3M65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjE3M6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:58:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D719CE4C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:58:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso8020188a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685451502; x=1688043502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tZ/CWWRhzFv4AUx7PeAsUKQAthRRG7iX6LhluPhso8=;
        b=fhMSzU0zIG+zrgA5AooIEwuldRbNN5bU/BcQz0bDjs49+J1JE8Ypo6iEi3Tk4DYoBp
         Kt8RU4R/R3FR+WUMj4eTbdWQfQzBLavDDpeM0H2Foqv4aroWYAsDKW5SXNxOG3zebzFE
         KcaVP05qsOp06RqqwPn79WiZmzIh0/isE2gKWsguNkqmEQd2wG2tDW7czRUT+tsLZR3H
         0P4sXxLcAsk5iSqc4N4HMH/S7X/mwzyCsZy8qwdXsKjrAzuZ0An3TZ9Q3anQRI2VlaYe
         U5F9yJDj3guqKIonPAVCbtPJgd13pxg+b5a89bfRl3qoZrMykehI8PCGQxtosmeOD7xk
         bbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451502; x=1688043502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tZ/CWWRhzFv4AUx7PeAsUKQAthRRG7iX6LhluPhso8=;
        b=TxYzWK8xMXQXLTH1jZkf0RMoORX2WAOecwzJ+gKcGLL5dUa3qAE9tFGa3yGbsSha8O
         S7Ze/qsl6Uw9iwOWtqhFGk4snuTYO+TIHVICz/b3chjYDxFa5SjLZZLrgIU+q78q75aW
         ZGeZcvroDKB5xaNdJyO4XHCEXa3FwJotkoY78Xi7L+4gfo9QJtTtnd9Z9s8A3dnus7E5
         PBZ0wBO2iyR+QrOAjUR9knAy0NQ6YBbF+SgIjrSWDSrmc56HwGX0yOU5+JhUWmrk7VdV
         PNJmO1IOGwBBPQMZHGI9X9RJrRP1+EkLou4eRYQQWLcOOhrvzPnOVZweXBOD/PHYMP1i
         jspA==
X-Gm-Message-State: AC+VfDyAikvM2s07cj58rtPD5+HvMpos89h6hd7x2XnfE7BBqnPkYXIw
        /saS6SF/CX9LkS1beg7AqfXvjQ==
X-Google-Smtp-Source: ACHHUZ6tHhgbxxkwo5nLr9tb12tOL8m2CoGZFRqhgO6IbbrCp+3ZktaR4Oz2McNAxdmztZnG3KJ8CA==
X-Received: by 2002:a17:907:60cd:b0:974:216f:dc36 with SMTP id hv13-20020a17090760cd00b00974216fdc36mr1963849ejc.17.1685451501958;
        Tue, 30 May 2023 05:58:21 -0700 (PDT)
Received: from krzk-bin ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id rv3-20020a17090710c300b0096f7b7b6f11sm7280614ejb.106.2023.05.30.05.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:58:21 -0700 (PDT)
Date:   Tue, 30 May 2023 14:58:18 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: qcom,msm8996-cbf: Add
 compatible for MSM8996 Pro
Message-ID: <20230530125818.yvzdycqt46n4dzo5@krzk-bin>
References: <20230527093934.101335-1-y.oudjana@protonmail.com>
 <20230527093934.101335-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230527093934.101335-2-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 May 2023 12:39:32 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The CBF clock on MSM8996 Pro has a different divisor compared to MSM8996
> and is therefore not fully compatible with it. Add a new compatible string
> to differentiate between them.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,msm8996-cbf.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1786737


clock-controller@9a11000: '#interconnect-cells' is a required property
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
