Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE205FC5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJLM6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJLM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:58:21 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD94CC45AE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:58:20 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id mg6so10812977qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnfLH1uWZM93WnOCm/j3uIYB90yqvfJmq8bZxGsy+kc=;
        b=bH9us0saWKJQhA1kWT+vjoJW/+MSU1ic6wzQjV9QVFsbI3TcBrQuuJZh3xjEm4f81/
         eAGrKd/w5yeMAeReTuqMd7v/KkHwN3FV3fyfR9uJejV6DwvTrW4RGK0cvn2ibR3CQ6fQ
         IaB66scH892vFJSAK1xZ+4vFs5J46bMJI5pcjdfZbJAXmLF4+DOkDBvjJ5hA/PUlDu2a
         oDIEyD6mdc33E5LDd5iZ951AzEkN3m7lXBv8fC00ap3yF2/Cm3KDoKqnSEoIPk0RSIpz
         ABQMK3GOtNd5cluoYOYpu4Odo+f3xbPGHhLFKaX0lKXldZF33B4bSGAF9VfMEOmEBDR0
         XwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnfLH1uWZM93WnOCm/j3uIYB90yqvfJmq8bZxGsy+kc=;
        b=qAVd+kJI5fnH9d79n+WnMzMzCmoHIwADDrYKykAMXyhmN2sxda8XtB6fAHvcl5lbK6
         caZWTbjN/j9Otm08O55ZJRBC8C7UgREzuAobcjowhPrQ1waCwk4jNtUOj21fa272dmH8
         idijzyBHNCzxreHZyvLZT2tw10qSSbl9wFF2vIkSX+jhAxFCbQYy4G5NHEmrupWlWHDD
         U/xFKEJ9dvUkNVz7u7Dn+B8wi0vbLScABTm1rTItPYpKNjJwCEYpjoyiAZX6obSlMe/B
         1++aENh2v1u9mD/mZZHWKSJqzZpQxTBDjau/EgZVoVvfjaOZ8MpJaOfCbZ2ntkGVYU4P
         8LYw==
X-Gm-Message-State: ACrzQf0bwsP2vl5Dn0317ZB2n9AFHfrKrI6dKrJEKvOm6Vplsn3zHsI7
        RXjxYk7EbK6+wGPF7rK7AiBFWA==
X-Google-Smtp-Source: AMsMyM4g/HhyeEiE7hqMEnGkibS/RP//a3WhquctLtW5wccxFEO5/bzMLDqE97UGNpAEEYvXTcrcQg==
X-Received: by 2002:a0c:e04e:0:b0:4b1:cae6:4b0a with SMTP id y14-20020a0ce04e000000b004b1cae64b0amr22874277qvk.121.1665579499909;
        Wed, 12 Oct 2022 05:58:19 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a430a00b006e702033b15sm15449244qko.66.2022.10.12.05.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 05:58:19 -0700 (PDT)
Message-ID: <be6586ab-8a4e-91cd-cc30-81d49e6d4616@linaro.org>
Date:   Wed, 12 Oct 2022 08:58:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [Patch v3 02/15] dt-bindings: media: s5p-mfc: Add mfcv12 variant
Content-Language: en-US
To:     aakarsh jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
 <CGME20221011125145epcas5p4f9d2656c8b91d7bb6a51989afa49120d@epcas5p4.samsung.com>
 <20221011122516.32135-3-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011122516.32135-3-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 08:25, aakarsh jain wrote:
> From: Smitha T Murthy <smitha.t@samsung.com>
> 
> Add Tesla FSD MFC(MFC v12) compatible.


Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

