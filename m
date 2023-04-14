Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF356E28D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDNQ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDNQ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:58:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2D346A6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:58:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id rp27so10196185ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681491478; x=1684083478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLuHyW+oToWSMJF/7yNdvhI6vBh6/Geuch2BcgJwQ+s=;
        b=p9jcxsu5QbhKFz/zEToMWOzWt4NlQFv/ocvksXuo79xWMN9r4zmYmzFuOuaGZxcPBz
         Bn9tdeRrraErGBUFG9HDf0ubFG+vlvtmtZ0TY4JgT6Bq7pyiOdUmLt3yTwyceZJsdzSr
         5yOlGNO46IkUnpG2VxOblDidTidYX75Jk80/Em/p3D4iJ50Ue5KWUhRlBDCWbwRHLUUT
         amskfEa6yTYjo40P3pvzl35iHmSyJ0PkK6UTzuRQL76sUGxYL5hA7734a8+6JuVan/q6
         l5jE7RvaHDQ73AsP0fQ5sruExM0suuYGq5Ir7UgDjty9tThT3wcnzhYgrmczrb2vpjHP
         xASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681491478; x=1684083478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLuHyW+oToWSMJF/7yNdvhI6vBh6/Geuch2BcgJwQ+s=;
        b=MMUTApnkBf3NyCIVbQVot08do/fhCyfSk3+RItsa+6QCPSKseH0956wIrD9pKSnzE6
         TXP8y84c8fQFv4DpgZe01I8H17nDH5iYa2NR+EifRQ3mIHdkX8eW8GKWT1u0Y1H8d3zF
         1VJeMPoXy/VmwvNl9QzSr1waAkQbEncEKSQmD+WbxVapzIecPE9C2pTevLvEgkjCDKRz
         /B+evvvJPknpk6sAK0jvyiEqnTuM21H/GBD2XzYjOkiwbmbvOY1+XZhC59IMV2RLeig/
         m/+6uqq0JxVwkWPPPwOALw3FnRYBRFNngVyJzLrrmqTmuKVnexJYMHGM8P9nCk8sxh7O
         PWIQ==
X-Gm-Message-State: AAQBX9fKojLAEn27g+WmMc49V3ksY8rqzbv+mdV0YlK8RfLbcjAbGfhV
        DXnh597tLyJk120WHtMIx6CtrQ==
X-Google-Smtp-Source: AKy350YQ1HKGT+ViKDuqS5nsV9zqTPyR2y8jAfhlwKBUAhpwzMu5YdZluLXysFoxFAEZSZMgaTQwww==
X-Received: by 2002:a17:907:9873:b0:94e:887f:a083 with SMTP id ko19-20020a170907987300b0094e887fa083mr6847292ejc.57.1681491478620;
        Fri, 14 Apr 2023 09:57:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:39b7:81a0:bd41:17b1? ([2a02:810d:15c0:828:39b7:81a0:bd41:17b1])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906698700b0094a9eb7598esm2620895ejr.120.2023.04.14.09.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:57:58 -0700 (PDT)
Message-ID: <b12f305e-ba53-bbab-1d0d-121b76d8b5f6@linaro.org>
Date:   Fri, 14 Apr 2023 18:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/9] ASoC: Add Chameleon v3 audio
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-2-pan@semihalf.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414140203.707729-2-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 16:01, Paweł Anikiel wrote:
> Add machine and platform drivers for ASoC audio on Chameleon v3.
> 
> The board has two audio sources: HDMI audio from the it68051 chip
> (RX only), and analog audio from the ssm2603 chip (RX and TX).
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../boot/dts/socfpga_arria10_chameleonv3.dts  |  28 ++

No way. DTS is always, always separate.

Best regards,
Krzysztof

