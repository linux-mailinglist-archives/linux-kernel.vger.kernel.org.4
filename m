Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17D16D9873
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjDFNlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDFNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:41:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C87E74
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:41:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i9so39575670wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680788469; x=1683380469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqET99kWQwPTEkmEaCDERWkshoo1jtg8YaUv2xNlnJQ=;
        b=WP5gv/X8cSXZVUV9KYAdcq3K++8SEsc+tb1qtM2T02yTfhVhdiySCUbPfNiZNqIoMj
         odbIjmo7meW+8WKIJSp4UbF2tWnn6oC6/PTI5654szFFcMjbg+gV09Rd79PIZ5f+/S21
         iyMHYSqM0c3W+yfDYo8qyWH35jW+twcyXkkM0GTNfyVKnm4Eydi5qoVZ80YisX1nkcOF
         63LHSjVs+T+1tmo6tgtIrsVnSjO36UGQT5udGl02q9W4t3bI98N1dSmJgqxX5AtJFpu0
         EFdHqfrkr7c7scweP+PXFZev4W5p6phZZIpoES6Wnmw7hSp9/c8oLfRmJn9H79FLxx0y
         9L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788469; x=1683380469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqET99kWQwPTEkmEaCDERWkshoo1jtg8YaUv2xNlnJQ=;
        b=ZeozGyazJD8O2gz+HpWbS4J7Ty6yZKxbunf0vcPc0FvcgK+zQM+wndX7wWH7URYbH0
         IcO9y0ohhyG0dLP0+8ruN5ZMHvrDkmkCLvKxXU8OJrHOfHOxPE5+gF/EXlEM8228mapi
         8vIkJ8BbI4LDqJePHxus86Jv8QE1V4D8dcIlIxGPI6T9MyUVzgQjZBtbu/MZFl7MvFdn
         97FXjx6ykkMtdSQgR5QpBNnD9X8vsr8AGI1k3QqjIaXURpxi423BGhDGd3yLcpr+uq/8
         +TC5zNO9jCvLAzjVLMDA5r6Ur0mmpWTuQk6MaIK/aHMzn9SCYapkSECWO7tXUE1hhoek
         wbQw==
X-Gm-Message-State: AAQBX9e9teiAqz1fKyf1p7z/xThO6HJQQEW6qC/oT+y5oObVrGVkEFdc
        qQPSY7S9uAgpIDeUBhuAozO2Eg==
X-Google-Smtp-Source: AKy350ZhLf4OyCO8fIg/dFWqIh8YWnY4krXkUYeBlyc6m45ugflq4UfuLeUBNN56Dqn+JbojgRBt9w==
X-Received: by 2002:adf:dd8d:0:b0:2d7:d4b:b33 with SMTP id x13-20020adfdd8d000000b002d70d4b0b33mr7248014wrl.21.1680788468769;
        Thu, 06 Apr 2023 06:41:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6630:ee96:3710:24c8? ([2a05:6e02:1041:c10:6630:ee96:3710:24c8])
        by smtp.googlemail.com with ESMTPSA id c14-20020a5d4f0e000000b002c56af32e8csm1814424wru.35.2023.04.06.06.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:41:06 -0700 (PDT)
Message-ID: <c17f1dbb-ad81-b64e-48c9-d89d3e170b38@linaro.org>
Date:   Thu, 6 Apr 2023 15:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clocksource/drivers/timer-mediatek: Split out CPUXGPT
 timers
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     tglx@linutronix.de, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Walter.Chang@mediatek.com
References: <20230309103913.116775-1-angelogioacchino.delregno@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230309103913.116775-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 11:39, AngeloGioacchino Del Regno wrote:
> On MediaTek platforms, CPUXGPT is the source for the AArch64 System
> Timer, read through CNTVCT_EL0.
> 
> The handling for starting this timer ASAP was introduced in commit
> 327e93cf9a59 ("clocksource/drivers/timer-mediatek: Implement CPUXGPT timers")
> which description also contains an important full explanation of the
> reasons why this driver is necessary and cannot be a module.
> 
> In preparation for an eventual conversion of timer-mediatek to a
> platform_driver that would be possibly built as a module, split out
> the CPUXGPT timers driver to a new timer-mediatek-cpux.c driver.
> 
> This commit brings no functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

