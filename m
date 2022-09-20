Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62DA5BE068
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiITIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiITIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:38:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0113ED69
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:36:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l8so1359146wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=G0FLaYn/AlB4kBokkXdR1ngnFrEkCavl1AWmIrWkH00=;
        b=UXK3kl98mDFa2jnaNHP872gafCZES++ImqF4yMvg7NWx1sfw8KVDm5rFJKvJEqKWGS
         bLZIZ6aY12nOemVofxEsPTly6oueFvRzclJUPEZeydVPSIHmde0soHick2hWch0CM+TF
         VDYVWHF3WPJWdioPi2YjDJV9K9sSYTbdBrOL0ITKfZ/ywNEMxUwOSjUppeQpv0zCRndC
         RN7giqcAZrWZp3o0PeesZ3m7VqFFv3qh9cHEh0GRG7KtmR3sxaEm9I/ELwKAfiquvAWc
         XmtD/y1F0gj+zD0v7CapNjpMn6FKVOPaaz4mPyAIn7X/p/TCnnx3hPcj1xePLnjVBtoN
         3A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G0FLaYn/AlB4kBokkXdR1ngnFrEkCavl1AWmIrWkH00=;
        b=am8fnZFoZhcaUSYCdoaNV9WUdcThL4IrIxOcY5o8zZ3aKvRa+ihpHzR2DIRhVnYbIe
         DnxfTxF1zP8qiGdyDYdUqVZa4eo7R4wcvFnCcRtOFyU57sjGNDeM1T7zoAroBz95nqJE
         kyW+2vopDfEZdNEZVLHve64nK99a2oEeLoj5WkswtFzgOw68xy4VMTKlgsXwPZrhKmlM
         XRyyzakBDcyQb8Lm5Dy//nZ9QEgGi1XKTsHqImHqi86Ao5KZcRf8bgk1Dg/Q/fRTIOXg
         CdK/hzPlkJdA37hE1P2IwKatiHLNKhMKSz7Ef+kwBJfd7jNNM86Bm71U45J/sKpRMKUh
         KxeA==
X-Gm-Message-State: ACrzQf3BCiVKtV+RkraOkvQuDEBYUa1wOim6a1puScVgiXSyRJkHkE0l
        oK6zS7U22KoArYMwAwj6R/NVAA==
X-Google-Smtp-Source: AMsMyM5EVdKnnqhxfa27IVQ+zJzRqEAV2sxlzwTG9kD4PNGOYpZrDvL4ydekhby4lAiGIK6fZmnSUA==
X-Received: by 2002:a1c:541d:0:b0:3b4:b691:d4ff with SMTP id i29-20020a1c541d000000b003b4b691d4ffmr1411353wmb.56.1663662994067;
        Tue, 20 Sep 2022 01:36:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n3-20020a05600c3b8300b003b435c41103sm20506081wms.0.2022.09.20.01.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:36:33 -0700 (PDT)
Message-ID: <2e7d90cc-4801-ede8-637c-1ecf402c2fcc@linaro.org>
Date:   Tue, 20 Sep 2022 10:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] clocksource/drivers/timer-gxp: Add missing error
 handling in gxp_timer_probe
Content-Language: en-US
To:     Lin Yujun <linyujun809@huawei.com>, verdun@hpe.com,
        nick.hawkins@hpe.com, tglx@linutronix.de, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org
References: <20220914033018.97484-1-linyujun809@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220914033018.97484-1-linyujun809@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 05:30, Lin Yujun wrote:
> Add platform_device_put() to make sure to free the platform
> device in the event platform_device_add() fails.
> 
> Fixes: 5184f4bf151b ("clocksource/drivers/timer-gxp: Add HPE GXP Timer")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
