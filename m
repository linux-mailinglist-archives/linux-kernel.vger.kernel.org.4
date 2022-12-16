Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC1064E9D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLPK6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLPK6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:58:40 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231C733C15
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:58:40 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so2868803lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVJpKmqfc75gvy1Z50KnGNDLe2BU4CCyVDTSkolvh5U=;
        b=GTH5VXht+LUVhVD4aiQbpvosHo19veTLjxLnnhc4l3jyFskwcw+y2XqDD7hrJNuPiJ
         ZceDWQlYpDbuOG3mJp88TnZ5d8utsea4yDTzW7m+J+oILl/AVK13luoaTyJnPIpk6KXV
         Qfctmz6JoIL6vaD7lHv9Cr75MvmwHzz9pKqQpPFWYbr5pN9iZ46Gpma+Hk9MJY8/DGn3
         guLTL+gJNeBvCai9fYeYPPVmJeOfEuI7/r/1kxTTrDSdbPlAwZWWk8qEZptMBkK23o/F
         eDcnOsXUH5jhaCm7oXoWzvPjI780NnDjo+ZPdJ8tLgO6WwiLw0QFwZIOJtpelnSlkESc
         yEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVJpKmqfc75gvy1Z50KnGNDLe2BU4CCyVDTSkolvh5U=;
        b=C3NpFzLTcJTQuKgsMsZNr88OaAOEy9ARUJKW0bacCnBXFxAjGMqKUmB2hBMyd3N8xE
         COr/Aaafitr7HFnoWioegK2dgeW52li1B/m3KF4E5riYvCYaiBs2pCkqL6RmaQKF7N3S
         N32x2qfjcVbwwDbpByhkhRwqpALtr/3JABP/SdLA0DV6lr40xfvxNFXRcd/TPnJv4IHX
         mAMDD145k7KASb4xZgjZJbU4lHaEZuQK4BIP9x2eGA+k+Vsp+pxXKsmm5dGewH0cZGC5
         lfdWvdQLAV5Wvo6UEAQgD5QRT4TsfNk4AK3InqljVwmIt7TjJDRtO3oZQYhq+3j0riMA
         UCnQ==
X-Gm-Message-State: ANoB5pn07i5ka3SfykvwI5I65kGWAgKe6RLGg4vscB5qgVHK5Qj4gath
        KjJm0bHTSwold2eynIZkee006w==
X-Google-Smtp-Source: AA0mqf7KaaxHndY+Tb6alrKKxdHUig3JmTRuspaG46BrfUxehq2Cv44HHpYc4kJwqPQg9utm8NEgCA==
X-Received: by 2002:a05:6512:2586:b0:4b5:2eb9:8d3 with SMTP id bf6-20020a056512258600b004b52eb908d3mr8322317lfb.19.1671188318546;
        Fri, 16 Dec 2022 02:58:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f10-20020a19ae0a000000b004b40f2e25d3sm188358lfc.122.2022.12.16.02.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 02:58:38 -0800 (PST)
Message-ID: <e7f8b106-b71e-eac9-c2a0-83579382f0f4@linaro.org>
Date:   Fri, 16 Dec 2022 11:58:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: mt8183: kukui: Split out keyboard node and
 describe detachables
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220527045353.2483042-1-hsinyi@chromium.org>
 <CAJMQK-jWwDm4dy-ELzJ5gzLby37Ztqn9qhGT9zqFhmowdok51g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJMQK-jWwDm4dy-ELzJ5gzLby37Ztqn9qhGT9zqFhmowdok51g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 11:54, Hsin-Yi Wang wrote:
> On Fri, May 27, 2022 at 12:54 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>
>> Kukui devices krane, kodana, and kakadu use detachable keyboards, which
>> only have switches to be registered.
>>
>> Change the keyboard node's compatible of those boards to the newly
>> introduced "google,cros-ec-keyb-switches", which won't include matrix
>> properties.
>>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> ---
> 
> hi Matthias,
> 
> Kindly ping on this patch. Thanks.

It's a merge window, so for what do you ping now?

Best regards,
Krzysztof

