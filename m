Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8CB5F6F5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiJFUjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiJFUi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:38:57 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C1EFF21E;
        Thu,  6 Oct 2022 13:38:54 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id m81so3389574oia.1;
        Thu, 06 Oct 2022 13:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D9krJc6ATaFID1y/O7BGrtTy68wXhyY3vrFLttrUmk=;
        b=m22TPyXRZ7UdKEzVORP+pnaCydpuIdullzveprqgqZ4GGd2W7VDmkstXFOUmiG1q6I
         Ze+NWQopKhD0PNVMUMj0kQeGUjLGgokuZajFLDdoWrwHmA56Y2n6yiCbA9e/GN/fXnyg
         6S/+7RN2fSorIy/IWhoNIQ6lprmBwDh8N1G4KbY71kMN+LhGe3Zqbfrulx81FhEylj1B
         Fr+W7Y2HcWS23grWpsN1hbPMd7mBTgcS6KMxMiCHTyZLLqnfW/dCE/9sH7Ihu+cr0w0m
         wMOBTUxWl32NXjC7HMTj8KxJcJ43qWwVKIvDEceU4OGMtOkrS9JYEAQnPhedpgF06jlx
         fjhQ==
X-Gm-Message-State: ACrzQf1IYxqBgVLfvPX1CWv0jnmNPyPxCOYp6lGTezzYw9LKiNCuwNgK
        57xXv2i6iUYL3Kg7WQJYSw==
X-Google-Smtp-Source: AMsMyM7X1uhVsBrzbCgMGO2NNAw2RNZ8R+YahaMFXPOt7ruSlCUx1EVU+uKJwd7WNQreL4mGn0d2xQ==
X-Received: by 2002:aca:5d07:0:b0:353:ea99:cb74 with SMTP id r7-20020aca5d07000000b00353ea99cb74mr744881oib.224.1665088733350;
        Thu, 06 Oct 2022 13:38:53 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a1a83000000b00432ac97ad09sm105870oof.26.2022.10.06.13.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:38:53 -0700 (PDT)
Received: (nullmailer pid 117260 invoked by uid 1000);
        Thu, 06 Oct 2022 20:38:51 -0000
Date:   Thu, 6 Oct 2022 15:38:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Martin Botka <martin.botka@somainline.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 23/34] dt-bindings: pinctrl: qcom,sm6115: minor style
 cleanups
Message-ID: <166508873077.117199.17778451690402137851.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-24-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-24-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:26 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
