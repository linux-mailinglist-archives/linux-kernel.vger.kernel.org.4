Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677C6652601
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiLTSH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLTSHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:07:22 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34C380;
        Tue, 20 Dec 2022 10:07:20 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id n6so7573182ljj.11;
        Tue, 20 Dec 2022 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3imWvls62dj1UxwcS5+wTzlMuhOXdm8/MF0rzDeGFg=;
        b=KgN1Eiw4NE5on8GInH5cEOef8iIthgFSCGc+fPGTtyWeH7BMMv0s54IQaDu3/Xgv/U
         7UnfEX24icD1JXenU4eodNYX2kIP6l99IeLziZwtDIB5Ld4ZDOVNU+BjBkTEWFZ4WVr8
         FUYe5gVdT+6tDS1odlOtVGCjFQ9WME0V5R23iDTNniDVq8f7Kb2HSGdKe3cNyNGtMsin
         R6iRhqaZJ/TMemfsDaGbye3hriqtiqdGACbO0Mnz71ivrJgZWuHYOPJzZWAeLKrHaCl5
         eScLIUo9EFKOSWoMt058UeVZJIM8tFOT0247y5S7wKa8Nesu5+LKoEmlcOd72YhqMCvF
         1Lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3imWvls62dj1UxwcS5+wTzlMuhOXdm8/MF0rzDeGFg=;
        b=Zlv8WUeRUdHl1Z/pugCTZ75w8q3+qAFIAe1ND22gt+k5KhhezeC2QUzIbL4ClBtfZj
         S9C8ntIo96eVMdw9BycwCko4nVUQbkOra4bTrtX1JBYgo43KQlQBUsHM/wZ+13kJ32PQ
         Tv2ss8DsqNW/oE3TNnafKoRFDFFyB8VJYKmDlRkDf11UfuaIfEhiOb7eKE/MElGKjVXW
         vwSD/Wc6YpeHJWESsd0ATJTvP6b3IhW492J6JuswFHYuvHLnqE8G8H9/KdumGJvWZrco
         xkNungQ0E5IUnpFNk05XLbUW35eGxpspSK6cIaOEfMHwywK8m/oj5fYyHKcV6XQByMKm
         2wsQ==
X-Gm-Message-State: AFqh2kr/nAJSmR/77Zz6kaplU8NRZ3kGOXHCZ0DZkrJdfUrsZ6XKUOSq
        OAZ45sFnXTLZB6IRzjcKAMM=
X-Google-Smtp-Source: AMrXdXveg7sa20oDz9wiSc65mR9G++G0rTcx1gyigTmZUkEAu5j85O+u0apczpZwnoxTXrv5UZwajg==
X-Received: by 2002:a2e:be1b:0:b0:27f:8546:80bd with SMTP id z27-20020a2ebe1b000000b0027f854680bdmr3896885ljq.26.1671559639290;
        Tue, 20 Dec 2022 10:07:19 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id p28-20020a2ea4dc000000b0027e4da2d952sm1092763ljm.68.2022.12.20.10.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 10:07:18 -0800 (PST)
Message-ID: <f4e05666-d094-18cf-2641-ebf92da85dc8@gmail.com>
Date:   Tue, 20 Dec 2022 21:07:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221220160240.27494-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2022 19:02, Sumit Gupta пишет:
> +#ifndef MEMORY_TEGRA_ICC_H
> +#define MEMORY_TEGRA_ICC_H
> +
> +enum tegra_icc_client_type {
> +	TEGRA_ICC_NONE,
> +	TEGRA_ICC_NISO,
> +	TEGRA_ICC_ISO_DISPLAY,
> +	TEGRA_ICC_ISO_VI,
> +	TEGRA_ICC_ISO_AUDIO,
> +	TEGRA_ICC_ISO_VIFAL,
> +};

You using only TEGRA_ICC_NISO and !TEGRA_ICC_NISO in the code.

include/soc/tegra/mc.h defines TAG_DEFAULT/ISO, please drop all these
duplicated and unused "types" unless there is a good reason to keep them

