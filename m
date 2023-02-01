Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3716868AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjBAOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjBAOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:43:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B98930EB7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:43:16 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o18so8058998wrj.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 06:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dC2Rf+qs0P/jrCe9msdGE8AkAgDIJW5HtHWs9aRUyUM=;
        b=ibXFxt9BRYojnFB5aMpK5zHfRUr3rTuXK8gbzrbbANcmXrBoR3/gZFAibr8X/eCyvG
         nZM2qAouhLUMXlBtMMSSx22Q2Wh+QbUCfXVemidC222OvyJrgcpA2z3s6d0cGPUOooas
         KfadIZ9z7m0x69PB9tFiOVfdYU/Ynba6LssKc07/efXQ255RPM8osrkZf3G4oXwnvGyJ
         hPqhdqdZrA0LkIDPCzL+aAsGQ5LcfPAg6yvUiSx1EiXVR2TfIplLZtYvjZQgZgA2SNw9
         E4SeopzvVb5y0LGJbxCZzJvQtw6EmxbQvpnV2Je6RJhpaZj7HrcpJgIWti8ZHGNrppvk
         gd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dC2Rf+qs0P/jrCe9msdGE8AkAgDIJW5HtHWs9aRUyUM=;
        b=srkzZPzhz82Yfoogl6AXVoJHB7s6wDKWjucWul8D4ovcCOyXxUu+2I2XAxqK5LoO/K
         j7CfpB8fL2uQsRflUnVARqz0vtNl1962JUykbm/nWlxKF9pbe46D46RLCaSHfKsAoSUx
         Wl1a9v65+S9AmMA4svM3eBDX5/Szds/HJN/CoK/tgNFpB1S93APEPz22VB1W5l3WHKwd
         SA/JjbbCdJ7v+KD8N492J69tIBWUY6N6bzkbgTBX6yq37q+0FQ6oP8G4KjhJclOFxkwx
         kEYA5gddQxmqHykLaPVsAYOS2MUBRGljJI3Zc/BBWFSFaff/2Wf77u5wHU33hpkcFEnE
         mQBw==
X-Gm-Message-State: AO0yUKVDJTP1PhkzYLsKfsRlG77/jClFJE1e7r/+s6BCrM7Bw6uu928y
        N0aKxlkbTEk60Ff5UTxVIYrkJg==
X-Google-Smtp-Source: AK7set8PI06q3hLefAX/yzLn2ALEYmydTMRpaxfh4uUmHXpFyC9Y/mCBDAhLTB1c6A+QZNC14bxd6A==
X-Received: by 2002:adf:d1e9:0:b0:2bf:9543:2bea with SMTP id g9-20020adfd1e9000000b002bf95432beamr3759674wrd.35.1675262594646;
        Wed, 01 Feb 2023 06:43:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r8-20020adfda48000000b002be25db0b7bsm17513102wrl.10.2023.02.01.06.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 06:43:14 -0800 (PST)
Message-ID: <6491d6fb-2a10-1c80-d422-8300d5a75ce4@linaro.org>
Date:   Wed, 1 Feb 2023 15:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303 binding
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kiseok Jo <kiseok.jo@irondevice.com>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
 <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
 <Y9pxGUMWyMeXQpZM@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y9pxGUMWyMeXQpZM@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 15:03, Mark Brown wrote:
> On Wed, Feb 01, 2023 at 02:13:46PM +0100, Krzysztof Kozlowski wrote:
>> On 01/02/2023 14:10, Krzysztof Kozlowski wrote:
> 
>>> Because the binding:
>>> 1. Was never tested,
>>> 2. Was never sent to Devicetree maintainers,
>>> 3. Is entirely broken and wrong, so it would have to be almost rewritten
>>>    from scratch,
>>> 4. It does not match the driver, IOW, the binding is fake.
> 
>> I understand that in general we tend to fix, not just to revert. But the
>> poor quality of this binding and the next patch, which was suppose to
>> fix it, plus complete lack of testing, means I do not believe the author
>> will send correct binding.
> 
>> More over, fixing binding might require dropping incorrect properties,
>> thus changing the driver. I am not willing to do that, I doubt that
>> anyone has the time for it.
> 
> It is an absolutely trivial binding as is, it is utterly
> disproportionate to delete both the binding and the driver to fix
> whatever it is that the issues you're seeing are (I can't really tell
> TBH).  Undocumented properties are a separate thing but again a revert
> is obviously disproportionate here, glancing at the driver the code is
> all well enough separated and can have default values.  Looking again I
> did miss the sysclk selection which should be dropped, clocks should use
> the clock bindings.
> 
>> It's the job of submitter to work on it.
> 
> It's also not the end of the world if we have a driver that isn't
> perfect.
> 
> Please, try to keep things constructive.

I tried. I started writing patch to fix few things in this binding and
then noticed that it is entirely empty and documents nothing.

The trouble is that soon you will send it to Linus and then it becomes
the ABI even though no one ever approved or reviewed the actual ABI.

Best regards,
Krzysztof

