Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37137683619
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjAaTJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjAaTJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:09:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B433043478
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:09:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q8so11086385wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDRJwxYBMPkL+MaeHifU1sEB1D3aKfZTEIbcHFJdbsA=;
        b=sNzGYvCdHkXBT5IHB3qLr+N+zZoswFPPlcm3LYvnVXHQ8P1c2GLIFgFIdxU5s9zacH
         Gsho7VP/2bz4nENrRkQGI4gVDFFHZo5OpCp/xANyivD/XZO0C1bxsqpRTQBAcDnjwpRE
         7D3BZ9uIJ8W/2bxPrW3jpkXwzIVpgcHoUBJYvdvEf6rtsUkuCtKXSRLj9GaVIoRHxQoQ
         scmaBjWOLIW5JD1AafyIH7fFb/9IxGGmj08KHeyMzAcpVH06fmZiEYkNVdO7/LAMb7kE
         iKxDg998dj2MONyCzSABDQEDaxMYAGOZfDNSXBrhaFv0COQmJAq8Ny+PwYDt7SwsrVRV
         QI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDRJwxYBMPkL+MaeHifU1sEB1D3aKfZTEIbcHFJdbsA=;
        b=iLN/B4zd9ZetfXuVoAY5Jr61eWGA1GX59mMM/qA5xBUH+aQipVdjjojn+uy8sUp6ut
         3U+eXNEhz4SiC3SgY2jx4UNzIHgnqii1q9TRlVSbau57ogrX7oTlErFBgx0in0/r8FSi
         zmE3AQAvXbJAB0xkr6L34bO29JGqRv4Qz2dBiuuALc/lsvZO6Gclxbel5TqYSN1X3rd8
         VfSmjND1inTTJyiI9UwhJo4QgAwHrCxq7+xpfWPhHHVyk/S1tceBz8AzWpFgEwPI76re
         gc3PNYGzcfYk6y8xpzSr7ZsnoEO84Qs+bZyKGPd43rC6r0GRmjAFZTWYvQ3NtRdr8H0/
         jH5Q==
X-Gm-Message-State: AO0yUKV6XIC4b50/SP7Hj/nZOt7ADBiSztBl5dnUxe1/FnxHbTC6uSsi
        VgLeTzFDpWqxGKFWlrmCrjSRpw==
X-Google-Smtp-Source: AK7set918klgzIWFOJDOtz599HBOVqDjblTaT6UAvI1CXt2beoDR8rYYfQlZbDXRnYQaq0z6wq2UIA==
X-Received: by 2002:a05:600c:500b:b0:3dd:caa8:3ae2 with SMTP id n11-20020a05600c500b00b003ddcaa83ae2mr2220292wmr.6.1675192182240;
        Tue, 31 Jan 2023 11:09:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b48-20020a05600c4ab000b003db1ca20170sm7540949wmp.37.2023.01.31.11.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:09:41 -0800 (PST)
Message-ID: <d29e4ec6-848d-4a72-caa2-6b9e66064e85@linaro.org>
Date:   Tue, 31 Jan 2023 20:09:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: rename .yamllint to yamllint
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230130162650.399490-1-masahiroy@kernel.org>
 <CAL_Jsq+e15e64Vsg8SwDsrUfzS8rWKi_39ajp3=2Ck7Dz_gs5A@mail.gmail.com>
 <CAK7LNARZwt=WpmTwWV0Kp2q4hAvGGhCVDWf-xBpWCkn98AF7mA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK7LNARZwt=WpmTwWV0Kp2q4hAvGGhCVDWf-xBpWCkn98AF7mA@mail.gmail.com>
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

On 31/01/2023 02:54, Masahiro Yamada wrote:
> On Tue, Jan 31, 2023 at 4:53 AM Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Mon, Jan 30, 2023 at 10:26 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>
>>> This file is ignored by git by the '.*' rule in the top .gitignore.
>>>
>>> I do not see a good reason why this should be a hidden file.
>>
>> Only because that is the default name yamllint will pick up if it is
>> run from the bindings directory. Not really something I do though.
>>
>> Rob
> 
> 
> Or, do you prefer adding
> 
> !/.yamllint
> 
> to Documentation/devicetree/bindings/.gitignore  ?

https://lore.kernel.org/all/20230127150225.18148-1-andriy.shevchenko@linux.intel.com/

Best regards,
Krzysztof

