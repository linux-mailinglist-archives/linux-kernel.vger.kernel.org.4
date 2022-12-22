Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697FA653F21
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiLVLhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiLVLhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:37:38 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0F928E14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:37:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p36so2289092lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3dFp/oI5Q5dQ5wwd/ulSr6dhNqL6ZqSNPqtr9kld8A=;
        b=Y+Eab9fFOqbuSpMMx9QaFXsViJH309/ale7ipzeUyetsoBLPSNm3BbbrGFKBXdDT/1
         Q8SH2+MEOAoGwVjM40B1iFPFSvDqablZBCL2vEH6tK0GacMdKICAmtrHrdZV5b1lMzUV
         ox/XX271TFp36fjcjjD7yrl/5wD+sU/pFzeQ0dOG2KcM0xoMb78yNS0EGOLcBQaOkTj3
         EyO+14jpPrYyI/RbjV2gg2OOTlBqbmp3GQQ/dqJMwshgqM4DmJWJwYFExYQ6dOKIXLG9
         Vx8JY6snphj8c5KyJGwvzXGpuFvAUGTnoTGHBVwcrPhauiyzvLw9VvU47jghvFh1edav
         B5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3dFp/oI5Q5dQ5wwd/ulSr6dhNqL6ZqSNPqtr9kld8A=;
        b=5VwiFGYpGohBuLp7HrXDlH3I2/B4nlFRPw07Xx6jvRU736PuDpGyQrnd3ty6RyONH/
         /6TyhnboLuN0mMAvJxLqSW8GZdIGwHZCxmpS83ErSzSAd/4dkXCxV0RXGN7LGeVKulb+
         FJ2Fs6SSUKv9xyIMwlqyI/lk51fYu6nKHhdDBzqFFo6J/NdpSt2hWLIU04vVU48VaGYw
         HUiNylMGlS4rsZs9ZgHtybsKuOI9Ln85LO0/0ZcfJ7PMm6ToLjs8Q/VQRDwI+Pv6PTZT
         u5Hr46ZNj7VlQtEH3QI3MjcV87h7m7a7jbRON9yvTtzF+Z02Hp/sDqqYs1Y6o+iMc6v9
         MHTA==
X-Gm-Message-State: AFqh2kruCfKtE4qp68P52hAfE2lT5ZOa314sJh3zEaRH/Vn/+pBSx7Ok
        s+2Q/qVEXqc8FHQRH/th732u0w==
X-Google-Smtp-Source: AMrXdXu5ipMG9KfK2kHMM5bFqFrJnWNtPxPN+7XKps3+Y9S/13kRFXNoin/6IB1zH/viyyNJ3MbNfQ==
X-Received: by 2002:a05:6512:1115:b0:4aa:e120:b431 with SMTP id l21-20020a056512111500b004aae120b431mr1829201lfg.38.1671709056308;
        Thu, 22 Dec 2022 03:37:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t17-20020ac243b1000000b004ac088fdfd2sm44242lfl.85.2022.12.22.03.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:37:35 -0800 (PST)
Message-ID: <db223161-a424-c4cf-09a8-ff2241fda71a@linaro.org>
Date:   Thu, 22 Dec 2022 12:37:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 09/10] memory: tegra: get number of enabled mc channels
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-10-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220160240.27494-10-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 17:02, Sumit Gupta wrote:
> Get number of MC channels which are actually enabled
> in current boot configuration.

Why? You don't do anything with it. Commit msg should give the reason of
changes.


Best regards,
Krzysztof

