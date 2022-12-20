Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802A9652591
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLTRaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:29:58 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E61CBFE;
        Tue, 20 Dec 2022 09:29:57 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id k189so11156319oif.7;
        Tue, 20 Dec 2022 09:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnwjYbOSnq96MLGD0jKkXjZD7qvCW3wHn8FBcGEyxRw=;
        b=Rcqcvelsw+Dqfk9B7OPObNc0Qn6zG7rsta1ck3nus819CiYadWJ2eEVIVlHJ7952Gf
         vaOaHBKPLfRoCKextjqa+Re9ynlq8Ab0BwSqTLxFZtGM49Np1+S9LXAjH0n/ZRsYDc45
         UAYHQjIEt6klUFFSF7xoVSBU1a51QBrccf5LmXkNPCWVSqdw+Y/H7FeWrcgss/7yj5GT
         jyArj4CUCb2u//IaxJR8+VKBOUnw1NQAXQ0NkPBjh3dpXyc0Dmba1FjaZb1PX9aKBsmc
         6lreLPJckTxURhC6OUvUiQhe2YDghQLC9e3RO8HZ/4TjXYSCWQkb90O5GXsYqAnSrjbn
         eeHg==
X-Gm-Message-State: AFqh2ko9imnnSCoxbKCrG+PAlu+KVRyjDxvrK3BH+CIoQXz4r3+qanEK
        StsXjxwGVRNehh9zkL7dQA==
X-Google-Smtp-Source: AMrXdXssrh0aJySHKFo2QCwNuEbmMEX7JcTvhjBIj7wrIGwhcl1lkdnvu/3gs0HUN2DabKEeR0M0EA==
X-Received: by 2002:aca:5a87:0:b0:360:f286:820b with SMTP id o129-20020aca5a87000000b00360f286820bmr4121597oib.2.1671557396639;
        Tue, 20 Dec 2022 09:29:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i11-20020a056808030b00b0035468f2d410sm5655911oie.55.2022.12.20.09.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:29:55 -0800 (PST)
Received: (nullmailer pid 783422 invoked by uid 1000);
        Tue, 20 Dec 2022 17:29:54 -0000
Date:   Tue, 20 Dec 2022 11:29:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956,
 SDM636 and SM4250
Message-ID: <167155739359.783362.13406259397795119629.robh@kernel.org>
References: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Dec 2022 16:06:05 +0100, Krzysztof Kozlowski wrote:
> Allow qcom,board-id and qcom,msm-id leagcy properties on these older
> platforms: MSM8956, SDM636 and SM4250.  Also mention more OnePlus
> devices using modified qcom,board-id field.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
