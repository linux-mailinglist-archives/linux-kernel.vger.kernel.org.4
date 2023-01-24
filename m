Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88771679F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjAXQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjAXQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:55:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB034673E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:54:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e3so14484712wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbqVM245e6Z56JV4fTQJ7zaDg0Ij9XOsJaiCe7CtwSI=;
        b=h9LyvKHpqcEYEPF91dnPtmFsg1Q6w8uYVb2sKT5lMeEyiXpW96z3iumL0u0qM1EwnP
         TaEq0f7B7VcO3hhRz873j1GGvz3+FmJE7ftqI3EmXHTyPfEuscdo1Y0auets+Uzj96fz
         3b8Sfk850eA9XSOcGeLhQMjjUawr2P1mW3DBLH9R9rJ4pR67US94mJFlVXE4lIG/zAQC
         hdKBPYGS6SFhYb4Rk85tG5GsGjSk1qF6y1lf1+5DGuOQoSkYJHQUyz/QL4Di4suWiStE
         iP1ZegoV7hRyoYC6qVqk6YvjC9EnREHXN0x5FmMmoUmlwPp+bUas8Xpu4jXLYakET2/w
         8Psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbqVM245e6Z56JV4fTQJ7zaDg0Ij9XOsJaiCe7CtwSI=;
        b=hZ+5HyBzN7puqr1yB7br2/HBB6SomoP7Mmblzk3k91dyoG2eudujcxiKshzZ56/PlX
         j0KjT9oUqF/OhAuo89eFGHz2ec6iZcLPHtD8++6W8un+aoehh1T87lyApnnWD/1Biq7D
         9QFy4YHJFmPuFjZ4X9/s9zqOrJMbSbM9DwLPBHxaQ+DWM79n01mb78JEem0KLCu3eSsE
         +QIPKuLMSsZUmbWTe9d9wR4mHfHUczOuycVeFuABhn3iiYYkyo3SoWOEN/2HmQH3psJd
         Q133NfKGFcIH9K61oI6YQgdrsCvuPxKlkvelo1eJhKRmURgckbUwCbRZkfr9SoFLzmVL
         JYQw==
X-Gm-Message-State: AFqh2kqXC9oaPKsc2UoN+fiFxAxYpoX6S7DVnSMiSfELYRpUQCDsKR22
        /lgSDW58yISzwiU91AJKa0CT4A==
X-Google-Smtp-Source: AMrXdXvYLP0S2L1TVzYTE/JdyRpc+28HghprLvYQY2mjMLlO48/znsZB/dI8qkE+nkFKCEGaEuUmfQ==
X-Received: by 2002:adf:dd41:0:b0:2be:d9e7:f39a with SMTP id u1-20020adfdd41000000b002bed9e7f39amr12551254wrm.43.1674579294704;
        Tue, 24 Jan 2023 08:54:54 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g9-20020adff3c9000000b002bfb29d19e4sm1427304wrp.88.2023.01.24.08.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:54:54 -0800 (PST)
Message-ID: <9f9547a2-69dd-f91d-c587-289156bf9d55@linaro.org>
Date:   Tue, 24 Jan 2023 17:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michael Kao <michael.kao@mediatek.com>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
 <20221018-up-i350-thermal-bringup-v7-4-ebf08ff2eddb@baylibre.com>
 <4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org>
 <COTTJX635TNF.1WL2TEZN7VW9O@amjad-ThinkPad-T490>
 <adfe41f7-00e5-876b-7803-3127919fba13@linaro.org>
 <COUMF3IZ9Y63.LA3KFHJSUZIC@amjad-ThinkPad-T490>
 <0644aede-c281-3919-50e0-4466f6587d81@linaro.org>
 <187b0fe1-1f14-d8b8-c827-1e824da0b1d3@baylibre.com>
 <d3daece0-ed23-fae7-9bc8-c6e53b84e8e7@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d3daece0-ed23-fae7-9bc8-c6e53b84e8e7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Amjad,

On 24/01/2023 11:08, Amjad Ouled-Ameur wrote:

[ ... ]

>>>
>>> IIUC, there is a sensor per couple of cores. 1 x 2Bigs, 1 x 2Bigs, 1 
>>> x 4 Little, right ?
>>
>> MT8365 SoC has 4 x A53 CPUs. The SoC has 4 thermal zones per sensor. 
>> Thermal zone 0 corresponds
>>
>> to all 4 x A53 CPUs, the other thermal zones (1, 2 and 3) has nothing 
>> to do with CPUs. The cooling device type
>>
>> used for CPUs is passive. FYI, thermal zones 1, 2 and 3 are present in 
>> the SoC for debug-purpose only, they are not supposed
>>
>> to be used for production.
>>
> After reconsidering the fact that zones 1, 2 and 3 are only used for 
> dev/debug, it might be best to avo >
> aggregation as you suggested, and keep only support for zone 0 in this 
> driver. Thus I suggest I send a V8
> 
> where I keep only below fixes for this patch if that's okay with you:
> 
> - Define "raw_to_mcelsius" function pointer for "struct thermal_bank_cfg".
> 
> - Fix "mtk_thermal" variable in mtk_read_temp().
> 
> - Set "mt->raw_to_mcelsius" in probe().
> 
> 
> For zones 1, 2 and 3 we can later add a different driver specific for 
> dev/debug to probe them to
> 
> avoid confusion.

You can add them in the driver and in the device tree, but just add the 
cooling device for the thermal zone 0.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

