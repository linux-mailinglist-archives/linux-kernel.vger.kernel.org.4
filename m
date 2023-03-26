Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E966C9727
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjCZRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjCZRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:23:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E649CD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:23:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so26638820edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679851382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c//xVZOdC41tPmentwWhVn74VlOQ2hi6ybonN1NbtRc=;
        b=P5oihEOZTfjDDQazKlVVdjx4zRYICuik+HNXkq4KfUiIgmkyUjzcSoq0RbOFrpL2kJ
         iRgdkV0/sORCmsUTedpMqaSxA9bVoLczQdGYO+nPWqxkVTzGXT84f5fSZEyaZEk1kZFx
         Me+/6H7Ip+mRTV3HjXzqObHBOY+N+apq+aKDp9bSIyYOW0JGFmWpVpscbYAl8xUBxVKI
         14yALPGawyV0I6TRVY7j/2WyIrBpgrDKxXLv3qnJBrG1Ji9Xqv5SZ3bDaitbm9h5Y9Y+
         LzJlK15aj7VBFKzRnKexRbl8xDnBq1JzDNt1Cb1QbddBEIxbPN5RTaBUSRT2gIA7LB4i
         66bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679851382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c//xVZOdC41tPmentwWhVn74VlOQ2hi6ybonN1NbtRc=;
        b=RpdrdGEdLfqmeLpcsixi+XJOhfAfSPWPOGYG65YNCNAh1yj5pdp4DNWnSvedeCpS57
         8coyIsfQfmfiZNm5QRm6JY2fsTtVANUy9rVSWdPyYkPEjwRXRKW4chxrL6MaWaD7wc7c
         8236Sj08qYKwCp9CTITWezEOMDaNijud/lw79aBVCEGyAJGKo1IO43B36ID7jSwcYySM
         89h/kZOaqwl3e9XYJ5VI1wLkeRMB0jTamB+j1W2m62N8f/L1UFcOyzVtZV0fwitrYnuM
         LJ9Nch246RtVQ+sAGVpfWkAxlyHZD2HLdcvS9VsoX+j5VCJqvwCGwZJNLZipwjUak2ne
         RSSQ==
X-Gm-Message-State: AAQBX9eUF8XJf/VUg7bkIActVeq2zs7rWJk2I6c3ysvzCIOI8MY+VGnt
        /TfknpS+DY4AQvNHIcd09QCiGQ==
X-Google-Smtp-Source: AKy350ZkwalKYzOBxeo21t+SzzcLhWq4fDH4NUP1+KX7mCHqW39g5Wrdbos4r+2xR6xaXE5O8wC5oA==
X-Received: by 2002:aa7:ccc7:0:b0:4fc:709f:7ab0 with SMTP id y7-20020aa7ccc7000000b004fc709f7ab0mr10239236edt.0.1679851381850;
        Sun, 26 Mar 2023 10:23:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eca3:3b8f:823b:2669? ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id e25-20020a50d4d9000000b004c10b4f9ebesm13699097edj.15.2023.03.26.10.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 10:23:01 -0700 (PDT)
Message-ID: <717bfba9-1d70-ef09-9193-853a57117926@linaro.org>
Date:   Sun, 26 Mar 2023 19:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
To:     Shane Francis <bigbeeshane@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326001535.149539-2-bigbeeshane@gmail.com>
 <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
 <CABnpCuCzdbWTTp1Gc6wWPsB80J5GYw1QzKtZzzyEYU456E=1JA@mail.gmail.com>
 <1b9c8e19-10f2-824d-9b50-51e7a9287bb1@linaro.org>
 <CABnpCuAWm7jh19JKukOquPnZCwHoJispgDPGJzjYy6T_BZSnbg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABnpCuAWm7jh19JKukOquPnZCwHoJispgDPGJzjYy6T_BZSnbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 18:59, Shane Francis wrote:
> Hi Krzysztof
> 
> 
>> So mention this in the commit msg.
> 
>> Then commit msg should also mention it.
> 
> Sorry for not expanding on this more in the initial commit message, I will
> expand on this in the next patch set.
> 
> However I think in general for most modern platforms it can be assumed
> that replacing the bootloader is not always something that is achievable
> for one reason or another

Bootloader also does not use mainline DTS, so where is exactly the problem?

Best regards,
Krzysztof

