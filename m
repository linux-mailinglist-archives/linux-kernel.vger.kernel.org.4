Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3066EAF56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjDUQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjDUQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:38:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E241B8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:38:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so13805150a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682095117; x=1684687117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f37z8CaRZJ71kt5G3XjzfdmlNPZE2d/uOWK39okAU54=;
        b=Yh+uT6I/cylCmOik3uAz+q7RnLYjpKL0xi2y7M3WWvKnZ/zvaMgljyj90TsRzp/sag
         6dWZEKjPfLlrTh7Lhuo7ZAueaUYXJ6CEM1ALziDuumr8u5OEQKYQpl7l5KpMYGBks1nr
         Fu9UDEx2uKV0YzlYyxW/USkR4ZDz96BoY1HkzGMbuTNLKPyyVF+1XSQSX4P5Z3GnJCEQ
         Hh1zHpOslffWEC4w8LonVQU/udxu9P1Yd2H57zHY27SITEzj74L+Ep5vxDlBdVhWiwL/
         mtGcg1ZSav168p+nsNz6gDRCcvmiNE3U6G1ve0WjR9N0v7BBrOvZCtpetCRaXpNrTVUG
         So7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682095117; x=1684687117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f37z8CaRZJ71kt5G3XjzfdmlNPZE2d/uOWK39okAU54=;
        b=cozvWYM9n2Y/M+yzjxv82ygij/k1edpC353ISCM26ifH4JH+DLMY+pomyd45tCuXPW
         pYmJHdGmD3IslUuhSf4h6zScWXcMkZAZ9t87bVKh0xeowhgrJmczwhIeaE5eMpUrpfOu
         vrVb29s/EON9b8+zTL+sLErPdVMsfK9AOrLjjSFKLXmbSObeX/9beUu3dMP7m+d9vpWM
         efW/tJ91zw/O9KjXNLTtvQXONsZklS4X8SZn1ZZaIY0D262xFm1E4gSKR8YZXvWJB2jt
         hsKC5Jre8HakzsSDTwxbj6xktS/InM/5YCzoULk+UY0zTSl5hrw8nGZEWRth0HsFOP8b
         xZ1w==
X-Gm-Message-State: AAQBX9fTXCMPv0umBKITZaNhF0GGh7SnBlNFER842vPgMUNMwVw8lDOJ
        PvNBfeCZJ/UP6wqjH1ibBh+4mA==
X-Google-Smtp-Source: AKy350Y5t2Mc35ymMsh34woQ4uOvfYlOh9Dztn2hRVclw2MWmuBmIVK6FrtfRIKhUxRdQZI2OGeFeg==
X-Received: by 2002:a17:906:a007:b0:933:4d47:55b7 with SMTP id p7-20020a170906a00700b009334d4755b7mr3158319ejy.2.1682095117535;
        Fri, 21 Apr 2023 09:38:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:687d:8c5:41cb:9883? ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906101a00b0095729352bf3sm802923ejm.215.2023.04.21.09.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:38:37 -0700 (PDT)
Message-ID: <246b2227-91c5-5425-7af4-b2d082f76fc9@linaro.org>
Date:   Fri, 21 Apr 2023 18:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/4] dt-bindings: riscv: Add item for StarFive JH7110
 audio board
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230420024118.22677-1-walker.chen@starfivetech.com>
 <20230420024118.22677-3-walker.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230420024118.22677-3-walker.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 04:41, Walker Chen wrote:
> Add bindings to describe the audio board that works in conjunction with
> the VisionFive2 board.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---



Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

