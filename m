Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B15B9F30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIOPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIOPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:50:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70F5C97C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:50:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t7so31496721wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8FafyiLKp7Or/rqYTONtDbmDLktFN+TQm06lEnE/xp0=;
        b=UGvqViR+bEKfooxOKyl61f7zfYyQvT3UR91MaRK85zA5upl5qvDxqCoYKwJ9DbWTbK
         BXQL3kZQNfu+ZhhTwX2xaT1PBD7Pu3vnSgv12g+kYrQ2LV8GjDH8vmwFKRwZPgX+gFDW
         TBPL6AoRQG31b3E6zsUUF4ThJvDyFtPPpPzwdVXByH1tUimkdPTSP2WZPTrEOMpALbFB
         gQMlu9ZPYymNR8I1+X5iHBmP91hAAVgubxZvSgnLsYX+cRx0Lclj9mYlxbT0PYlvNFFN
         FUInwGCU7YdzwE8wrt6TGzeYpZmzNrsdnFcmv2tLFaUHqB/528M+HtMe8eYJfLm+oKOn
         RBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8FafyiLKp7Or/rqYTONtDbmDLktFN+TQm06lEnE/xp0=;
        b=brAlpRzyLtJCX4lPKOK20iz67KeM2tpcCmPSpWhLROmITJge6OO+KNQ/nounF8YjKX
         8k9ZPz5QxKVvtQ7tF/W831BqjGL303VWn9o4D2uxjKOYZTGN3KqDTwAu8tzYluxmvD0D
         uI2YUcWnoh7qg2UwLvKAo5tvzi8etXgFDLtb+sK5Y8lGAsGmQQVBhwOG88f4fMRzEDct
         rf9v9lujTfN28WkkZiyDqzLDqGvzYHQYBwnlMuEkXyFSnme/IurDR588/NTvwJ7D329k
         guUPJ7ouWWwwEU52kbtBg4Qpm4+vcel+XH0F/9aAnscTzGfLq9ICQXTYqVL78zTD7hg0
         CZpw==
X-Gm-Message-State: ACrzQf2EtE9/yfiDkfAHCNC15DYE2mPEyXr0Lvxh05JLvP3oJmwAx3lg
        Z+z/wIr/gwiU7JB6jmaAJsq7Xg==
X-Google-Smtp-Source: AMsMyM73EKanDBPB3oY8SpNYbImMYZv2oSNslZxghiuD4hWcbfKeoMv+Z3dheYOFVSWUYKvpr0r0rg==
X-Received: by 2002:a05:6000:10ca:b0:22a:3318:861f with SMTP id b10-20020a05600010ca00b0022a3318861fmr207641wrx.284.1663257040069;
        Thu, 15 Sep 2022 08:50:40 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e7-20020adfa747000000b0022878c0cc5esm2880247wrd.69.2022.09.15.08.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 08:50:39 -0700 (PDT)
Message-ID: <ca326ce8-3eee-8a7a-a522-9ffbdf7d8a82@linaro.org>
Date:   Thu, 15 Sep 2022 17:50:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: remove thermal zones
 without trips.
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220914131339.18348-1-aouledameur@baylibre.com>
 <a8af4c54-12a2-a314-f190-f12859ef4ddd@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a8af4c54-12a2-a314-f190-f12859ef4ddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 16:15, Matthias Brugger wrote:
> 
> 
> On 14/09/2022 15:13, Amjad Ouled-Ameur wrote:
>> Thermal zones without trip point are not registered by thermal core.
>>
>> tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
>> only but are not supposed to remain on DT.
>>
>> Remove the zones above and keep only cpu_thermal.
>>
> 
> My understanding is that this thermal zones exist but are not used. DTS 
> should describe the HW as it is, so I propose to add
> status = "disabled";
> to the zones.
> 

At least the trip points must be declared as stated in the bindings

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/thermal/thermal-zones.yaml#n213

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
