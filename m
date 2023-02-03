Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EFF688B62
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjBCAEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjBCAEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:04:45 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25958661E;
        Thu,  2 Feb 2023 16:04:42 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id bx13so2847093oib.13;
        Thu, 02 Feb 2023 16:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViNz+Z1RHNziUsIKWuWXWKW6j5dA+rs5JqtT/DUnJWI=;
        b=KtMJcbyaofF2uPCXeLa2ShZj1EJkIX+ZMaTYjTFnYbOy85cVjE63haUpupMQrBinpp
         oYjP6gQdPVQ3KkemDJq6ObSMDciO3qKqb0Q14LuZPkPmBb5l8spcEcF/ODkxCpx88xyE
         wW8twmCd3vxOFTu651OEAaBfCxU8SPJ4lvKpb9up96HAW7uUgvbMv6HaEcMu7+dbFsww
         iZH2k/O7hpKzX8BYjyfo/SA1+EOpBaVscqx6Xyt2L6eLgyApfz0Hn6aP3n5ibSHQ3oer
         2DorWD3G2JXtBzNPI1mmWlgcHwAyLThA4V8aPxlD60OfYZw9+/S1o0WURJncEGAQHAjp
         zOLQ==
X-Gm-Message-State: AO0yUKXKEfglidPeYtA1RItcFlqsxpTVXmHuuN7tL0xJVgKdhUKn74gA
        /D+kl7OUHu8t7OsoeEYr0w==
X-Google-Smtp-Source: AK7set9mU8f9VC0KV/zzIWMGvGLyqXwTnK4aoN+zqvul98yJrVzFWhhA2q/gwrxvZIaQdhreiHA1sQ==
X-Received: by 2002:a54:4e82:0:b0:378:5c2e:d8b with SMTP id c2-20020a544e82000000b003785c2e0d8bmr3414096oiy.25.1675382681947;
        Thu, 02 Feb 2023 16:04:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p2-20020a0568301d4200b0068be61a7ac6sm418764oth.56.2023.02.02.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:04:41 -0800 (PST)
Received: (nullmailer pid 2938873 invoked by uid 1000);
        Fri, 03 Feb 2023 00:04:40 -0000
Date:   Thu, 2 Feb 2023 18:04:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Iskren Chernev <me@iskren.info>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 04/10] dt-bindings: pinctrl: qcom,msm8953: correct
 GPIO name pattern
Message-ID: <167538267993.2938820.6882995503380643669.robh@kernel.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202104452.299048-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Feb 2023 11:44:46 +0100, Krzysztof Kozlowski wrote:
> The MSM8953 TLMM pin controller has GPIOs 0-141, so narrow the pattern.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

