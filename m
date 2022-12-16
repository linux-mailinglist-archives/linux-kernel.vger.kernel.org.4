Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E164EC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiLPNfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPNfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:35:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFE527F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:35:37 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so4179374wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQCf+qv5bd4ElCdzVZ3jNTOUbAb4CRaR/pYBuk0Bj3Q=;
        b=WiX8W2ruP+9YIPUcE2mF7jpRd3+tQbG6B2pisNWD/F60SYsz/mLlJkPZKeDevbWyRR
         K3KWOQt5JlSPIGHJ03kmpT/LleN/eJ4Ljj1BXCrk7hPDWmmg0xQdx6u03lmd4xjNjWfE
         BjZ3Vw+3gB7y+hLUsh9GD67YNKZD9pa2fKi4RiI6m53Q9XH2XTujXEFIwY+qBIDmBvA+
         koZnM84R/FLjnl3Y2ViXf/7Wv7J2Ku7Mz/t7vuYdkf7fc7ggibO4dwch/u8M0+uCQ4Pq
         TlpTwQnR/j9wUl+DutoY9257humQH0Zg6MVNqP6ZvVVbxY6JFpKMSFlA3VzUINIkEKUj
         O+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQCf+qv5bd4ElCdzVZ3jNTOUbAb4CRaR/pYBuk0Bj3Q=;
        b=CBgj52E2U78qo+pNutzrFyHMbSZynQoFktRklGsg8BTcJKkA0W9UEuTMl9IuyQon0c
         1F5m8Zkz6Sx7GZQwHAkMawyeykoYiVkJA12f6cs7AbeQqsWQFQ0p9EfK2ZgKVuZHTt7x
         BxKEMisZlhMxkWPI2LAovQSEyqyeQ1TOh4hTZgldoLvR+CsRlDhkWEuFeayHiiTlHNEH
         JUQH/N4jsTYRZBbJ/dSjBa+Gj2xuWRgc0GiLPjtbPHWnGfy2QyBu/VWYsldouRIZIzag
         tP8JuW7zsu1Lv374PWL5Za3VAV+goRHt1aC2O84SuUjgiUoQJik6bas4vdB4HZYScrJW
         olGg==
X-Gm-Message-State: ANoB5pmlPjfo9jMN+EC1TgPk4r9LegcqzI6xqPgimZJ2fgt420R3pmrg
        Jf9Vwyg19s6BZgxtX1zyRww=
X-Google-Smtp-Source: AA0mqf5cIONd+2x+L2MXCRiqZq2/EcC0pk+sRNVlYXBgoIRtXYMkzbVBjpJ730j3x5UYsqwZQ1EoJg==
X-Received: by 2002:a05:600c:3592:b0:3d1:bc32:2447 with SMTP id p18-20020a05600c359200b003d1bc322447mr25311006wmq.21.1671197736187;
        Fri, 16 Dec 2022 05:35:36 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c510d00b003c6f8d30e40sm11757007wms.31.2022.12.16.05.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 05:35:35 -0800 (PST)
Message-ID: <52a9924a-aaea-ed31-672f-fdf8e1ef2881@gmail.com>
Date:   Fri, 16 Dec 2022 14:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] soc: mediatek: Add deprecated compatible to mmsys
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org
Cc:     nancy.lin@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221111082912.14557-1-matthias.bgg@kernel.org>
 <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com>
 <CAGXv+5FORS=iGe55StxR_1E3sdtk9cvitfvNa1SydqCjWGcubg@mail.gmail.com>
 <CAGXv+5GfZYdhSCkhdGXRvbprwhceMJy9a9j+cNxsyUFYhMNZOw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5GfZYdhSCkhdGXRvbprwhceMJy9a9j+cNxsyUFYhMNZOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/12/2022 12:25, Chen-Yu Tsai wrote:
> On Thu, Dec 1, 2022 at 7:20 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> On Mon, Nov 14, 2022 at 7:59 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Il 11/11/22 09:29, matthias.bgg@kernel.org ha scritto:
>>>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>>>
>>>> For backward compatibility we add the deprecated compatible.
>>>>
>>>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>> ...And tested on MT8195 Cherry Chromebook.
>>
>> This now seems like a bad idea. In the dtsi we have two nodes (vdosys0 and
>> vdosys1) that both currently use the -mmsys compatible, which in the driver
>> maps to vdosys0. So not only do we have vdosys1 incorrectly probing as
>> vdosys0, we also have duplicate clks being registered and duplicate DRM
>> pipelines. On my device vdosys1 ends up winning the duplicate clock race.
>>
>> I suggest just reverting this. The display stuff won't be useful unless
>> the drivers are able to distinguish themselves from one another.
> 
> That and try to fix the vdosys0 node ASAP.

I'm not sure what you mean? If there are any patches that are in my queue that 
needs attention, please let me know.

Regards,
Matthias
