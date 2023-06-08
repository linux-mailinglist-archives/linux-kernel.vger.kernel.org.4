Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23165727B9C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjFHJje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjFHJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:39:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4EF213C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:39:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so310661f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686217169; x=1688809169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kis83jMD1oWs6024Wvt+G1gr/3Bk88oMA3d6rNJj5g4=;
        b=dh2IGeZP1UXlw/rxc8tHwYftXW4vIKDKiSgUwwpYDTnQLnUUZ2eKQNpLe1ae+OOkaq
         ZUOfth6aGXN7TreMG667Tdd0b9nHJipOIZXaw1UP6PJgGrkbGVKv9GmuLrgVrxUYmEtL
         Jn5nUBOvSxF1p5Yll4gh3dz0l4pJpALQwXgKrtbWLz6N817Sd0MTH8Sbh8LY9iGf6iAv
         CA9Rl9Ase8AAeu4Y4vACb40mBoVt52+cKQzMjzXTUPPT7gr2SzKoi+ST2qflIt5sBVSX
         V4/djTioCzHuu7SKvoD/QBgRw4Sn1CPnceGIBVTQmGx0HHJWzWQOb8PCENz9gqNAuTcO
         o5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686217169; x=1688809169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kis83jMD1oWs6024Wvt+G1gr/3Bk88oMA3d6rNJj5g4=;
        b=QU/3b4/FKHwhOIsQ551MATEk8MuG+eISf0HMOnxOnUugFwihA8QzLbsUXSU+3V/9CX
         LQRXsGjBMxnKEs65SJ0nIpywNBC+yfBMqnXefYwuPSMlJMU+DzkIjLwuqm/dSB50YMqo
         RMspioF7MJGyJUj4RxHbKnRWe8fEquESE71h0kK/WJwem//Ef/X62DyQ651Gkkmc4Usb
         zvnPG/wxkVwzY1kNRNxlkOr4kwxVELz6aWlsXAiqnqclQQ4UAsAx09yBhOdtJosaoWZf
         0xw1qhxmPEJY0PS7ebgLjPAoLESTQqJsIV7WXAvefllkrb//jTd5tDCgaH2OFvLT+QX2
         87EQ==
X-Gm-Message-State: AC+VfDxfQ2Mo7pQjSKmnfw/4T4ZtOJQvbJk66cAHq4RlbfK6PS5lSCsA
        kj/5twvP1vQ6PzhzO44ceITbSg==
X-Google-Smtp-Source: ACHHUZ7Ms6WXtKfgT/Z+U3P+H7HunJuUiCLEYOMq2NRw8YGy939Doi5kEfI1/uibHdDRb84aF9r7Mg==
X-Received: by 2002:a05:6000:108a:b0:30e:56b3:60fe with SMTP id y10-20020a056000108a00b0030e56b360femr1337520wrw.4.1686217168916;
        Thu, 08 Jun 2023 02:39:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3a59:921c:4758:7db5? ([2a05:6e02:1041:c10:3a59:921c:4758:7db5])
        by smtp.googlemail.com with ESMTPSA id u13-20020adfeb4d000000b00301a351a8d6sm1046418wrn.84.2023.06.08.02.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:39:28 -0700 (PDT)
Message-ID: <59c7c90c-50f2-5a77-af12-b266c6e6e0b1@linaro.org>
Date:   Thu, 8 Jun 2023 11:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230530195132.2286163-1-bero@baylibre.com>
 <CAGXv+5EVfgEBDm=7MmQ=OsP322KmE23PwycJ-0LjU+3dEZygUQ@mail.gmail.com>
 <572f5a88-8c2e-4324-b477-836a5024ec67@notapiano>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <572f5a88-8c2e-4324-b477-836a5024ec67@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 19:09, Nícolas F. R. A. Prado wrote:
> On Wed, May 31, 2023 at 12:49:43PM +0800, Chen-Yu Tsai wrote:
>> On Wed, May 31, 2023 at 3:51 AM Bernhard Rosenkränzer <bero@baylibre.com> wrote:
>>>
>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>
>>> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
>>> Also, add Suspend and Resume support to LVTS Driver (all SoCs),
>>> and update the documentation that describes the Calibration Data Offsets.
>>>
>>> Changelog:
>>>      v4 :
>>>          - Shrink the lvts_ap thermal sensor I/O range to 0xc00 to make
>>>            room for SVS support, pointed out by
>>>            AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>>      v3 :
>>>          - Rebased :
>>>              base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
>>>          - Fix issues in v2 pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>:
>>>            Use filtered mode to make sure threshold interrupts are triggered,
>>
>> I'm seeing sensor readout (either through sysfs/thermal/<x>/temp or hwmon)
>> fail frequently on MT8192. If I run `sensors` (lm-sensors), at least a couple
>> of the LVTS sensors would be N/A. Not sure if this is related to this change.
> 
> Yes, it is. Filtered mode has some delay associated with reading, meaning most
> of the time the value isn't ready, while immediate mode is, well, pretty much
> immediate and the read always succeeds.
> 
> For temperature monitoring, filtered mode should be used. It supports triggering
> interrupts when crossing the thresholds. Immediate mode is meant for one-off
> readings of the temperature. This is why I suggested using filtered mode.
> 
> As far as the thermal framework goes, it's ok that filtered mode doesn't always
> return a value, as it will keep the old one. But of course, having the
> temperature readout always work would be a desired improvement.
> 
> As for ways to achieve that, I think the intended way would be to enable the
> interrupts that signal data ready on filtered mode (bits 19, 20, 21, 28), read
> the temperature and cache it so it is always available when the get_temp()
> callback is called. The issue with this is that it would cause *a lot* of
> interrupts, which doesn't seem worth it.
> 
> Another option that comes to mind would be to enable immediate mode only during
> the get_temp() callback, to immediately read a value, and return to filtered
> mode at the end. That might work, but I haven't tried yet.

Why not understand why the filtered mode is unable to return temperature 
values most of the time?

I tried with the filtered mode and I can see 90% of the time it is not 
possible to read the temperature.

IIUC there are timings which can be setup, may be understand how to set 
them up in order to read the temperature correctly?

Caching values, switching the mode or whatever is hackish :/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

