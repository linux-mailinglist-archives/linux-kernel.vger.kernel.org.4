Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282C4736EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjFTOm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjFTOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:42:25 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7AC1708;
        Tue, 20 Jun 2023 07:42:23 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77de8cc13b4so234486039f.2;
        Tue, 20 Jun 2023 07:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272143; x=1689864143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MmZ0g1HW4agS/tjTfgrP/sLuSN4tElhlwhGgoaJ3go=;
        b=LQw3Jp2C6DWjtkSa0lrPTJE2eYzsLYbPe6RuSZuSqJMlleIO57EgYpVdZ37QcrDbT7
         vgHFORJcjuAJJicX1PAH35eN/UyFyWcRKB29pr1vKUtKY8pSJ2CPDu8qFXLwmQ0Ll359
         SFS62ZYBTDikEydN73kdwHbxgONzJrrVfFbpfoXj4BXdEQCrUuRI2UB90e7TJ7yP1A7S
         IxensYoZ+6triqENkttAG+XCGwPGXyaYphHWcRp8mUwuIbeJwTN9ACC0it69F+4VrxiB
         XzOar45D1QzJTi33RXJoT+VQFhVuuwkkFwzGwNvLW7jAwES+yZpOc/Eiw3KzL7M9MbsU
         vfLw==
X-Gm-Message-State: AC+VfDwQuj7tFHMT77YPqOsUQ4ZkxosrD5hmteCKvOqrz5Q5zHnJVg3w
        2Gao9mEmGEA25M4vKiobgg==
X-Google-Smtp-Source: ACHHUZ6+i1Qpe2BYZ878BybOTtRyh71NPNDpWWXT+XcPjB3Rn3VGzSz4sJVTkp0w/dkvLRDHJBTzfA==
X-Received: by 2002:a05:6602:2995:b0:76c:4ce7:e37c with SMTP id o21-20020a056602299500b0076c4ce7e37cmr10852808ior.16.1687272142793;
        Tue, 20 Jun 2023 07:42:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l9-20020a5e8809000000b0077e2ae3170fsm674348ioj.55.2023.06.20.07.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:42:22 -0700 (PDT)
Received: (nullmailer pid 3564600 invoked by uid 1000);
        Tue, 20 Jun 2023 14:42:20 -0000
Date:   Tue, 20 Jun 2023 08:42:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: rockchip: grf: drop unneeded quotes
Message-ID: <168727214023.3564537.237122680984653343.robh@kernel.org>
References: <20230609140702.64589-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609140702.64589-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 09 Jun 2023 16:07:02 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/soc/rockchip/grf.yaml        | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Applied, thanks!

