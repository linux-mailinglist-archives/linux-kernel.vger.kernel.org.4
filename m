Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB86D755E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbjDEH3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbjDEH3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:29:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A3230C4;
        Wed,  5 Apr 2023 00:29:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h25so45434057lfv.6;
        Wed, 05 Apr 2023 00:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680679772;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvTPj7JDS1r2B2wpp983E4Ys4jc6a4Q/4coRYCaHEmY=;
        b=OoIjlrlvP6SBSAd2JbUrsy8dUL+NrcccLZdea5/nV8DyblhtmctEjriCQK5nZf3vRm
         +F+QeXf6++5BQtMZx6I+VuUuHCqj7ANWzeLr5FIzv89UIMVmrhjFlG/X2CdFdx89xiri
         XD3dohtJNZyGWi27zaU2eAlDMD6cTSbvtzFsFPTxjGUteK/QUb/yurFOunwJBnEKuNv9
         cDkIO5P6ifnU8GiBOHQU+oi86ruUwcrr740mMzONIfpBecd740FrY8Ln5wQS6o9P0uYk
         Rw3ti/2oRR9caJwbphWhWKqRoGPtpuRJyVk1GiPn7HfBrcMAoubQCRuufuwle031+jEk
         +HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680679772;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvTPj7JDS1r2B2wpp983E4Ys4jc6a4Q/4coRYCaHEmY=;
        b=cEgE2yRSlgee3A6JfXkGiXS1N7d85/FBTdLhsaX3KduDraag6m4BnXvMhX8IcTWmMh
         tC1rRUnXtz7Dw2+q777yZNKbShVZSVKwDg5EDXvE0dN1ikOAGkWcH60YCpBh55s6iiyD
         MRXwogTDZupo4Iw/jaR6UYzwPasy2yeUEveLqfiQFnz4z/lheiE7apuE7Vop2XIR4eqH
         6ZNwEjve+7qLaThCheUSZFzvgYXGAKY87LmJeSkQBSsNZkj+vTTe+8pauHc3bHAJil4c
         Arr7twNUATkkMTIsJ1Ij+ACbo9FOrJEr5031h3eYhorWM/0uaj4KPoYa7yqJ+tu8hnC4
         vXeg==
X-Gm-Message-State: AAQBX9dn3tsehW/ycUr1fN8mxd7xtyklEyz7uM5481HuJbT6yqrpcbBe
        bHzCO9TG9q6pGWd65o2uU32OSdDEe8Y=
X-Google-Smtp-Source: AKy350bsp4Pt4fbT44lteJDaJhcRuzPhzlj18f8Vf5d6MNaUlJ5kpOZ4E/Dng2t0igBRWRXWxM/UDw==
X-Received: by 2002:a19:a40c:0:b0:4eb:50ba:cb06 with SMTP id q12-20020a19a40c000000b004eb50bacb06mr603482lfc.49.1680679771644;
        Wed, 05 Apr 2023 00:29:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u12-20020a056512094c00b004d8546456c6sm2717619lft.195.2023.04.05.00.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 00:29:31 -0700 (PDT)
Message-ID: <2652d7df-b208-b88a-026e-5821d3d745ef@gmail.com>
Date:   Wed, 5 Apr 2023 10:29:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
 <20230403-da9063-disable-unused-v2-1-2f1bd2a2434a@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 1/3] regulator: da9063: add voltage monitoring
 registers
In-Reply-To: <20230403-da9063-disable-unused-v2-1-2f1bd2a2434a@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 4/5/23 08:29, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Add the definitions for the registers responsible for voltage
> monitoring. Add a voltage monitor enable bitfield per regulator.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>   drivers/regulator/da9063-regulator.c | 29 +++++++++++++++++++++++++++++
>   include/linux/mfd/da9063/registers.h | 23 +++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index 82f52a2a031a..1c720fc595b3 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c

...

>   
> @@ -932,6 +955,12 @@ static int da9063_regulator_probe(struct platform_device *pdev)
>   			if (IS_ERR(regl->suspend_sleep))
>   				return PTR_ERR(regl->suspend_sleep);
>   		}
> +		if (regl->info->vmon.reg) {

Just a very minor thing - wouldn't this check be better as:
if (regl->info->vmon.mask) ?

We may have device(s) where 0 is a valid reg. However, mask 0 is 
probably not making sense - unless I misunderstand something?

Well, I guess the reg 0 is not valid for vmon on currently supported 
ICs, and it probably is unlikely that would happen on a future device 
either. Still, treating register 0 as 'not initialized' always feels a 
tad bad for me if it can be avoided. So, perhaps consider this if you 
re-spin for some other reason - but I don't think this is by any means 
crucial.

FWIW:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> +			regl->vmon = devm_regmap_field_alloc(&pdev->dev,
> +				da9063->regmap, regl->info->vmon);
> +			if (IS_ERR(regl->vmon))
> +				return PTR_ERR(regl->vmon);
> +		}
>   



-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

