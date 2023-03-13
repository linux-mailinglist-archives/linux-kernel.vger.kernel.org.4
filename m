Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543F86B704A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCMHt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCMHtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:49:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC06928EA8;
        Mon, 13 Mar 2023 00:49:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f18so14513486lfa.3;
        Mon, 13 Mar 2023 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678693783;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4yYOlkrJK1v/do01qxSdMYmulUpu/Bz4z5n79tBu1k=;
        b=Yq14euj2ZEXOO1Z13UciRGh1FIq3eYbVwu7XXqfHNn8ZNUk0eoY6pGvMG1YumD5ZRc
         BoCOhB0IwWYkiQB3837KE9zJndBUDPLaI6SM4OwA69Ak0WtG6aRCnHdksbv1NWb6Mejw
         EBFspEc8sr9/TJtry4ZEcUskPNgtJUu2ELz3jXfyFuPEZaouqo7IK4xf0+OE4mWv9y09
         DFMG1V68qM9T6pfR58F0iqMJvWL5HeW6fl6Mq1eyqcnmquExrrbesnELBQfDbEP0F5gI
         sm3LrSPkHOf7CP1pQa7q18hOjjIhYwJy+mywTThIb4xPzwiRqPh/U2fIiItKADfPB8X0
         gCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678693783;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4yYOlkrJK1v/do01qxSdMYmulUpu/Bz4z5n79tBu1k=;
        b=3ZS793Hl1EmL6pol4jQI7zPpp4MFtF+jXQnCVV9pFIZHYTBx7o/GF842SmzqGzKI+G
         nU4N3bgjRWiht7TMtyxMNqfNSI+5j4AiQRybztYjE0QpCFclWHV0DFvBgSOxaUs8Lid2
         UPH3yZqkBIA/YpRV6rcagZ6t5j9w64WUqQxLnhi8/Afb5JjKx5fI1T5Z4RRe3GOnfROA
         iZ+xtN27Hfd3js0gUVxhqz8XwuIVnDRJM8x/rRlQynpO5tUvxrMasK8SwqGu/bIdKtXb
         RMkedtutP+0FeRVJyh1z9ioxAIPhSj2ASXxNKTLHbLwqRNqEHOpeleiD2hbG6MghK5xT
         GKbA==
X-Gm-Message-State: AO0yUKU+HPWibkKJSLueoVKE7hmLjeaoAY0OjFv4YVxmG+5IiLCVPYLS
        05YA3KxuAewydol8QWaBrk0hNbZDMf0=
X-Google-Smtp-Source: AK7set/3x4g6gp5V4j/Q4A+/l9zd+h05lNZudorUUx6mekGqubbXSn2N8HTmL13hON26vrirmk98GQ==
X-Received: by 2002:ac2:5962:0:b0:4dd:9ddc:4463 with SMTP id h2-20020ac25962000000b004dd9ddc4463mr8714799lfp.5.1678693783232;
        Mon, 13 Mar 2023 00:49:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b004e81c9bb65csm880516lfh.282.2023.03.13.00.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 00:49:42 -0700 (PDT)
Message-ID: <eaa72600-b85a-fa97-45ff-6412696682b6@gmail.com>
Date:   Mon, 13 Mar 2023 09:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-7-sre@kernel.org>
 <CACRpkdYTD3OZ-44N0oRD93gToxR_DoFSkLhvNjrRpCms2TX5nw@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCHv1 06/11] power: supply: generic-adc-battery: drop charge
 now support
In-Reply-To: <CACRpkdYTD3OZ-44N0oRD93gToxR_DoFSkLhvNjrRpCms2TX5nw@mail.gmail.com>
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

Hi dee Ho all,

On 3/10/23 10:29, Linus Walleij wrote:
> On Thu, Mar 9, 2023 at 11:50 PM Sebastian Reichel <sre@kernel.org> wrote:
> 
>> Drop CHARGE_NOW support, which requires a platform specific
>> calculation method.
>>
>> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> 
> I agree. If we want to support this, we should use the generic
> methods with interpolation tables defined in DT as well, and it also
> ideally requires load compensated resistance calculation to figure
> out Ri so this can bring any kind of reasonable precision.

I guess you have your reasons, besides you have far better insight to 
things than I do - hence I am not really objecting this - just asking a 
question ;)

Do we have generic facilities of computing this based on the DT tables / 
Ri in place(?) I guess that we do need/see platform specific 
implementations as long as there is no generic "de-facto" way of doing 
this available...

Well, maybe this helps kicking things to that direction :)

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

