Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BEB681C82
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjA3VQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjA3VQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:16:18 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA71E4901D;
        Mon, 30 Jan 2023 13:16:17 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1636eae256cso12576110fac.0;
        Mon, 30 Jan 2023 13:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV1dItLYR+W95HBel01Gu7lvSH4WMJ65AbKugsEQ1vI=;
        b=KQp7qmgx+aDLR3FTmFAPNRsCaI28x4Ik8dWBdSuMUXbltJUf4i88MQYYy/Bdqn7ifm
         ewWcDk1ha7E1LwDgPdS8WFUGxCEl3BTi2RN0dLQM950F2oEhNJkRMM/yVLXnLM7TOBxm
         kPA9ZY51lVfxxz/Gb3pqZJz7fZby0S/gOTy1U/ozuSOgtN1yzqOMcy+rOtBW8V7xpt9a
         ZYfhpe9dkup6JqVM7HEobTe2xIR+FPx3uGR4OTf+vsT1cRxEv3Ccss6NdMPlVi/qDG8U
         HLh2JVD/0t5NFSWIhBb+WJJkelFDy8h+5O4sSe1y0xwK46bKYgO9WT67ar3B1yW6TNne
         1ZZA==
X-Gm-Message-State: AO0yUKWpi96mcefAHwem5i0z/CBHxvl0yuvYyGvp3iDuDThtva3rzNiw
        klN8vx1gIZC6Nb/XvThT+w==
X-Google-Smtp-Source: AK7set8zUB5w5KfEhJ1U1Nc8qvgA0o6VRcsYbpz1TZvVoaLakmP54qXh9Vud7YdjN5wItc8wnVEoDQ==
X-Received: by 2002:a05:6871:54b:b0:150:3588:3359 with SMTP id t11-20020a056871054b00b0015035883359mr5576619oal.2.1675113376950;
        Mon, 30 Jan 2023 13:16:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j3-20020a4a8883000000b004f28d09a880sm5398999ooa.13.2023.01.30.13.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:16:16 -0800 (PST)
Received: (nullmailer pid 3447303 invoked by uid 1000);
        Mon, 30 Jan 2023 21:16:15 -0000
Date:   Mon, 30 Jan 2023 15:16:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Vinod Koul <vkoul@kernel.org>, replicant@osuosl.org,
        Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: phy: samsung,mipi-video-phy: deprecate
 syscon phandle
Message-ID: <167511337499.3447076.12280997602883482062.robh@kernel.org>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
 <20230127194057.186458-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127194057.186458-4-krzysztof.kozlowski@linaro.org>
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


On Fri, 27 Jan 2023 20:40:52 +0100, Krzysztof Kozlowski wrote:
> The MIPI phy is actually part of the Power Management Unit system
> controller, thus it should be its child, instead of sibling node with
> syscon phandle.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/samsung,mipi-video-phy.yaml          | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
