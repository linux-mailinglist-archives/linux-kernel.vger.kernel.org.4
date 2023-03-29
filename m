Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A79A6CD409
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC2IH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjC2IHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:07:55 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7507F35A7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:07:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a21so8007468ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680077271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KifxtcvbarKwRyuhr/Ufg1uKerUmicIF2vvptJLaYI=;
        b=ZXyHG4l1WqIzWxT8epXnTXnuCvJZXDvD+/2fWHMq2KM5Z0Vd5HWIgmlEoMbvNAjtbc
         A24d/WV0DRlI0ER+hwAHxQEeezwJTQk6dhdJAdpiYUxBPRL2zC9myFyO00wPrp1CoNVx
         w5p265Awmjeqln/IV/u2IJeFCgE27v7CnJJEWWyM4WJAXBrHZHUkmI7NiQsPPRteBFO3
         qO/h8XmwwQKHnRPASg3Y+RfTu6AWHhtxXrSwzLhFlyPhTMLv+JzBVL4hvc99O9eOOhMA
         q1xTMYmCHP2+xnmXj/gnPM52A87Nbg4h8yWXD+uEeQLHF509zZ2TXRA8PeZDTSG8L+jJ
         AbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KifxtcvbarKwRyuhr/Ufg1uKerUmicIF2vvptJLaYI=;
        b=jhF/RoAcQXzJmYyE0lLewGPz8MjLYwM7/5sNjYrULqKc2K2XbZVYdny2AQWrDDGEM0
         tKzrySU4/Z0dbbcUUTKDGB3L7y/ZgeVMUPwnLXjUkIVVtIKHMEFD9O6EamZYPp1cVtLc
         3jdGo3N2DfK1oz5yQmcHDDn8jpS3wixCxWK9SxLwfIL9fJkzEvHs8lX+UycneMGjYofn
         /D5J4seGWvQyqCZTDSNnlTfE5Yksh5Z0Ey98BRQGr1kKWZ5xZqIWH22Wx1cwGo/K6+U2
         xvCCVK7xNfxr0K6ImUn2wpRvHjQUSjYXVHhUyr8yxA9DmnOtmjHfEMwmgfuiM4YsiVdb
         pnlA==
X-Gm-Message-State: AAQBX9dtZDdbY+/t5xQFuo67LNp8WRuXjyJe6Cjw5/SCMZWEko6xo2TN
        fHsfjcOpPwj87q/XtKdf0ktL6Q==
X-Google-Smtp-Source: AKy350bMTcCNWTcZWOOrCYdOk1J64lvJehoM/rLLd6gzi5zzF4F09iNN1/n6D4V7bZFsYSBKVEFn0g==
X-Received: by 2002:a05:651c:446:b0:29c:88a7:9a96 with SMTP id g6-20020a05651c044600b0029c88a79a96mr6212076ljg.46.1680077270753;
        Wed, 29 Mar 2023 01:07:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e95d6000000b0029bfcbeac09sm4513572ljh.41.2023.03.29.01.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:07:50 -0700 (PDT)
Message-ID: <e9b1b899-9f19-0abd-8e20-fc486bf28b17@linaro.org>
Date:   Wed, 29 Mar 2023 10:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 0/2] spi: loongson: add bus driver for the loongson spi
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
 <20230328113536.ldxpvx3hibezcqtb@intel.intel>
 <253f3bf2-a193-69da-79ef-c3771d677478@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <253f3bf2-a193-69da-79ef-c3771d677478@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 13:53, zhuyinbo wrote:
> 
> 
> 在 2023/3/28 下午7:35, Andi Shyti 写道:
>> Hi Yinbo,
>>
>> before submitting the patches for review... can you please run
>> checkpatch.pl on them?
> yes, I had used checkpatch.pl to check and no any errors and warnings.
> 
> user@user-pc:~/workspace/test/code/www.kernel.org/linux$ 
> ./scripts/checkpatch.pl *.patch
> -----------------------
> 0000-cover-letter.patch
> -----------------------
> total: 0 errors, 0 warnings, 0 lines checked
> 
> 0000-cover-letter.patch has no obvious style problems and is ready for 
> submission.
> -------------------------------------------
> 0001-dt-bindings-spi-add-loongson-spi.patch
> -------------------------------------------
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'
> total: 0 errors, 0 warnings, 55 lines checked
> 
> 0001-dt-bindings-spi-add-loongson-spi.patch has no obvious style 
> problems and is ready for submission.
> ---------------------------------------------------------------
> 0002-spi-loongson-add-bus-driver-for-the-loongson-spi-con.patch
> ---------------------------------------------------------------
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'

You have errors here... Fix your setup for spdx check.

Best regards,
Krzysztof

