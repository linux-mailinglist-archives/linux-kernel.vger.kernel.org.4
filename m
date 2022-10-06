Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E485F6F68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiJFUkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiJFUkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:40:01 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D32810FDF;
        Thu,  6 Oct 2022 13:39:42 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id o64so3344097oib.12;
        Thu, 06 Oct 2022 13:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0HeLuGPfdHD2hNxpYbUHjzfNExeN2+NyiXdG7GUvCw=;
        b=cimQhw5MbXnMh5Vm1871W2yC4RXP18ytEkyH+dA1MHHqZgriOklH0OBGCni+FLRVc9
         mAN/EIOHdu6f1OFN9O3eaRI95IPvEoyGnyDBSqU2Yyd6H+IcUF5SDdpruIuNyOugJOL6
         1L44uxsxZna1J6W6HcBihwJ5YB1OXljmJgxPhdxooWr2wSCFTXec5MxW8PqbqOeML0Eg
         JIuSnJQqR/zoP9GzBfdwGxsDFqVuUW+GyPjhZppfVLM1Q0zcuqpxwwlS8vZ+Ax5JccXs
         PXoMShPxkIqprf4HEB3ATtHSZrfkn8QkTTRvk2ub5YKpMyZztqm1pEPENBTs99UcbIsJ
         XjnQ==
X-Gm-Message-State: ACrzQf3PiOKLZBhq/4ni9ik/M8QkFDfouMza1LWRi50+v/QDqcJn2qkF
        OKyS2zxaWkusbqw7wyYY3RvPFGQp3w==
X-Google-Smtp-Source: AMsMyM6nRAmqQ+aOzJddKkX/QPWgLJhjrhtSd0U0b5uWdICrriCInGNfy+2P886JPJ1ohARPVhL/DA==
X-Received: by 2002:a05:6808:17a6:b0:350:92a3:1547 with SMTP id bg38-20020a05680817a600b0035092a31547mr723250oib.177.1665088781871;
        Thu, 06 Oct 2022 13:39:41 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id c1-20020a4aacc1000000b004762a830156sm85746oon.32.2022.10.06.13.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:39:41 -0700 (PDT)
Received: (nullmailer pid 118049 invoked by uid 1000);
        Thu, 06 Oct 2022 20:39:32 -0000
Date:   Thu, 6 Oct 2022 15:39:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Martin Botka <martin.botka@somainline.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 25/34] dt-bindings: pinctrl: qcom,sm6350: minor style
 cleanups
Message-ID: <166508877087.117907.4885648851461043128.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-26-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-26-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:28 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml         | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
