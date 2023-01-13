Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C65669F22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjAMRMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAMRMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:12:17 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4959A88A3C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:11:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw16so41928190ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXnH9+h8kjSG0D+e/tnKkzeho/i7l+Lx3wm/Pwk9hac=;
        b=ROG+cpPA7tl0aCgfJI9jL9DcMqmLVplApi4g3Ilww+0nQVJDXEJz5+pkSOj+WKlc9Y
         9It0rNCOMWqs31gTquAT75MIhflWofQmAXN4YdlkMYxgUCIuNIclhhP3VR88v95TkFMN
         s04wUBBiDuUs1Jm2zak+zs9h9W1gvDzqDH6K8AWRD5z3kMv9nnfG9oOF5jnD0AvkAlxY
         PatMIuorIACUKx9viOAX4ZERgZEWGNparDSsu7QU1A3cd7NCa5CdyGqe2xe9S/8QEs2W
         bWIGSV3PSwTogUk10787nrTXyWN1aSFtwzHq125GxfuEEImWgrPCd+hleRHEwJ1RpftP
         eBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXnH9+h8kjSG0D+e/tnKkzeho/i7l+Lx3wm/Pwk9hac=;
        b=dOjjDQfrf0AkXGPHLafQcZDEIj3sKnaHAJizDn4NYTJYC3/CS/7blOwCY27ay6iMIu
         3VUEi0sZCZy7Mjyl1rwy3Bqme3ELX0oD1OLtK6+cvpsFl1pD+HqbbCHyWOzCzkr4N4Uv
         6oiNcswckh+fI7PWFkIJmq+HJAwLhxh/29O1LXmMoS4msKTioXRm5mI/6Id/tx4I7XVh
         uHDsi2uLc1cb20qkgTy1AEZmsbfK5TH3T3po4p3rC1Wgu3wAU8Sp2Kn4BPqZJxC2hQ23
         3kMBAXW11ojH+iDZBxw0RTZBuAgRD4/9okfJlBUy4PFzlvordZwMOikUQE0uEVkDJFzX
         ZbOA==
X-Gm-Message-State: AFqh2ko1HyBkCdqvLD6HNyz7KDJQwykjnu1aKiWcTxC4XOxGCU428NpA
        PIGqR27E5gsl0MdJXIVrcNqtOQ==
X-Google-Smtp-Source: AMrXdXv6SPsf041fEDD4/yrRnbbzKtP8ij8KanGx5OYsJX5jdeqd/G+Y7NuRCChlBMCjb6SDeiiNZg==
X-Received: by 2002:a17:906:b00c:b0:7c4:fa17:7202 with SMTP id v12-20020a170906b00c00b007c4fa177202mr68173183ejy.33.1673629871904;
        Fri, 13 Jan 2023 09:11:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id og5-20020a1709071dc500b0084d420503a3sm6994015ejc.178.2023.01.13.09.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 09:11:11 -0800 (PST)
Message-ID: <6bd2d336-e8e8-245c-292c-1e74b4988d89@linaro.org>
Date:   Fri, 13 Jan 2023 18:11:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Patch v1 05/10] dt-bindings: tegra: add icc ids for dummy MC
 clients
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-6-sumitg@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220160240.27494-6-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 17:02, Sumit Gupta wrote:
> Adding ICC id's for dummy software clients representing CCPLEX clusters.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

