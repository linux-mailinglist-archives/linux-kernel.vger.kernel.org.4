Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4464B8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiLMPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiLMPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:37:56 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA961FD3E;
        Tue, 13 Dec 2022 07:37:49 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id q186so101571oia.9;
        Tue, 13 Dec 2022 07:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxV3JvN/uWnRShkNDQxQrnokkXJZGJf7HJ449Gx5vHk=;
        b=nEyJmksXm/0b+vnt27VfBTeHLJUPN51SmW36bTgWfXoiThygSP+ilRleQ9a5Cn+5Jw
         OYSOYEOz+FstVjfhaJCoLJRcOdUusRg0wllAiq9/C5s/qQ1E029weKScrk6/US5MPbH9
         hYuyXNqfogtjVLs5rVHTqKtIgJ/Ppdfhul8ciKCho6fS40YtT36lwBijkR+oO2+sfLwp
         3cnocmSmhLT9LfEcpnCxKrdSgnEstIsznJKZY5KjdFF0OI02Ayt9/dMBKq/Q+Re5/19p
         Cztsp96LZYRAS9s71Aze4jutpERQDHCUoFKmTtf3sf+wUXqNFe0XIe3iyxAJOGbdnten
         ZM0g==
X-Gm-Message-State: ANoB5plIsHkIw/3hyQlCuNEk13h9SiNwY8Aq9iXGb4F7MoWMZtv08N/p
        9TjSwK6Njj2Ln7RSbIQrjVyHR3s2Jg==
X-Google-Smtp-Source: AA0mqf77kvtcezWvznrUagkATp8H8L3iiPvtGiAqe7av/woRSSXbhbKgsBa/qSkER4/pkD05ja7oSQ==
X-Received: by 2002:a05:6808:179a:b0:35e:66a2:146f with SMTP id bg26-20020a056808179a00b0035e66a2146fmr11147989oib.3.1670945869000;
        Tue, 13 Dec 2022 07:37:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bf21-20020a056808191500b00359f96eeb47sm4727510oib.49.2022.12.13.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:37:48 -0800 (PST)
Received: (nullmailer pid 1422625 invoked by uid 1000);
        Tue, 13 Dec 2022 15:37:48 -0000
Date:   Tue, 13 Dec 2022 09:37:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 04/12] dt-bindings: watchdog: qcom-wdt: add
 qcom,kpss-wdt-mdm9615
Message-ID: <167094586734.1422390.3827935693962970857.robh@kernel.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Dec 2022 17:35:24 +0100, Krzysztof Kozlowski wrote:
> Document new MDM9615 qcom,kpss-wdt-mdm9615 watchdog/timer compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
