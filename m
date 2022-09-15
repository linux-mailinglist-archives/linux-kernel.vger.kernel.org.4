Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC35B9790
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIOJg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIOJgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:36:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A283A6F564
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:36:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay36so3900822wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Q5oC9faImt9D0zslczuwTCnYe/Fu0rELKtEkE9Enw9k=;
        b=f4LkzKRBrsqWOrsiFynIlNRNEQmtjOegH1rGBO+J54GGi14tmZ4vkp5YWia1ONm9XQ
         gglhzp0BPaXj7TKFENEnKH+gdfBYtpJfsVAIYYq12crzhi5Ze4CfcNVH+W27xf4XbM2u
         RAtYzlKtplUiso71VruUWkBsbAWqFRHtXe7VpandjNf9xGkQ2yV3kOKxVcFpOXxYTZIz
         wPgyVT1xaaVqBD60PGeh+V9a1FT16BGuZHnXdAmohTN7Bt3HzB/VrxwCF17u79iDIEL5
         WOx9T/JumWYeL3z6RzxZ2IrJsiu3GAwASrAA73e1YIZX5JBWmNqUcaGL8qXwBOWLb8os
         rW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Q5oC9faImt9D0zslczuwTCnYe/Fu0rELKtEkE9Enw9k=;
        b=pp8cUcexJjTbho+fqD8qtVLmeXDIFvdmYpJqlaxPbW5GlDUKBSzOdQqdWJZZpe46TO
         EMIl8vAVg8vuGhmjt/l5qZOS2pMIdxC3KiwjwuwKKegLZ3JLXzwZ8GsDPm+lgkN2xtzE
         0mLriuD5kASizsid6WX2lIJqco2oL+DCNrtqgknp7J5rdIS5QKcEyrrhs7/q+KX5xous
         T8wn1iJqoWJ4WHtoX4KwkpoCK2AdExQRy4lBPCT4yad2k1ZurDoQzIF5MSEQhC2pgrVM
         C4fGPxSLW2sYOSSy2XEUEmOkjVFbPcP9w33GHEKj5FRE2IgQtkaEp7AZfrxThL3yB1x6
         UdiQ==
X-Gm-Message-State: ACgBeo13H7Zc5r7LR+LUson+u/TryCPNGBZ16WGu+paXuqtjjvP7vKzv
        JDZ9GOrlNZ8tqKZQzmom6WyZxQ==
X-Google-Smtp-Source: AA6agR65hP5LHu32uKJVvqgNLMb2zEp4ZAqaMy8dZpFTmm+m6vtEIK3zg73WcW0k9xNVMlLa6+0nVA==
X-Received: by 2002:a7b:c844:0:b0:3a9:70d2:bf23 with SMTP id c4-20020a7bc844000000b003a970d2bf23mr5929370wml.165.1663234611305;
        Thu, 15 Sep 2022 02:36:51 -0700 (PDT)
Received: from krzk-bin ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b003a60bc8ae8fsm2544406wmq.21.2022.09.15.02.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:36:50 -0700 (PDT)
Date:   Thu, 15 Sep 2022 10:36:49 +0100
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alex Helms <alexander.helms.jy@renesas.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, geert+renesas@glider.be,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Message-ID: <20220915093649.djdipsrq4homkmaz@krzk-bin>
References: <20220914211809.22500-1-alexander.helms.jy@renesas.com>
 <20220914211809.22500-2-alexander.helms.jy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220914211809.22500-2-alexander.helms.jy@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 14:18:08 -0700, Alex Helms wrote:
> Add dt bindings for the Renesas ProXO oscillator.
> 
> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> ---
>  .../bindings/clock/renesas,proxo.yaml         | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/clock/renesas,proxo.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/clock/renesas,proxo.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
