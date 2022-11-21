Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A121631E78
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKUKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKUKeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:34:24 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA5E27CC3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:34:23 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp15so18128238lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g01rBdqiiTuvoRvPxYyakM/ID62S4Z8P8ecgqOpG6Fk=;
        b=wFH18v//BO+mSjYvq4+pAXmZBg4PjE0BeTd3kAFFjcC6xH8XmxyFZOr0GV27y7gg22
         JMgpn7rDNTfrWd4H+zZCg0gOxri+c/wXE/KRmkO0U1V4URhgTQD3JzgBD0GfssH+VgTB
         2GuW7sPQV2g+V1W0vbSDFQZPH9qYer/gQIcA/6OeKSl9C7gSG//OQf2+aXROMwGrSze+
         qIJY1ezr9wzU5UG6xK3+zNjphPIipzAH7Asjz/sA3axJPnNtyUxtoFoEtYGElVgnNbnG
         W6jUsODTfsclAmANjGIH8ASeQIKhjlIVWpStromLdg9memHEK7xNVemBBjXsCuPQ1xOC
         rvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g01rBdqiiTuvoRvPxYyakM/ID62S4Z8P8ecgqOpG6Fk=;
        b=qmjXy3MJk8toTi5JV/496zU/Po7e0NhHPZo8ZYfFU7PU6KFwod+PldIT64Wx77iC3s
         yVv77dlIDYpyS2/plyfpvdg0OEA0mVHtyurY+wqigsy+MOdklWmCipG0oLKOJ+iU727I
         ddIAmchPBXAL0356z/NZ61c1r2Q0Fc5jTUYNSMaUoqRiJ6Vazw46id1PexGKumtIg5eB
         2nn45nl+0HyfyYR9XoH54marLmcm/3h16MKyz4spjQJAJzUuCpuYFRYnaGj7uQVhJ8V7
         yYObH6sbtInTiqEdI+67nUQtdkPMlcy9fwqRCOD4sLGka8h8DX9DsrVwup3kXNxwsvGJ
         N/QQ==
X-Gm-Message-State: ANoB5plgqNLlq5K8LqBv5Ouaew7V3L87lnWcYtYy2kILL2sXlLEPE0x7
        eDzrWG+9vbkE8XLUV8qC60V2edNMdE6+7V34
X-Google-Smtp-Source: AA0mqf6nYP6HjyYkv6L/aAK9yRawGjQhM899BPw2v0roscvBxNE129EPtnmzz2ueMEh8xr9bZNcfsQ==
X-Received: by 2002:ac2:4346:0:b0:4b4:a5c8:cc0f with SMTP id o6-20020ac24346000000b004b4a5c8cc0fmr6388397lfl.138.1669026861877;
        Mon, 21 Nov 2022 02:34:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i16-20020a198c50000000b0048afb8b8e53sm1978969lfj.80.2022.11.21.02.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:34:21 -0800 (PST)
Message-ID: <86ead5ed-b236-ce2f-d965-1eea72f58857@linaro.org>
Date:   Mon, 21 Nov 2022 11:34:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v12 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, wells.lu@sunplus.com
References: <cover.1669023361.git.tonyhuang.sunplus@gmail.com>
 <8c8fbc29524819d8ab45a4fe75311b3b7b567650.1669023361.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8c8fbc29524819d8ab45a4fe75311b3b7b567650.1669023361.git.tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 11:06, Tony Huang wrote:
> Add MMC YAML file for Sunplus SP7021.

> +++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus MMC Controller
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"

If there is going to be resend, drop the quotes (and keep my Reviewed-by
tag).

Best regards,
Krzysztof

