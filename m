Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D3717B72
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjEaJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjEaJLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:11:55 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D26138
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:11:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f50a8f6dd7so2764359e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685524303; x=1688116303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+rhtjoI0oVWr4lv7CIl4YpL7WJExUtXF/mZsGUKruo=;
        b=Iy51vWIAOJEYhuMmlu7qQREiZEWb0ykWvKQrH7g08xAUjpmSTz9580hHm3zNvhwRPO
         mOOyHvchn3HQLHZwYDg3ldiYL8VsczTo0PSdfcIK6SY6nOuJjlLDoxQ1ouk7rsf7xiuD
         BSJdPpSZ23dx4Xg1VHUbo4f5Pyh44FzgERtIMQ+aLXdnI5J17cljPgvOVN+FkYh1Z+bz
         U4VcaucTXmnct4QrLcjkeGQTLHxV89MU1WwEyukaaTyraCFqrusVXJZBFmv82V1p3GLV
         hzKKAboSdcxG9c3/2ZsCLitpsJEy66ioLd0f1oKlXimzwzUhBs+NJIyosKNn0OZTeGoK
         k/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524303; x=1688116303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+rhtjoI0oVWr4lv7CIl4YpL7WJExUtXF/mZsGUKruo=;
        b=ixkXxSS2KNQ9BijxxqA0YRdgv5z00jn450guknb838fRP5IvTvJmxmdztJsx+jTUK/
         qxQvlu0EZnOKJ3fKl+lIyyXQa1SdG9iAHAQtCDo8s4n2F8MRd5DFG9HpbinuthMpFDT0
         Q3EU0h9RTXXvcsRYZ7GzZIgRm+ybGk7kBzAvBi6g6nqQBsTQcCwfmhZQZ0ZqZZEud0NC
         s9d4GwXcDWrY+9BQ1LA9DRtsfN5qYQm2GjJxYQuWIYtNqvhO4WRAe3ZmXAzIzy9E/LAM
         UUelXYSrtcMZ+aT5jVoDIQS+ufpb6fsjFG06/E5v55MEcBYWspaGJlJy5Hlk3pOmRMyI
         lh6Q==
X-Gm-Message-State: AC+VfDz9IIItzsd51a79o7UCj4FlWClHYmR7yY4Xk2mSxSkCL+xma/UQ
        heljn/O75mFNq+Ap6xOTITlETg==
X-Google-Smtp-Source: ACHHUZ6xBAZjyXT/YB/xNZ0KdSNoP9qtdld3FAw0nIeEga8FmMgG+PzrRjktTTnIcrWrcPyIGTzFqw==
X-Received: by 2002:a05:6512:243:b0:4f3:a485:919a with SMTP id b3-20020a056512024300b004f3a485919amr2147076lfo.57.1685524303455;
        Wed, 31 May 2023 02:11:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a19-20020a50ff13000000b005148f0e8568sm5124081edu.39.2023.05.31.02.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 02:11:42 -0700 (PDT)
Message-ID: <0de8cecf-ec36-9300-656b-2c073f60c407@linaro.org>
Date:   Wed, 31 May 2023 11:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/3] dt-bindings: regulator: pca9450: add pca9451a
 support
Content-Language: en-US
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Joy Zou <joy.zou@nxp.com>, ping.bai@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <20230531065724.3671795-2-joy.zou@nxp.com>
 <f343458e-519c-1e5c-e48f-acfed2c00ad7@linaro.org>
 <25e6d735-f191-68a1-84cc-d7e1ae4c3217@kontron.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <25e6d735-f191-68a1-84cc-d7e1ae4c3217@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 09:22, Frieder Schrempf wrote:
> On 31.05.23 08:56, Krzysztof Kozlowski wrote:
>> On 31/05/2023 08:57, Joy Zou wrote:
>>> Update pca9450 bindings.
>>>
>>> Signed-off-by: Joy Zou <joy.zou@nxp.com>
>>> ---
>>
>> Subject prefix is: regulator: dt-bindings: pca9450:
> 
> Is there some way to have this consistent for all subsystems? Most
> subsystems seem to use:
> 
>   dt-bindings: [subsystem]:
> 
> But some use:
> 
>   [subsystem]: dt-bindings:
> 
> Casual contributors (like me) will very often get it wrong on the first
> try. Examining the history is extra effort that could be avoided and
> often doesn't provide a definite hint as you find both variations in the
> past.
> 
> Can we standardize this and make checkpatch validate the subject line?

I understand your pain. :)

My expectation is just to have "dt-bindings:" prefix. It can be anywhere
- first or second, doesn't matter to me.

Then there is the generic rule that subsystem prefix should be the first
and here there is a disagreement between some folks. Most maintainers
either don't care or assume bindings are separate subsystem. Mark (spi,
ASoC, regulator) and media-folks say it is not separate subsystem (real
subsystem are spi, regulator etc), thus they want their subsystem name
as the first prefix. It sounds reasonable. Anyway it does not contradict
DT bindings maintainers expectation to have somewhere "dt-bindings:" prefix.

My comment was only to help you and there is no need to resend. I think
Mark when applying will drop "dt-bindings" prefix if is before
regulator, though. Life, no big deal.

Whether checkpatch can do this? Sure, quite likely, one just need some
Perl-foo to add such rule. :)

Best regards,
Krzysztof

