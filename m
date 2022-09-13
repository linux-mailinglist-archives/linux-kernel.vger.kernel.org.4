Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1335B766F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiIMQZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiIMQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:25:29 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9E6AA3D5;
        Tue, 13 Sep 2022 08:20:23 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1280590722dso33033116fac.1;
        Tue, 13 Sep 2022 08:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qtPsc16qIbDcI3G+/gbDV3y7UrOWZm6PWbygdH/NtPg=;
        b=cV3myExGtLPEefkx9i9RZJl/5WRAzt1qYt78pnSgTPfvGZyPJDMnRo7SyzlRqkcmaV
         IuzC4rkSrL935Y9ncqcNy48l1JS4/IhNaFRSkzRols7f4mlFSZZaigJvsflEI5NLS50X
         1dcNAwsBvBxxvsDwGo38AX8jDQoMDHOZMNQwVAC6m2Q6YkYArx+t26b2FlneT39EBCMc
         FYQIGK6q0XNKesIKGjpbCmVqFm32XGX9CHwLN14mQjLW9JhNzdEEaZjv4D4lk0WuUIKk
         7ZuuXE3liiLPzlRRqIhOo2/Tf+E/p3OY1rwK1FE6x/OFpMKu+4SxFwInKIl7Pm3m0uaB
         V7rA==
X-Gm-Message-State: ACgBeo2RnxYhNDkcLT5xi3B9pMoRgAHCit/6X7E/s692UtG/3t8bBcfX
        4Zso0b3tJyJXnWtSaTs/hCz+iNpGuw==
X-Google-Smtp-Source: AA6agR5IEPb/y5rUqNpsdbihXxs5UXn2eIiCKF17hUbkqKgbrPa5sijj6sjT+wD9iKKJUAn1jK6zPg==
X-Received: by 2002:a05:6808:2124:b0:347:cab2:a5d8 with SMTP id r36-20020a056808212400b00347cab2a5d8mr1624741oiw.71.1663082259771;
        Tue, 13 Sep 2022 08:17:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k6-20020a056870818600b0010d7242b623sm7128471oae.21.2022.09.13.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:17:39 -0700 (PDT)
Received: (nullmailer pid 3731413 invoked by uid 1000);
        Tue, 13 Sep 2022 15:17:38 -0000
Date:   Tue, 13 Sep 2022 10:17:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 02/40] dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix
 matching SD card pins
Message-ID: <20220913151738.GA3731343-robh@kernel.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
 <20220911111200.199182-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911111200.199182-3-krzysztof.kozlowski@linaro.org>
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

On Sun, 11 Sep 2022 13:11:22 +0200, Krzysztof Kozlowski wrote:
> SD card pins do not have function, so do not require it:
> 
>   pinctrl@500000: sdc2-off-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'bias-disable;' is a required property
>     'clk-pins' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml         | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
