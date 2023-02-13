Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C51694738
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBMNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBMNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:41:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F82F18B0E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:41:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m14so12240215wrg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jniYWNW0O39wpTJxa3SQEvop6eWznu5uXxnO2EMbWgQ=;
        b=FBWDFebJdOqOt9UisLdoEICfZUOvdzF4VjQAvexnYvTzYXlNt/8kpZ93WzcGcOScmh
         GSGmXXBlLEH03sbYKwfyYdGJvTvt4pMuzr3QvwOk6Kpg4D/CaMXYF0kQ4MjOSvjV+bAN
         KlEL8mdPr3o/gPPowuH8FFQXdXYrJWnq+OJMUqoW2x21lUo42IHDegHxH9wGE21goH5s
         PTMnWdcixkpnLWd6tjeycsGC2mgjtdXIZ+dqpkzb/RsZGUW8qR8wSIkPtka0Zx/OmEYP
         ce7lM/rKB9WmY38o5PP/PBywnkTlLPXqo5ljii1M743Mgwkq03eN214Npjdq6fbL0aIG
         sAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jniYWNW0O39wpTJxa3SQEvop6eWznu5uXxnO2EMbWgQ=;
        b=JnP9JxOqpruMfH91x3kLj6Y4nBsBSzqPVwljOKp2LuoW1cu7Ljdej5NpfYFHAfduFD
         z55JeSf9kulBO7uCENJ5WIAetCjAf9hu8lXR47mijMDDJ0F6OrBVxmxpXBs7KMVzo3wT
         AFAz3uiGhvZqLCcoEBk5NCLACvBNBa4BdfReLUCS9S+SULU/XXnqkOIvlk4hWpOAbucU
         wbgLrXfSmfJYoBKLekGrIvSXpVCNiujOiF8QKWXAAX7W/KdTk9FIL2D/2e6IOycziHiw
         +ExtilFBrfSAs2Y1VlK3BpWekO7ZT3cqMjtgfdD0GjqyJxVTwSo6C6h47ocSNeTNGhQr
         kGGQ==
X-Gm-Message-State: AO0yUKV8gv4ZPgJjR8f0plgx1GJ29v1TXewf5M3qBS39FbTWBu1JN9oW
        mGSHXGXO1knhHjLS6A0Hnwinjw==
X-Google-Smtp-Source: AK7set9Ck5nVtGr3AA0e07USwlY0O4KmviAeT07ZvvWqq9KVybVYwczKDubU1V+AXYHkIkH/gEo6Nw==
X-Received: by 2002:a5d:61c8:0:b0:2c5:57d5:ef6e with SMTP id q8-20020a5d61c8000000b002c557d5ef6emr3328146wrv.46.1676295673210;
        Mon, 13 Feb 2023 05:41:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q2-20020a5d5742000000b002c560e6ea57sm218722wrw.47.2023.02.13.05.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 05:41:12 -0800 (PST)
Message-ID: <0c74070f-6dbe-9379-3acf-85d173217419@linaro.org>
Date:   Mon, 13 Feb 2023 14:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 14/17] dt-bindings: sound: apple,mca: Add t8112-mca
 compatible
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-14-cb5442d1c229@jannau.net>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-14-cb5442d1c229@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 16:41, Janne Grunau wrote:
> The block found on Apple's M2 SoC is compatible with the existing driver
> so add its per-SoC compatible.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

