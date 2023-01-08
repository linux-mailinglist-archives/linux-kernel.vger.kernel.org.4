Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A920661918
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjAHUKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjAHUJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:09:47 -0500
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DB8DFCC;
        Sun,  8 Jan 2023 12:09:46 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id b192so3586694iof.8;
        Sun, 08 Jan 2023 12:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtPC/bQVn9BF6Dzjwl6te96PHPaucQ4FXKKNo1HiErc=;
        b=IV7RdHk5GST/7saXNKrQNaKVEAkc9P7UBlh3pjIsi5LkrXVWBJIaDl2UjQaHTq4lyF
         L9fCa/Y7i12JcR+F3g7sWirmFT2F8L91ZN/yB5GaVtW4dWpIVY0Jd7h4gCHSbe4Nyd0z
         8bUNQjgwFZdJfHhUfcJEJIuPjgNrx9z3G+1zc3aEr0nsa+jq05GGh/QznAH1+vdtCyA2
         dFvw8ek7IaIqf4dphQCgOc9jNu0j1P/6Va5wWDFnxT0u7BDq6hotYdNrO7oJw/Da7zh9
         gM4LMopBQ2d1t0eklJcRAJjVMMPwkEfLdXnTQmUQg9w3EYXv8YFVe6cICUIgb/KVK+vE
         eusw==
X-Gm-Message-State: AFqh2koqsOfSZUWxXPQcG+qIhFOVPVhBFHNZleBpBNpMIXFClXu/bx4W
        OLovZaPqX3QPUEr/7Ws7Pg==
X-Google-Smtp-Source: AMrXdXsFguyxhIg1RnryDU1k3YHXILI41nZmSNAmZEES/Y+a3GN61KhrLf2+q1YbfzAGZFIQxXh5XQ==
X-Received: by 2002:a5d:9816:0:b0:6c3:a4b:9c17 with SMTP id a22-20020a5d9816000000b006c30a4b9c17mr39235405iol.5.1673208585631;
        Sun, 08 Jan 2023 12:09:45 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id a12-20020a056602148c00b006e25b512bdesm2496488iow.33.2023.01.08.12.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:09:45 -0800 (PST)
Received: (nullmailer pid 214252 invoked by uid 1000);
        Sun, 08 Jan 2023 20:09:41 -0000
Date:   Sun, 8 Jan 2023 14:09:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/9] dt-bindings: pinctrl: qcom,sm6350-tlmm: add
 gpio-line-names
Message-ID: <167320858068.214180.11122501416137182563.robh@kernel.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
 <20221230135645.56401-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230135645.56401-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Dec 2022 14:56:39 +0100, Krzysztof Kozlowski wrote:
> Allow gpio-line-names property (quite commonly used) and constrain
> gpio-reserved-ranges.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml    | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
