Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4665ED19E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiI1ASr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiI1ASj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:18:39 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B215CFE074;
        Tue, 27 Sep 2022 17:18:37 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id r34-20020a05683044a200b0065a12392fd7so7289750otv.3;
        Tue, 27 Sep 2022 17:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SK9DU5Xe9kPl1hDpagcyd81Zfibef+XUkfCjSskqfD0=;
        b=Mea30zJwJbxsdk21k+AOU5GZOpZQlhMyg+IVf61IVxuaoXcvMrhRZRJVXfmLhkkv+J
         IK7+/2mo93nmhNAC8d4i913r8owUJMqfyoAkmypjvypy4fiYn+OJmf0kg8TWc6aZVS2v
         mDCTr5b1YkrfsNO5KqQBs+apU+7YuUgEhZJlmEhPrAsBE7p99RwhcfYPOUa0wTEPrlVY
         2tWaV7Pm7yoadxT5mDBvLF3BM3pMD9Aas14HaTKjOZjax65iOSIPmC21HPIBrykn5jvb
         KAmYM+DOQ8wpr9UsPbVSxZMJSLZqVXNuDGPPez2ZL4yYVsBfZoNW6rMLvQ53s8y4+oKd
         D3bw==
X-Gm-Message-State: ACrzQf3KZsvVJ7YJrSfVxZbfY1kWDtLY5lgN7MxmyME2vvUZRQigGIP1
        BDJ+YCtYtCKJidnnGcM6kA==
X-Google-Smtp-Source: AMsMyM5h4GbT5oyloGUUWLvWsXaetPJKlnHSoubYi6SPB65YMtjQxthRhnvs2BKvE8JXL63r1FZUdg==
X-Received: by 2002:a9d:7b56:0:b0:655:df1d:c9f8 with SMTP id f22-20020a9d7b56000000b00655df1dc9f8mr12439612oto.32.1664324316889;
        Tue, 27 Sep 2022 17:18:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x16-20020a9d4590000000b00618fa37308csm1475588ote.35.2022.09.27.17.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:18:36 -0700 (PDT)
Received: (nullmailer pid 2670382 invoked by uid 1000);
        Wed, 28 Sep 2022 00:18:35 -0000
Date:   Tue, 27 Sep 2022 19:18:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v3 15/34] dt-bindings: pinctrl: qcom,msm8226: use common
 TLMM schema
Message-ID: <20220928001835.GA2670284-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-16-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-16-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:43 +0200, Krzysztof Kozlowski wrote:
> Reference common Qualcomm TLMM pin controller schema, to bring other
> regular schemas and additional checks, like function required only for
> GPIOs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> ---
> 
> v1 was reviewed by Rob, but patch was changed since that time, so not
> adding Rob's tag.
> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml    | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
