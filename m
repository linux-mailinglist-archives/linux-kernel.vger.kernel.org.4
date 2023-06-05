Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510FF722031
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjFEHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjFEHxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:53:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F34E9;
        Mon,  5 Jun 2023 00:52:42 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D2CF366056AA;
        Mon,  5 Jun 2023 08:52:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685951561;
        bh=ma8BsYbgBg4IWVmjxVkOdcEeWuXb2Q5wJV89M9WEafQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fPWZk0y1402kA+YZQ63ycsSDCF70dv82ThEZDWUKgjAM19Ezcmg9BuXaMBSW5r3eG
         v5HY8RyJPmXdjOpab1yj3AJGh0K1nZbygk9BYHkj2DBBrgljsi9bDpqQTvTVib2f0d
         IjlHgzHbpOkT7zvjeuyQty8h7zekYuuzxm3d1K6v+WhxfiKSjX94kMTfOerY4NuHz9
         42D14zFM+hwhGtvd9eRF6fb8M//9CH4Ybf1Sww1lUD9I8munXPK2+ORGJO7B+b4g2m
         t/rajBjUgz0i9YqDVFXZ7G/K1AK0kZotmW4GnVin4RAJPoYbeMrZxVmiwOj9fpV980
         NgAic0Zt1XTvw==
Message-ID: <fdc3cfa9-3221-c422-a42b-602410dc22f4@collabora.com>
Date:   Mon, 5 Jun 2023 09:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230530195132.2286163-1-bero@baylibre.com>
 <CAGXv+5EVfgEBDm=7MmQ=OsP322KmE23PwycJ-0LjU+3dEZygUQ@mail.gmail.com>
 <572f5a88-8c2e-4324-b477-836a5024ec67@notapiano>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <572f5a88-8c2e-4324-b477-836a5024ec67@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/06/23 19:09, Nícolas F. R. A. Prado ha scritto:
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
> 

The issue with keeping all as filtered mode comes when we want to add MediaTek
SVS functionality which, on most SoCs, is used only for the GPU (apart from the
MT8183 which has cpu+gpu svs).

It makes sense to cache the readings, but I'm concerned about possible
instabilities that we could get through the SVS voltage adjustment flows, as
that algorithm takes current IP temperature to shape the DVFS "V" curve; please
keep in mind that this concern is valid only if temperature readings get updated
"very slowly" (>100ms would be too slow).

So, point of the situation:
  - Filtered mode, less than 100ms per temperature reading -> cache it, it's ok
  - Filtered mode, more than 100ms per temp reading -> switch GPU to Immediate mode.

Your call.

Keep up the good work!
- Angelo

