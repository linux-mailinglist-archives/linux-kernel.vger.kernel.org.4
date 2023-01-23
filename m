Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4FB678958
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjAWVSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjAWVSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:18:12 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DFC125BC;
        Mon, 23 Jan 2023 13:18:12 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id o66so11570294oia.6;
        Mon, 23 Jan 2023 13:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywud7ZWeMHmFOjclbft5yqOHQmEsSUXtRD9i7sVK4H4=;
        b=ALTfYGYOylZVx5sewQN3qY/XI5Rp4gu8T0SZ6W8C6Rb7abeoeeCadQlN5gelcOTagw
         xEkiqouP6mbxUAmFVQKOySSEa6knxj4rNpoJsyyoyWRrwxcvJAUxJi8A7LzFu9MbjIfZ
         zhKUJyfnWbmq9m/zp+2owLkUNG3OIcF2HzhXVbzRp5+tBMF2Vcyzl9vzZVFBBRPe0b6b
         DHUmcWYbRj40FJz+rmD7h/5CbVwrJLUMAj4WVOc+1pVKNEwBn9q5dm/ScMGC3D1XfJun
         2I4b0s/VnZOtUFitZeRBQV73mqpGPrybWIZ4JNsVV17bqhcscf0oCUXDz6fJ+adV9iu/
         cY4g==
X-Gm-Message-State: AFqh2kqUNkBs3IxoiX9zWRrBiJBMaSsE+sjPlSNJ36f92UdcKtGmeE0H
        El9yRQO/YEdcsZYWY7vGKw==
X-Google-Smtp-Source: AMrXdXs10bEeIFi0iNTyIEE1UTl8pknOudNavorSMN1FcmHPxgWJTXAPtNxXk9tDO/wrml1h3JNCxg==
X-Received: by 2002:aca:3203:0:b0:36a:d348:26d8 with SMTP id y3-20020aca3203000000b0036ad34826d8mr10764521oiy.52.1674508691287;
        Mon, 23 Jan 2023 13:18:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a056808130500b00363ef79e2a1sm223198oiv.31.2023.01.23.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:18:10 -0800 (PST)
Received: (nullmailer pid 2655726 invoked by uid 1000);
        Mon, 23 Jan 2023 21:18:09 -0000
Date:   Mon, 23 Jan 2023 15:18:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Ilia Lin <ilia.lin@kernel.org>, linux-clk@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom,sm8450-camcc: constrain
 required-opps
Message-ID: <167450868811.2655634.3848215536562654320.robh@kernel.org>
References: <20230119130028.106817-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119130028.106817-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Jan 2023 14:00:27 +0100, Krzysztof Kozlowski wrote:
> Be specific how many required-opps are allowed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This change is independent, although logically is connected with my
> dtschema pull:
> https://github.com/devicetree-org/dt-schema/pull/95
> ---
>  Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
