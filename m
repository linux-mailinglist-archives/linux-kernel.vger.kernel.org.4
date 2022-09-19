Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336C65BC333
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiISG6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiISG6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:58:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140951CFF4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:58:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f14so44458717lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HixeEijgNdIfC96l5GNmM/ip3I7jc6GLlC/pGYJiNe0=;
        b=DUXv11xaW6oMqERHnBM7YEDFc0tGNDWY3rhOtm1JxwWar9ZNHZrSE4S7NMpm+8Yfop
         +rb3g4YutPawjYnK7H0D+AD+e+uh0+7u4Hv4HvuYbjIk0xK7XNHXwfmEWeBGLqZ29l66
         EVzkLTXDiyW9G3bhW+82POdEpJnkSZ2RWkHJrC+hcEevzfSUx4nbZ6xtVFRhwCbauucq
         NTjBuM3OG7TVNyWKekKqdQhkYPUSCbjIcERHVXvkzGsGMETfYtaOKpyzDNgT2mEeEfUn
         eeVSqsy15SNWZPtgSpT5H54q4viBIE9B6umjQg4cTSde3g4HlUh4hLvYDu1in4YGvHLH
         BcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HixeEijgNdIfC96l5GNmM/ip3I7jc6GLlC/pGYJiNe0=;
        b=fmckFoIc75Xh6RgAVfTUVNSYWGpzaXJpL8PH5pZ0RGSGJKmOwbR8zUGeR34bkDnOiR
         7qaJqONuADAZZ00MFfF4g3ekbpsft6c4zA1E+d8x/gBnsfwvkvVdFtkLmMmnJJz40mNm
         LJWZliQ9FHlgFpNu2Hr4Byu59gS1VaDhfVAkv5hsGN6GTXAXVueyOps7poO3+ObrNWac
         pgzs71vrE4vDRcQOzv5aCoeMb/lGcP1PZaa9ShWlF4M03WpGAU2r618ncim58rUech8j
         f1L+qbNntck6vQg9DWFEXFZt1GrWy+PAkVAoZxZl/4F0KXApVxW8OnEPqkC8CvPCCSc6
         cZ+w==
X-Gm-Message-State: ACrzQf19QMEyec47EiGxIBhkIVeTPw2/ZOqDRe2oVsfXZ/qkrfJQU02D
        /yRUZGHWOZ46LKc5t9Sc23TPtQ==
X-Google-Smtp-Source: AMsMyM5nZRKY7/6eiAda7e78HT4hWua3cDCMp6gdnKVGnPVMSuONGWGJSGCo4ZZQuN/ESUWvErWucQ==
X-Received: by 2002:a05:6512:3b23:b0:49f:59db:62fa with SMTP id f35-20020a0565123b2300b0049f59db62famr4623020lfv.79.1663570678448;
        Sun, 18 Sep 2022 23:57:58 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e16-20020a05651236d000b00498ff4ae746sm5046224lfs.294.2022.09.18.23.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 23:57:57 -0700 (PDT)
Message-ID: <40700e39-9791-d2ad-8563-0ba2da982e10@linaro.org>
Date:   Mon, 19 Sep 2022 08:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] dt-bindings: clock: convert rockchip,rk3128-cru.txt to
 YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     zhangqing@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <4e69a06d-7b53-ab48-1e50-2b29ff3a54e6@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4e69a06d-7b53-ab48-1e50-2b29ff3a54e6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2022 16:29, Johan Jonker wrote:
> Convert rockchip,rk3128-cru.txt to YAML.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V3:
>   Fix xin24m clock-names position
> 
> Changed V2:
>   Use SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   Add more clocks
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
