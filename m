Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65AC6BC6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCPHOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCPHOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:14:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB45FADC11;
        Thu, 16 Mar 2023 00:13:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a32so618262ljr.9;
        Thu, 16 Mar 2023 00:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678950818;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2wFT7CrRqcdyw8L0sjGieOy+9WgGuAwjTPbuLH379I=;
        b=AFZJv8f0LnZQ0fM7TsswxbUC8egy/hgi+pKDIFZnbGJyZicjuFs+lKy4jytlsC1VbR
         KkA2qJJTH1nNsThH8SdG4AyIb++pNptf/eT4c81KKQxuJwAIqZQBotg0fRx1sNmEwILo
         8Vpf2q8SkRmfx/gZMIwO3oZjPtz7znR8+OHM25x4suC5PQgC/W0zo7gC04rnEhLuIoUR
         Sn781dn8NyRnKUwFIzSyOcVRXmAiiHtp5Q92oUq1AZLfsx1Bj4a/OP2CwAXbHiOTfpja
         Z66ZYWwy9gDvI4r37kODI/cJpcvhkdt8Lwk/PIGi2EKaY0mCj+f1tQ9iuQvcmNXqcYUc
         nMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678950818;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2wFT7CrRqcdyw8L0sjGieOy+9WgGuAwjTPbuLH379I=;
        b=XmwElcI0/2nr2BsgRNuk46OUlXcUdnjt2UrngOXZJf19XtZedtpMYX1bOxOiWM7YM/
         cDeRzFjHcvKHtKDnD1xbxfSsAclQfvgLWRNeq+D4ogAgwvW4vHr2zgEWeFMSzlxAD8NE
         9ZPzIMrvbGyWqwchFWGTBoRVCtqmU5VjbUn/Cd+2TK3Zi5aTJSVBmobeB6Cv2vT1HspI
         +jyusPuTbez7ad91ihBqJqXqSacAcK6Dw6ZRd7e/Rqe5cihQJC6GQAcCHY3HPm6gEpCF
         bNE/hP6KEBCYxAHDCFPKAPjUNx8+UiJlXQcAsNIjjW5CDvAqJUSWYEuPUJV22GVS9q32
         s69Q==
X-Gm-Message-State: AO0yUKVH4Ztn2jy5fDurNv2sJub35lWkhSDMM8OqGu+NQc8NIK4zbLV0
        8j0cL0M3InSKVzjS1CgU4EQ=
X-Google-Smtp-Source: AK7set+QXuT4Phd7o0BtowhfYtOterzcc0ah/2EqaDQmwvsYz8jF5sUdZeNB2iugK3zTYb4BrkcsRQ==
X-Received: by 2002:a05:651c:10cf:b0:28f:8fa4:7c25 with SMTP id l15-20020a05651c10cf00b0028f8fa47c25mr1421917ljn.25.1678950818031;
        Thu, 16 Mar 2023 00:13:38 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id t17-20020a2e9d11000000b0029353caa593sm1124713lji.5.2023.03.16.00.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:13:37 -0700 (PDT)
Message-ID: <f581a290-4f10-5f32-7640-8c5dea0ccfce@gmail.com>
Date:   Thu, 16 Mar 2023 09:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv2 02/12] power: supply: core: auto-exposure of
 simple-battery data
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-3-sre@kernel.org>
 <baffa307-173c-6ba1-0289-e7287049c0f5@gmail.com>
 <20230316004121.rwieru4aj7d6mwgb@mercury.elektranox.org>
 <de0848f7-7f33-b170-54b7-f0fbf4e5d7d6@gmail.com>
In-Reply-To: <de0848f7-7f33-b170-54b7-f0fbf4e5d7d6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 09:10, Matti Vaittinen wrote:
> On 3/16/23 02:41, Sebastian Reichel wrote:
>> Hi,
>> [08/12] power: supply: generic-adc-battery: use simple-battery API
> 
> This one did look good to me but as it was pretty trivial one I didn't 
> think my review made much of a difference :) I can reply with my tag on 
> that one though as I did review what there was to review.

Sorry! I mixed this patch with another one. This indeed did have some 
changes - I must've accidentally skipped this one. Will check this after 
eating my breakfast :)

> 
>>
>>> [...]
>>
>> Thanks for your reviews,
> 
> Thanks to you! You are the one making things better here, I am just 
> treating this as an opportunity to learn ;)
> 
> Yours,
>      -- Matti
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

