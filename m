Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D439B5EB0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIZTD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiIZTDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:03:36 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE71996FD2;
        Mon, 26 Sep 2022 12:03:21 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1279948d93dso10464856fac.10;
        Mon, 26 Sep 2022 12:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OxTCM/nz5bhxL8sMmDNe073lxJ0LVSSiBKn/6zH9MH8=;
        b=EXXZYs171yfwh2EmR97v9s7NZNXivt4wdSezqaD2kOE2AojSau9VeHGe//R8zvWWAR
         3GIJBFp9pwbQtaCk7sd+wggGsMM9o7ssqGOaUzi66+rnNnwZEO40I+T9GfZ8wN10lXIA
         +ymm+WdFZLowpRIyjaF0++YMLlkqyq8SLF+Vj4XV1Nt45fn3NBywHbDSMiRQmkNEqX8M
         45UsJVKidCfQY1N5KLmR2PkZKEllD7uEOu1vyGK0HcUAJhaTdqvehJNiffl54bdbFiAX
         imRjgw0KXbB2IEVFnaR92b33U4NViwHAY9zDVgVFih74vF2Dc01orzzwlVY0BvEGEqo5
         pQqQ==
X-Gm-Message-State: ACrzQf28402hl4GvguPwJ1WQtXvH/X++J2iX0KhZN7LLgmlvTR97iw01
        IB1yk2QRux+D/9xclPML1yyhZTJmzQ==
X-Google-Smtp-Source: AMsMyM4o4vE++pKjkstmDL9aCzjGdQmxl98BCceQ/dM4bvvkTUNkDFgTiJOoCcYddLrlFkeklkvfLw==
X-Received: by 2002:a05:6870:e615:b0:12d:943e:256a with SMTP id q21-20020a056870e61500b0012d943e256amr101761oag.83.1664219001159;
        Mon, 26 Sep 2022 12:03:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i2-20020a056870890200b001227148da8csm9356485oao.36.2022.09.26.12.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:03:20 -0700 (PDT)
Received: (nullmailer pid 2594505 invoked by uid 1000);
        Mon, 26 Sep 2022 19:03:20 -0000
Date:   Mon, 26 Sep 2022 14:03:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm: qcom: document Google Cheza
Message-ID: <20220926190320.GA2593932-robh@kernel.org>
References: <20220918095430.18068-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918095430.18068-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 18 Sep 2022 10:54:30 +0100, Krzysztof Kozlowski wrote:
> Document Google Cheza board compatibles recently added.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
