Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4732687830
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjBBJDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjBBJDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:03:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D357212A7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:03:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k16so826488wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7F5YTzHrVyr8QuuHkXVmJUZpVCaBRGUSFsoCx+3N03A=;
        b=YRPfCH+G/7MHufVPyLtQ5D6FdhMqwLFJYSOac8c/Rj1F2Jbm+ohgMFD5UqVOzA9n+N
         zXg/aNARZWYNUeouOB6k/YqLD3EfqO1J6wzwMs+J7FuaMnQwn+DU/qRwvsoQZanwlmA3
         sfAPy1q3gHeva2N+wieTu4yxYo9TCnFXGLrt8aokgh0ChRIAqMfcVuJiLhmcsDXXfqK8
         HQTXR7anVDaTR/8M+X3+cVq/DYB051MgGJ/tNGPkixjwlPM5aZOjMiMDO6ExEwZAffRZ
         XojjWXnGuUNdEZx4ai8C7958LsMP3SdayNjk08nH6vVeSksYfzLeqTMYKwxrJbifaNbP
         I5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F5YTzHrVyr8QuuHkXVmJUZpVCaBRGUSFsoCx+3N03A=;
        b=h3hfEoQDR4TGSDlVul6tZW4SqFQGtdY4N7BBeZU3D0UKW40T/ZaZkwKxu87gDlSTN5
         J5xUgH550AyNcZImxTV2WvvTaMz+oqV4Zcji46Swx6iLrDOuIm8BAAmhVvASr7AAJSlh
         eEYkOIqdpCmWs3pmsPgqejhL7IhFmIAZZPh44/e2uugCNJ6saNBKMGmc+R7Q5NBhEQ0t
         y0gQF+0P8s83RL2JlRDKJN8aXtmO97yEp6XwjcodVoRI1BWvjlsfwmZkM5GaU+u5h2R3
         19Br9Z38ZgnwKBISho650g/FnlUW6Hljm4Xq8PcocEQwf2vQeCu8jfEFh1AMXA+c03Vg
         wx6A==
X-Gm-Message-State: AO0yUKX3KeR8c3p84qbFIv9RKtZ30KO+ZgR1jhjqNX6DDy296cJFFr8V
        U23tq9MPhahoWDEJmuIxTROLDQ==
X-Google-Smtp-Source: AK7set9lAC5MNe/nu7qxCknw/Oxh/cCzvtvfddKrsencwwfHUr3rd+VCW9H823WXjZIkxGD/S6ERcg==
X-Received: by 2002:a05:600c:4f03:b0:3dd:e86e:8827 with SMTP id l3-20020a05600c4f0300b003dde86e8827mr5019102wmq.4.1675328613859;
        Thu, 02 Feb 2023 01:03:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ip23-20020a05600ca69700b003dc59d6f2f8sm3877475wmb.17.2023.02.02.01.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:03:33 -0800 (PST)
Message-ID: <a21e7783-cb1c-8fec-78e7-bdffcd5e25f1@linaro.org>
Date:   Thu, 2 Feb 2023 10:03:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303 binding
Content-Language: en-US
To:     Ki-Seok Jo <kiseok.jo@irondevice.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
 <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
 <Y9pxGUMWyMeXQpZM@sirena.org.uk>
 <6491d6fb-2a10-1c80-d422-8300d5a75ce4@linaro.org>
 <Y9p+p6wt8WugDBuH@sirena.org.uk>
 <SLXP216MB00776F066D70DB2F3F77B09E8CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
 <SLXP216MB0077228B6071F62B183F4D648CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
 <6439a587-0b65-a037-1013-b697e19000a4@linaro.org>
 <SLXP216MB0077847FB6CF0EF4511E3A628CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SLXP216MB0077847FB6CF0EF4511E3A628CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
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

On 02/02/2023 09:58, Ki-Seok Jo wrote:
>>> Is there anything else I should do?
>>
>> Correct the binding:
>> 1. Add all properties - just open example-schema and your file and
>> document everything 2. Fix non-existing reference (there is no such file
>> as name-prefix.yaml) 3. i2c_bus -> i2c
> 
> Fortunately, I modified the 3thigns you said, and I also tested with the
> above command with the contents.
> 
> So, I'll send the patch file again.
> If it has any other problems, please give me feedback.

My revert was not applied, thus please send incremental fix to the bindings.

Best regards,
Krzysztof

