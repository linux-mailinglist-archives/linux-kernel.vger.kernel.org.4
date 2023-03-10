Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43866B3CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCJKtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCJKtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:49:11 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2121DC1C0E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:49:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so5680008wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678445345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/E6IrVKV8tG5qez0g2DUS7e2rWgj0M6l+MKeGZ3HBz0=;
        b=e/q1nQOZaOgOGhjEVIYRqX9xJy5plKJzuZF966ibRV8zb3vIeiv6ZLEtYSLz/KxR+5
         Dg9i3dsa1bJJjAtuI7XL1DhvcvsKpVdYv4npaohckUnNZ3F2T2MfX/CZ8h+nFfaRqW2g
         2i6IdXGDj2lrIDoPRlMkGPZtJajX0FUIfKu1JHHJLvh7S4elyME7MHtYicnKNHcyVHoN
         4FV7TU/O8KWDX/27obaA6220XsqEwIeylfwD3zM6xE5pwQXOlM9SJ5Z0ASRJqkv75wsE
         i35HgsxoJvM7GZwl2/M2s759g7qy/kaehVqjrIFR1s/ke/JiYumOtv5A3Mgg40RUCdw8
         Odzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678445345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/E6IrVKV8tG5qez0g2DUS7e2rWgj0M6l+MKeGZ3HBz0=;
        b=nrEMMfiwloR3gYyvFDlccwQC0XKo9/FQnaYothIlEIu/edpdhPIID/qaM+AcMugFJ1
         dI9czo9IuelDyy9RNAotM921f+vmxDE9ump9THWUHm0/o8lapIWCSm4bWIygRqpHqDNJ
         ff7QBmRshvN3fz2SzpPtoMC+gNMabfQhLMqqpTthT2j8LdgbF730yTs4JP+4iPbXcudT
         jJcV2IJ5ImiLWidPqIzMABN3Rg7NdWp5OzhLRP1U8W5IP6oYYotC4OwM5x4ZGiZwu0Iu
         O6lN5SrdU6Q9ed3/y+ZCrVw087izacCbmfvZkuDO9KqpjLJ1h/Bt0+VReopdzgh8Xauw
         PCiQ==
X-Gm-Message-State: AO0yUKWQxDkp0X0U4HWQ2qj+IkFFzDolJANaPUEV7rBwDCeRXOmMDAjC
        OqBQchU8mvlUXSZvwwrE4XsKbg==
X-Google-Smtp-Source: AK7set/5RCXZfA4kzKJq1Ejjyv0p5xZ6qMEaBmQh4RyDM5dvuwn60+7H5akktvLAkB5tLo9N+D3bfw==
X-Received: by 2002:a05:600c:4448:b0:3dc:1687:9ba2 with SMTP id v8-20020a05600c444800b003dc16879ba2mr2127085wmn.35.1678445345509;
        Fri, 10 Mar 2023 02:49:05 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id y10-20020a1c4b0a000000b003e0238d9101sm1751838wma.31.2023.03.10.02.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:49:04 -0800 (PST)
Message-ID: <cdcdf549-2031-e689-f98e-0a201357a5ae@linaro.org>
Date:   Fri, 10 Mar 2023 10:49:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 11/21] nvmem: core: handle the absence of expected
 layouts
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-12-miquel.raynal@bootlin.com>
 <c37d2d5d-4a25-27de-3f80-033984232ed9@linaro.org>
 <20230310114510.0867e0bd@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230310114510.0867e0bd@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2023 10:45, Miquel Raynal wrote:
> Hi Srinivas,
> 
> srinivas.kandagatla@linaro.org wrote on Fri, 10 Mar 2023 10:30:14 +0000:
> 
>> On 07/03/2023 16:53, Miquel Raynal wrote:
>>> Make nvmem_layout_get() return -EPROBE_DEFER while the expected layout
>>> is not available. This condition cannot be triggered today as nvmem
>>> layout drivers are initialed as part of an early init call, but soon
>>> these drivers will be converted into modules and be initialized with a
>>> standard priority, so the unavailability of the drivers might become a
>>> reality that must be taken care of.
>>>
>>> Let's anticipate this by telling the caller the layout might not yet be
>>> available. A probe deferral is requested in this case.
>>>
>>> Please note this does not affect any nvmem device not using layouts,
>>> because an early check against the "nvmem-layout" container presence
>>> will return NULL in this case.
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> Tested-by: Michael Walle <michael@walle.cc>
>>> ---
>>>    drivers/nvmem/core.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>> index b9be1faeb7be..51fd792b8d70 100644
>>> --- a/drivers/nvmem/core.c
>>> +++ b/drivers/nvmem/core.c
>>> @@ -755,7 +755,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
>>>    static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
>>>    {
>>
>> Any reason why this is not part of 10/21?
> 
> Yes, I would like to credit everybody for his work, so Michael for the
> base implementation and myself for the module sitaution handling,
> arguing this is two different features. May we keep these separated?

Thanks for clarifying this, that should be fine.

--srini
