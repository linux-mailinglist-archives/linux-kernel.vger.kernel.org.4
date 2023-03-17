Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD17E6BE981
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCQMlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCQMlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:41:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9413B85A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:40:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er8so8090613edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679056849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdfsyAZ8ebq/tYreK/csP/pvOMbudUDFDkVltciv0uI=;
        b=DmKCuYf57JxQkvV+oLSMw/3rwVLdO7+tezGzmiFu2UkO2yOD68Ip/2c9FyYX9hPkq4
         abXeKYtJpIvWFgpswGgMf9ZnwEVuQnQiWTixr93uOH6IxffVVcB+QNRTMUzQJCdzYR6D
         6XbgMKVqfsWHyrMD7wVr3ue8C5CYVc8UYEZYq0Jxt0lUQROxIiQnX4pv/imU4sKvsf28
         bYyM+OUB3ohBoEkciJF4M9EmmfxDNwILJyx5OdTtpPuAlJz/gZZolC/Et+eTLB2Bdvv7
         q3y+VSM9UBngg6C/6aEriqfHuVG9zZbBnl2rRmiKzTUd1HpAs2e62MP+NX7TTniyNI4u
         8dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdfsyAZ8ebq/tYreK/csP/pvOMbudUDFDkVltciv0uI=;
        b=MdoW1sHiE3Bc4AlfG1szNfhHl1qf3oWOU/m4MzNwH5rTL4TggXz/pGbX30tA/IYLex
         MoC9OEq+gosWQKuGylqsE3JBNbnNFYy2s1CKFNGXNEyocQH3QSoPMS6SUTmn1onl0Qax
         LREHx4eZAY4J4247sTexNFnW0f1swYZZ4PuPFFIxNsAANuPSnfmWVyU4M2zShmQfA3nT
         g9jaILf307Z/vA4u3vJO8TrGAFzH53UWjuL/jFA3+HrlSPN1N5Ma3evGeun1lcuZgZhT
         Y+t9DDuDf/aEL+W3jPXFxY00rXp9jKkYUHDkYIloA/TYGL1dAJx8gi0qWeWOAn5G3kBu
         sdOw==
X-Gm-Message-State: AO0yUKVOTl1x1UMexYVyMDgGP9i/uufiAyaDNy/Jhhi8MfYCOu7UNcLu
        iTpdkm5/G6IDUEtTaWdXsKh+iQ==
X-Google-Smtp-Source: AK7set+V3e2JzutohwFlOeDNYQueNhcUfJCbnZtB2g+Wl5NQZpHl9n0X9hbbpdxrXm05AQ+lCva1XQ==
X-Received: by 2002:a17:906:3986:b0:91f:32f9:82f0 with SMTP id h6-20020a170906398600b0091f32f982f0mr13762286eje.29.1679056849465;
        Fri, 17 Mar 2023 05:40:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d013:3eeb:7658:cec? ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id yj8-20020a170907708800b00930170bc292sm941591ejb.22.2023.03.17.05.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:40:49 -0700 (PDT)
Message-ID: <cce4f28e-075d-137d-3f64-6bfd4074be72@linaro.org>
Date:   Fri, 17 Mar 2023 13:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: cavium: Fix GICv3 ITS nodes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Richter <rric@kernel.org>, SoC Team <soc@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230208185506.2305349-1-robh@kernel.org>
 <CAL_JsqLz9mtsOr1sTB+eAxGOsZFthrLV-LbFBW7o7RdwgLCBZQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqLz9mtsOr1sTB+eAxGOsZFthrLV-LbFBW7o7RdwgLCBZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 20:51, Rob Herring wrote:
> On Wed, Feb 8, 2023 at 12:55 PM Rob Herring <robh@kernel.org> wrote:
>>
>> The GICv3 ITS is an MSI controller, therefore its node name should be
>> 'msi-controller'. The ITS node is also expected to have '#msi-cells'.
>> Add it on Thunder as there are no users. Thunder2 uses 'msi-parent', but
>> Robin says that should be 'msi-map' instead and I'm not sure what's
>> correct for it.
>>
>> The unit-addresses of both the ITS and main GIC node on thunder2 are also
>> wrong, so fix them while we're here.
>>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  arch/arm64/boot/dts/cavium/thunder-88xx.dtsi  | 3 ++-
>>  arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi | 4 ++--
>>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> Ping!
> 
> Should we remove these platforms instead if they aren't maintained?

5 weeks should be enough... Applied with my other cleanups.

Best regards,
Krzysztof

