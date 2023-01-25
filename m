Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44A967AF00
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjAYJ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjAYJ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:57:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3B826870
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:57:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q5so11795315wrv.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C28GHq9eGnl5C7gie+JAKtI6Ivmm07fD3qZCGDhhJD0=;
        b=apCrKMlOFE35UeCLT/45jDefh+0DGAJSPjkmuPG50sSlGr5w+2ZAWeU9HH1Q+NyJ5w
         cKkygEQ7SV2ArCItkDAEfQBwtvyYuuuT2mlux5xzqqYHfrVARXbqGBn51HkC9Bu1MDnS
         3LEJ1gdTp5iM8+REO/3Zz7HSnFGOwCNV3klEMMQlyIb3fy9pzsOojlIcPEDaazFHXDfM
         ezgL8ynmxSWcJDoIiOSDhunqVqiijYkrFsDNft+2yamXM4/+42d/adaNFPFGUhS/ebNj
         xYruzqMiu9pZ6Zr1nnD6TQd94pAZIjkhT0v1bxjk0pqaO9o+96+DFwxuYxHEVgYXvqS4
         FmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C28GHq9eGnl5C7gie+JAKtI6Ivmm07fD3qZCGDhhJD0=;
        b=HxlWcmx9GREwsZgTUM7CmI7X6GRX9VKSkQZ3cHZfNC97DhNrW+dxSmfIUWevbbaXVX
         R43aYKV8dxsfBNGCKF+Gqa7Efriuz3iHsKJsYtuvZHL6dDWwG9+IqZhsi3VIwZOt58FA
         UA6Qc1ThXRtIN2fRCRp2qQlYoQqENMeX46AEScu73KDqNb81ttljUyvuYQ1qGI7KtIwn
         wA0p9FPjcdKXHwz1P63pluUtEGuN3HcbHBrNGFsVCdkZXMhPZ6mwVxRCzE/5DeCZ0Asw
         rS9LEd+2pDVc6c85ZUUFqjMP8tMSlJWAb8PaqQqAHHMcbMgJ8eBbv69/+//aiYezxVAP
         xFYQ==
X-Gm-Message-State: AFqh2kpW1FbsxlyZTY6OT/uTv9UGjWL3VV01fr3sQff4lA+NTwKD1CWx
        wesLt4jhoMQIppLX0cwzGESROQ==
X-Google-Smtp-Source: AMrXdXvsbvHnaMoEXFp66nyVdfTb24Mb5lvBtJ7BntzuF0Hy5p5VVX9YiWQI19QuXrcISd1TqN8J8w==
X-Received: by 2002:a5d:568f:0:b0:2be:b09:796c with SMTP id f15-20020a5d568f000000b002be0b09796cmr27610933wrv.64.1674640624592;
        Wed, 25 Jan 2023 01:57:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q14-20020adff78e000000b002be07cbefb2sm4759057wrp.18.2023.01.25.01.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:57:04 -0800 (PST)
Message-ID: <d2ce0dce-eaa0-12e9-e250-bf948d2ce9e1@linaro.org>
Date:   Wed, 25 Jan 2023 10:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH RESEND linux-next v4 4/4] dt-bindings: usb: Fix properties
 for VL817 hub controller
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230125072605.1121-1-linux.amoon@gmail.com>
 <20230125072605.1121-5-linux.amoon@gmail.com>
 <bd29cba9-fb1c-051e-e10e-cb3e73ec5ff9@linaro.org>
 <CANAwSgRWVPghhEwvQgzQicJHcjgAv_d5nYfE0Ni90butc5ouSQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANAwSgRWVPghhEwvQgzQicJHcjgAv_d5nYfE0Ni90butc5ouSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 10:43, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Wed, 25 Jan 2023 at 13:10, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 25/01/2023 08:26, Anand Moon wrote:
>>> Cleanup by removing unneeded quotes from refs and
>>> add maxItems to reset-gpios and fix the required list.
>>>
>>> Fixes: 31360c28dfdd ("dt-bindings: usb: Add binding for Via lab VL817 hub controller")
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> NAK.
>>
>> You ignored my feedback. Please help me understand how my tag appeared here.
>>
> I have followed your feedback and modified the below patch
> I thought you review these changes see below.
> 
> [0] https://lore.kernel.org/all/df1c8545-01d0-3821-0c19-07a369e40472@linaro.org/

This was entirely different patch. You cannot take reviews from
something else and apply to other patch.

Best regards,
Krzysztof

