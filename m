Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4655F6F57
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiJFUi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiJFUiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:38:51 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B21C707B;
        Thu,  6 Oct 2022 13:38:45 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1326637be6eso3508935fac.13;
        Thu, 06 Oct 2022 13:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Agu6xG9VX3rjcsAKBUx4ZF4C52KkIIwQ0G2A3pvuDCo=;
        b=7owst/iUGKYyxhvi4suX2ipPjJcG6DsldghvUCeP+CmNM+tgvqSzI2/eDE4xBlHf7E
         7b87qxCBm85VfSZmnoWDuR74l+ReuXyS9lv/IwCsP5r0Ar3v8bC2SDM5/kOGgaRHR36L
         2rbgsPFe6cN71JFF4J7kakmfzWIs/Q3OF/udQESME9qn/PZRH8TYigelEGmCiI0MhjDa
         37OPH70DuHQlUViiBiz4CHprY/lpSRVdj9MPfI41qU7r+RFZIkFAWQ/XqjGUpUY4iZLn
         sDdgbaDPVr4CZ5aB1suvLoklvux/AfVb133sQywDyTfG3QRvlmUOYjVwvhUlojjSdBqU
         qThg==
X-Gm-Message-State: ACrzQf3W9flRZXol0MpVnOd94cIAfFV+MT0s2ORRG39/mULLAkTs4hoj
        bhKuuzGsXUqAt3II8RvzUw==
X-Google-Smtp-Source: AMsMyM6o5cRKoQPZCGj3WkTzJxl76sriwibaJfa/3ne/4ifi9ID7xj+mVw0NzuhIAITpqFl7xIL+KQ==
X-Received: by 2002:a05:6870:c58b:b0:131:9324:60fd with SMTP id ba11-20020a056870c58b00b00131932460fdmr6704022oab.154.1665088724555;
        Thu, 06 Oct 2022 13:38:44 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id ep26-20020a056870a99a00b00131c3d4d38fsm329176oab.39.2022.10.06.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:38:44 -0700 (PDT)
Received: (nullmailer pid 117019 invoked by uid 1000);
        Thu, 06 Oct 2022 20:38:42 -0000
Date:   Thu, 6 Oct 2022 15:38:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/34] dt-bindings: pinctrl: qcom,sc8280xp: minor style
 cleanups
Message-ID: <166508872155.116957.15264829020356164782.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-23-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-23-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:25 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml       | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
