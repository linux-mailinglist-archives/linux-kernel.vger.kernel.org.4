Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89967E528
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjA0M2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjA0M1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:27:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260B4EF7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:27:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y1so4840683wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1BkSp8a2SvuUtTINTrnLCf7Tcv5hygrYcnbRo1GEug=;
        b=LnhV9J3Yn7Z8I53kKhiCN2RGVq7tHcF79m2NzfDjvQASZ01x/oc1znQh0iKO35lUS4
         6HrxNvG/G+Di9/IvLcs38517bVcGnJa2P2r8dZwE8I3Ahtj5kYVe3JIiK3lhgAVYTO4/
         Yq+FHOc6OkfuK7ISyUn5tEmxJPx/h14FQ9OLyCNczLk4eG9aOM6hqCadxNecyETQ6oU/
         lPWwXIAsQLeelU4iOLajsqQsLv5SaPEf5rximuX5rCIEvrNg2DzQJsKh66xTtzFmg5Rc
         Gz/VGQh3yCEDLPfW09jHbsVmTBzlWRseJ6UWSua2xDzb/EMU+IYwuGdOuQ2kt11u1dj9
         7iTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1BkSp8a2SvuUtTINTrnLCf7Tcv5hygrYcnbRo1GEug=;
        b=kix65VKdz25VKgftIHzjCcvGxQO3x2YFcSVPjAcX4Yi+5bGPVO1/ahIOiXBCjNzcPd
         decN9y+mE4AaPgeTAbiHF8eXeXCjccsKjsL9qSNYGKH4qQXkVA6YpDbDoLOi8zfCnoqF
         eLRSCH9Jd/jN0RDrerlMRKVwhACfILmBHfmMOdMEY7nbC1gFbsHJFzBlaqEidiE6yTOQ
         jUGAFSSWxbhBoNvNl+bSmnYqzwm5iDxJV58mWWAlJINsfw+AcTe1GcDdjONFhLflGf+h
         2TCuXzmj2We0iujXyUJ+UVYAiA+02beu2+P6Dfz00yIx7BJbtqjMQAw/IMBu3XvmfR05
         tj3A==
X-Gm-Message-State: AFqh2krv1/3QcI/6GbQ3CKQWc87ruv7MnFCpWW3o9RvGcS3I2HuDyHBD
        tssC44Xp5RP8zUpc3UMBuPya9g==
X-Google-Smtp-Source: AMrXdXsfp/n8e5fqT7bIHpCYgU5aavFQWhWOXmTPTYNIgN9J069wlX1RjYllTcs2QfN+Vr7R+OMVaQ==
X-Received: by 2002:a5d:43d2:0:b0:2bd:c962:cd35 with SMTP id v18-20020a5d43d2000000b002bdc962cd35mr32882981wrr.68.1674822441121;
        Fri, 27 Jan 2023 04:27:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d1-20020adfe2c1000000b002bfba730b0fsm3858826wrj.65.2023.01.27.04.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 04:27:20 -0800 (PST)
Message-ID: <d03c3234-42e0-4357-2187-19ff9c7209a0@linaro.org>
Date:   Fri, 27 Jan 2023 13:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] arm64: dts: realtek: align UART node name with bindings
Content-Language: en-US
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
References: <20230123151514.369101-1-krzysztof.kozlowski@linaro.org>
 <167481277324.62929.7688485206150758782.b4-ty@linaro.org>
 <a3ca0bd8-2153-cf69-adf3-bc92a31d0efb@suse.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a3ca0bd8-2153-cf69-adf3-bc92a31d0efb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 13:22, Andreas Färber wrote:
> On 27.01.23 10:46, Krzysztof Kozlowski wrote:
>> On Mon, 23 Jan 2023 16:15:14 +0100, Krzysztof Kozlowski wrote:
>>> Bindings expect UART/serial node names to be "serial".
>>
>> Applied, thanks!
>>
>> Let me know if anyone preferred to take it via sub-arch/SoC maintainer tree.
>> I'll drop it then.
> 
> We did have an equivalent patch in '21, from Zhen Lei of Huawei, that I 
> gave a Reviewed-by for. So should you maybe apply that original patch 
> instead?

I don't have it in my inbox... but if you reviewed it, why didn't pick
it up? Or whoever is/was the maintainer? I personally do not care about
Realtek but I do care about bindings checks to succeed without warnings.

Best regards,
Krzysztof

