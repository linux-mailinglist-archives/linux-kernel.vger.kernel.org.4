Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3C6835AD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjAaSv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:51:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D702DAD0E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:51:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso11380860wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CY9SU6b3wZS3mZz9rbdfa32Xi5zQER2G6OPN575iHjs=;
        b=nNivMXLsjaiN/3aTeN/Lx6QcZcbt1RJlRnPixE1F7Fch6ltg/BBpprez8gw8Gq+dGe
         Tgm6hry7MKyw8I8LJ8EURd7YdOTpdVj4XZBa8ecy3InRxD75HDKmvuqPGMTq1pcaVOLX
         YB5IpVAVIhnDFW2/Xnttpt922JZhnD3Vi+aybwW0dhGIk3/M8Nm8LbMIkXE261RG0Hu/
         +JuE4cuBaOISy6kyf0ie7V6mzTkIYXKkPFIujc+y625HNJIsBvZ2GrqJk7ZoDmBquPRE
         yVrAi/4Z68Ria/lvveiUlx5aRDLq+MtImBN8jMiZuSyS4Bb8qBwFMhKAkSO5et3evecH
         kM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CY9SU6b3wZS3mZz9rbdfa32Xi5zQER2G6OPN575iHjs=;
        b=C/WodDttV9JEeIY9FCMBvdXpKr0FQnTvAaTpuDjWCHPEkXpBjzEi9edvE8TgBB94+9
         XKpSPy2dRGc2AiB09iCQ0az9k+ciaBTLKwKDRogt5+WeanAEHGQm7xODULyUBlVYaRxN
         YIvDlX0bu3/rpvbUsv2I3MjmTr5DsLpVmnk6GOh+CXD87qT0nfUrnA3ATSq1p0FPH7Xn
         GaZBgtjA72IEqtmgFimYh7mUghZQr5Vl7LIEfhOMPDmZxPfOpeXvf0sYQl+EYdb/u1C5
         GW06H+EmtkuAE3HJOEkIT5t2ydEFp/k8vMasBqHjZetaA6VlxqpaCegt5MUf6v8zRv/e
         dlOA==
X-Gm-Message-State: AO0yUKWKqvzJIprAJItxsztxR+sfmq7lnjMsSP3cLhjQqc9fnQS4rpZb
        DzA1qWRv7T/qc2nHPniYTgeqeg==
X-Google-Smtp-Source: AK7set9ZL+h5Ih6YWjvFiX0L4adEoDVpuqr7PReh+RMuFCV91yflLtTVzqywSFgp+6zswQ2pScIOaQ==
X-Received: by 2002:a05:600c:19cc:b0:3dc:48ab:d8f8 with SMTP id u12-20020a05600c19cc00b003dc48abd8f8mr13739438wmq.0.1675191083438;
        Tue, 31 Jan 2023 10:51:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c341500b003da28dfdedcsm10925140wmp.5.2023.01.31.10.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:51:23 -0800 (PST)
Message-ID: <63fd0037-0994-bbfd-6b99-f9dcd095cbca@linaro.org>
Date:   Tue, 31 Jan 2023 19:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/6] dt-bindings: hypervisor: Add dt-bindings for VMBus
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-6-git-send-email-ssengar@linux.microsoft.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1675188609-20913-6-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 19:10, Saurabh Sengar wrote:
> Add dt-bindings for Hyper-V VMBus
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  .../bindings/hypervisor/msft,vmbus.yaml       | 50 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  1 +
>  3 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml b/Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
> new file mode 100644
> index 000000000000..8f50d6097c48
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hypervisor/msft,vmbus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsoft Hyper-V VMBus device tree bindings

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

(other places as well...)

Best regards,
Krzysztof

