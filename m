Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0B5B9DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIOOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiIOOq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:46:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC758B7A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:46:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so6743346lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AGYhLBK5MSu4nlYE38/3ZKhX68k6E7tf3J/hrxENfXs=;
        b=rpZUuAgkZgkOjflUiWTZwd+GkSbdnhZjLkU0OETEYgL08O6D1xhJlen9gERv+BxelT
         /8BVBnibVun9LB8UkpDRfxmYNfT+K8doUZ1FiYbYvQDK6l+mu6JoGW5k2i3OEN3XLd6h
         mgOEzDQpnm+eXJ5deTLa+ru/Ngz64gRRYdcw2UPNNy0h7PK5u+fdUoje+ILuKWiDDsTu
         SE7j7xTSi/EkhtkEROFfF4Je34W6PGSUY2dgIPN1sit9/C1Wv7UmDWN0fMYOOX0Sr8Hs
         hIHYQ3pTQEt7ZWq7OBmMNFTS6eeqZl+g0c/QvP4qeHJ3FwWuqa2r3HgL/Bg8J4nmbfMy
         AOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AGYhLBK5MSu4nlYE38/3ZKhX68k6E7tf3J/hrxENfXs=;
        b=1kO178e+l4IvvUsACInUxitZg2WRzAED/veLNO2qdie8VSj6d7AoMbbjF6Zh+PbTpE
         YQMnR6zcI7qGmX+gPa5N2n3xMVH/ovPVSkXNaJG2BZrM/fZO2JbbvDbGobX+hIrZNGG3
         cmsFD5XGl2ZBaAnvO0HMScxarr2BmKjO6ij4baZ0TleBWBbufU8aRhYts5aMJqrx8coD
         UTXfLg+Wdx5mAEWVzzpgM5U0KcN1B+27qrIEosMdrm8+1mYK0NQqfhhs3vEUL1+PVk0e
         oUbGuSxjup1hx4sgBhA/N4RImdBoO8wpCINzsGpwJ/Ou+eE1mW1tfeWADqT9H1fmJYqg
         NHmw==
X-Gm-Message-State: ACrzQf1hihJ3U9D2YGLeBp2UNO4hmRzbkJsQuSCjIzsQ0nIqf6v62F+E
        GCZLil9VsF9LvhWBTlT+ZoR1Bg==
X-Google-Smtp-Source: AMsMyM6sTVqBhiHgRPSFWFJfdv6mwloF+nJ/A4e7ioKumbOT+oAyNzVGHqJY4u3N4UmUmYMrcLrvlw==
X-Received: by 2002:a05:6512:3184:b0:49d:6b29:201c with SMTP id i4-20020a056512318400b0049d6b29201cmr80443lfe.363.1663253213308;
        Thu, 15 Sep 2022 07:46:53 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y15-20020a19914f000000b0049487818dd9sm3003927lfj.60.2022.09.15.07.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 07:46:52 -0700 (PDT)
Message-ID: <2e941f23-e951-f952-5c0f-fc2946a189b5@linaro.org>
Date:   Thu, 15 Sep 2022 17:46:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 1/2] mfd: qcom-spmi-pmic: convert hex numbers lowercase
Content-Language: en-GB
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220915113523.44074-1-luca.weiss@fairphone.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220915113523.44074-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 14:35, Luca Weiss wrote:
> There are some IDs that are written in uppercase. For consistency
> convert them to lowercase.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> Changes since v2:
> * Split out to separate patch
> 
>   include/soc/qcom/qcom-spmi-pmic.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

-- 
With best wishes
Dmitry

