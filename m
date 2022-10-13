Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77CC5FE35E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJMUfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJMUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:35:09 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F993399FF;
        Thu, 13 Oct 2022 13:35:07 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id u15so3031571oie.2;
        Thu, 13 Oct 2022 13:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paVbD3p6W+Byhgau60ZrecUWAAUw5dv8/tznnKkrBDA=;
        b=2G0tu1ChbdncsK0mBZhBNks5vJKa8WTBFzxttCn0APapMSnzHFjjRURh2Wh6x2H97D
         jHuAFrPYGPlDoUcN6yzNNpTkWcHosZIo/uvUVSUZHanvfB8N6tcNX//RZ0ycgpRsqo/r
         6c4wHh5UtOPrvKBQ6l0igGOI2XU+xT5AZbh+brOUPhwOj5tXZOETO3Z4/YZfKbP7+SF5
         oxbsHprPDnPDkTpmVrdoYqR33cHp+BZbdMwfWZhmZKzX/WUxPNPGW81jCpzwx9moVMGZ
         LY2FkPpaPSSoPOvtqWaUS+av85CKM2sOU5a7zahBhXZWnWSfURd/9n0cDhLDB4z81+u5
         ul6A==
X-Gm-Message-State: ACrzQf2CDY39pEdwZ7EE5j6HZmFCh62H8iHepHznUBlsy2lyn00FIL/Q
        kha2QJ5OaiTtmgga+KLL/g==
X-Google-Smtp-Source: AMsMyM6ukUZ4lvie+Z3IVSzZXvnvTfVkaA/WHrRMbck8vCqZ5M9nqf5YuGbFe+64sWCVW5KxkfaOBA==
X-Received: by 2002:a05:6808:150b:b0:354:3a01:bad0 with SMTP id u11-20020a056808150b00b003543a01bad0mr5451840oiw.286.1665693306586;
        Thu, 13 Oct 2022 13:35:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m36-20020a05687088a400b00136a0143de8sm412018oam.40.2022.10.13.13.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:35:05 -0700 (PDT)
Received: (nullmailer pid 183578 invoked by uid 1000);
        Thu, 13 Oct 2022 20:35:06 -0000
Date:   Thu, 13 Oct 2022 15:35:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add ALFA Network
Message-ID: <166569330583.183529.17449068100293610145.robh@kernel.org>
References: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 11:54:15 -0400, Krzysztof Kozlowski wrote:
> Add vendor prefix for ALFA Network Inc.
> 
> https://www.alfa.com.tw/
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
