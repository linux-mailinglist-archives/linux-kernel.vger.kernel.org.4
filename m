Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489856486A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLIQju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLIQjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:39:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C0AEE30
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:39:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n7so243593wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njnMK/hrXSKFlyaZTROPhHjj3l6OW2XlOYaMXcPgWBU=;
        b=Jick5liy6ombgHlybQNlDUgSbNNqt1bNN89xlUZL0Z0cKpFAUCO9hpQdCg86t7Donj
         SIuMVMp2Rs8JPr2eRc8avVG8lkWZ6i4tPtyLWWEt2w+iS++OYhmcyp7ixRxGLh0PDpPi
         0bl8TlBFVgU/KydWqql1UAyf67tgo3isZThY921vJwqsCaGpz/OYB07PcUa7QW0vaHSz
         6p03bPfhhyHdHcXTMk49Jtxzhxh668p/RHOzwS0FbhUliBko9PBHxJC8Fs0X70/Cuwkg
         NAyO6GN19VWoJ/U8xjpOYpnqxPdb1xjqxSfCtppr5eicP5AbiNT4svtRu4PgrcXmJaKk
         X5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njnMK/hrXSKFlyaZTROPhHjj3l6OW2XlOYaMXcPgWBU=;
        b=K6hbUqqKztP0SB0yYXScGfkDyMR8fpSxxk5FvD+LP8HVzaz2eaGz1Mvkhi4CJP5Niy
         apeI3if8DDZvr7WPRDbsFgR0E/zb3FEk6HP9lTEY0jwD4pmX/xr12KUSKlj7F5SNTUwT
         PhKCgh/vD1IOV0xXoBJ4MASt9NGGQAV9cAGgSxoHOMDSfqCK3Ve5c0mDY+ICJk+fnnNo
         ZKeDURjVhMludD3yOWlalsoLT5y7tXnJq1lgZCQZuh4R2xoG37dEtR5VMAglfs/anxyF
         xVzvdsXYHK0QF98v+ruO07lAlT3sIwUjCUFS0f+F3PureFI4tO/DOjMBsAAP01GY3/Zr
         hy7A==
X-Gm-Message-State: ANoB5pnwDqU68LqnIjPbduxfgmMO19tFz/vhvcwRSatK8rgOiw3IVENn
        sQ7uohQ68BFsZeuVGAiU8th6cQ==
X-Google-Smtp-Source: AA0mqf531E0kb8v4u5EklQF2XcqqQr6rriZVs47VMSRPyNlOliOh2Isek0ATxvrI0nBfnHVtsHhlYg==
X-Received: by 2002:a05:600c:48a7:b0:3cf:df52:af96 with SMTP id j39-20020a05600c48a700b003cfdf52af96mr5751526wmp.22.1670603986464;
        Fri, 09 Dec 2022 08:39:46 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b003d2157627a8sm100591wmg.47.2022.12.09.08.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 08:39:46 -0800 (PST)
Message-ID: <a36149ce-3e04-819b-5ddf-842e3a7c2aec@linaro.org>
Date:   Fri, 9 Dec 2022 17:39:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3] MIPS: BCM63xx: Add check for NULL for clk in
 clk_enable
Content-Language: en-US
To:     Anastasia Belova <abelova@astralinux.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20221209100550.30470-1-abelova@astralinux.ru>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221209100550.30470-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 11:05, Anastasia Belova wrote:
> Check clk for NULL before calling clk_enable_unlocked where clk
> is dereferenced. There is such check in other implementations
> of clk_enable.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
> v2: Fix errors reported by kernel test robot <lkp@intel.com>.
> v3: Merge several patches into single one.
>   arch/mips/bcm63xx/clk.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

