Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD05B75D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiIMP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiIMP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:56:36 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344709082E;
        Tue, 13 Sep 2022 07:56:09 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11e9a7135easo32783768fac.6;
        Tue, 13 Sep 2022 07:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YjuyOX0vuflNgkEmb8EuJtzXMVxJF9AgUE3KWZmCdSc=;
        b=T1TODXLno+8d6721LbvzXdNvPA2up4w2lzcTS19dlKy6PgQz2Absr/DyrQSHxecU/x
         GLikMl0CM263f4kn54kvc4cox37yEtb4ymWePQ2I7AO3wLqOjrimrECJJmUozJP/5vJS
         180flN1+TPb7vU1t6z9Up3pNluyVRod0evn8ncwgvz9T1xcpgDbTI+fzkwUs3zxytie4
         XH6CtVt/ZaR/fNmzzFoO8peisXeH3GVXpGq9lTy9/oXEKwm2g4eK66BSWuVNNzOCumbR
         1RnekKL5ao9ks2DmdOcCkgnU749IiIugJ+NOVP7IdMpBREytE/fo6UHesNKgzYlddhzq
         bOCQ==
X-Gm-Message-State: ACgBeo1Zywznkeg0AjzqbCQE8s6eEnGtOytgu3Vr6A7/1CeVDIxcJ7Un
        vsxyjHvReF3LseZTmHxEXQ==
X-Google-Smtp-Source: AA6agR7LTlwKvsObOgPAOhlG9PGJU7XKt7gp8lgROdkzXmSWSVY5D0f6yfV4NXUehkSSAGuO5FL3UQ==
X-Received: by 2002:a05:6808:201b:b0:34f:80a8:6a2a with SMTP id q27-20020a056808201b00b0034f80a86a2amr1715116oiw.121.1663080842592;
        Tue, 13 Sep 2022 07:54:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj8-20020a056808198800b0034fc91dbd7bsm1880962oib.58.2022.09.13.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:54:02 -0700 (PDT)
Received: (nullmailer pid 3658520 invoked by uid 1000);
        Tue, 13 Sep 2022 14:54:01 -0000
Date:   Tue, 13 Sep 2022 09:54:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 14/15] ASoC: dt-bindings: qcom,q6apm-dai: adjust
 indentation in example
Message-ID: <20220913145401.GA3658488-robh@kernel.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
 <20220910091428.50418-15-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910091428.50418-15-krzysztof.kozlowski@linaro.org>
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

On Sat, 10 Sep 2022 11:14:27 +0200, Krzysztof Kozlowski wrote:
> Cleanup the example DTS by fixing indentation to 4-spaces and adding
> blank lines for readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  .../devicetree/bindings/sound/qcom,q6apm-dai.yaml   | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
