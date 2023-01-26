Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A467C986
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbjAZLMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjAZLMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:12:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D990C62279
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:11:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bk16so1374003wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIEd6MMIG9TmRzKZAciT+VqzBs6xJZhSfliDV0pPFxE=;
        b=mNVBznyVVJoKwPDIkGzuUptKKqXEaBrcS2l/35JM6iLWQnVluqBxBfKq3No2U5ZriK
         dmKVVVnWZd/Hf8oB5toYtAP0dzchoyQ3GBCWQmh8cGedmWUJZwWj4KiI8vLCHRPe8l6D
         331zVCz1KeA4xuqdrCznOicB4NfoN8H5Fj+ngs9IhSds077Kc6Ax5//A+i+JmnFk9iHG
         mVNvYjD9yWd0GaDSPPnYYKRIKbqMf/FSnp3cV/kICjmDi1KdmngP5MNpZWiqWD6aHx3w
         GVtGoLFGcXqvjrUuIjQsnmnGthHqboAkwgyhggSkVm+n51geCHF/5X7k/a0fmYQJRGBM
         CdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIEd6MMIG9TmRzKZAciT+VqzBs6xJZhSfliDV0pPFxE=;
        b=5tHQmHyip1CPU1zrG7F6IusCz/eyHA2LXYa29X5tlGLoLJj+/KR+5/+I7VSdDIfID0
         65XNwguLd0r+ahzrhUjseCdnFPEFb29mXM9JOsbvXfywVzTfABM4u5BvRX2MOGQ2S/bb
         gN4zN43fYiyiju7N6EvnYjahzDKYLus5935u4OwDKCH6yMIRqTozMKiX93the5RJ6nQh
         o0Wk7q95uOZ4KZdKV6PXIKLKxkvlMHTbXGwNf12LWpwJkTWnCROMDPV62CgO9LHGFTi8
         PMzeWAMMJlH6RWvMyyB/YrpG7ofNa72NQES+O0pF+klfUuatNyE0NRNPbPdBRSCn1QIZ
         imlg==
X-Gm-Message-State: AFqh2kre8+tUK7Y30uuFNc5AA8Ow0DA1ITUvsd73pjyD3kzmbR4sBh4R
        QYU9SJ13EdhrmTvAlRKzM6UPMg==
X-Google-Smtp-Source: AMrXdXs2KdENfVfAkWOrZ9w61joBjtFOOQfMYU6o5Y9wWeFEAyzTQEvg1QiUxKYjSfWwpCaghVUsHw==
X-Received: by 2002:a5d:6b8b:0:b0:2be:1d46:e500 with SMTP id n11-20020a5d6b8b000000b002be1d46e500mr30413699wrx.28.1674731511874;
        Thu, 26 Jan 2023 03:11:51 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z2-20020a5d6542000000b00267bcb1bbe5sm1030312wrv.56.2023.01.26.03.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 03:11:51 -0800 (PST)
Message-ID: <57fc58ab-6dbc-41d9-781c-d80c50050a27@linaro.org>
Date:   Thu, 26 Jan 2023 12:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clocksource/drivers/sh_cmt: Mark driver as non-removable
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20230123220221.48164-1-u.kleine-koenig@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230123220221.48164-1-u.kleine-koenig@pengutronix.de>
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

On 23/01/2023 23:02, Uwe Kleine-König wrote:
> The comment in the remove callback suggests that the driver is not
> supposed to be unbound. However returning an error code in the remove
> callback doesn't accomplish that. Instead set the suppress_bind_attrs
> property (which makes it impossible to unbind the driver via sysfs).
> The only remaining way to unbind a sh_cmt device would be module
> unloading, but that doesn't apply here, as the driver cannot be built as
> a module.
> 
> Also drop the useless remove callback.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

