Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D865C358
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjACPvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbjACPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:51:43 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DFB120BC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:51:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id fy8so10822644ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 07:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=taOMH3TFvYbtpRD0i3FdC+J1eAZMym1mmkB6tNExdDo=;
        b=y3D0xl6E94OyBJK6MXqzVOiVd651iCiYmyUsGpN5EdFHa2gjM9CkO5Bhy0VW8zDTq3
         389xpL0IgOvqC2T6LKVIrZM0xObZnEs9o2ksmqJ+1QyjgjvHrstWySTQcoEVYw2bFRX2
         wDn17oz4JWMmhqSonFcJX3a2wB5TDi/YAJUD+4q6h2oRLNJlSqh0xc+Gh7rA3xQRt3oB
         vWbyKAbtvrh/m/LUqfAileFF+3K7W9cjuIpQJdhG1sHW3jQRpoEsrwZn45GHlLDK555U
         k1IxsclvndKby6kXn4POiFMyReo1KzZmP3DNiJHHMftvo6rF1+5LdQMSDMSjowF0DGt5
         6CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taOMH3TFvYbtpRD0i3FdC+J1eAZMym1mmkB6tNExdDo=;
        b=maQ49P0cGtH0D6/De7/quHIkjiVfGWt9YH3WvzNpiBVeG6iEAoBjhcRe3dfmhAuk8T
         C2asAqotAUKqRRpqMYJVHVDPBlgzW2bfvmiaJD8vtJYOvNJGdULmTkwveYljyUllDmkg
         1Kf7GbCMP/n8GKRMnPEHJ5LvrLporKo9i2/Sa6vJ5YVeLQkQ82GYzwpLNO5RiKBAWnRA
         GsPgf+n6WnaBaA5GOYfxbv3f6TyseAGT475UFPjZRpekLq9JqgSUv6uHDIdIdFsJmQXK
         /bkEqm5B82IWAZ8I+KZ0t6aQE6nsTXyAUPPcnRG3Cei/3DJPbBgY7fmK77qfDLnl4kXy
         HOUA==
X-Gm-Message-State: AFqh2kpIzepOaMTQiy6hl2sTO+oZWGoIklL8WzoCfnVbMucRt5hTWrz3
        apYObiuGS2i7LODMj4eYzKAp8A==
X-Google-Smtp-Source: AMrXdXvSh+smSCJ42CzF9CfpTvWzpF8F03yhi6vtuR/jj6aHCAABZEojnPbol2OjVyIPRT66fpxx3w==
X-Received: by 2002:a17:907:d410:b0:7a7:9a38:d284 with SMTP id vi16-20020a170907d41000b007a79a38d284mr31250540ejc.19.1672761094018;
        Tue, 03 Jan 2023 07:51:34 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m9-20020a1709062ac900b007c0d41736c0sm14158313eje.39.2023.01.03.07.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 07:51:33 -0800 (PST)
Message-ID: <cf00e248-1f2c-d4ce-868d-9f77b2c9b76f@linaro.org>
Date:   Tue, 3 Jan 2023 15:51:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
References: <20221206200740.3567551-1-michael@walle.cc>
 <20230103163902.218cb5c7@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230103163902.218cb5c7@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 03/01/2023 15:39, Miquel Raynal wrote:
> Hi Srinivas,
> 
> michael@walle.cc wrote on Tue,  6 Dec 2022 21:07:19 +0100:
> 
>> This is now the third attempt to fetch the MAC addresses from the VPD
>> for the Kontron sl28 boards. Previous discussions can be found here:
>> https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/
>>
>>
>> NVMEM cells are typically added by board code or by the devicetree. But
>> as the cells get more complex, there is (valid) push back from the
>> devicetree maintainers to not put that handling in the devicetree.
>>
>> Therefore, introduce NVMEM layouts. They operate on the NVMEM device and
>> can add cells during runtime. That way it is possible to add more complex
>> cells than it is possible right now with the offset/length/bits
>> description in the device tree. For example, you can have post processing
>> for individual cells (think of endian swapping, or ethernet offset
>> handling).
>>
>> The imx-ocotp driver is the only user of the global post processing hook,
>> convert it to nvmem layouts and drop the global post pocessing hook.
>>
>> For now, the layouts are selected by the device tree. But the idea is
>> that also board files or other drivers could set a layout. Although no
>> code for that exists yet.
>>
>> Thanks to Miquel, the device tree bindings are already approved and merged.
>>
>> NVMEM layouts as modules?
>> While possible in principle, it doesn't make any sense because the NVMEM
>> core can't be compiled as a module. The layouts needs to be available at
>> probe time. (That is also the reason why they get registered with
>> subsys_initcall().) So if the NVMEM core would be a module, the layouts
>> could be modules, too.
> 
> I believe this series still applies even though -rc1 (and -rc2) are out
> now, may we know if you consider merging it anytime soon or if there
> are still discrepancies in the implementation you would like to
> discuss? Otherwise I would really like to see this laying in -next a
> few weeks before being sent out to Linus, just in case.

Thanks for the work!

Lets get some testing in -next.


Applied now,





--srini
> 
> Thanks,
> Miquèl
