Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339406E221E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDNL2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNL2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:28:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429375B93
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:28:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so1848948a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681471719; x=1684063719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aiRpESCbLxQk+SHaAMEqLmff7Uno7K02X/hy0RYyko=;
        b=dl3Hg++Qv6HfQT/L9JjS5DV2rWbm0glWZt1wU9yWmWgajcJZlOzZzJLa+8AONcugzk
         7pS5VpouSIAQ3edfaPssbx5NVRdQbtCjDh5YISgKCabxnDoLPq93amDKmL1mQpOjIBBN
         MFwdFn2f6zQ9PDGvEDiM5GVPXZqzMJUQPrnSHVeMPzIlC7mUptjMKlEe0ZXHFK5PMFGV
         zznUTSnKxEmIjt01wKa0FyQdcdD5Apmo+kePLjt0EysiN+++oq5u/8XfOZl9wVmn70WK
         5qw+oPQCyJpbo5IO0ML3LsNRW11hsI19uepOIwSn2ZZjQh3cVKslxbKkUHGVXWoq7EDd
         Qg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471719; x=1684063719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aiRpESCbLxQk+SHaAMEqLmff7Uno7K02X/hy0RYyko=;
        b=AF0W7HNe1NNimN+I0CBuAhHfmOVq/Kzxh8RKEm5B5V0oQjPpxqLA5UrBAVEhnQA6PR
         Ira/+Rl55FgMUN+TbpKDAM4SDERgQ0bt+FQeVYJDIg+A6aFY8JwHjRS9YsIOFZMSlmX2
         6VHGXXi0outVkRqnG82yW9P192ZLsB4ROkVwPm7fUV3Qhc+fr9QvhUV6v4UqLudnTLvE
         wOcBHEdPfDCTh+mFjmigU1yGqQ7I8vfKZjKVyaZY6IiSgiYKkjtiRqa8d9FmkfBO9joo
         rLB+cq2/Zr2VNTzjWs5rlHaK681Qy7Bfudke2f+VuKX5Ygeyd0xCdiRYrzTBlypeIAoC
         W0ng==
X-Gm-Message-State: AAQBX9eWOni1DTO9LEwANpwZOjdYdVB2z6+DNHwynXCDBXEWu4t2zXCl
        1YINqkW5kQqCaEktrd9+jkHUhQ==
X-Google-Smtp-Source: AKy350a3Sy2CqykR/sk8IhliNFf2Djv54ny9JClOEK+yPtCZ5o7ogUd06Gii/jIrfmuVUmcNljWjSw==
X-Received: by 2002:aa7:d7d4:0:b0:504:8c1a:70db with SMTP id e20-20020aa7d7d4000000b005048c1a70dbmr6581398eds.32.1681471718716;
        Fri, 14 Apr 2023 04:28:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:40b9:8c57:b112:651d? ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id w15-20020aa7da4f000000b00504890a0de5sm2023467eds.34.2023.04.14.04.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 04:28:38 -0700 (PDT)
Message-ID: <3f6d77cc-5a9b-47b4-db41-5fd172d2ecb6@linaro.org>
Date:   Fri, 14 Apr 2023 13:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Use generic name for es8316 on
 rk3588-rock-5b
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230414093411.113787-1-cristian.ciocaltea@collabora.com>
 <20230414093411.113787-3-cristian.ciocaltea@collabora.com>
 <fe746692-fed3-6635-8658-4e91d30f2aa8@linaro.org>
 <4d66fb01-76da-be30-26dd-908ee1a22eb1@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4d66fb01-76da-be30-26dd-908ee1a22eb1@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:53, Cristian Ciocaltea wrote:
> On 4/14/23 13:26, Krzysztof Kozlowski wrote:
>> On 14/04/2023 11:34, Cristian Ciocaltea wrote:
>>> Use generic 'audio-codec' name for es8316 node on Rock 5B board.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> index 62750beb12aa..8cc97d146a73 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> @@ -72,7 +72,7 @@ hym8563: rtc@51 {
>>>  &i2c7 {
>>>  	status = "okay";
>>>  
>>> -	es8316: es8316@11 {
>>> +	es8316: audio-codec@11 {
>>
>> This is a trivial change. Fix all instances in all subarch/platform DTS.
>> Not board-per-board.
> 
> Looks like only the rockchip DTS are affected, but not quite sure how to 
> proceed in the case of 'es8316: codec@', should I change them to 
> 'es8316: audio-codec@' as well?
> 
> arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts:   es8316: es8316@11 {

No, fix only this.

Best regards,
Krzysztof

