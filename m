Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72A688B5C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjBCAEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjBCAE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:04:29 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11F442CB;
        Thu,  2 Feb 2023 16:04:20 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1442977d77dso4789175fac.6;
        Thu, 02 Feb 2023 16:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1StN7SV7YQSbvJ5RzvSVkGo/oxxleI/TgSCVmJu+HE=;
        b=OIhk7Jlu0BsYPeQ90pAHErePbTxa2r8H7MfTUcVg5Ob9APPD2YaEj9rWNlg8AQHGxw
         Sx4dJEXAwxF5l4c5Fcz05MOg+ZQGkCMQeW6kvbNEVZjMKebZSrBsuTgoW5ZquIAntmhT
         uIJa3aXBctwwWWgO8gLWYLxjL/ewnzbAX3pcCymahSI5yY+Z9D87Dp+edkNtXFqXNrPy
         H948JCRcsMXrPrIXQxIIepJVOoRKPpDY4xkjWQPSKvil47D/4hcVdeGdIjHnZvNhaRNX
         9Wx51zOCCKB7OalfwN9oX/EZf8+2vydqjVYD45QRVDsQ/c2D04a8vGPl5wNZgq+67S6B
         XUMw==
X-Gm-Message-State: AO0yUKUUma2Or/edLE9fqF1B8CqIGQ8G1aJ6Hd/wwhGDPDa/cvXWJy7N
        1/xjZ9NoR+oWRYRz4HXZ0Q==
X-Google-Smtp-Source: AK7set9RR9X6XhexiY5Xd0RSqlp6LZXsZodT/HSji2SSz0MnFQc7i0kW3nmvYRQKD/tyKw0CaPM9xA==
X-Received: by 2002:a05:6870:784:b0:163:16dc:84d3 with SMTP id en4-20020a056870078400b0016316dc84d3mr4054624oab.56.1675382660142;
        Thu, 02 Feb 2023 16:04:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ea48-20020a056870073000b00143824af059sm371562oab.7.2023.02.02.16.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:04:19 -0800 (PST)
Received: (nullmailer pid 2938407 invoked by uid 1000);
        Fri, 03 Feb 2023 00:04:18 -0000
Date:   Thu, 2 Feb 2023 18:04:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Iskren Chernev <me@iskren.info>, Luca Weiss <luca@z3ntu.xyz>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: Re: [PATCH v2 03/10] dt-bindings: pinctrl: qcom,sm6375: correct GPIO
 name pattern and example
Message-ID: <167538265834.2938356.2421324030706769127.robh@kernel.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202104452.299048-4-krzysztof.kozlowski@linaro.org>
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


On Thu, 02 Feb 2023 11:44:45 +0100, Krzysztof Kozlowski wrote:
> The SM6375 TLMM pin controller has GPIOs 0-155, so narrow the pattern
> and gpio-ranges in the example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

