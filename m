Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA22A6404F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiLBKoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiLBKnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:43:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1CDB3908
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:43:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso3937885wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fT/vQ1+9LdOSyeDNiP63ONcd4GJxKkdd47jOzWA5GqI=;
        b=XIuIUTgWX9l84mEOdSgTCkD/Sl0N3998Tim762gAVJ1fEvYWw0MZZ/rszQymsiPaSp
         96zDtSOrHdpSZBNbJYm3ZGrg2NbP14XOEK24mhnsXmNsAhIUlnl4cQe5g4ayHorM7hug
         azO5yZxcw2/uEqsc8zh7Fwm/7fDWqrvMQ+49pJ657cshyuXrxiBURxqOpJL2Wkt2Oo0/
         MN9IA4GuzDtBX/el4mi60OoCA8Hgq1Eqi/w0trtHvz9qUBwTqM3QHl/w15AHIXq63IGC
         Rljg77zxIlJps54xPaBw+5fT5rCPfq30sR4Qvgd4rczzRxxv5EJI+tcgLtk9XSSTLQff
         5GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fT/vQ1+9LdOSyeDNiP63ONcd4GJxKkdd47jOzWA5GqI=;
        b=5mClKjUNd8IvEdkK1XwZxr90KuF1OknxjejcCgLF0sV6rmzeDfi77+OxJzj9/6TEzJ
         FNO5rtgvXpn5n0UUOX4tYbIdRf5JeJHoSqPkZMi4YqqdaFZFFKKr3c780wgA297rcgBq
         f/Nt+YM4ZgWATMRlT0F+axKhEMXApWp7MYop/i/MliWa2spK8GcO9kPvc9bA8da5m9PN
         1hXEuNKWuGS/5gcgnZpBx53rsyDl/RRjhd4Rj4fUCPP6MZ3K1Y1kZTUXE9JZwiL1SysF
         FUopR3wCj2s/GQYtB11WoCmOcLcVjWghLDVtQvZpdRP7WoPrSPcnEBkE/TJtUswu4BQj
         7LsQ==
X-Gm-Message-State: ANoB5pmft7pkFRNS3Ko9jd8VU8YJAjweh8c+MWIhP//d9DI5eKxq31tA
        iCIpRo5vw+YY5fmrZjfx4oS9+w==
X-Google-Smtp-Source: AA0mqf5qRV0FocAQp2TyfozCqQTvmq2wdFfZ8YKeDB6alkOVU34wx0xq8rlSjS159IYtdAQWM9Yv/w==
X-Received: by 2002:a05:600c:2159:b0:3d0:7865:e2db with SMTP id v25-20020a05600c215900b003d07865e2dbmr7025751wml.70.1669977817934;
        Fri, 02 Dec 2022 02:43:37 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id bg9-20020a05600c3c8900b003cf483ee8e0sm12929809wmb.24.2022.12.02.02.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:43:37 -0800 (PST)
Message-ID: <5db3dc91-e302-945e-25e5-c4a9840d26e8@linaro.org>
Date:   Fri, 2 Dec 2022 11:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH linux-next v2] mips/pci: use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     zhang.songyi@zte.com.cn, tsbogend@alpha.franken.de
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202212021028158035876@zte.com.cn>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <202212021028158035876@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 03:28, zhang.songyi@zte.com.cn wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>   arch/mips/pci/pci-rt3883.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

