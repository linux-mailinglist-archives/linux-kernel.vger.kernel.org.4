Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB16716DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjARJAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjARI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:59:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30CF10433
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:17:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n7so7002434wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5CDdoCUnCUysD4OwVm5x8AKmJcxld25F1lQaxRj+UE=;
        b=EsaEmOoj/k5hWYVjzW4wymx3f62KDXfpdzhsx0vO65rwsFrA+poJW2jsK6zGT+xXoH
         rbq/Yms8ZK0EGiUaZqM6luB0uS21dzPoPAkOVY9u9y9ezrG+9wCSnuQ5SQHLnhM3GgVN
         B5w7wMLLDYaHUBH8SdHPka1xEFAgmgFAcaAzkVWDMEesOhVTFnosQ8eX6reNJf1igI4A
         tFA4KJpQvkiM5GNLdqooZUWLarVAEqR9yOg0Mp+cMJqcLaxsFs61HCJqGE3fbfIPk1Ha
         McC6WDlEKw1zN6WKcBI58mxObiE7nYHTjs8WGvpYgo0LU9iSXC4xsPAUdicr5BWW7o4n
         MKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5CDdoCUnCUysD4OwVm5x8AKmJcxld25F1lQaxRj+UE=;
        b=6hyq8+60V8cpHBh/zwEOazaYE4oGY+XTyBOZuGlfCw/MhgtnRLKPw8PBZTsQ5F/a5D
         bl6bR3FoVyyHT/hW6PdynQH1HhrHix2mc3gWWJCM6sgPhvsKgAXpsaLIrRbYgisDKg13
         uEr13yVDcrdteU5QSqTowjpOtwZgfJYz7Eh9ftiIQDF96Y4y4437l/qEfDt55k6IZwVc
         Zi9M1bWpZCrCSyrXLXhEveyRMpLeeGxv6tohKoIGb6TIJImyVXFvg9u9dJxiMEstLPBm
         ERQDHzqkjHm7eT1tth1QILvgbqNrkROr2Q3WzK8wDjhRDHmV0GzJngpVPgNmskZ64LGP
         8obw==
X-Gm-Message-State: AFqh2krHuVt6Msr7j4+wVJC0KdZ3BAbA1wUBnWVkd1CPDYLF90taxcGs
        AgGuodtk5e2B7pug46vIpl9Wig==
X-Google-Smtp-Source: AMrXdXsrGhBFxvpmGjjvtTlnHTlkVNbgpbSMNOaiPhI0paRO2JgxMEJbIW6PDkO2ecInUF59pt+Kww==
X-Received: by 2002:a05:6000:1f0f:b0:2b4:e5e:c0a3 with SMTP id bv15-20020a0560001f0f00b002b40e5ec0a3mr1566357wrb.21.1674029833248;
        Wed, 18 Jan 2023 00:17:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d62c7000000b002bbeda3809csm24778523wrv.11.2023.01.18.00.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:17:12 -0800 (PST)
Message-ID: <5378f107-7676-d8c6-5bd4-d82fe12fdbe5@linaro.org>
Date:   Wed, 18 Jan 2023 09:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/9] dt-bindings: usb: Add device id for Genesys Logic
 hub controller
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118044418.875-1-linux.amoon@gmail.com>
 <20230118044418.875-2-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118044418.875-2-linux.amoon@gmail.com>
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

On 18/01/2023 05:44, Anand Moon wrote:
> Add usb hub device id for Genesys Logic, Inc. GL852G Hub USB 2.0
> root hub.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2: - drop the vendor name from compatible string.
>     - drop the -OTG and -QFN76 suffix from commit message.
>     - drop the GL3523 USB 3.1 root hub device id.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

