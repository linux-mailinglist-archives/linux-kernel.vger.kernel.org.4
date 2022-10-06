Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1675F6F62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiJFUjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiJFUjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:39:18 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CA7FF8D9;
        Thu,  6 Oct 2022 13:39:17 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-132af5e5543so3531906fac.8;
        Thu, 06 Oct 2022 13:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEX1bGbryJRy1vf48KLKroQDe2aZ5gee++0YZwKCRCA=;
        b=1HxA7ozXRycMQnMCI1lUCJjwr25EvrTEEJVOZSIowyY6afzxQEMT7JT8vS1JjwKsq2
         FZDEOd4UclbXGYI09yNow9/O+4yKtC8qUSLKq7hzU3a1q8aUUA4dO5/qi9mX4QCTVj24
         0anZIvyAaDDOlt+o/QJ+4jFekgoMfuc1hlYxoPHPtByTLtyJ76bEy64lnEg7INFP1xm3
         Vxzfi43lHoUovsqyHaf6vr4US1PTg5Wyuol9Os906u2PjtUrX9u8fdj5aor4iUVYFlho
         gwSrweFtU5jN0P09V2MShUt8LuyTkkIGIJ4lUGjRom7v1pASWOfl1vZHlixzGWaSZywz
         LEVw==
X-Gm-Message-State: ACrzQf2q7GcnZywyNuk9dBa+KyvpIBn7P4BVi+KFz80M9QQFBVRzHdCq
        Aq08WH+AgaKqRn8rAOyktg==
X-Google-Smtp-Source: AMsMyM6CQGieP7qJHGoH2CLNqQk0py/WYuP6czsfyCGfbELqDckps4uRIVVGt0TW+sfOBrHzvsLIeQ==
X-Received: by 2002:a05:6870:d607:b0:132:7c31:1bc9 with SMTP id a7-20020a056870d60700b001327c311bc9mr856636oaq.131.1665088756665;
        Thu, 06 Oct 2022 13:39:16 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id x2-20020a544002000000b003504805a618sm66995oie.45.2022.10.06.13.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:39:16 -0700 (PDT)
Received: (nullmailer pid 117659 invoked by uid 1000);
        Thu, 06 Oct 2022 20:39:13 -0000
Date:   Thu, 6 Oct 2022 15:39:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Martin Botka <martin.botka@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 24/34] dt-bindings: pinctrl: qcom,sm6125: minor style
 cleanups
Message-ID: <166508875275.117607.11086220631634834194.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-25-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-25-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:27 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), drop redundant minItems, use double quotes
> consistently and drop redundant quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm6125-pinctrl.yaml  | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
