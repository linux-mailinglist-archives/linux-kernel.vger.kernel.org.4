Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112B466586F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbjAKKCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbjAKKBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:01:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74601B9CF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:58:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t5so10061209wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CHpIDH1rMG1Owv5eVtyw16nuH+y+qhna5O7yLLSeRw=;
        b=RNHLAM9UMNWjzNdMdG9Xyke7V2tvwiaMWk2yetrWIWk9PiP/TiIgBaI7hQJ48yicT4
         ikwmc6VkZcZmcvmInImlhlTcbzYAdTtI0ONi7CsZfA/3YVmrSVuC6Lj5FmVYzx9abd2z
         IbpjEW7Fe0Um491Fc2PgQwnUgaK8c+u/gHBtfSORSP1rSCb8HbiQY7ZgqFvK7jTK/1vr
         MUHsO9KB+uPJQItW/4BEcTne3K4I6ZuK1oa8sfXQzHAlwRaT5w5ilr97DBqfJD9cgewo
         NWUgqy4lD4+ZXvkI/W53F2X28SAzkNK4d/r/0BXXP4t3zVLrdhBmcLjZf3NySRS0ECLc
         PHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CHpIDH1rMG1Owv5eVtyw16nuH+y+qhna5O7yLLSeRw=;
        b=rBw45Medpw5gpxBZHzWdTYPihWzZorjj0gVvCwhWVVR7h9tghuiFJfUo2oOhDsYUdC
         2OeH4pCemuu8bDGOwbf947I8qU6vWhDf7ox4c8qtSecwglCdXs6aOs8Fcw6rJJQ91yTU
         PCCLjd0gcie+YUJTyXEfQ7IwgpbNVGXqlrK48LzjWkRpIRhPYIF3bzqBOS0yzz2Hk3RH
         2bO1orAYoqiuYm1nBJO62eXrLJ4+H8wF508Bv5qlUDNj5GEnq0pPcE1oG3Xv97stEA7+
         IokpswjkxVbRmC3vpeweGO+AxQolXaiUnyKXz6kxixU3BM9eE/IsFLru+nzVnYfrR3If
         GO1w==
X-Gm-Message-State: AFqh2koRLsaH/IdcY2+PN5ike6GMiftGBP0Kr2fue+unXUJroqCI2jxO
        IRZuH7+/VgP9o1n1VoNIg69lVg==
X-Google-Smtp-Source: AMrXdXvOO92JdADUb6pK4nZXTuSXDpapYvVg5c/tyfJN2x9QXp+QTXqy7lCQx9L1qO0ZWPHWZu3bXw==
X-Received: by 2002:adf:fb88:0:b0:242:1809:7e17 with SMTP id a8-20020adffb88000000b0024218097e17mr40370295wrr.6.1673431094509;
        Wed, 11 Jan 2023 01:58:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n6-20020adfe786000000b002bdbde1d3absm3053607wrm.78.2023.01.11.01.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:58:14 -0800 (PST)
Message-ID: <1dfade07-f8c4-2e16-00dc-c7d183708259@linaro.org>
Date:   Wed, 11 Jan 2023 10:58:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 08/10] dt-bindings: sound: Add support for QMC audio
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230106163746.439717-1-herve.codina@bootlin.com>
 <20230106163746.439717-9-herve.codina@bootlin.com>
 <c393e532-d466-366b-a390-65de47c58b6a@linaro.org>
 <20230110090728.2024b5eb@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110090728.2024b5eb@bootlin.com>
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

On 10/01/2023 09:07, Herve Codina wrote:
>>> +      qmc-chan:  
>>
>> Missing vendor prefix.
> 
> Will be changed to 'fsl,qmc-chan'
> 
>>
>>> +        $ref: /schemas/types.yaml#/definitions/phandle-array  
>>
>> Why this is not a phandle?
> 
> I have try '$ref: /schemas/types.yaml#/definitions/phandle'
> 
> I have an error from make dt_binding_check: 
>   dai@16:fsl,qmc-chan:0: [4294967295, 16] is too long
> 
> I need a phandle with an argument ie <&qmc 16>.
> Is there an alternative to phandle-array to handle this case ?

OK, then you need items like here:
https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42


Best regards,
Krzysztof

