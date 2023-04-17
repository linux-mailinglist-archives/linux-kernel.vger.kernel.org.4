Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755656E3FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDQGaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDQGaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:30:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBBD10E3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:30:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so19030365a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681713002; x=1684305002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rbr7dITfZlBNrOU3sgoC9hFuL+fFrZv65zzAZtIBsq0=;
        b=SrWjsobloflYb7f6BmyVdO/YYtFDDB9pO7XiY0wOojUUVk8iSBQ63xasHG0VfazS6+
         1xnySMqqRmRzDRynGmGqOheZrm70j93MkBSVBhDBIU70vBOdm2jSs6tDsafxiWvbg8ph
         ToJ1RPr77U0ZIQS3S+ARaodQ/JRxbhbCjcMsUJWHiSLwE6h3O2tyCafvd6Mzk7btMX3D
         NwiUWYlDKS5b2bsKCwgA72P6PLWi8AvQOlGLa/9QsaoDiPLeyUQEd1AvDPrQwnza0rkX
         Jh0kGbjfW3G1aY5q1x3/ZztszBj19MNZKNdr+joWV/zfDJ3XqGQeKs1w7DEJUCvI6WsR
         epMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681713002; x=1684305002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rbr7dITfZlBNrOU3sgoC9hFuL+fFrZv65zzAZtIBsq0=;
        b=S71WdDZX/CJRO/t6qdDFTMAb42LL2xyyR+RyEEiYuh+mxz7VWQE7YAEhT7TDNX6Uns
         aQa2EADzwCb2dT8vrrYlpyIg4+GozqDfVeQAvL4Xt9SENESL1iQkCocx8teZqpCXkI6K
         H+hz6eF7rc29USo849sEVQ6B4W8LQ3rUU7/PTZ4KwrkJ82e+oF8/SilrzUgnHxgz24A5
         7ktNTUclbnCCR+yBNZk2HBgSKtkBFVVgJAMYapv6KNv0LMtH9Tq0LhWS0bjF+Q7zZFPY
         usL0jsdpscybIlG7oQqFdpXcB8PtoH7uf0V/340BthI0VjbuNriAjZJ4H/VjAzTOtYxA
         XaSw==
X-Gm-Message-State: AAQBX9do5d8XASdg6dhkEBO71zvnG63uU/M2oq/LPg5Xwi99UQ+GIgoD
        GHFHq2t1Zqf80RmKLbF8QnjtOw==
X-Google-Smtp-Source: AKy350ZhGCI4nKB2rNBLO5dGxX+qcrNO6ZBdzl6bN0SQV/cayNGubQvkofnZFqJlnl4AGISWYdpnig==
X-Received: by 2002:a05:6402:4413:b0:4af:7bdc:188e with SMTP id y19-20020a056402441300b004af7bdc188emr16627552eda.16.1681713002258;
        Sun, 16 Apr 2023 23:30:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b0ac:4d3b:966c:b33d? ([2a02:810d:15c0:828:b0ac:4d3b:966c:b33d])
        by smtp.gmail.com with ESMTPSA id ta15-20020a1709078c0f00b0094fa472a7c4sm140808ejc.161.2023.04.16.23.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 23:30:01 -0700 (PDT)
Message-ID: <94e776a1-a927-ac3e-6f16-e9e71d71f3f0@linaro.org>
Date:   Mon, 17 Apr 2023 08:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: Add simple-clock-controller
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416194624.1258860-1-mmyangfl@gmail.com>
 <20230416194624.1258860-2-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416194624.1258860-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 21:46, David Yang wrote:

> +patternProperties:
> +  '.*clock.*':
> +    type: object
> +    description: Clock devices.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@ffff000 {
> +      compatible = "simple-clock-controller";
> +      reg = <0xffff000 0x1000>;

BTW, this is just incomplete example. Fill it with proper children.

Best regards,
Krzysztof

