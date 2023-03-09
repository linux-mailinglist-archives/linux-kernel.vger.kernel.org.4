Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684AF6B2AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCIQ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjCIQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:28:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D481DFE0B9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:19:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o12so9150412edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 08:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678378737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Zw8vqXpC0bU1WHMHt8aBbYpkThMfK2D6RUJ0aIcSMA=;
        b=CNoumR7hRfEhiItHmA86DPUeSVhUeg2S0X9JMh6EIppwoan1fCQnNNMNpNIKnVTDfv
         7A3C4sXQav4nOkupeInanOPXYmTt2byt3ngVoyvhgZZQ9qc1Rs6tT2+x4PKreMAlD3Wc
         HVPRAh7PoeYvRi+CS3G1ArjOQeBdNc/N/NiPO6HljOZGrNl9Wh4ediz8S/GoIPCL3fSe
         +3XTsoyLPXdEzxclhWz9OrtKNKhsd8P50EXoAXfOCDZK9PUoNKCBq9ViYRb+2YmeRvJK
         VKmsMV/zlCeJ90eVOp5bbEmptQ9NOs9bwm5l4ZfNtR+7oTriWCR5JUkEzBehzKvR1Khv
         LpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678378737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Zw8vqXpC0bU1WHMHt8aBbYpkThMfK2D6RUJ0aIcSMA=;
        b=2Idgv2UR+hLoJ0G2wDmPv0yjlhU9tqrwcqh7iOPXaLc82z5R/Ly8vAEgNazgAhemHB
         pZLRofPP52B/m/X435KFBqnkbr5uS0wm+iqdGYU2yW3vyufLDTlSw0460YWC5cygtWNt
         voWrLnhgsoYduWMAF12qoGA4tBAUDbMJLIdlSP3m5ARyfgO0DK6DiIQ6FHa71aFoncs/
         jm05oXNzxlr/VaO7aqtCoNKy2SSnQ6c4Vb5itfXHu1joJ/vmyw1dAb+O+xZ0phtf1tcu
         FcNmJxSYnZO/BkTXUSG+tN0ZYYRuzdnmmbwIzSMOBP6lUMd4Z1GEpZF4jnTf6viZ1y/o
         4f+w==
X-Gm-Message-State: AO0yUKV9X94yrOzdR43lN97tUgKYrmzNeI1Vb9tfPi8LCYc8dCPRqzXv
        sGkLdZTJje7Vjs8Issk4mTr5kQ==
X-Google-Smtp-Source: AK7set9MuKtpLuEwfh0WkbsVykrcHMrmS6AkP4kRrrDO6biY/uwWxqA/HNR5xrHkqLsyNSqWdQJlkQ==
X-Received: by 2002:a05:6402:3d8:b0:4bf:b2b1:84d8 with SMTP id t24-20020a05640203d800b004bfb2b184d8mr28243082edw.19.1678378737564;
        Thu, 09 Mar 2023 08:18:57 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id k21-20020a05640212d500b004aee4e2a56esm9743217edx.0.2023.03.09.08.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 08:18:57 -0800 (PST)
Message-ID: <060a51e6-fbaa-253c-dfa3-c4abc38344c7@linaro.org>
Date:   Thu, 9 Mar 2023 17:18:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230309140051.945329-1-lucas.tanure@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230309140051.945329-1-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 15:00, Lucas Tanure wrote:
> Add support for Steam Deck bios old properties. If a Steam deck didn't
> upgrade the BIOS, the driver should be able to handle the previous
> properties for shared boost types.
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> Changes since V4:
>  - Add documentation about this quirk
> 

Good for me, thanks.

Best regards,
Krzysztof

