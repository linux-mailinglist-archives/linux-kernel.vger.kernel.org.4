Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB407365B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjFTIG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjFTIGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:06:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2444912C;
        Tue, 20 Jun 2023 01:06:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f7deee339dso5319739e87.0;
        Tue, 20 Jun 2023 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687248381; x=1689840381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+inFlG1QWKjrrXswQCdliXKK/JRx4YOgAjgRQSu/iY=;
        b=CDq4kcHFj7gXvDWsR5MDMtOLIRdaweAQlZcfiLmu8p9/HDCuhqtmJLbTIZ0EbsN0Z8
         nkxa00OAxyyL+wz4p8+7K+VTtwu7bRB/bDinSYBYXf3buONcbmY1jNnDGFTIZ1/ZpSUY
         r/hHYmT4XSu5/14jDszVMfm+IcWt9Jbv2+TY07NxPeFlFDBVu/lhphWIAstMdWHXpGWj
         AqcQx3aj1qfDOy0IqNXOC5JJlpM5gUivnhdnUv+Xv4kaTz+kxZymlojNWsoJB9ZIjUA9
         AbKATJuAJSpdtkRmhFhiy6wKP1AeTcrkpvnBMLuWluARACcov+HNnUZJQOo+WJ92ff0M
         xvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687248381; x=1689840381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+inFlG1QWKjrrXswQCdliXKK/JRx4YOgAjgRQSu/iY=;
        b=X2ntPh0wSR3g66IM6boFDr12upMr+xh4ZRUzRR0m/SWKhURIqirAQt8q3ZjN/GNfz4
         cHXRanXk/sc7os6rfU5w4SBf9HL5gZQ2eprISrNQ+BdQK7CbtoYiNHP37V0crhxuFPa1
         28Laqs7YD8MQkBhyrmAVDN5ITrXYYvVoVnrAycAEc09bC0qSSSKhYdGIqPybn/xlyiYj
         RkiA7wE0mQQWEIdboEslgwx6/hP5jFC+ORp/6E2jctRSOEEYyWabcb1ie2Os3TvfsEpg
         680N7Ix1eyi9IZPimh+2Eylall4ClG2oSt23ZvQu0Cfl6572dKpZyavIuMPGZaMpj4aU
         QBOg==
X-Gm-Message-State: AC+VfDyg3SyXqYVSxtvADcnrydQjbkqgB4yGpnAW5s+m/bi/ep0Zuw8S
        nC/xr0VLjK5JIRFpzmnRt+M=
X-Google-Smtp-Source: ACHHUZ6Dy6gkaSpkR0pOUOdy1WDyokggP/3bdFdKO4qlktFeUG0JWqM1F6w54sXQE4Cp7mOzE9/OSQ==
X-Received: by 2002:a19:4f09:0:b0:4f8:4a87:53f1 with SMTP id d9-20020a194f09000000b004f84a8753f1mr6255702lfb.28.1687248380644;
        Tue, 20 Jun 2023 01:06:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id k11-20020ac2456b000000b004f76a1437b2sm254555lfm.289.2023.06.20.01.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 01:06:20 -0700 (PDT)
Message-ID: <ac0ea4f9-1a22-adf9-97a5-4bab4f3d162b@gmail.com>
Date:   Tue, 20 Jun 2023 11:06:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] iio: light: bd27008: Support BD27010 RGB
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1686650184.git.mazziesaccount@gmail.com>
 <327fde7f6e5e76908af474de3e348fe7626f39b2.1686651445.git.mazziesaccount@gmail.com>
 <20230617205702.29bdd84a@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230617205702.29bdd84a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/23 22:57, Jonathan Cameron wrote:
> On Tue, 13 Jun 2023 13:20:26 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BU27010 is an RGBC sensor with a flickering detection FIFO. The
>> RGBC+IR sensor functionality is largely similar to what the BU27008 has.
>> There are some notable things though:
>>    - gain setting is once again new and exotic. Now, there is 6bit gain
>>      setting where 4 of the bits are common to all channels and 2 bits
>>      can be configured separately for each channel. The BU27010 has
>>      similar "1X on other channels vs 2X on IR when selector is 0x0"
>>      gain design as BU27008 had. So, we use same gain setting policy for
>>      BU27010 as we did for BU27008 - driver sets same gain selector for all
>>      channels but shows the gains separately for all channels so users
>>      can (at least in theory) detect this 1X vs 2X madness...
>>    - BU27010 has suffled all the control register bitfields to new
>>      addresses and bit positions while still keeping the register naming
>>      same.
>>    - Some more power/reset control is added.
>>    - FIFO for "flickering detection" is added.
>>
>> The control register suffling made this slightly nasty. Still, it is
>> easier for maintenance perspective to add the BU27010 support in BU27008
>> driver because - even though the bit positions/addresses were changed -
>> most of the driver structure can be re-used. Writing own driver for
>> BU27010 would mean plenty of duplicate code albeit a tad more clarity.
>>
>> The flickering FIFO is not supported by the driver.
>>
>> Add BU27010 RGBC+IR support to rohm-bu27008 driver.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
> 
> Resulting code looks more or less fine, but there is stuff in here that
> belongs in previous patch - so send a v2 with the refactors all done
> there and just support for the new part in here.

Thanks for the review! I appreciate it. And sorry for sending a messy 
version. I'll try re-organizing the stuff between these two patches when 
re-spinning. A bit busy now as I said when replying to review of PATCH 
2/3 - but I'll see when I get a moment to rework this :) Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

