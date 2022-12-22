Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429365425C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiLVOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiLVOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:09:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F34C2A24F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:09:06 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o6so2895919lfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4z3JIyG8g1dhaLpLxJ0cd/xMqTiwNLaQ7XfbfyBcxA=;
        b=YLMfkY5Us7bhtxb29EseukOVYhUOINKN+lIAH2AxBjS6bQ9smg6fgwUyE8rlYDanY3
         lLsqJ5kKN1D8HJUF7/NG9NK72xCOsZ7eBbQQSqfnqk+61yprgn4cGwA4Ws29D0ihwOCp
         49QXPi6vkuxnXLY1r+MR9+aGwRRJVtfbCLTmnEQSLeJ9iy+LYH+M6RixtS96IQnoFMuI
         TnTuCrprJ8D8YMyGTMXwu/AIdTXuxaBq0A2eTFw2M+je0lsNrRf17tUDfLdJL8NoKUrr
         pGvrlc7HQPqEsP8f5RsaLIXrqJ8kyTUcB8ZB08gpFdLExp7qo+daSIUqherF6taGiPVY
         jeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4z3JIyG8g1dhaLpLxJ0cd/xMqTiwNLaQ7XfbfyBcxA=;
        b=oZcr7GANp+DAgWHaRYgOwojY1mZcJfsYLsMPopRjS8jPv0DVsMbC3m0yZ/gDaL9rD2
         V8r/Chyos/L9gbrNrz/PWobZ/xIcWbrfBNA9enJNaHtcwpQwx6xIygOD/GCUUedSoVAN
         tqxiX/7s9ArxESEezsi7ClubfalMUvdg/SBdFXAKcQd3LV1FOSZtFetwmoFtZntMUKbV
         +Z51j9HZdJr5vDl+eOzpgVp+fLTQn9Ha5w0/dlTNNPLBSVnISJCYPzpIALUcJFTAaK0y
         Ml6tpL7huX/phQWW/ebd3F7Zgd6fJ57g9Sa+kZaH0cNk745IHVH2HCVzBiaN0fVKwt0x
         n4/w==
X-Gm-Message-State: AFqh2krXVIWIRjNbSXUBMw7EfjqQuFiaiml4GDyFXeFH3T8xloi3Brae
        XfFT08OqNCjVYq2Ta3sHlbk4SQ==
X-Google-Smtp-Source: AMrXdXutefuLZB7u81h05jbymm8tyKXAtCk/YtU+ZGeFiiKtUr2LIbWIg/XoU2FyJRGTwZUrpJqFqg==
X-Received: by 2002:a05:6512:368a:b0:4b5:b90a:829d with SMTP id d10-20020a056512368a00b004b5b90a829dmr1431465lfs.66.1671718144563;
        Thu, 22 Dec 2022 06:09:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h13-20020a05651211cd00b004a2511b8224sm79512lfr.103.2022.12.22.06.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:09:03 -0800 (PST)
Message-ID: <7249d94f-0984-c1f1-fb2a-81e61b053a86@linaro.org>
Date:   Thu, 22 Dec 2022 15:09:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [EXTERNAL] Re: [PATCH v2] arm64: dts: ti: k3-j721s2: Add support
 for ADC nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        kristo@kernel.org, nm@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
References: <20221221055144.7181-1-b-kapoor@ti.com>
 <e21d15f9-10fa-671b-b49c-a9f748aae75d@linaro.org>
 <baf09a74-ecf7-e60e-4a24-18f023a802f5@ti.com>
 <a5673bb4-3a98-1e37-c6e0-f2a82c4575bc@linaro.org>
 <119fe65a-b302-b0eb-da75-207bc6ce4f45@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <119fe65a-b302-b0eb-da75-207bc6ce4f45@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 15:07, Bhavya Kapoor wrote:
> Hi, Only comment that I am aware of is:

I wrote:
"Additionally - I commented just before error in your patch. You must
fix it, not ignore it, even though I did not point it out before."

My comment was literally just before error you get from git. Just open
the patch and see the error - no new line.

Best regards,
Krzysztof

