Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11EB669051
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbjAMIN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbjAMINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:13:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB526B596
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:11:28 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f34so32000646lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEJhgr96OjUhNUOMZ8epomwf58coghZC2G6Ls6wpmxw=;
        b=oXqsThDc2ggzQ08OZiDaCOE/ulACWi9Vm7rZIKlHA2bgRmJ+Qf3J7vRzEOU4jIphc1
         Th2trV1Stt7Mjgrmbcq4DxmwCcFIRSv9gnt3ypmHBjG9Evg+BLufOhKVAZ7N+XVREvbc
         BMGxl6pTXc2HktJrQsxvkxB39md9k22A5IALJ8hPybGa8M/ZRVUgMrSus+FR1hDnw9ql
         4GKT8P6V2pwiCK9yMdPxM31PP+AA0wZcI0wdPi2zLq15YQS+/zI5fyyookWwRHKRysQh
         Uc5HmTk9325F8wr/W+2/q24oLM34M1z2jTjrvZ0N9rUJAktYIUMphxF5PFV1W9FCtNPQ
         AUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEJhgr96OjUhNUOMZ8epomwf58coghZC2G6Ls6wpmxw=;
        b=RkCP27UDSspx+HOfFngRir4PIDgV6EcpCHB6abB6/Sr5TRJegwbfwYUHyxudACJuB1
         53WLcxO0daLVk+UjqrI6PGf05PXYxFC3udMhI0MzbA6+fae7jxl4OAdawAB5AaCHrrg8
         NL7vnhLf3kZQkl6ffAI2i0Isx9aG1JMBAQh55B5EbrYMIaiUG3xKKe5cofyn15VPhWiS
         AccH0TnDfiMIRQ5c+H39vvbbEwlukVbfSnSivgsjTmbyMcrX8ljo8oVd9nDqyrh90GlN
         aMTCBF77kbaEvAu9no+/Q4PQ3AiTUFpj9eCH/cLF03uiUyBSPTse3gM8n2zYjy3JGQdf
         8pdg==
X-Gm-Message-State: AFqh2kq1xFRQ9iyIcDVWWk0Udds6RU8AO0Ff634QVwlJstzueFMgOsOo
        3GqzqCkiEfU5nzggB2mreVkYIQ==
X-Google-Smtp-Source: AMrXdXtb0Gb+cB6bSgqO0q/wA6znyb539VOV6vT2ir08hkLscrRVMISFcShEGBk3avDMfxQghrdpJw==
X-Received: by 2002:a05:6512:39cd:b0:4cc:53e3:771d with SMTP id k13-20020a05651239cd00b004cc53e3771dmr10486219lfu.64.1673597486819;
        Fri, 13 Jan 2023 00:11:26 -0800 (PST)
Received: from [192.168.2.31] ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id u6-20020a05651220c600b004cc865fdfdfsm2334386lfr.89.2023.01.13.00.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:11:26 -0800 (PST)
Message-ID: <742800ee-34d9-3455-06d9-d2e15c44e176@linaro.org>
Date:   Fri, 13 Jan 2023 10:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: add display port audio
Content-Language: en-GB
To:     Judy Hsiao <judyhsiao@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221221071734.2887901-1-judyhsiao@chromium.org>
 <afd7851b-0846-c21f-a769-10fb920c7c80@linaro.org>
 <CAJXt+b8eez8KTocoAi0WP8qC3YdA9bfOTPbY8ZGfXNb-MNaT-Q@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAJXt+b8eez8KTocoAi0WP8qC3YdA9bfOTPbY8ZGfXNb-MNaT-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 03:24, Judy Hsiao wrote:
>> Why do you change link@1 from DP to ALC?
> Because I want make the order to be consistent with the 3 mic version. Thanks!
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi

This should be explained in the commit message. And as Krzysztof wrote, 
it should be explained, rather than mentioning some other platform.

>>
>> Best regards,
>> Krzysztof
>>

-- 
With best wishes
Dmitry

