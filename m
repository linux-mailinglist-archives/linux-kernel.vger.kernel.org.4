Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419226A80A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCBLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCBLDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:03:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642E9773;
        Thu,  2 Mar 2023 03:03:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so1408611wmb.5;
        Thu, 02 Mar 2023 03:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677754998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkHuEvWnBbmn6J9IHM/XCzxQvuZdAVkzVZy6DwR1zSo=;
        b=BDwGZkebAseiLNLVCP3fUulwLJK3BAX6aOcYlZdJ+9o6XbspZwfiY6Nq+XWUlz6nDj
         wvkfkvOMwBz+Y3CSBSqSj/Mr/0HLiTSpB60Refn0RsFsoUYV9EQKiEUyXDO2C2j3vsXn
         3wPXBf36Se2Y/sJRwqyv4Cc4TAoxUMqulXfIaPl9A+jxUUK98tgYRx0MDJ/fCDyptD9k
         3c3hnIyvs7sHYFIMFJqW7cnHazcSl3v8w2HjnJ68GuCKLiPLFXRnQynkxeVUch90WOhG
         Z9BGa+3XNat+LQZFAB0HGYdd7kdeoTzQaOqrczqzPqeQDKdYfnkr6TLlHpJ0Pclfalt+
         Inpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677754998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkHuEvWnBbmn6J9IHM/XCzxQvuZdAVkzVZy6DwR1zSo=;
        b=0m265S3/NbzNAAGnFt0l261EDZ0PRFrJBFE7NJp1CReZ0ZDnBMbmPYGhVidzcC4dRx
         X28ONaZtuH3dAkeTeO0SkMczTvu91dYO7v0GTn0BCLuMglY+94J51gHju7EHncmyysRc
         mVZL/0M4em7aLEM8ivOsZ63WQWpsInYmVE074wUSHtmum4l69++8g6M21at3rHEdUEKS
         5JPhfAwgdYOYB+3u3vH8oQ7fOEcTa2pJc7PgvwK2ppGTvpLuE7NASwqgbck0NhiJB29S
         +qzy44J2xv4gAnIpxxz6xuBR/FyWmJsgECTfUERHRuPY/+fPBvrhm4vkuo+QYUBzPvck
         WJbg==
X-Gm-Message-State: AO0yUKWlDoMgdXO2t0PofjgpUS8R2EGF659IB+KfvE9Xj8rRC1fyiTn2
        Pk0aVJYFpfAYXHuX3WwNOU4=
X-Google-Smtp-Source: AK7set/JlzFceze8hhK3/4uajo1mpfVadvTq9TwAVwpchmL5fNm1Ggc9LQk17dnZcbn2PRNdl/6H1A==
X-Received: by 2002:a05:600c:458b:b0:3e9:f4c2:b604 with SMTP id r11-20020a05600c458b00b003e9f4c2b604mr8193890wmo.24.1677754998008;
        Thu, 02 Mar 2023 03:03:18 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c1c2800b003dd1bd0b915sm2893847wms.22.2023.03.02.03.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 03:03:17 -0800 (PST)
Message-ID: <dcd653a3-3f7c-7bfb-f096-033f62cb9074@gmail.com>
Date:   Thu, 2 Mar 2023 12:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 4/4] Revert "arm64: dts: mt8173: add mmsel clocks for
 4K support"
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230209160357.19307-1-matthias.bgg@kernel.org>
 <20230209160357.19307-4-matthias.bgg@kernel.org>
 <3db45ca3-9104-826c-9f92-549e07471296@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <3db45ca3-9104-826c-9f92-549e07471296@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2023 12:59, AngeloGioacchino Del Regno wrote:
> Il 09/02/23 17:03, matthias.bgg@kernel.org ha scritto:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> This reverts commit fc6634ac0e5380aeb1063275a2e9a583d41b2306.
>>
>> The mmsys is a clock provider but does not have any clocks connected to
>> it. Therefore assigned-clock properties should be applied to the users of mmsys.
>>
>> This fixes the DT schema check:
>> mediatek/mt8173-elm.dtb: syscon@14000000: 'assigned-clock-rates', 
>> 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> About solving schema checks: agreed.
> 
> Since this is impacting on multiple subsystems (display, vdec, venc), can we
> instead move this to the topckgen node?
> I didn't check if that would trigger another schema check, but I remember
> doing that on Qualcomm DTs a bit of time ago.
> 
> The alternative would be to copy that over more than 10 nodes, which would
> be a bit ... ugly.
> 

Thanks Angelo and Chen-Yu for your feedback. I'm not able to reproduce that 
problem right now, so I'll drop this patch from the series.

Regards,
Matthias
