Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6326480E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLIKZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLIKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:25:08 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8066ACC3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:25:07 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id l8so4437882ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 02:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOtIGgZTz5rbWK4rKV6rRYl3mDfMnPMz6gg/QMTk5+s=;
        b=fpqPNTBFrz3Kr6CGm/v4qrfW0ytpkSBQnJoYu/xu94TX+HKWocL6JG8Bv9J55AlL0Y
         sVCUCM46l4bmxNGYjXL4jmFElfXPJBeGQ4FnrkZpZNNcuE2NGPrMvZV2izXLPNxB5PjD
         I8OceDB5hNBHXAs9uoIZ/bZTe7iMxufAyv8d1tqPHQPvN9n8VQ3sRjxG0A2LwBv0znCq
         Xc8q4gvTglbhMR78591Oij9Y+Xe88fVEoWf/6Dq5c6NYIbtX7KsPx3N7U8RMFzzZdqYE
         zJWqVSA4jFVGla+lfMEcwkbOUngMGMDSRKDG+nenEjmIgRky6y2CrXsekH8hsCfQGNhF
         +LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOtIGgZTz5rbWK4rKV6rRYl3mDfMnPMz6gg/QMTk5+s=;
        b=N4Hzt8R6II7MNBgUSaKe4UdvR1ZwEC44PWT8em0YdnLU0sA/D93I8Y3oXjaQ2oIedO
         OaXHA5MxmWbezticz8cvx5Lsa7m2+XtCzGQxX1WLuYaNF4HQDSQ5qdo6GBhgpGiNmVft
         rSritx25zA4Ll1FdQhV+S3UStY53Yk1CJiRYh4KGuH/rxse4sc0q1pFCo8h2mSA4BNoj
         dIU5o6pH86PdyOtt8Ro0pOVqnT3eDyFKT8lbR7tZQVk02bHjI9Y6jVBuCQOHlc7EbF6B
         +bWFHvYEclHOWldFeUEfcAfdUb15DkLMhTHegT9UURAp1BhqRb6Po1S8OINMywayWF00
         VXyA==
X-Gm-Message-State: ANoB5pmImiX5/YtLqvl0kEWNk5ELDaEqTvuMaGn66TVtkEvBf+vg1qGa
        U/Ay2ahKNOq7CC9Hr08PBom3fQ==
X-Google-Smtp-Source: AA0mqf4+jUvlgJI+n9wtlOuqyiLa1j1wItLezrUSNRCfZRwesZZuIJ1dWG5Dq1rYhfTM13TUIXf3cA==
X-Received: by 2002:a2e:868e:0:b0:279:8056:8b07 with SMTP id l14-20020a2e868e000000b0027980568b07mr1126121lji.20.1670581505222;
        Fri, 09 Dec 2022 02:25:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t2-20020a2e7802000000b0027741daec09sm158243ljc.107.2022.12.09.02.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 02:25:04 -0800 (PST)
Message-ID: <c0b660bf-93c2-89b6-e704-17489efe6840@linaro.org>
Date:   Fri, 9 Dec 2022 11:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org>
 <20221202155738.383301-2-krzysztof.kozlowski@linaro.org>
 <CAD=FV=UPLssDromnt89RYbSEU9qq_t+CSyd5VhmD7b-9JkcMFA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UPLssDromnt89RYbSEU9qq_t+CSyd5VhmD7b-9JkcMFA@mail.gmail.com>
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

On 02/12/2022 17:53, Doug Anderson wrote:
> Hi,
> 
> On Fri, Dec 2, 2022 at 7:57 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> DT schema expects TLMM pin configuration nodes to be named with
>> '-state' suffix and their optional children with '-pins' suffix.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Doug Anderson <dianders@chromium.org>
>>
>> Tested on Qualcomm RB3. Please kndly test a bit more on other devices.
>> This should not have an functional impact.
>>
>> Changes since v2:
>> 1. Bring back UART6 4-pin bias/drive strength to DTSI.
> 
> Just to be clear, it doesn't actually belong in the DTSI, but it was
> there before your patch and it's fine if your patch series doesn't fix
> the whole world. I'm OK with this one staying in the DTSI for now just
> to keep things simpler.
> 
> One change missing in v3 that I would have expected based on our
> discussion in the previous version would be to "Add UART3 4-pin mux
> settings for use in db845c." I think you said you would do this, but I
> don't see it done.

Hm, I don't recall that. Changing db845c to usage of RTS/CTS is
independent problem, not related to fixes or aligning with DT schema.

Best regards,
Krzysztof

