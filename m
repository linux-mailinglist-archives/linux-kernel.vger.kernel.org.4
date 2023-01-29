Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8649467FE60
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 11:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjA2K7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 05:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2K7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 05:59:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C404219
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:59:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k16so6240448wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zi+I11015NCUz0N7y9W3Jr+WUdrxDX5W6xHsycXDzg=;
        b=gk6FTivk4VcbuaMCSGe81Shm6BZrMVLoA/c6PNQ8p73ukV1e8JohvkLCIet2jVxVsS
         JRgrsChaBxFOcU12ZvDkpqiOYtYm6eSgPAr4z2NwPjWCQuAR2z97Gz1Vr+GNqF7DM2KS
         uHqvi4cA+E+bJKAo7bPQjJmj8ugcHP2aBlIg5Fyus2uBCLEbTzOPkPl/RDkSPOnBLuz/
         +wuZf3xRdn8qMqj2+Rc2ipNCHwhFHn0mgq42G+iAEkyxFkk/PSvKyXv+WKiVvGbpY4uQ
         9uiN0AcA4n7uFo791Paac1O24+9lxsksbfYd7YsDklQezwB43/JcRVHgPIO5E8ia6Itr
         UJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zi+I11015NCUz0N7y9W3Jr+WUdrxDX5W6xHsycXDzg=;
        b=2s6nOZq4p0osrrMWsWGf58pKXtoTRnm6Xvyrp5Si/d9DwvIxaemMI6HtZU7LX+TcUN
         N2DPOiMK8yoZXQG09v6qddHBgQUyjOACkQw3LkqcvYHwWSPWm43VLVwi0VXBo25WOW9g
         f9kRbEFOJyrntSGanrIOXd/y/mOWTz4s/VwkZ83U4QS55SEfuJmJeaXflbUYNddMmoEe
         Yko8wnRXYHxOvj61Ku3mkxEJlsue91qIQZSDxvCJbsHdKmbe3Vwu3/8XAcRsmXNcYw+b
         iYdUEvVxrPzU3SN9HTGkHuzfjaKE+gSWFlEl+wRCh2nUfssv78BwS4aZPv4YjFmyu+BZ
         kZIw==
X-Gm-Message-State: AFqh2koX2LoKfzr+dHzVOIk/+46Epbf6Shri8zbteRhipOLYUmVQ34lX
        xhwJ9pD8JuPLeYbnQZg0rz/tnQ==
X-Google-Smtp-Source: AMrXdXvKeCcJ+95HZDpXVnnwC9DcVbaPjo0HvSb+0omSgwO9b7m6BRzYzDDtVF1EHm+W2nUkVgfyfw==
X-Received: by 2002:a05:600c:4395:b0:3c6:f7ff:6f87 with SMTP id e21-20020a05600c439500b003c6f7ff6f87mr44584001wmn.11.1674989949734;
        Sun, 29 Jan 2023 02:59:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b003dab77aa911sm15240955wms.23.2023.01.29.02.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 02:59:09 -0800 (PST)
Message-ID: <b43f26c9-f76c-c898-aadc-ce3ee7b7823d@linaro.org>
Date:   Sun, 29 Jan 2023 11:58:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: mmc: Add cap-aggressive-pm property
To:     Hermes Zhang <chenhuiz@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230129023630.830764-1-chenhuiz@axis.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230129023630.830764-1-chenhuiz@axis.com>
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

On 29/01/2023 03:36, Hermes Zhang wrote:
> This commit add a new property: cap-aggressive-pm to enable the

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> MMC_CAP_AGGRESSIVE_PM feature for (e)MMC/SD power saving.

Why this is a property suitable for DT? IOW, why this isn't enabled always?

> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Best regards,
Krzysztof

