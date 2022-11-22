Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E36336A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiKVIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiKVIHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:07:40 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113D2220D7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:07:36 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a15so17064583ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdIkh5FeSoZ8vG2Py8Ie8AdpYwxDaXFSiRuPe0OKxvM=;
        b=m5+q7lTyIb8KkrkhnClVZg69k6pi3OIIzeCcggOo/2b7fe+FKVZ5zZQsqTxcFvcrDr
         4mp1ixyHnqgxYEzNof2EYaVrexjqMLGVz1MfvArmzAZnN9v/1e0s/7VUz13Nbf9fOIeY
         QcPHA/uf19lhAXXfZVaSPQHngrp9FjhoxyOvaQmwe9RL8hoKZjSXc3c27X6O/AXdaiiW
         zdjJSJWHNaCBXv9uC48c4IC6Ph0Ew7MYE9pymwLwvDutl8d+z+UN9uy6/PQKdsWui6Ts
         YbEktCw0J2ukUMbAgaRHlRsMxg8WliXuAvCOCYJEWDEwXeYL7GK+pbGs44v/RVvj/n0O
         TzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdIkh5FeSoZ8vG2Py8Ie8AdpYwxDaXFSiRuPe0OKxvM=;
        b=EnhPLVDkb0pHggvXRi063NVdes96Zlh1DzYN0IuMixStuJs/juWrrZPeXg+5Uyv7/D
         MIXOV4LKT3ygsM0qgcTX13e/21H6hKhLCLmRStMkLR2dSUCf948w6kH6jqdfeKVQZqAM
         TtG/IZFF1NDzf4LOLbZvKQfxnifQDBSYYD4IXtygLlpdttEkMu7PL3hJnlDxjmpRejk4
         x4TZ6xeDCzbbQb1pyF2JCpq5c6yT+NVkF/z+y/gcGpsXh49ZDvK0gScVIjKthwgu5rxL
         IUIZFVsTuwMoxA0On3KvYT5h3azoUyqw24+cT+ncwqKN9VHtB9uZjy2A3UXsMo6czLJ8
         tbPA==
X-Gm-Message-State: ANoB5pmWbNMFBQlaN68TyqShSFcLz1OCPcNKX19z52Q+Oc8SLCWQmrNq
        kPM9HjIYsvRWQYNTzr0xS5fhog==
X-Google-Smtp-Source: AA0mqf44ISQxoEcJpXAmn7cIhtH0mCpcVETxgWhH+HtfH/H9FR/axCBi1Ql68qW6Mti0P4kTAPSdlg==
X-Received: by 2002:a2e:bd81:0:b0:26f:9736:bd5f with SMTP id o1-20020a2ebd81000000b0026f9736bd5fmr6787783ljq.285.1669104454750;
        Tue, 22 Nov 2022 00:07:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s15-20020a056512214f00b004a8b9c68735sm2380745lfr.102.2022.11.22.00.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:07:34 -0800 (PST)
Message-ID: <15374b92-335e-051b-790e-eef39a62b20d@linaro.org>
Date:   Tue, 22 Nov 2022 09:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCHv3 4/9] dt-bindings: arm: rockchip: add RK3588 EVB1
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221121175814.68927-1-sebastian.reichel@collabora.com>
 <20221121175814.68927-5-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121175814.68927-5-sebastian.reichel@collabora.com>
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

On 21/11/2022 18:58, Sebastian Reichel wrote:
> Add DT binding documentation for the Rockchip RK3588 EVB1.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

