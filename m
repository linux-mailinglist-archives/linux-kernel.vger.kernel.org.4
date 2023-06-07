Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554027261CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbjFGN5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbjFGN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:57:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363261FCE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:57:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so1341062a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686146229; x=1688738229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKpvPu5Rm/nURTMMsBy+tWBtqwgLaFCv5S24g6y4mow=;
        b=lMeYAGAQIoc851Xz0eJb0PtiX9acHzzCcIRcU/RyTCtJylY8kOce+BtmAAlbchfgaM
         ux+d4RvKhJql1f2hncN91Yae4vn9KVyIXDZvMApIjJJqotSYy9KErr8ln1HSA9AqQyLj
         QIxdWloAaOUglN1CJzxmEbLFF6S9bmUUeF5KZLKtDC8W5pY5ZG07/IBa480wngvl+pgw
         21f3vyl4N40oShuNEk1gxWHWooKKFb6NMW8ElfrfxNAKnFR4Nt+Hn3BGGE354AXtFJmQ
         UlwcouKzzYJNk++/7CYeYPcBZFy1JC6M3V2I5fXnuIaT5kb6gF26yMald57+QMWk4rjA
         DHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686146229; x=1688738229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKpvPu5Rm/nURTMMsBy+tWBtqwgLaFCv5S24g6y4mow=;
        b=lHoSR0/68n9daGKVa5qOfeLXvCITE6DKIl4r2N1dnN8TuA0elJ7qpr1gE5BHn0QSM/
         2W8cSS+ODU2fXq+6bLU/3nZLDIWCZhbljclMoL5aUZmYpbZJ1o56hF8BVWrdvWr9w1Af
         w2oQSKqFf1+529nkMO4EyDIEZls96Ss7P4FAOAO0kjQHM0WYe28x9CBXG4iZCunJqUXL
         MkWXBd0rMh4fSB00yh64uPYBLLhuEX179w23bv4fHK3bCmXIGa5dJe+Ksxd9MSTdNiOj
         dfsWIIPEEn1BN+mWsUiWSMU4qvNCoUFO8EjR0b2RqzUfVkIu1p8aryHS3NlR+tNPAAJQ
         N33g==
X-Gm-Message-State: AC+VfDwC1fTiuYVGJCmInkcJF779jVQdGUdq7oiuNAe0z/KGWw5abJqo
        yE0DmS+018LhSBewj+folfF2PQ==
X-Google-Smtp-Source: ACHHUZ7EcYvo+spZ1Zu2vN1Sav3wheuQzpa99azcDZ/IzhZp4uRXdRVAhEfFaElWL4x4m1MwMFpu5Q==
X-Received: by 2002:a05:6402:2142:b0:514:9edb:185a with SMTP id bq2-20020a056402214200b005149edb185amr4634692edb.9.1686146229452;
        Wed, 07 Jun 2023 06:57:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p19-20020aa7cc93000000b005166779bfd2sm2893476edt.6.2023.06.07.06.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:57:08 -0700 (PDT)
Message-ID: <14fab6aa-2f9a-c3bc-5ed4-0d4fb20b20d6@linaro.org>
Date:   Wed, 7 Jun 2023 15:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
Content-Language: en-US
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230606140757.818705-1-pavacic.p@gmail.com>
 <20230606140757.818705-4-pavacic.p@gmail.com>
 <dfe2c108-0268-c4d0-226e-b3d2bc8c3369@linaro.org>
 <CAO9szn3PyQQRKsxdsOrmVNMP2xuvN4_dHwb1_TWEqmhnr3TLPA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAO9szn3PyQQRKsxdsOrmVNMP2xuvN4_dHwb1_TWEqmhnr3TLPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 15:38, Paulo Pavacic wrote:
> Hello,
> 
> uto, 6. lip 2023. u 16:45 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> napisao je:
>>
>> On 06/06/2023 16:07, Paulo Pavacic wrote:
>>> Fannal C3004 is a 480x800 display made by fannal that requires
>>> DCS initialization sequences.
>>>
>>> Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
>>> ---
>>> v4 changelog:
>>>  - formatting and style changes
>>
>> Are you sure? I see other changes - removal of some code, handling
>> errors and GPIO.
>>
>>>  - change community room
>>
>> What does it mean? Where is this change in this patch?
>>
>> ...
>>
>>> +
>>> +static const struct drm_panel_funcs fannal_panel_funcs = {
>>> +     .prepare = fannal_panel_prepare,
>>> +     .unprepare = fannal_panel_unprepare,
>>> +     .enable = fannal_panel_enable,
>>> +     .disable = fannal_panel_disable,
>>> +     .get_modes = fannal_panel_get_modes,
>>> +};
>>> +
>>> +static int fannal_panel_probe(struct mipi_dsi_device *dsi)
>>> +{
>>> +     struct device *dev = &dsi->dev;
>>> +     struct fannal_panel_data *panel_data;
>>> +     int ret;
>>> +
>>> +     panel_data = devm_kzalloc(&dsi->dev, sizeof(*panel_data), GFP_KERNEL);
>>> +
>>
>> Drop blank line.
>>
>>> +     if (!panel_data)
>>> +             return -ENOMEM;
>>> +
>>> +     panel_data->reset =
>>
>> You have wrong wrapping here. devm_gpiod_get_optional() goes after =.
> 
> I'm not sure why, but clang-format makes it that way. I'm using this
> style: https://raw.githubusercontent.com/torvalds/linux/master/.clang-format
> Do you have some other style?

Linux kernel coding style.

https://elixir.bootlin.com/linux/v6.4-rc5/source/Documentation/process/coding-style.rst

Don't use clang or other non-kernel formatters.


Best regards,
Krzysztof

