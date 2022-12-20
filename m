Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184016525FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiLTSGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiLTSGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:06:15 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1A9183B8;
        Tue, 20 Dec 2022 10:06:12 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id g14so13201851ljh.10;
        Tue, 20 Dec 2022 10:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gx2snfeHln3kw0y81rW/3OOvyMzsp6N4nP3FZs/fhhc=;
        b=IL0Ph0Hfssc+L5rT72mcV4RGom/oVv8riLHYLI1rZnfWZAv58k2z2v39I58h5pUGLu
         Us7KffYdFb+3fIMAD46gh4aW5rKXQGwf4YRa1bmjDimOSQAkMhlh1gZieOaJcbCiNEc2
         +A+FwOvUoZOdV7uRs0mol1NrAwwDzwvbgf+GKTwpvVaVaVG2qj6FuM/j5Pyd/sqmpgkR
         olliHp12akMVdA3pkwLpY1ni+Kw1PW0TR/DsoPNGyH0H2+KSmegzChUY9KTfgJEmPebi
         lgDIdcsc9SWtCHAxrFwJnemCBMX7Rp35rB0K/v3PTh2Ock0RTh1B37Ec/dV8TMOP73Ad
         hzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx2snfeHln3kw0y81rW/3OOvyMzsp6N4nP3FZs/fhhc=;
        b=S9VnIQQT5Uo0PVbChV27nhktqAPZD3CodfaVy83wIj7rQpVWBEuNboTs/JXLIYo1oR
         5zJeYuqqu417O9Sfk2DmmjiekZQJRgwCa8R4/plaDUitKIWgD/OQR+1c5dmtWjDiMbiM
         RUd0a9p0nPUpmu+GkW1zJ8alTwd5wzgLdHSsTJsIYBMNetZSzTIN6LLw+m0EwCwrEaVU
         Mdku0sS25nCqvGmJ1PLYv4FPx0Wuv9c/q8RErBUZFXlCGrX2nUKt+uRnnuXD02ZTfJeA
         ln+epQYhy9W/kp6uBx+5desB9o+qFh8ul4l8JNpvKR9MT/XKhTQLG3436511tUPRK7ag
         v13g==
X-Gm-Message-State: ANoB5pn1A/Mxw6zLiOGDTLjb0PvJdoiwZ5RP9Ntgky0d2qIDomE0ZYtU
        8mORllLB8GqEGW7z7hroGg4=
X-Google-Smtp-Source: AA0mqf515wEeBLoiepEGdSGZDqJIA9LjWbEItP/8R+cf9SX5kAyMeqVD57YEaq7cAvSIK8TC8ET6dw==
X-Received: by 2002:a05:651c:120f:b0:27a:1194:85ee with SMTP id i15-20020a05651c120f00b0027a119485eemr12775050lja.35.1671559571537;
        Tue, 20 Dec 2022 10:06:11 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id f7-20020a05651c03c700b002776eb5b1ccsm1089851ljp.4.2022.12.20.10.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 10:06:11 -0800 (PST)
Message-ID: <23afd0ac-dc3e-3a62-915f-d1af1218e5a1@gmail.com>
Date:   Tue, 20 Dec 2022 21:06:04 +0300
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
> +		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
> +			err = tegra_emc_interconnect_init(emc);
> +			if (!err)
> +				return err;

"return err" doesn't sound good

> +			dev_err(&pdev->dev, "tegra_emc_interconnect_init failed:%d\n", err);
> +			goto put_bpmp;

Move error message to tegra_emc_interconnect_init()
