Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEBA6878F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjBBJeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjBBJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:34:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7DD58662
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:33:56 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso849953wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H09QHxNeoCXQ1wOs5uX5+X8RxKFEgQBRGhj52BhstFA=;
        b=Cdwp3qY+c6Ow4apxcPArveNT84h/K16vjo0WqVqdIcQZ+oclk57RDVB/FZMcuvyLdT
         0Y/3VVo39EsD+rH2UuBMwoUywz7LTNh2ff6JK5cLZ39GDNcNpBfYjFtvQZsAgCMxIrQS
         cEVG/xHxn34q9E53Ty05Mm4ZwinL+4vSu9Rmuh/fHoNl2vV0CvMHYPAOM98+JLkSHdWk
         YEPpYpOpQFc/hBqWgkoTo8W/7WdrvzDJ4+3Ox8+3Fbz4Uj5dkTrMuCwSI82nwmGyTERy
         c4WFWGWaVKyHDqCRzOyKFDvZANWA3NQfgE6YGtOA5yA8l5Ndc4q4wjgh/anRQAQSisLd
         vicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H09QHxNeoCXQ1wOs5uX5+X8RxKFEgQBRGhj52BhstFA=;
        b=zDBe38xZW9bE7796vvepgXAJX+/W/R3AFISAabSOJ1RdFZHZWb5W43h5S/mFdL/qZ6
         w3sNbjgoDocQDWcsRe3hQea2m/eaDmzpSFolCUUcUrM0JkYFpLwAB0WMmxI6nYTjGktx
         2xr0vv/n+dzON0yO0VPtx0ldIyiAQ1D9ub9W8O7OlKmgRYt+w3SkgclTfkohibA9id4N
         SI6Mb90d9PhZ/yKEdiCLE6T1l2ZNrb7ZhKL72cg1RB8qSL4tgtUWKmorzbhzdxd3itCV
         Ximqa4P8ncsQ8Yweom9NeIL9ron4tsz+8nFZqJAPn+lTQvAhFer+DZdvBELfGwjSczpo
         J0Yw==
X-Gm-Message-State: AO0yUKVFfeJGc2w9xCH5lYzAr5ybn1hT/hksVMTD6wled0BcvsR03yAa
        vG5nue5ETp93Un29zo9cZSdh3w==
X-Google-Smtp-Source: AK7set/+rQvUFqlsAkRs1BGOMFIQlEk1J/k1cx9lTGnjwVLNdtnrNdV9c2ux8pPA45NvjnmloJxnhQ==
X-Received: by 2002:a05:600c:1e8d:b0:3df:deb5:6ff5 with SMTP id be13-20020a05600c1e8d00b003dfdeb56ff5mr829753wmb.24.1675330434645;
        Thu, 02 Feb 2023 01:33:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c158900b003dc4ecfc4d7sm3934579wmf.29.2023.02.02.01.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:33:54 -0800 (PST)
Message-ID: <a3883306-97b6-0f50-a0a3-62a42c9b79f3@linaro.org>
Date:   Thu, 2 Feb 2023 10:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Content-Language: en-US
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202092325.21241-1-maarten.zanders@mind.be>
 <20230202092325.21241-2-maarten.zanders@mind.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202092325.21241-2-maarten.zanders@mind.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 10:23, Maarten Zanders wrote:
> Add a binding to configure the internal charge pump for lp55xx.
> 

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

