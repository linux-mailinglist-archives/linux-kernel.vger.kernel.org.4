Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7626523E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiLTPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiLTPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:44:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C83F1789D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:44:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m18so30147605eji.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwruL0979JFuznH/sYcDGOyKnO5iM9PcWtLgGuw0NsU=;
        b=p4V2EGt3ZnZQxaCBjlBhrwCG5HcuYcfA7xUfw/CAQ6IyHD/S44ZCqBrSM5JZDwLerm
         GDjFxBiBAXvKJRwWq0H9SwdUEBM8miqRLpSQR2LBmndgqIQTP+4W5xQSySG7/v7bXpQj
         uHFauQbgi3qKRcAEbHn06zTXAZei2M4vEAg3KFGpHPeGYq0ryjr7WGElleLmEv2cUcQ1
         twbHF5it2suv2ThaShjVv3CPErmvCAy8n58V3dwHL6A4rEpS7EkGa81BUTG1bgxaNGfb
         upWph0T1Xg8ePls6P+kIATtC/FNrnOzBTzZsJ3B8IQAdYU7ufW3f83co90ZVag4iRVFI
         q/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwruL0979JFuznH/sYcDGOyKnO5iM9PcWtLgGuw0NsU=;
        b=CNJFgIp9FzrjuJWB/gwGGEJy6rybFUH4GBb1IVpqeyoECgxNja1m+PH6XESNS2qSl1
         7wbRTck30Y5hdeQLn7uvWzo/ervrwAoVeaDBBMz+aoIbaJt54UU7NMf6ileAumY2BDwn
         8zt+pV/JYpDerfISFKBc1GfhduQS+WrmNVpk/I1rJ1OL8Gdl7f4CPGPAXsHMZrrrBe2c
         AmSaeTJNtnBmGfh9bVw9c9eGh3N/NDOCrUljW6sX82C/chwWfGWHmLflcak1Ig/Tkst7
         3T6XnWpQTzxZd7C4wRLbAhlhNGhyTmKN0wqiEPmWm6aMEbPguZPafeyt5rMBuJK7xuZq
         e13A==
X-Gm-Message-State: ANoB5pklaMVTnk6PY7FxSkjSdz2k1uQSqip8PyatDqN3O0BTmIvPFouR
        wkSE8swqkNWeLs6u/mAL3fVkNQ==
X-Google-Smtp-Source: AMrXdXseLZUtPK83YwnsfQ0466FsHGDk9R7HCChN4XLU5MhKcRPjDUQ3xQu6Zo3PCJe1EY5ZLlvGVA==
X-Received: by 2002:a17:906:858e:b0:7c2:3b8a:9f0d with SMTP id v14-20020a170906858e00b007c23b8a9f0dmr25004914ejx.51.1671551091036;
        Tue, 20 Dec 2022 07:44:51 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id j2-20020a170906410200b007ae693cd265sm5825058ejk.150.2022.12.20.07.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:44:50 -0800 (PST)
Message-ID: <cae6328b-5204-a1ab-810d-8fb64e466453@linaro.org>
Date:   Tue, 20 Dec 2022 17:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] [v2] mtd: cfi: allow building spi-intel standalone
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221220141352.1486360-1-arnd@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20221220141352.1486360-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnd,

On 20.12.2022 16:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
> fails to build, as it includes the shared CFI header:
> 
> include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
>     62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
> 
> linux/mtd/spi-nor.h does not actually need to include cfi.h, so
> remove the inclusion here to fix the warning. This uncovers a
> missing #include in spi-nor/core.c so add that there to
> prevent a different build issue.
> 
> Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me. I'll let the linux-0day bot run over it and apply it
once -rc1 is out.

Thanks,
ta
