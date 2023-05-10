Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49C26FE0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbjEJO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbjEJO7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:59:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2004769D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:59:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-966400ee79aso842387766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683730754; x=1686322754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aehoaVgCSePqbPoVe97WNYRMqFAtsRLIVpWyzt/4WLc=;
        b=FmOs1NFd1SUzPGky5Rpf7/Z8g9QRT97ttT6uYa3ubjDXQrP8hHxDo9RNsx971U3bCC
         N1NoF+W3vZRR426+tirpbFlYKcZTTe99FVS8DhCulR1WjTSxTRyRERIk818Yb1gDvwUp
         IyVsrIl2M57sqIM/nXeJdLKQODQeyrSCHt1hqodknn/UOtH7On/RIPGPi5zCarqscwf7
         K8kkURtLhoOxsVwbbkcJcsdLIr9itFchAUHdqp5TvxSm1S9f+Gktgy2fWG4l3NocjdPI
         QzA2KKSIZEJDuCXXthoBHGMuoSaPUdEnMbZFWX8Zm2W/w/0aj47jJxSouYII/vwdJQ9i
         GNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683730754; x=1686322754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aehoaVgCSePqbPoVe97WNYRMqFAtsRLIVpWyzt/4WLc=;
        b=b9Wqb9SaNq2Msp2tVg0fg61ysEh/dlpDk7x1Y4Xnha1eOM3FWscWzaBQ7IZtt51Q31
         n6zJAuqQHVd4emaRUMSxjrtXf+dzmDO3eH445l/erXEtw29viNnLLF/rp1f/X3W+T9Oz
         cwKM3NkF20pxFnLi2aZTUguDZMt7axZ2mP6TwALRQFHQ3zawOQfdhl0ItKT+FnvouPWt
         z8ltmK/YZhzljAW9VhvG9SlpJfygemdpnlBkjsJ5BkTdTfFainRszDUUR3E9v6LhCIUX
         HCcjwtZCwOKhdAt3sN9F94xl3ODcIeIuCRez4WtPYa0YDX/i7is1YER5bDWvAPcniOAL
         OY+w==
X-Gm-Message-State: AC+VfDzsL1QQPOIUw0R2JY+ZuouW/2LbVdhT6ftjczN6aqESX2s0HV6h
        mzyBcwDq7qTbTgUbDzLP6v5qwqUsGKoFkJwPm4o=
X-Google-Smtp-Source: ACHHUZ6aBvD/dAkRrEm1gMWqoodG9M6ZxMPCBaWChZGOxhPwLp0/OMEolD8JvPElBRGEK6s7TeDm9w==
X-Received: by 2002:a17:907:3183:b0:965:626a:26cc with SMTP id xe3-20020a170907318300b00965626a26ccmr15378746ejb.65.1683730754154;
        Wed, 10 May 2023 07:59:14 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id jz10-20020a17090775ea00b00965ef79ae14sm2738079ejc.189.2023.05.10.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 07:59:13 -0700 (PDT)
Date:   Wed, 10 May 2023 16:59:11 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: input: touchscreen: st1232: add example
 with ts-virtobj
Message-ID: <20230510145911.66jxevntvzrghoct@krzk-bin>
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v1-4-5ae5e81bc264@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230510-feature-ts_virtobj_patch-v1-4-5ae5e81bc264@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 15:50:49 +0200, Javier Carrasco wrote:
> The st1232 driver supports the virtual-touchscreen and virtual-buttons
> objects defined in the generic touchscreen bindings and implemented in
> the ts-virtobj module. Add an example where nodes for a virtual
> touchscreen and virtual buttons are defined.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../input/touchscreen/sitronix,st1232.yaml         | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.example.dtb: touchscreen@55: Unevaluated properties are not allowed ('virtual-buttons', 'virtual-touchscreen' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml

See https://patchwork.ozlabs.org/patch/1779521

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
