Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC16BF384
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCQVH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCQVH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:07:27 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF77632CE9;
        Fri, 17 Mar 2023 14:07:23 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id k17so2883231iob.1;
        Fri, 17 Mar 2023 14:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679087243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dqn+fg78Ag7B5+9Jiee42c6aGp7pvBZ9dU4byyjXrU=;
        b=0Vcb2zZDLq2cpxZnW47P8/FapJfNS4UYiUgf1ksZMu4cXaQklAqv2MuJW+pE5FW/9s
         I7G6dndAifg6ol/WvCSr71gG9OKVwduXcKTn4/hr0fQ2t82ooi2OfuDbT+t9dnsDNtZ3
         j4IYPkngGa5laRs13U9tN41VGrh/yU7ik3RTZW5NE272KkpC7RGWuNaFpMI45nJo91hC
         MskAgCq+Yf5g6FVyENbryARQqLodT85+f6DnIqxNJjzCkC+NH1jtlJzdbYHxZZLjsR7m
         oQIVNU6/JdkAz+pCt54LAGGH9OP8Pvx0lyDK+V5jes8R3uruf0wpnWqZ9Wg8FfJY1vMS
         SB9Q==
X-Gm-Message-State: AO0yUKXECyRbUgOqMG/wfMRjlmnxy3sJH/pPVqaCBAuPV8oU7iAviwXm
        18KbDkO3oh78n2z2k8Vucw==
X-Google-Smtp-Source: AK7set8y1CYqH3X7LhNzpZzi+CLbnN+clreLg6Y9DzqN57EANoLy21g2b/KnjsI/RXQEVSDxjpQE1w==
X-Received: by 2002:a5d:97c6:0:b0:753:2c12:3ee3 with SMTP id k6-20020a5d97c6000000b007532c123ee3mr425233ios.21.1679087243226;
        Fri, 17 Mar 2023 14:07:23 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id cd8-20020a0566381a0800b00406521ad090sm60479jab.94.2023.03.17.14.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:07:22 -0700 (PDT)
Received: (nullmailer pid 2806531 invoked by uid 1000);
        Fri, 17 Mar 2023 21:07:21 -0000
Date:   Fri, 17 Mar 2023 16:07:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/13] dt-bindings: mailbox: qcom,apcs-kpss-global:
 correct SDX55 clocks
Message-ID: <20230317210721.GA2805378-robh@kernel.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
 <20230314080917.68246-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314080917.68246-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:09:05AM +0100, Krzysztof Kozlowski wrote:
> SDX55 and SDX65 DTS takes clocks in a bit different order.  Adjust
> bindings to the DTS.
> 

Fixes: ?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> index d888ead09282..2992227631c4 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> @@ -97,14 +97,14 @@ allOf:
>        properties:
>          clocks:
>            items:
> +            - description: reference clock
>              - description: primary pll parent of the clock driver
>              - description: auxiliary parent
> -            - description: reference clock
>          clock-names:
>            items:
> +            - const: ref
>              - const: pll
>              - const: aux
> -            - const: ref
>    - if:
>        properties:
>          compatible:
> -- 
> 2.34.1
> 
