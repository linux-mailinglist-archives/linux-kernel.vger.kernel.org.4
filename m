Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887CB5B4F02
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 15:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiIKN2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiIKN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 09:28:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBBC2B255
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 06:28:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id o2so8494952lfc.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+9UPKb7Ii6FzBDArfIx0mfVT3Zwlk63jeV9czZ35D+0=;
        b=me0+3UlNEKv/v6DZqOPfcO4uSIDs3xkvdhHto4CLAR3VdMynR1c1Kbm3ZYrqIGKYfJ
         VLVB5MrinHp2+2Q3tl+14ZONtMbB+Xr6x0VJpnggNCZYXJwf7RTHoyqiOp+Vl6vjYZGg
         a5j3ubD8QHTK+OTZsBZ8ny6TrkyuCzAIkTLpMQW6OJFkU0x2x3TWHcH9lX4H1SsMoEsd
         v0pgK4CNWQjqw2ZBDAGNeIfkOzqmTcl6bfO+pJv55s0Df1cqB7wmquEsIOuZHuD5DTKF
         d9P1NH3QDR3ctRs0Im7NPYhBI78zEj/plZZlyMypPV4D9IRJeWwZsvcQiEZ9fkXpvZAS
         q+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+9UPKb7Ii6FzBDArfIx0mfVT3Zwlk63jeV9czZ35D+0=;
        b=JHpK67DoQFeX2U6E5HU/M65eXCOud+5wEiB9/r2bxmjKimUPaR+zhmIh38BlNeGyzF
         m/U8TNiMVhFPLOtbhe5W3ElGjOkU29KeUu/i69pwgX/ZyJta/LoTGc4ZFf62RWynh5uk
         UHdv94yy1caYQHgEq7BvEioIIf0Yt/4rV3QlfxYUTye3Pk3fvkaxA4EssCwi+VMlNQLs
         4qnK0KOOFHuWg6JcbO8foMTbmNBn0qQHMu4mdqPWoOYl7y6mqA9vXObCwaaVbZ9o0jeN
         wBm4F1JREL+HkI8fcnQABwM5TmgiCT45Wv6dVevgo2PwdDgbisURquCWaFaMyOKtwVXp
         LJ5g==
X-Gm-Message-State: ACgBeo2bT9J3x7BXwfz9rrkf4PsxySZbbfDMut1+BUbn+ja1mL1Meiok
        WiUJPS7c5uS1onlIYay3BjFc+Q==
X-Google-Smtp-Source: AA6agR5Qa+jJgnLCmlDWo1wDT3VmVkwiXfyp+ekNEOEo4vuUYmkt4gZpNxtizVLDAYMar2xpMDVxVw==
X-Received: by 2002:a05:6512:280d:b0:498:fd40:51d4 with SMTP id cf13-20020a056512280d00b00498fd4051d4mr4083477lfb.167.1662902922803;
        Sun, 11 Sep 2022 06:28:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bj24-20020a2eaa98000000b0026acfe1b3b4sm674886ljb.17.2022.09.11.06.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 06:28:42 -0700 (PDT)
Message-ID: <1bfa4397-47a1-ea46-5ced-8b69fb2452c0@linaro.org>
Date:   Sun, 11 Sep 2022 15:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings
 for DMIC controller
Content-Language: en-US
To:     =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1661872039-40174-1-git-send-email-fengzheng923@gmail.com>
 <25072fba-64e2-df11-c8f0-a274037141f0@linaro.org>
 <CAE=m619qeaDYkWiB5kh50gY1Kndyrvo4oZuZjFKRCKK=j99K2w@mail.gmail.com>
 <0b8b2e01-5209-6437-c79e-3cff9b29bfcb@linaro.org>
 <CAE=m618WS-RKgWn6r1=Zfsd5N-gp3A4S725RtbDKDQ4PLsBk5w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAE=m618WS-RKgWn6r1=Zfsd5N-gp3A4S725RtbDKDQ4PLsBk5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2022 08:18, 班涛 wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2022年9月8日周四 17:22写道：
> 
>> On 07/09/2022 15:03, 班涛 wrote:
>>>>> +++
>>>> b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
>>>>> @@ -0,0 +1,79 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id:
>> http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Allwinner H6 DMIC Device Tree Bindings
>>>>
>>>> s/Device Tree Bindings//
>>>>
>>>
>>> So, modify it to 'Allwinner H6 DMIC Devices Tree Bindings', sure?
>>
>> You pasted the same message, so what is the modification? I wrote you a
>>  search&replace pattern.
>>
> 
> "s/Device Tree Bindings//"
> I don't understand what you mean.

It's a search&replace command from Unix tools...

https://www.cyberciti.biz/faq/how-to-use-sed-to-find-and-replace-text-in-files-in-linux-unix-shell/

https://vim.fandom.com/wiki/Search_and_replace#Basic_search_and_replace

Just remove that string.


Best regards,
Krzysztof
