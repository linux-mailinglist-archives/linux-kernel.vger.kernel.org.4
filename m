Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97E27286F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbjFHSO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFHSO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:14:26 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B8210A;
        Thu,  8 Jun 2023 11:14:23 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-77797beb42dso44935639f.2;
        Thu, 08 Jun 2023 11:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686248062; x=1688840062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ADQ59f6QOcSXJ5LRsHTU01rCUCUpfqHT13J1yXr1pg=;
        b=b6qWHzDHJvHEwIqFYO9tW4pXe1nvDpXF0qnH1yzzayfh3yX2TCKmw32ct+87ps633H
         k/lAMHgiOwghcv6dh7PWSN2+xn+NgRt4vfvYd8ZfTnMpM3jNVHVnjCCJqGCIc5jRgq+U
         yRkHXuJ54KoomsWRqSV3ljVaj9RpAAQUL25daBwLy/LWxcTYT3+WKGvhOfeVvrqUSEiT
         xwl3WJfP/Vif53ZvAFGlx3Ot2V8zBjV46+CONq0h5GGdg6/sMHa+0MrUqgfTr1JH4qdS
         zHWCIXp6R+e+FJLP5dNejHc6terFpsg5H2Qm11YPKbdNkSFkx4wIMKmCEeC1hcJjk6DH
         +phw==
X-Gm-Message-State: AC+VfDwDQtm78nvxMAa11Lxc4pjD1p9ofkPlj3eK94mYE4LSeen6toRi
        XeXBBlQRFAoCz4Vn1rQBlA==
X-Google-Smtp-Source: ACHHUZ5eESly7H02+HXiJ06ielEvCD+9KkTClp9Yzp484VkdqIsP1dOAGy+NyloWFM7G1XpI1Sg10Q==
X-Received: by 2002:a6b:dd13:0:b0:777:cdfc:102e with SMTP id f19-20020a6bdd13000000b00777cdfc102emr10406679ioc.19.1686248062683;
        Thu, 08 Jun 2023 11:14:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t18-20020a028792000000b0041fb2506011sm408965jai.172.2023.06.08.11.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:14:22 -0700 (PDT)
Received: (nullmailer pid 3183367 invoked by uid 1000);
        Thu, 08 Jun 2023 18:14:20 -0000
Date:   Thu, 8 Jun 2023 12:14:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Campello <campello@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: iio: semtech,sx9324: reference common
 schema for label
Message-ID: <168624805991.3183324.4718869038495095681.robh@kernel.org>
References: <20230507173923.263741-1-krzysztof.kozlowski@linaro.org>
 <20230507173923.263741-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507173923.263741-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 07 May 2023 19:39:23 +0200, Krzysztof Kozlowski wrote:
> Reference iio.yaml schema from dtschema to allow already used
> label property:
> 
>   sc7180-trogdor-pazquel360-lte.dtb: proximity@28: 'label' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Patch for dtschema:
> https://lore.kernel.org/linux-devicetree/20230507171219.232216-1-krzk@kernel.org/T/#u
> ---
>  .../devicetree/bindings/iio/proximity/semtech,sx9324.yaml    | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

