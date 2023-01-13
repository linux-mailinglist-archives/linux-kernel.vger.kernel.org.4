Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500B6669E43
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjAMQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjAMQgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:36:52 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF2E84BD2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:31:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so53567075ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fL8be1/hWU/zBSKzMOQE0sbZUNNKC9C/Oi/Qs+RWgQ=;
        b=QU8UssxzfelsMsupXM2CTkukdmkHQbNcMZA1GI40K+EpSQXadIzS8WaBlsG1ALterx
         xGDWi+nZcb+BDzgN31i2uUFsrTw8ZsiVjFUqcZCw4RnaX3CqhSYPn0FW/dYSEJbPzmNf
         tH2cW+Whz3Rn6W6QqYkwTm74j+7v67Dev8fqZ9Ngqq/0ucGX+hMqaTnwL9PrxepUwEJ3
         SdtZtE0Ta+r/dolt2oZxy5neARIf+bCDA+iU6P/z1b96neDyVtRTZw4M5sXPJw/un6J0
         6uYWxK4l1PMTK3xrB63eiTSXb19Veh+HMV140Igpx4nV0yy8HwQh/ljpgWbmrkDCpf3G
         AgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fL8be1/hWU/zBSKzMOQE0sbZUNNKC9C/Oi/Qs+RWgQ=;
        b=zPKJKVAIiPYpC9P9e4MJMpFXRw6WlbOOH9ekY7XmIoou2x0srPL9evTcNeXMVbLB9d
         PwJ8etAn+UkhYBENW7yEaiCZkNGDN3uJSYrRFNnMZEHpAXwZfBVLhBm1abBfMKYHa1+i
         zPg+te2Dv3XL5awBMa4JUt/6/E9qU+Wta/cKSS9hAb5bqMXz4dK+truvfMGPSXHRVVBI
         wV1GEtwmLm8uYCqyK8NQfpqwMomaRUd7qz4C4DdZ95YYM+Zb24qmtH2APc5jSpMyeVwn
         zgBzvUV/9PBA59gsp5RobFBy4944K/pWx8p8GsjVNkmHBBoQnA755tBEUDKHJ+cIL7C+
         mREA==
X-Gm-Message-State: AFqh2kqlrvnS7p2Y9+xl9CmCym2h1gYbKYnbSUD+w/VIrzFD4WV9GYan
        xDMVdfh2HyHUbo1uSsNmSAuqPA==
X-Google-Smtp-Source: AMrXdXuNM7+hFpAqq70N7tSscaK7osTdbr2Csk1H5PBNX86/BK1dJbWmKt6EVmRZnrHQW/tXz/bV5w==
X-Received: by 2002:a17:906:5acf:b0:83f:41a2:a68b with SMTP id x15-20020a1709065acf00b0083f41a2a68bmr3450656ejs.30.1673627506147;
        Fri, 13 Jan 2023 08:31:46 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ba6-20020a0564021ac600b0045cf4f72b04sm8303139edb.94.2023.01.13.08.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 08:31:45 -0800 (PST)
Message-ID: <972fc587-be4a-d306-4e1e-7e68e37ed452@linaro.org>
Date:   Fri, 13 Jan 2023 17:31:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add Bang & Olufsen a/s
Content-Language: en-US
To:     =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     a.fatoum@pengutronix.de,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230113160102.677865-1-alvin@pqrs.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113160102.677865-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 17:01, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Bang & Olufsen a/s is a Danish designer and manufacturer of high-end
> consumer audio and home entertainment products.
> 
> The vendor prefix 'beo,' follows from the ubiquitous product naming
> scheme, e.g. Beosound Balance, Beolab 28.
> 
> https://www.bang-olufsen.com/
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>

We do not add vendor prefixes for every company in the world, there is
no need. Please bring this patch with an user.

Best regards,
Krzysztof

