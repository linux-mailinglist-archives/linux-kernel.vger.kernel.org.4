Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D36240DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiKJLJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKJLJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:09:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73676CA17
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:09:14 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l11so2543869edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+zj47CxDazv5n5Weo6oSJ5S2zaBuccDAxOqSC3Ye4E=;
        b=rLIZgsq79GQmr376cwc8RVovgmgoNwJ1K1r4jQhv/hMxNnCjlRBN9GGoVZoMv2MQ8W
         Dx+7yV9A1P8d6/bNLjSZi2Mjgk7wmHr2CI8a6UWIlQ6pPKjTYLfV3l49ix5G+XNheQsg
         06rYnGdpVYHIEbIGGKSRhspas2h42odmKUfAtLwG8Y/AqQZSMOMn8XU33r1SENhFNzqf
         tS2iY2RZKUsM2ydNa1fTBdWlnR06AzMJpjo3iv7JMFlDFB3qKOyKgqGttK6oGxdfzkdq
         zsYROGlQuJfzltdIbdryGkO/mDDjJY6QbNMKt9h+wmpXcUlMbu8t4YCXSpfLOqeoTfqI
         zWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+zj47CxDazv5n5Weo6oSJ5S2zaBuccDAxOqSC3Ye4E=;
        b=q7nBVZdg2Udl+fNWssZC3ZQqnf0Ri18v+pHoDEEJgokZ3H7aejOONV9jNNgl19+H3I
         jaIdp+rl1IrgxByeJF1qNKKFGlcfvE5bmyqwQlXNTzKqxvX3CQCsidXoCw+vDJ8r2vVX
         jRRY7K+MsAUPA9aq9aw1g6XAjDro9s/ADcrG5/6JY6kLsh3p9hCO06zl/HIGOU/NsMhd
         ByircCcuhNBUaP7S+idO9dtGi/iAcQbd2o8dbU8wkHugfIwXVwl6uwtvcfjbokfZFXLe
         K+BlNXaZl0cF6InumWn36Tb5KhyDQQSGYpDHk0jcpMY9B49bsC6m8qxiGujdFPxLKZ96
         TYSA==
X-Gm-Message-State: ANoB5plSJh63XCFTw4pftb8K/KxmDegPm/5sYo+eOw9s2AULXYuU5Xbb
        Q/lKLRyCZ4GDFrsbxdxfBvZKCg==
X-Google-Smtp-Source: AA0mqf489JZ/W0OQS+ENK70ZqqTJfxAYOeGzJw0uwG/5NFavrLZIO/1J+m/WtaYIWKtWSS99ljo/tA==
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id x5-20020aa7d385000000b004618cd3b38bmr24091150edq.172.1668078553506;
        Thu, 10 Nov 2022 03:09:13 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id x6-20020a05640225c600b00463a83ce063sm8372518edb.96.2022.11.10.03.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 03:09:13 -0800 (PST)
Message-ID: <bf3e5725-8cf7-3a0e-aa9b-0b05a4507868@linaro.org>
Date:   Thu, 10 Nov 2022 12:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] dt-bindings: regulator: qcom,smd: Document PMR735a
To:     Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, patches@linaro.org,
        Rob Herring <robh+dt@kernel.org>
References: <20221109110846.45789-1-konrad.dybcio@linaro.org>
 <166807822235.115312.17138185226634439165.b4-ty@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <166807822235.115312.17138185226634439165.b4-ty@kernel.org>
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



On 10/11/2022 12:03, Mark Brown wrote:
> On Wed, 9 Nov 2022 12:08:45 +0100, Konrad Dybcio wrote:
>> PMR735a also appears to be bundled with some SMD RPM SoCs.
>> Document it.
>>
>>
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
Please apply v2 instead:

https://lore.kernel.org/linux-arm-msm/20221110091736.3344-2-konrad.dybcio@linaro.org/T/#u

Konrad
> 
> [1/2] dt-bindings: regulator: qcom,smd: Document PMR735a
>        commit: 9263c69696c8c75ef97ebf57cb4f308c4c2420ea
> [2/2] regulator: qcom_smd: Add PMR735a regulators
>        commit: 0cda8c43aa2477b7a9f9bed0adff2f34d3afc143
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
