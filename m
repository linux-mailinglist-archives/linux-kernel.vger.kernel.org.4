Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED36D98A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjDFNyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjDFNyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:54:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3E57D9A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:54:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v1so39605011wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680789253; x=1683381253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezT0NDsUMsm10HBHulD+tvoUb5KJlGUy+bX2OIndrqE=;
        b=uDn1XPw9QQnbG4CQ/ZnIv0s2GKDkcAOuVrNy4bSd/rPD71Z1tjzz2Yl4Ib//qRquqD
         ijBC8iwNnJWx0dlc0+sWzs3VwmKgE2tcP5THEEd2WuecNJ+ZxtRKg6iZ47HU+QQsIeTJ
         NxpnTAhbMSfnaB1BC4rMxBBMQak4EtC3iuzo1WEVBVSwgsM00tJbpNo6GUusIJRfs+XB
         KXyTUHQ4clWDylm8qqroPxqDPz9Gg/FUmdrYFCGd+CfrJy+9a44kn3PCMa3bVvf+pcR8
         rccg+q9IXhXCWV1jdJtirFTmD7r/POHza+D6RjOpeocWbQJ1ktALfp64bs+z9Z2O6eoO
         tpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789253; x=1683381253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezT0NDsUMsm10HBHulD+tvoUb5KJlGUy+bX2OIndrqE=;
        b=N7CpDQhbf6ok20QGB/kf+SU9z1dC44GR7CB45xXxbmss3EljMriVyDd6EK7dI6tGRG
         RopHsT0ogjjXDtcnhMaC3k4N14b8NouyQce2Ijv+OZppQG9vvJs5uqoGrJq2nuYTYW8g
         YQkYdKVzBXeM44m1B0NvEpJvFgQmXXba9AdMt53OnSYJzLfQpyWy4aStVmAvMgBQbbOi
         rdwzuk5xXvy1mkP5hKeL3kgyFy7cvyjPu59/n0Ex/mhHTQ3JRCAn4KfSXIbbw0z/0KQG
         ewkBwUoAj9uBi/QAu7VovcwcwMs0VGM0ZfCctcqCgrmRzWR8oE4wWV/zbTsRUVxr3IIq
         BO4Q==
X-Gm-Message-State: AAQBX9fBkIT5/KcR6/qD5rgh9VSdMtu9/MXgZBA2/BccTdgyr+ASD225
        CnXvfaZz50tavvXTewq5tCHzDg==
X-Google-Smtp-Source: AKy350bC0LRKYynmaTA4IXUV15q6OdxA7m8TujnIRxxxtl9PPIg0UCGI2eOFvvdpUHN2V+bZpayO6A==
X-Received: by 2002:a5d:4846:0:b0:2ce:a8d6:309a with SMTP id n6-20020a5d4846000000b002cea8d6309amr6795139wrs.61.1680789253438;
        Thu, 06 Apr 2023 06:54:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6630:ee96:3710:24c8? ([2a05:6e02:1041:c10:6630:ee96:3710:24c8])
        by smtp.googlemail.com with ESMTPSA id k15-20020a056000004f00b002c71dd1109fsm1860813wrx.47.2023.04.06.06.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:54:12 -0700 (PDT)
Message-ID: <0a42d419-7ec2-6d09-9b19-15aa25888625@linaro.org>
Date:   Thu, 6 Apr 2023 15:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5] clocksource: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
References: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 08:54, Uwe Kleine-König wrote:
> Hello,
> 
> this patch series adapts the platform drivers below drivers/clk
> to use the .remove_new() callback. Compared to the traditional .remove()
> callback .remove_new() returns no value. This is a good thing because
> the driver core doesn't (and cannot) cope for errors during remove. The
> only effect of a non-zero return value in .remove() is that the driver
> core emits a warning. The device is removed anyhow and an early return
> from .remove() usually yields a resource leak.
> 
> Most clocksource drivers are not supposed to be removed. Two drivers are
> adapted here to actually prevent removal. One driver is fixed not to
> return an error code in .remove() and then the two remaining drivers
> with a remove callback are trivially converted to .remove_new().
> 

Applied and fixed up patch #2


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

