Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A3464B87C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiLMPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiLMPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:33:40 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70D2DD4;
        Tue, 13 Dec 2022 07:33:39 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id c190-20020a4a4fc7000000b004a3addd10b5so1911930oob.1;
        Tue, 13 Dec 2022 07:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPuWVdCsiQ6yJaMOr3TcVxzSaa6VY+lACVWvBUw8UU8=;
        b=pWnkMArzh0FeJgL1GHIDLXUSY9cOJrhNDR9CRx1V4pmRmv87B2Tx1KAqlX0FRyWZzf
         6C8mWUiAJLV5U6B+WV8GjYOJJ2RqkOuoNPyFgtUzvrgoV+mJcCufYvNexWd+LGon6aob
         +zgkQVW46qZfl6DcNhthVinXmEjn6thOWvb5fSV768BNVX4eZy9KIOJWkswkq3wuMSHr
         EsY3sFvq6XhMIDYEUm6Oep2uz95vCEDW/1U7hRoVTnu9npLgGu8D6swKuHvKDZtyrH7u
         /KjrcwTvLPHfjAX2++TRLs00roO0VwZaDeA/kN33PWq3DTEqm04pYGTOmO1M0ie766Ec
         4yuA==
X-Gm-Message-State: ANoB5plSC/owkyLjWDqex2tZo+XWG8i7p7WJXIhnBxvVDciWjA8PigzV
        Q3lClrCu+1Sl3Af19s5pkg==
X-Google-Smtp-Source: AA0mqf6/cNRZZAe9sBYIs77njH/ABSum2Z8DkxhvWkhi8MAVGXguXvDpaGNKXfdFxIewdxdJrvcGPw==
X-Received: by 2002:a4a:e54d:0:b0:4a0:7f83:8f68 with SMTP id s13-20020a4ae54d000000b004a07f838f68mr8457556oot.0.1670945618708;
        Tue, 13 Dec 2022 07:33:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w20-20020a4ad034000000b004a0b424f99dsm1213292oor.43.2022.12.13.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:33:38 -0800 (PST)
Received: (nullmailer pid 1367550 invoked by uid 1000);
        Tue, 13 Dec 2022 15:33:37 -0000
Date:   Tue, 13 Dec 2022 09:33:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-msm@vger.kernel.org,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH 01/12] dt-bindings: watchdog: qcom-wdt: require fallback
 for IPQ4019
Message-ID: <167094561706.1367236.4736487890422958676.robh@kernel.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Dec 2022 17:35:21 +0100, Krzysztof Kozlowski wrote:
> The device specific compatibles ("qcom,kpss-wdt-ipq4019") should be
> follwed by fallback "qcom,kpss-wdt", which is actually used by Linux
> driver for binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
