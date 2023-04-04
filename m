Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8346D5971
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjDDHYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjDDHYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:24:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010E1FCB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:23:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so126570712edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680593018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUK8JD+uRunCT3us0+K96/PDNUuY5k90r+of18dK1CI=;
        b=KCPZ9WIUFrgOLZZoO18bDAzfQXIE31N4UEwLOBJqtVyBmVZ5IhG9R2K94tYRAiBGpp
         IdSKoXkP62cwmTIhro2iU98BxSyvrPehTjyKg13FZBIjpIW/UyA42tXQ0+fcT9c2cuKf
         ihEJH/e/nWljXyt5aEdBX5ZaMPgm/NH9/MyctEHEgLlg2T0jv2ePuiPoNzhU92pVU5tE
         WIDOu3WhuHCk3hXS/8KcHxBLwQjs6ngC7QcfwNOodqu3gXae0SDMSnQaUckyAb3f7bKE
         CKtLlle/F0UmWjBa1qIzjgRX8UmZhEk78al2zA/q0CH0CWTqa0koDAH48Zt+wjjYaure
         73Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680593018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUK8JD+uRunCT3us0+K96/PDNUuY5k90r+of18dK1CI=;
        b=IrKGHXS7rSNymVhgGNOS3H+MvfQc5POn4PTuWyZL08JR28dzWUhPUdQ3aLHg1Futpi
         MqO54Fd1WXx12fi/EJOaaN1Pp2VyAiEpguHGL7c9ttqtahEEyGA2l0yd63m8mTMZwKOA
         kgn7JuQTpeHYrGlbAsOd6P1HBoL3Xj+V7tMbafjABdGEG32DCusC5gyJIz5CAIstrsiN
         x+FwcyWawSS3YvuLqlfhYhbm1ezusO/qwBfTYKFnOhyByGGszOxDIrvw7ce1c/h0Yvp4
         I0gokXN43VoDVMvM0j4e+4YmBiBAZ+CddVWijuT2/5dBMBqCI4QPvB3HyfFjzZHm11Rh
         3ETQ==
X-Gm-Message-State: AAQBX9fxH0GIouNkVf8Egc6SPjKD82WHMNDKMJ0ogKavJtP6fsp5YMw9
        Q2nPP8EHRKmVCdkahoDEpBhYDA==
X-Google-Smtp-Source: AKy350bQiKhSapVjYuj1KeJAFbzScHjNUhn44Hy1bYd9SIbkCHzCikODwygDV7z7aWdHWVFHFKuvcQ==
X-Received: by 2002:a17:906:f284:b0:878:7189:a457 with SMTP id gu4-20020a170906f28400b008787189a457mr1212000ejb.51.1680593017797;
        Tue, 04 Apr 2023 00:23:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id tp24-20020a170907c49800b00948c320fcfdsm1664413ejc.202.2023.04.04.00.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 00:23:37 -0700 (PDT)
Message-ID: <f7ab2fcc-93fc-ce87-8767-579d33907225@linaro.org>
Date:   Tue, 4 Apr 2023 09:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/5] mfd: Add support for the Lantiq PEF2256 framer
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
 <20230328092645.634375-3-herve.codina@bootlin.com>
 <20230330160510.GB489249@google.com> <20230331094208.41ab4420@bootlin.com>
 <6d39e9c3-fb6a-4b2a-9889-8fe8d86716d5@linaro.org>
 <20230331141104.42445da9@bootlin.com>
 <a642e653-e3e2-c3d2-68cb-1efc92be05bb@linaro.org>
 <20230331165904.4e7f46a1@bootlin.com> <20230403142822.GA8371@google.com>
 <20230404092036.2d1cd5d9@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230404092036.2d1cd5d9@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 09:20, Herve Codina wrote:
>> I suggest that none of this (besides the child registration, which is
>> achieved by a simple OF API call in this case) has anything to do with
>> MFD.  We are not requesting and initialising shared resources and we are
>> not using the MFD API to register children.  The pin control
>> functionality clearly needs moving to Pinctrl and the rest, if you
>> cannot find a suitable home for it *may be* suitable for Misc.
>>
> 
> I am confused and I am not really sure to understand where to put my driver.
> 
> The core pef2256.c needs to:
> 1) setup the pef2256
> 2) add the children
> 
> To add the children it calls  devm_of_platform_populate() to add the audio
> parts as several audio children can be available with the same compatible
> string.
> 
> I plan to move the pinctrl part to the pinctrl subsystem. With this done,
> the core pef2256.c will probably add the children using:
> - a mfd_cell for the pinctrl part
> - devm_of_platform_populate() for the audio children
> 
> The setup (E1 lines and TDM configuration) still needs to be done by the
> core pef2256.c. Moving this part only to Misc will break the hierarchy.
> The audio children depends on the core pef2256.c as this one do the setup.
> Having in the audio children and the part that do the setup in same hierarchy
> level is not correct. Audio children should be children of the part that do
> the setup.
> 
> So, the structure I have in mind:
> - pef2256.c (MFD)
>   implement and do the setup at probe()
>   Add the children at probe():
>     - pef2256-pinctrl (pinctrl) added using mfd_add_devices()
>     - pef2256-codec (ASoC codec) added using devm_of_platform_populate()
> 
> Lee, with this in mind, can the core pef2256.c be a MFD driver ?

You do not use MFD here, so why do you want to keep it in MFD? If you
disagree, please tell me where is the MFD code in your patch?

Best regards,
Krzysztof

