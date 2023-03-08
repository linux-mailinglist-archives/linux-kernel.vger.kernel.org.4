Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5506B158F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCHWtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCHWtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:49:03 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6B2E808;
        Wed,  8 Mar 2023 14:48:50 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id q15so264033oiw.11;
        Wed, 08 Mar 2023 14:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GuMp91Ix4d2fLjZ+k2xiaHoSPAtesmVFFCJjpId+TY=;
        b=DWSotEwJkmG+B2B5SVVopyAgH+/50JVOxBXQBMP571qLA/L//WJeJLoIjs8jidmknf
         azvBX09NU9gqTT2DyyP3qo0VEuttL+CpgwEBJorZQ6rZFHaTgtwxycsY/82P8T96Nx9k
         OG34x7ToKxHRnD/fMqDsXdu+9k7uVx29IByEQAZMiANk10y8Z6GqumyEJtuyZ7NZbkUZ
         YFJWuKLK1f5uIpZ2XwsE03Cl9KzK+lOvc76HZDu8hmjRCEMFW3JL/lF4Hrjt4Xp6RUpt
         HM2/bCtahUxppa5qx/1HBLp8W9EYJNTbaYOCVt9I5LoKXNn6KrIq80uNEhjN5EuLgEae
         /j9A==
X-Gm-Message-State: AO0yUKUHIhfdTId717+4F63GKE6QZnrByjFVyb6xCh4SG0MwuRhs2vBz
        fz8TQs9vipZdyXVm9mu4trthkI4cOw==
X-Google-Smtp-Source: AK7set/rBiBGIpexxHfnYdXsWT7//FO7FpITMrDs0XFH0m2KmOf6OIajcxYZ7XZMMRwkH3wGXFVk+A==
X-Received: by 2002:a54:4612:0:b0:384:f4c:7ee2 with SMTP id p18-20020a544612000000b003840f4c7ee2mr8119235oip.30.1678315730090;
        Wed, 08 Mar 2023 14:48:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r204-20020acadad5000000b003785996ef36sm6847420oig.19.2023.03.08.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:48:49 -0800 (PST)
Received: (nullmailer pid 4008340 invoked by uid 1000);
        Wed, 08 Mar 2023 22:48:49 -0000
Date:   Wed, 8 Mar 2023 16:48:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom,adsp: bring back
 firmware-name
Message-ID: <20230308224848.GA3947747-robh@kernel.org>
References: <20230305125917.209262-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305125917.209262-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 01:59:17PM +0100, Krzysztof Kozlowski wrote:
> The firmware-name property was moved from common qcom,pas-common.yaml
> binding to each device-specific schema, but the qcom,adsp.yaml was not
> updated.
> 
> Fixes: cee616c68846 ("dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> index 643ee787a81f..828dfebaef6a 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> @@ -44,6 +44,10 @@ properties:
>      maxItems: 1
>      description: Reference to the reserved-memory for the Hexagon core
>  
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string

We need to stop redefining the type for 'firmware-name'. I'm adding it 
to dtschema, so here just put 'maxItems: 1'. Some cases take more than 
string, so we have to define this as an array. (We obviously didn't 
learn the name things plural lesson on this one.)

Rob
