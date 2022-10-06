Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDF75F6F0C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiJFU0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiJFU0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:26:22 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED9BC1482;
        Thu,  6 Oct 2022 13:26:09 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id m130so3328549oif.6;
        Thu, 06 Oct 2022 13:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRjYDbG3uYBEN2tRyCqd601w9YLBFDNpzdOavWyuI7I=;
        b=x+DPZzfFZvpf5UD9jLgJy4YwBhewst3h1SVCpOwFJ9HcXRXQhbsxgn8Pby/yOLb94u
         Zd4HJ3ikkTcCfPAL+Cv3Y4icR4KHdvJN4KZ28uf0WAWdOfj0nrJIkbglMlRtTk/AokwF
         HXVkRsLgJ31bXvGf0jXOlRqJjPJnsBvskfsUnKSpfBCVQ2lLUbO6xM79q+1App1iYP4e
         yIlbj/vrzMdnZRppnvLuQlZiwiNP9C+uyAnkFphnG4/KQCrAouZ7Qup0OA+LtKPOJS66
         GMl4WSzNWQltKvdoWk6C8qVVnrsPbPywDFJvUv4k5jjHENY+l1sUOgZ+YvaZe9Pzo2KP
         TbbA==
X-Gm-Message-State: ACrzQf0kNNiB7snfLGa7cuGis8e1Pe9Kow5H9ELNnDNdmCXqPu949Vvs
        YWDFyuN5i2llemPVDu+LHQ==
X-Google-Smtp-Source: AMsMyM6quIFi3k7LiXP3uimKWiTdAC/u7+YJ+naBruR3UhW+PztGW7qjFDyX42RVG8Q22fTxOA3SpQ==
X-Received: by 2002:aca:b409:0:b0:350:e9a8:15b5 with SMTP id d9-20020acab409000000b00350e9a815b5mr5813616oif.299.1665087968196;
        Thu, 06 Oct 2022 13:26:08 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id q36-20020a4a88e7000000b004728e64dc0fsm62956ooh.38.2022.10.06.13.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:26:07 -0700 (PDT)
Received: (nullmailer pid 105459 invoked by uid 1000);
        Thu, 06 Oct 2022 20:26:04 -0000
Date:   Thu, 6 Oct 2022 15:26:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 09/34] dt-bindings: pinctrl: qcom,sm6350: drop ref to
 pinctrl.yaml
Message-ID: <166508796340.105395.11257928930130368316.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:12 +0200, Krzysztof Kozlowski wrote:
> The binding references common Qualcomm TLMM pin controller schema, which
> references pinctrl.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml         | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
