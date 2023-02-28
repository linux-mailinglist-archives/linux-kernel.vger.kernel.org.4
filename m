Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD846A543A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjB1IQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjB1IQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:16:03 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9016D29E1D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:16:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p26so5778303wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677572161;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cviph/FMxZ3sdMi+0ZrOaolxsjo4GH8Quc77ocNpkY0=;
        b=qE8sYGAthZOrFTDcEMy5U8Fo7m0Axbzkq+3tFXrH7EKhBorDhGz2Oir0Xr5ht75gOp
         pdPuxO2D7NGcQnoi2UFQ61HTcsK8BxB4iyjZJIFZtr8Q9JqA53SJGHNjDtT3lqkdGiT3
         wG2mozymNG4ZBfB9oMY9DDy1/1ZFKWIgFgSzDBSUnGHdqxAm3qHp4E0bTtVsFKyCod6D
         GFdvCUhYJ2jQwYFkt4cYwFc8iiCY+D1qIT9YV4FbjkrgK1GlBkeSgPTV+rZkkC0uaQsa
         o6R3qcISXbebVz9lYmi6IHooatrtY2rM94qbmbfelHSfya6YF+e77sxI9Lyim1AJo3To
         Mdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677572161;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cviph/FMxZ3sdMi+0ZrOaolxsjo4GH8Quc77ocNpkY0=;
        b=bIrNXfvBDzlYo0YIFPc9M3iiiIdbdB6P6/7LbcC7N83e+Cf9y28p8Ccg+0cU5AKz3K
         VoU3xaKHe+ebWPaqEx4aWe2CpHKeLNqv40uO/U8H2hpdZp0Cr70DBAeUnbGdtgbgiHsZ
         gYsP0E7CvX/Y+QhTY0AeDp4ez7NrlwbxIn0Rxgs9rWnbWKbaJpORkedBT9E4EOpl7fpo
         Pa0HleK+SpnKDoqABGtSUyO98bMtNNhTUgs+N7xs1iK0jMTfDSJHWKG6UC1Rpt/p8yau
         PpqS8BhcFoj5jnCw7wEoeFKY553focmBGgcDmrExAjBsO/pJtSnNDhIWCe/O+63bfX71
         CZ+Q==
X-Gm-Message-State: AO0yUKXlnGLw8CRQg46h6RIGAcJLo82OP7K2uBzTW6Sk32OIawHp+3dF
        sQpunwjonkwy3YO9WiHzzUSw2Q==
X-Google-Smtp-Source: AK7set9jwhZlPWevBVMtDci9OdBkgjIY3tqQK25NdMSQRBHdkFs0NwTkA6lABch489IP4tUq2XENhA==
X-Received: by 2002:a05:600c:4507:b0:3eb:2b88:a69a with SMTP id t7-20020a05600c450700b003eb2b88a69amr1431122wmo.14.1677572161057;
        Tue, 28 Feb 2023 00:16:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z19-20020a05600c0a1300b003e4326a6d53sm15097914wmp.35.2023.02.28.00.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 00:16:00 -0800 (PST)
Message-ID: <43fcfda0-f0c9-304a-8d8d-923fa499b60b@linaro.org>
Date:   Tue, 28 Feb 2023 09:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: wlf,wm8524: Convert to
 json-schema
Content-Language: en-US
To:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230227091938.1671416-1-chancel.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227091938.1671416-1-chancel.liu@nxp.com>
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

On 27/02/2023 10:19, Chancel Liu wrote:
> Convert the Wolfson WM8524 24-bit 192KHz Stereo DAC device tree
> binding documentation to json-schema.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8524.yaml | 40 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8524.txt      | 16 --------
>  2 files changed, 40 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8524.txt
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

