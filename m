Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FFC698E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBPIQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBPIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:16:02 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0656F2449A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:16:01 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id b2so3198263ejz.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUKG5YPhru70hIY0uF2wn2wEXa9HKzbQaUOh/EWXtKE=;
        b=TviBwG1j/4T74Vy5Q6UPni7S2+k88DB0D9XxQuZPZ3KxBM6rmpF6ejlSi7F9MJPGZI
         VtDzQ+ZLdUhLt9yF/yoMkJEdDt9PGO01fOVFuPUp7FudOFGBR+d+K6Z81gx0quW7LdaK
         aKeCWpx1thXc+SxM5UjxbR8Xvng8gU1PhdSyo5RcTu5uJEtyeYTyw9oA+Loeuk0Rxb/8
         53xcK6jF7OaaYuqfl/f+KJu3Q9N6MQUJza5K+UxS8H468npU1g5pJZHtTCeb0Wy8oOxZ
         YdMEN98CfqUjWYrIkhfK7U6lb7h82Kq/f3Q/gS/bOacLGpxcBFdFFPtN2u1HZpiTuoiy
         FldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUKG5YPhru70hIY0uF2wn2wEXa9HKzbQaUOh/EWXtKE=;
        b=T+UGQsKEed6x1/maLK7QP5FD4loH8FibRkGG0GsiD2xDZ/NvLcXwsJ48SfCeHPddgI
         hl9mMQXE0NIrLYI8TFGOQPbp1O6ZkZAz8pLInUXelC2efgBLjhEYCMDuGXTT0uHk77Dp
         E7o8XlV0Cb1oE39OyM7vYRjFb1A3+xZ43503A6JSbln2rgznWbElOcARRBB/U5PyW4f+
         vP30DdE7Md0/grGFixh+3F60e5QEO50fSIJiV2uHROpfRZJyM+yA4yGcZucK0u6fW5a0
         DpBbndUHlOsTtZFOpXsG4tVb0r7REcUfwcneavRm7F2tFn9MuUpJSPNErVqckXcKQTGt
         JB3Q==
X-Gm-Message-State: AO0yUKUkvszX64aCxvyqUj5JroyGUUsUnb+vBvP3oC+GSoXk3jgVXjIM
        z/zoYFRKFkF7zEg90m44GgGYNw==
X-Google-Smtp-Source: AK7set9NqBS/MqufYv5CckvhPlTpKHEyZXD1IaqYeAqa8KMVWLtyfPIOV1bTl9tEMBgo6Lcejy4AYA==
X-Received: by 2002:a17:906:68c7:b0:8a6:93a4:c892 with SMTP id y7-20020a17090668c700b008a693a4c892mr5133777ejr.44.1676535359466;
        Thu, 16 Feb 2023 00:15:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906395800b008b1315bff9fsm480986eje.148.2023.02.16.00.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 00:15:58 -0800 (PST)
Message-ID: <fa013fbc-dc54-6d20-7935-2ce01afc37be@linaro.org>
Date:   Thu, 16 Feb 2023 09:15:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] dt-bindings: hwlock: sun6i: Add missing names
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Bastian Germann <bage@debian.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20230213231931.6546-1-bage@debian.org>
 <20230213231931.6546-3-bage@debian.org> <20230214104554.35338faa@posteo.net>
 <43336959-643d-4041-d11a-b0c030fbf050@linaro.org>
 <20230214181138.4a8f4beb@donnerap.cambridge.arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214181138.4a8f4beb@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 19:11, Andre Przywara wrote:
> On Tue, 14 Feb 2023 13:37:20 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> Hi Krzysztof,
> 
>> On 14/02/2023 10:45, Wilken Gottwalt wrote:
>>> On Tue, 14 Feb 2023 00:19:29 +0100
>>> Bastian Germann <bage@debian.org> wrote:
>>>   
>>>> The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names
>>>> and reset-names set to "ahb" as required by the driver.  
>>>
>>> Hmm, this one is a bit odd. If you look into my earlier versions of the
>>> patchset, you may notice, that I actually included these bindings and they
>>> were refused. I think the argumentation was like
>>> "there is only one bus = no need for it".
>>>
>>> If it gets accepted now, I really like to know why. (It was some trouble
>>> back then to get the documentation properly done and accepted.)  
>>
>> The clock names and resent names are not correct. They should have never
>> been added. If you got comments about this and did not update driver,
>> that's not nice. You just shoved incomplete bindings. :(
>>
>> So indeed to avoid precedence - people pushing fake bindings and
>> avoiding review - NAK on this.
> 
> Maybe it's just me, but I don't think this tone is necessary.
> 
> Wilken's original submission was correct. Later there was a comment just
> on the binding patch, to remove the not needed clock-names and reset-names
> properties. But there was not a word in there that the driver requires
> changing as well, and I don't think it's fair to blame Wilken on this, or
> somewhat even implying intention. There were several patch revisions after
> this was raised, and this just slipped through review. But surely no one
> wanted this or pushed for that.

I would say it is quite obvious. Otherwise you could remove entire
binding and still submit the driver, right? Isn't the entire point of
the binding to match what the driver is doing, as it is the description
of interface used by driver towards DTS?

> 
> If anything, it tells us that we should be more careful when merging
> drivers without users: if there would have been a DT patch, possibly even
> a consumer, this would have been flagged by dtbs_check.

Sure. To me it tells - this patch is a no-go and driver should be fixed.

Best regards,
Krzysztof

