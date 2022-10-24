Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E06A60AF07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJXP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiJXP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:27:11 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367C19B64E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:13:04 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m6so6110881qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQh6en3faLQiT/yj2VP0RfsSYxaK3tAnPo5TU5fEGwc=;
        b=XQwHoUNkuA6v6mtVC0x7/Jdi2fJ+j+bLMcd4M8ZRXa84QYTdOZiBGd0W57yOnWipZF
         iLj02CJsYIfvSiuYvmr5mESSMZkJSQEFdmAj6KQGuvOU4JjCi3VORda7DJaZFFxcxBZ+
         IRoqURWQX+VqEb02VJ3rNyyfxWotJCTex0O9xRnLI+rRFpyUDSbk9BTpRuKKkNaXsh21
         FRRHX6SbEvjuN+MRg4qSYVrBLR+ecTPwchYA7BVaXvabr5vn/DGwZNIi/quj44Q6Cnt0
         /x7e8gIlUnNfwTnibxZ6sxL3TrgSYOQXqAzpLPv1ap2zBsT3jvamSehEu3hLYxlrr54B
         gHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQh6en3faLQiT/yj2VP0RfsSYxaK3tAnPo5TU5fEGwc=;
        b=VQ+FT4mQC0tqHh2IH7NYwjJQmM+xDLbV2wQIDDgSTJ6WMAfAQ3QuJtlkOg4F4knHrI
         LUqvVbfg7N3Uqrml0ZwgjzMkszzKcS3LSnmFeYgEfKETsFVakJQHCzTKTvjDjhsfyPx3
         Z7kd4oXs8rlxQWcJcpcJ8GUD8SLYeZUh/yipJL4zH7Y91bQZNdoLrlffGJZJxXq6nUgE
         jYjYypTkPzMSyk4elL71tGrQse7UCsyccpQi3RUHVoXIpKe8a5zJjXd9RsOzxdQpJJ6q
         qJuKsh7Dguimbkr8RJCXLnV5R4i5a6Pk/GYfRBF4n50FyYyTqeIaCVajzltIACpW5e0B
         OXEQ==
X-Gm-Message-State: ACrzQf0bIIQBuodMGkYJljvVqPkx7VM/XYxAlY2vMlDouQNzPK0O4ZlG
        n1WYNp3Pd/zA68V8ceEi1fAHlQ==
X-Google-Smtp-Source: AMsMyM7Qxr6BevMKOWfQdZIPH/PhEDWpoflXYfmA0OT9fJubp9WQkPM2hswnDri38ZBfuIOc8i3S6g==
X-Received: by 2002:a05:620a:29c2:b0:6ee:b27c:2a50 with SMTP id s2-20020a05620a29c200b006eeb27c2a50mr23920806qkp.485.1666620593227;
        Mon, 24 Oct 2022 07:09:53 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a0d8d00b006dfa0891397sm29980qkl.32.2022.10.24.07.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:09:52 -0700 (PDT)
Message-ID: <826176ba-d7c6-a64f-e15e-d2694571cb72@linaro.org>
Date:   Mon, 24 Oct 2022 10:09:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: add TCSR node
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221024125843.25261-1-johan+linaro@kernel.org>
 <94e05a63-e7f3-a78f-d0a6-8efcae619726@linaro.org>
 <Y1aWPhP7/ft8s+bh@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1aWPhP7/ft8s+bh@hovoldconsulting.com>
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

On 24/10/2022 09:42, Johan Hovold wrote:
> On Mon, Oct 24, 2022 at 09:34:22AM -0400, Krzysztof Kozlowski wrote:
>> On 24/10/2022 08:58, Johan Hovold wrote:
>>> Add the TCSR node which is needed for PCIe configuration.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 5 +++++
>>
>> Please send the patches together with the binding. There is no need to
>> have this split and it causes additional effort during review - lookup
>> of the binding.
> 
> I was under the impression that the dts changes should be submitted
> separately from the binding as they go through different trees. (And
> last time I posted them together the subsystem maintainer ended up
> taking also the dts changes by mistake).

Yes, that's also true. :)

> The binding has been picked up by Lee now so I posted the dts change.
> Could have added a lore link though.

This also would work and help a lot.

It depends in general on the maintainer - for example Greg does not want
to deal with individual patches, especially if DTS is just one patch and
USB would be 10 of them. Our toolset is not good for picking up 10 out
of 11. For all such cases - please provide link to lore.

If however there are just two patches - one DTS and one for maintainer -
then having them in one patchset should not cause additional effort for
the maintainer.

As you can see on the list, majority of patchsets consist of
bindings+DTS. Pretty often entire piece - bindings+driver+DTS.

Best regards,
Krzysztof

