Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1070E753
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbjEWV0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEWV0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:26:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C71126;
        Tue, 23 May 2023 14:26:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso682808a12.2;
        Tue, 23 May 2023 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684877162; x=1687469162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PgxNHZj4UwDTS6F97+9NYcBDmjYn8Q7KCM1kPowz7w=;
        b=rdkjx024S826zFQkHayX4XQWkfaqCgEmXWLe2SH+kJRaGjunBCKBHxzmBUuOT4HqoA
         GhpyD5VgYelYdOaNGRjM3P4w8UyNnMGeNePUUNGw8lI4L59i+5eskWGOPrigjf21tqkz
         tGgr3RNsmuT5JK1woaEp46lIyPnyCGbi5HGZ52bnlwbofyF/X/doqeCA0wNfrEvxHAof
         JXJHwSRrvv3u4Uesne2HIYtSEOhQhRfigviWDRjbx1jntDN52TleN+32DKEK2EbEF4wz
         9UxmR16hwxUgTK6tNQMddtXkLT9Gq2+qFEzmJGweaoBDneFHkPXRug44XTsWEtKg+eMU
         FyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877162; x=1687469162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PgxNHZj4UwDTS6F97+9NYcBDmjYn8Q7KCM1kPowz7w=;
        b=XBfU649+G3bUdxysovdjQvFHXj3iV0upVNBgDfAWeZZxLiFWHOGoN0PLx44qzN1DqC
         F0ED65Sdxmentfunseh4z0D9hJyi2woRNgIu/qGsl6Ftt82y1cB9CghQ77dLStll+xcm
         k1LtWWGOsjH1/PI82KTVqXoQNE4Qf5xpB8ZPUF/YC5fi/QKbdtUt0nUo7ZeZzjR3QQKg
         J82xsq99V6gpsDoWDP5Qvn4ITTViQpnaN8Tma6BUKDI3OdEpKVFpVxYslWGvWdWKhwTa
         EYt86yRTSMXxgJZf2qzurDix/g4OAkkRY8+rBhOZZGp95DAsNF22XQ+qSu6/+NvNM2+M
         Ol2w==
X-Gm-Message-State: AC+VfDzF+1C26y86t6y6nytq3k0HXwDJ1X7rVvNLmj2jTLkEHKFVf8LW
        J8qnlj8yYcrybnrOpJ88FuE=
X-Google-Smtp-Source: ACHHUZ65tHm0pxgScIUa0KaMsUX6v1DGtLyGO2CEmEvCmIHRx9ohEEp+ai4aBgw9Rti2j00nkuO3Zw==
X-Received: by 2002:aa7:c614:0:b0:510:d889:88c8 with SMTP id h20-20020aa7c614000000b00510d88988c8mr255307edq.38.1684877161960;
        Tue, 23 May 2023 14:26:01 -0700 (PDT)
Received: from [192.168.50.244] (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id u17-20020aa7d891000000b0050bd19ec39bsm4364090edq.83.2023.05.23.14.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 14:26:01 -0700 (PDT)
Message-ID: <0c08fd7b-435c-67e9-f2a2-543a72cb3140@gmail.com>
Date:   Tue, 23 May 2023 23:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 2/3] drm/panel: Add Samsung S6D7AA0 panel controller
 driver
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230519170354.29610-1-aweber.kernel@gmail.com>
 <20230519170354.29610-3-aweber.kernel@gmail.com>
 <20230523180212.GA1401867@dev-arch.thelio-3990X>
Content-Language: en-US
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20230523180212.GA1401867@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/05/2023 20:02, Nathan Chancellor wrote:
> Hi Artur,
> 
> On Fri, May 19, 2023 at 07:03:53PM +0200, Artur Weber wrote:
>> Initial driver for S6D7AA0-controlled panels. Currently, the following
>> panels are supported:
>>
>>  - S6D7AA0-LSL080AL02 (Samsung Galaxy Tab 3 8.0)
>>  - S6D7AA0-LSL080AL03 (Samsung Galaxy Tab A 8.0 2015)
>>  - S6D7AA0-LTL101AT01 (Samsung Galaxy Tab A 9.7 2015)
>>
>> It should be possible to extend this driver to work with other panels
>> using this IC.
>>
>> Tested-by: Nikita Travkin <nikita@trvn.ru> #ltl101at01
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> 
> <snip>
> 
> This change as commit 6810bb390282 ("drm/panel: Add Samsung S6D7AA0
> panel controller driver") in -next causes the following build errors
> with clang and GCC older than 8.x (the kernel supports back to GCC 5.1).
> 
> With clang:
> 
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:312:14: error: initializer element is not a compile-time constant
>           .drm_mode = s6d7aa0_lsl080al02_mode,
>                       ^~~~~~~~~~~~~~~~~~~~~~~
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:415:14: error: initializer element is not a compile-time constant
>           .drm_mode = s6d7aa0_lsl080al03_mode,
>                       ^~~~~~~~~~~~~~~~~~~~~~~
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:443:14: error: initializer element is not a compile-time constant
>           .drm_mode = s6d7aa0_ltl101at01_mode,
>                       ^~~~~~~~~~~~~~~~~~~~~~~
>   3 errors generated.
> 
> With GCC:
> 
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:312:14: error: initializer element is not constant
>     .drm_mode = s6d7aa0_lsl080al02_mode,
>                 ^~~~~~~~~~~~~~~~~~~~~~~
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:312:14: note: (near initialization for 's6d7aa0_lsl080al02_desc.drm_mode')
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:415:14: error: initializer element is not constant
>     .drm_mode = s6d7aa0_lsl080al03_mode,
>                 ^~~~~~~~~~~~~~~~~~~~~~~
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:415:14: note: (near initialization for 's6d7aa0_lsl080al03_desc.drm_mode')
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:443:14: error: initializer element is not constant
>     .drm_mode = s6d7aa0_ltl101at01_mode,
>                 ^~~~~~~~~~~~~~~~~~~~~~~
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:443:14: note: (near initialization for 's6d7aa0_ltl101at01_desc.drm_mode')
> 

I've submitted a patch, "drm/panel: samsung-s6d7aa0: use pointer for
drm_mode in panel desc struct"[1], which should fix this. I tested it
with GCC 13.1.1, GCC 6.4.0 and Clang 16.0.3, but I'd appreciate any
further testing and feedback.

Apologies for the error.

Best regards
Artur

[1] https://lore.kernel.org/all/20230523212050.9970-1-aweber.kernel@gmail.com/T/
