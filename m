Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B199B6D9FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbjDFS1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFS1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:27:41 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF58900C;
        Thu,  6 Apr 2023 11:27:36 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o25-20020a9d4119000000b006a11eb19f8eso19953817ote.5;
        Thu, 06 Apr 2023 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680805655; x=1683397655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Urs0sPmIxKY7EMdaMcVPb88xjrnr7/n5Z/v53+WXKo0=;
        b=aNBjohhSpNCH5LwvwGucbPyygMc7wmva992tdG/a7wUKHSEJdIWnQpidnRQFyxIcaF
         D5vuDuu4DzBQ99/UvSAR1oyfEdeGW1N1XOpIlxgpDHtgZc+jrdqz+6mads5i7seB5MbA
         7WbXP+eJ4EXSrGoWg/ms+felB+/BFISBR78vepSQj02EmC56OI85FMg+zoCGfM7DjL0l
         OXSwMQqICF/hpyKxfBguULLnvqJzmMPsbd7zy3IZsE4ghBqFHTaSXFisz1Hc5FXlhMgc
         LxV+6ujBfIlq0Wzh+++RgLdeCzzIH5AZJI6j8t9OlSvnw42+Mh4qN/HvJ8pgTU8doGoR
         tm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805655; x=1683397655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Urs0sPmIxKY7EMdaMcVPb88xjrnr7/n5Z/v53+WXKo0=;
        b=IBPc88Aw3KBlhVn2TGohyTS/6jWgdDRCGaVvSnGR7eh1oSvvmN3SwAn8UVAqjc9IXb
         2ZCxnHXkop8nDGg+QUx1ivWu2HhIAGFPS0tmNVG0ZeaCVZKIvCJnNurNEgXbRB3l2z5O
         MnWcrAvKab9RLsVo1lvMG58CKbQUWd3uh4PAVrUJPnBpPkYRlM4qCMQFODIGgXhzJNXG
         uY6lVuPn03Jm6IAO1YyZQQqgaisxtrik/blyo38Vx9vpTSr007WxycvhuuI9jWJKYRji
         e3peygcMKoO5sr5BlZ384q+pIoeC3HXvD5AWLmHqLcIZAvhWAJXzOihdioFck69VVZ59
         dtyg==
X-Gm-Message-State: AAQBX9c2RWwazLGQhgifTaMu9AwdaWqy3t7bCDloBMkULTxCg8c80uJ6
        rTRqGM9279rMaiD9EugNUPg=
X-Google-Smtp-Source: AKy350Z9t6tWzzltI8glK73b80eEQJnXz/5+x0SuFtrFkF7BWJRMfu+4DcuHG6U2OVSbqb4D7zQ/0w==
X-Received: by 2002:a05:6830:334d:b0:69b:1665:8fb3 with SMTP id l13-20020a056830334d00b0069b16658fb3mr3361991ott.15.1680805655572;
        Thu, 06 Apr 2023 11:27:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x17-20020a9d6291000000b006884c42a38asm974512otk.41.2023.04.06.11.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:27:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <31a5bd88-4121-ac5c-0d8d-eee6b221f1db@roeck-us.net>
Date:   Thu, 6 Apr 2023 11:27:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: (subset) [PATCH v2 0/2] Add PWM fan support to Rock 5B board
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20230404173807.490520-1-cristian.ciocaltea@collabora.com>
 <168071663557.3186456.17606522894011578076.b4-ty@sntech.de>
 <1a914522-8780-febd-7224-121b1f1fc2ba@roeck-us.net>
 <840877554.0ifERbkFSE@diego>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <840877554.0ifERbkFSE@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 14:35, Heiko Stübner wrote:
> Am Mittwoch, 5. April 2023, 21:04:04 CEST schrieb Guenter Roeck:
>> On 4/5/23 10:45, Heiko Stuebner wrote:
>>> On Tue, 4 Apr 2023 20:38:05 +0300, Cristian Ciocaltea wrote:
>>>> This patch series enables support for the PWM controlled heat sink fan
>>>> on the Rock 5B SBC and, additionally, converts the hwmon PWM fan bindings
>>>> to DT schema format.
>>>>
>>>> Changes in v2:
>>>>    - Updated PATCH 1/2 according to Rob's review
>>>>    - Added Reviewed-by from Christopher to PATCH 2/2
>>>>    - v1: https://lore.kernel.org/lkml/20230403105052.426135-1-cristian.ciocaltea@collabora.com/
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>
>> Both patches or only the second one ?
> 
> only the second one of course. According to earlier talks the dts patch
> does already follow the text binding, so the yaml conversion is actually
> not a requirement for it.
> 
> So I picked the dts patch let the binding sort itself when people have
> time for it :-) .
> 
> 
> Looking at the mail b4 created, I guessed this would also be visible
> with the subject saying (subset) and the listed commits only showing
> 
> [2/2] arm64: dts: rockchip: rk3588-rock-5b: Add pwm-fan
>        commit: f36bb17653e4b9e26bbdb1224027d20614e77636
> 

Kind of, sure, but I figured it doesn't hurt asking to avoid the situation
(again) where I apply a patch and then get a nice e-mail telling me that
some other branch also applied the same patch.

Guenter

