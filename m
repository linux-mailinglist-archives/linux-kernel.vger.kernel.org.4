Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43651601680
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJQSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiJQSjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:39:11 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496175397;
        Mon, 17 Oct 2022 11:39:00 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1321a1e94b3so14280677fac.1;
        Mon, 17 Oct 2022 11:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVjkColzLJkhV5CmuDI7LfNZ/MBGdI9xHtDT0GRnfH0=;
        b=bP3YZerwzTc/3MXOGi577uI8nFp7zW+aByBdJ93CgoAGNbepHy31bvNbLmyMdDsYsQ
         o3jZJbZkijSFRfBqu0SW9ilnrM6eq8uyTXjcGz7EYXC+C1HTxFaLO4bJXShMt+Sdlheq
         FXhBBJLqFpuHer6B5tcZ9UKOfKsAYgIn3My3SzmE+ZzHkTc0h9h7VtGlyXtEY0BqcSXR
         J0cDBxMtuEwsIbgNNdXpKjwzrekwlmzlOPRW6ViETxzFw3oUrxfB3o0NRZ+0HF4j4zqI
         GtQ+f++5qvJGMVGsVkz/xpwiK1KoZ0q14CJH4sz7jiUKIFJRFAz3SS2uyxRTrfw8/VxF
         kd7A==
X-Gm-Message-State: ACrzQf158K2c4I2ODG8GQAvYi+vLCbzS6ECOYMDIVRmkrD5pDaha5qRi
        y1GsEKWziAlqHGclr/4uIg==
X-Google-Smtp-Source: AMsMyM4Owgl4KxiTfWIlsubQR4f1tMkCAZKWNxRtPZW0O7HZFOpOhemPP2xpPZFlq8U7oV9H2x3aGQ==
X-Received: by 2002:a05:6870:390b:b0:132:9ca3:8dc1 with SMTP id b11-20020a056870390b00b001329ca38dc1mr6373660oap.106.1666031934466;
        Mon, 17 Oct 2022 11:38:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r41-20020a056808212900b0034fd36e95bfsm4702748oiw.31.2022.10.17.11.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:38:53 -0700 (PDT)
Received: (nullmailer pid 2260004 invoked by uid 1000);
        Mon, 17 Oct 2022 18:38:54 -0000
Date:   Mon, 17 Oct 2022 13:38:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document Mikrotik RB3011
 board
Message-ID: <166603193400.2259949.9596015282136077583.robh@kernel.org>
References: <20221017014653.12970-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017014653.12970-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 21:46:52 -0400, Krzysztof Kozlowski wrote:
> Add compatible for existing Mikrotik RB3011 board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
