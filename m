Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA16294A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiKOJoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbiKOJoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:44:19 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710D922B31
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:44:17 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id s24so16766126ljs.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R4Ips1YGy+CHLyynMFYhlMgSLuyCrOKw2tPYJgbqJY4=;
        b=NYq7B521o3+lx3bjT+9ZWWyhf+ndDyFYtrcc08K9F1XcPZFOubB/b10S7HPmEJFK87
         NvReoIrl0pXUnqZ/NCz57RKnrfBThapX6rPe6YGRq42lcG6UgOrSDJEV+0CRfE4AbZG3
         iTjM+An+M3MSaE0NHZQiqyyeyvCfklX7WvY7eN5ADaUn11fjYAdXAXmTBSGSvPNUbUp4
         ZjhzQdXVvw0WIV7t+F291nrJeGpKyyCJCMQSCqXjEsjEsiH58DPH00mLs3Sw1fA4HBlF
         r0ZGvrK/hhvLa+jx8l6VAQ9ieNYNMbyJHypbEpMLYqEeFuD2G0RnB/ekBskLjYMxs/kI
         B0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4Ips1YGy+CHLyynMFYhlMgSLuyCrOKw2tPYJgbqJY4=;
        b=IQA8NhanDLgb1EtFYV9yYc+tOozBfFZE48/bTrfp7I3jTZMy5y9Gc0+pizzatTwDr7
         G81STqm8RthNnawrGm90lwrXauh5nWudohzowBM4uqJzscsMYIoIqZZBFLbZCYfzzxGk
         8wTMPADhdx+x6rzV5jNE+3lwxQmjedmBT0IAmN0ZI2uI0lTlkKUBW8BanGMuNcGMg2IQ
         VjSB1vH5ggGw+CKv1qg/1E+WA+gnf4YZDP8xkHB8PmzEUM1UCR7NK8LkROzRYV//cObK
         f7SLzoqvrPq+n6ka6ecLLgIAzhnXI/gKY+rrBjnTZKZTb5b0QF1J6cVSefM6kzaTUcn2
         oGuw==
X-Gm-Message-State: ANoB5pnGixmBbLvcysovvbnylnPcesRK2yxWCGTg8sAhU9TV6HhmeLJ7
        QFwYegfsUEej7FKqBM3C1sXlsQ==
X-Google-Smtp-Source: AA0mqf6u4AeCi7RO3VOcejjZExMxdA7pzHStUekHmSISGlloupdeeNGR4Qq/SbkkH5VWHZ5DE0PGyw==
X-Received: by 2002:a2e:9316:0:b0:277:831:3970 with SMTP id e22-20020a2e9316000000b0027708313970mr5188812ljh.331.1668505456145;
        Tue, 15 Nov 2022 01:44:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m20-20020a056512359400b00498fc3d4cfdsm2155447lfr.189.2022.11.15.01.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:44:15 -0800 (PST)
Message-ID: <b32baf1c-e00b-ca1d-2294-bde11c61e5cd@linaro.org>
Date:   Tue, 15 Nov 2022 10:44:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 06/15] dt-bindings: usb: mediatek,mtk-xhci: add MT8365
 SoC bindings
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-7-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115025421.59847-7-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 03:54, Bernhard Rosenkränzer wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add binding documentation for the MT8365 SoC.
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


Also:
Drop second, redundant "bindings" from subject.

Best regards,
Krzysztof

