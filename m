Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB426B7269
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCMJVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCMJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:21:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA2A3CE26
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:21:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r15so18612455edq.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678699300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChjVkAtxNzFgBrBrBjvGAo/5qTy6VmGAkbGx6UrGPSo=;
        b=uNGpruYXNGb/dWoOlwDO9HpArD0zlK/79mlgX8HlEE379UvbxFoUqVKwSA15peqQeR
         Pz+uvCa5gMeiKTi8RSebqv4Zem+ZFP6KQs5XkzajS6Yd7ree0d0raxsE1Ui1gb9fuUlR
         KbxE0zo2CLpC7loUzr31Qm/CtiSlJl968MDc7Yy5NqmF7C+SL0O89ajo1JmXsbVIXu5/
         Y7W7+AWW1f72USrOA50FIs/pes5qHT+YIIcY9yqJX0FV5p9kDielfnPAd6jPkrvihacl
         xIoK5VWyWWYGILZGUiN7zJUIaVwdaCdIXPRKK/BewZUpS/ymYsYeagHW0Und0Brh+JhX
         Dujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678699300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChjVkAtxNzFgBrBrBjvGAo/5qTy6VmGAkbGx6UrGPSo=;
        b=zj6nph/BxuwVtz+eUJcKpPFJFPYcizg3I7OPNhkFYBqtTQKUS0JL//U+VVUX3gAMjI
         r8wT+qHbuu/He12Uu6eG60MGfAQvY3dwIISPVPJVuEtDJjJuO1dp11lQ9YEM3fnJRH7f
         BDf1O9R9qoEY71EFh+sWYvm6BXRiuXeKF5HwH42tYhquUGtmjX7sZ8OgDmfTqRiWvgEU
         gFwy+8ucUjeEb3tljLeYc1Y/NQNG/IN1szgUVepCKLazxqMDUa8L3li7Lqxo6mTU29+6
         0lXuOtQ5h8N2VXp+4YttvAKiOdNVVD9haOXYOkn11ycmBJ7dkvsrYl3C5FVPrl0lK7Ln
         FwJw==
X-Gm-Message-State: AO0yUKWEg40UOWmO56vkT+Gtof1LmK66Ou4Jzw0tECHf6tsnQyIjZm3u
        r2P7sD0jqmMj9VhgNFF9TsslYQ==
X-Google-Smtp-Source: AK7set+i4PxNmRIvZNYhRnZ2Naq7xrD3RJlAeUcasLedfz/IXR1Vf0NVTUZvJHpDWxiwVj9+M8tjzw==
X-Received: by 2002:a17:906:2d51:b0:8b0:f58c:e87f with SMTP id e17-20020a1709062d5100b008b0f58ce87fmr31707373eji.33.1678699300667;
        Mon, 13 Mar 2023 02:21:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f052:f15:3f90:fcb3? ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id i2-20020a50c3c2000000b004bc2d1c0fadsm2248793edf.32.2023.03.13.02.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 02:21:40 -0700 (PDT)
Message-ID: <a5be6b0c-654f-0cfa-29ae-66f91ea4156a@linaro.org>
Date:   Mon, 13 Mar 2023 10:21:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] usb: typec: fusb302: mark OF related data as maybe
 unused
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310222937.315773-1-krzysztof.kozlowski@linaro.org>
 <20230310222937.315773-2-krzysztof.kozlowski@linaro.org>
 <ZA7q0PkvhB5i4CS8@kuha.fi.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZA7q0PkvhB5i4CS8@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 10:20, Heikki Krogerus wrote:
> On Fri, Mar 10, 2023 at 11:29:37PM +0100, Krzysztof Kozlowski wrote:
>> The driver can be compile tested with !CONFIG_OF making certain data
>> unused:
>>
>>   drivers/usb/typec/tcpm/fusb302.c:1816:34: error: ‘fusb302_dt_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Should this be marked as a fix?
> 

It's a fix for compile test with W=1, so not a real issue.

Best regards,
Krzysztof

