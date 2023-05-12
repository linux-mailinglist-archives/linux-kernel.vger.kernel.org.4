Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945AF7000DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbjELGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjELGvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:51:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7780A5D8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:50:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96aadfb19d7so42388466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683874249; x=1686466249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjLTSzaj/aJam+P8bDF+fpLGAFitrvdhPxYkij3cdnM=;
        b=KXwh1obIMnIY9EpDd/kl96eg4glZYjziU2VDrzj0M+j00eDbKSqTPpFCJqz/DmFc3K
         H1lt58qZtQiNFDfZbaX4CIlkv8iXrcFVEOQUORaNHfCe10LzBIrN0qWDExvq7TLcGIT1
         3A+n1zC1xhJ8STMD7DRlmrQwv6oJTWTwpLuCY5GmyG1KMqMoV6XiT9mnBxy5bBqowF8i
         QNDjZPa4hVcO1f53LLBhY+iXQty6JCJPX+wYciAn8pRtq9ZcDcKH/oT7f4SHwvTtHlMr
         zbgFi/0ILZj3NLMjLAGLlcjJ3CCk/MfX6rz8Hyob51MdWu1E9uVmb7Q3HsorM+4Ydqsx
         fbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683874249; x=1686466249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjLTSzaj/aJam+P8bDF+fpLGAFitrvdhPxYkij3cdnM=;
        b=l5MjXRU28JFu+WqE9IXBuEnuyESkBWNtdw/qUuhlPKTL91K1xQ93v7WQLeaIV8NGsj
         dXfB/kdg4/uHhimegZyJhjSr69QX1qo2yyuVm/2Weybezn4oIhF7JGmim5Fz3PsOeFwA
         pscmG9Nbx8k/s/qLJZ62tl9yNVJCnkHWa+yxgYg5bH6kA95BGF7R1IAZZtMX7lPUDH87
         JOceTBH010ltYw4iQxs+M9rXqOW82BIyn/SzVGe7pACZbICc26EZcITKmYzHWkBtYX8T
         kynTxfkG1HZefAEGnLPnrPwJmAB3jMsuuDQfuEkEXSMkvV6dzSVePijaP+E8r7OdHUOC
         jyAQ==
X-Gm-Message-State: AC+VfDymbtmwNH1WiBc/mRRVhsjx591Uf2IC6LUgJxp9iSJ8kYwR52XC
        UV4CLAFcMOi3BLT6j3hE3FLWEA==
X-Google-Smtp-Source: ACHHUZ76mXy1zTI9i2lKsIPaB4P4XRWrjQ/x0aamkZb6fQKroHOTuJZ7C8gUN6BprZD4LBeSRMFy3w==
X-Received: by 2002:a17:906:da87:b0:966:3c82:4a97 with SMTP id xh7-20020a170906da8700b009663c824a97mr17082800ejb.35.1683874249187;
        Thu, 11 May 2023 23:50:49 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b00959c6cb82basm4974642ejc.105.2023.05.11.23.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 23:50:48 -0700 (PDT)
Date:   Fri, 12 May 2023 08:50:46 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Message-ID: <20230512065046.bhblj4uci7hnjoof@krzk-bin>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-6-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512022036.97987-6-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 10:20:34 +0800, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add documentation to describe StarFive System Controller Registers.
> 
> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 67 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml

See https://patchwork.ozlabs.org/patch/1780353

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
