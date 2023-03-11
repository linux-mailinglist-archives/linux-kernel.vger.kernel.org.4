Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0086B5D99
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 16:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCKP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 10:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCKP6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 10:58:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFAC1E2AA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:58:23 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g10so3589321eda.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678550301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEY3ZLSWUW7XsIa9CCPgTwpcYQffLbl3wrMRUOgD69k=;
        b=U7zIRT3w4Gv+arQEt90+L156snTB3qQ7nhF7QSJ2KRFlNYZ/PAOH8MeUnXLU924LKc
         ZTASA0Ws0xccVJqD2659J6Tnnk7/lPGpxlotNfnAZSSn/peKEVWUPwYa7za8DIXpygYB
         ew6sBga2mr/bVVHDlTGvInBQSSwSQFDDPKwpgh63nhs4v8MIi8LZl3lqnoxUVL12NB/E
         jrac9V5e90uLJ5OXdVcFStCb3G9ovMYUYN4gNGnkRJ7+8rN/Kk9rWgw/s/z2YLBFowHO
         CYT+GaBxCxWVC1QIRxAP1BqeJiDrsWuj1EHb8mXnVFfSdVDAflWNH9jRAOg2+VQF5Cdr
         Zemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678550301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEY3ZLSWUW7XsIa9CCPgTwpcYQffLbl3wrMRUOgD69k=;
        b=ZcaODhnATIwWa4X5lW2WVoJLf3dQBZmlEaw3X5/5J/KXxGdE0SYX1HUd3KuDTKRv1A
         8AwMz1Cj/9GpDgCLF/LCShTfF6TovOIqksh5eT2tB0Qnqv3wSN9B8QzBlUCah/S6k4Ny
         W7th6iIC1qn/QIfuFXy/I6ZtJwJ+VGodbPNvCoqjKiMTNgEP77kp7l6JLVATFKVGRt/9
         texdsnEHEt0dV+ZVdNxolbLd/D+v5QjaxlE6Y+JTjIwO04/8x9TZjpCEnT+hmwlSVOW5
         TYGGDPttECCjGlNYp7SjmYa+ecqYAgzv+RFQDctGzIUfuaek3engpM9yjbD32/9F+XJe
         Q2tA==
X-Gm-Message-State: AO0yUKVREZ3IsPC86YonrXa9MoC62lch4mEwXFL5tb+8MiuhF5RyAIxc
        UccuV3UByqIQ6oBw8UqNx/GgPg==
X-Google-Smtp-Source: AK7set/rTX6aOjV6jOMdTk7oGqNeQp6gP4Q+ddlQbe8TtUA4b1Cv3eKDysAuVFJnI87ZZwYWwojCAg==
X-Received: by 2002:aa7:ce05:0:b0:4ac:bab1:feee with SMTP id d5-20020aa7ce05000000b004acbab1feeemr23294992edv.24.1678550301639;
        Sat, 11 Mar 2023 07:58:21 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:6927:e94d:fc63:9d6e? ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id h14-20020a50c38e000000b004fa610895b5sm865948edf.7.2023.03.11.07.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 07:58:21 -0800 (PST)
Message-ID: <4b6b7aee-bd20-208f-1743-ff76388feffd@linaro.org>
Date:   Sat, 11 Mar 2023 16:58:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <640c80ff.050a0220.2983.0b8d@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640c80ff.050a0220.2983.0b8d@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 13:54, Sergey Lisov wrote:
> ---
>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++

I received your patches twice, so I already responded to one thread. The
comments apply also here.

Best regards,
Krzysztof

