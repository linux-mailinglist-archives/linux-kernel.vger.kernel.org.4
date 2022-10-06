Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12395F6F50
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiJFUin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiJFUih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:38:37 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3CEFF215;
        Thu,  6 Oct 2022 13:38:35 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1321a1e94b3so3566355fac.1;
        Thu, 06 Oct 2022 13:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9XJFPkZL7IcihBSQF7cuyVu5Hw9xdZWRj5vNwH/O5o=;
        b=oqSSYa9IRJSVrDfDUSXJY/ZNnb8CfWKNWSZUTgj3YAOt7ITy64l4l7UD/qc7fQKXHz
         lkq+AzjvSCC25QLL11H4Y51N9a33CaLy3vjpDZ9zbKrKEW5MRVd2tJebJUicyJ+c1dRO
         Kj0e6IbM5dZH6ll7nWVXRLNjEbqrQ70jvmFzW1igbxYuNd9g98tnLp1gNjEamKffYTjg
         sx6MscclDbSAeDpL+94niT2wzMa80L3rAIeTL/mDVFHpH6BvbG9vAEhAr7RfLH/nBpeI
         UkVxVLsE5fyT7iba78LXN8UO+MxQ3RuLBsChkM2W/ZzMLfGKg6f4GDOtxs+DHw/G6fpW
         7Rxw==
X-Gm-Message-State: ACrzQf1dB+FXOpI8mrnW/QUPK/vqinAQJ/5DNv0rgewA9f+Hq2t9JtE+
        HiH7JzEe20djYLvQpi1HSw==
X-Google-Smtp-Source: AMsMyM4ZKahQKNCTD4GBVIF0qbbS+Wal7y7FGpnpdwC3uZGez5DW+/jVePjHWooZ5ZAbjHE6RiZ9+w==
X-Received: by 2002:a05:6870:b14f:b0:127:d4f1:6a90 with SMTP id a15-20020a056870b14f00b00127d4f16a90mr870998oal.116.1665088714932;
        Thu, 06 Oct 2022 13:38:34 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id 71-20020a9d084d000000b00660e833baddsm301927oty.29.2022.10.06.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:38:34 -0700 (PDT)
Received: (nullmailer pid 116764 invoked by uid 1000);
        Thu, 06 Oct 2022 20:38:32 -0000
Date:   Thu, 6 Oct 2022 15:38:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 21/34] dt-bindings: pinctrl: qcom,sc8180x: minor style
 cleanups
Message-ID: <166508871178.116711.11112134533081147444.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-22-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-22-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:24 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc8180x-pinctrl.yaml    | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
