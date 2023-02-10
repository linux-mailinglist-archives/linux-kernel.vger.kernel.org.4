Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18F691FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjBJNg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjBJNgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:36:53 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404841CF77
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:36:52 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u10so3835721wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQNZ76NgQoOX3VginCo9ln2LWcn9mGFbOfHzpQwFJLU=;
        b=K7zknJ38FU5C1kWRJ5xeFXCWONMYjiffBpp9Ex2oUH6g2/J2qu3+VOWtz/GMMFCCFS
         vLqR2GlcSkAQTXZmw1rmg71ngZ8q6chS8N9ZFLojubrdH54H9EW/4Adyr6rg1JMRIvF2
         XnPTgxD+1dj/mPefVrw+ju10FR3swfY/D7/KAkIjhkHtJqGCZ4/DcWf+n3bfn3kqCxW3
         6c3PYVwkI3RrJQHzUAWIETGIW84uvOFZQ0gOYBJsSrv9A/NBhEzCb98VQU3P6rlt6v5k
         PZ9vF8PUfc4pDyRAksICuposHEZshTa1EegsXw5jfBC5VK5kdF4xruBxOFR4Mu2Q92Vj
         5hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQNZ76NgQoOX3VginCo9ln2LWcn9mGFbOfHzpQwFJLU=;
        b=QEh26Xuoxwd3+fG8OPRXvpNJoKl+qPEH6FUqk8VqEkpy77Efa2Ks/1swoq6nwF4OUC
         DE7S4z79KQynuQMxk2z5t7PV47rBfumQRIyovcPLyD7k24VZiTHbuTc0NpL3RJmS9CbI
         i2OKXj2dbsAq9JOBjajQp0DmQOpX1lIQEgAArjdjINYStpYg6y39UY3m+bJiIqQXJeUq
         RKE5UD+3Wv1jHqk0BxPkaFyD61mIcCBTNmajW9deNlzA3wlg+rqAN4OscLtaDxS7i38z
         BFQ+qhkTrZ2g0FGLd59GaiJ99LEb0WirFXFrU3AnRJPyWfYIRQ4INqiaCrmR/q6kBVZX
         6NUQ==
X-Gm-Message-State: AO0yUKVeXANxltzDp9Uil6BqAZHtN7k+/X2C4jFHBaCmHgZUxbjgRGwb
        HMAARVZDHy3J8IEjl+usXQyicg==
X-Google-Smtp-Source: AK7set//bgmUZWRlv+by+TRDhSoseBN27Gk7Iz8ww3tsA+BXoWkLMHdTDAWpz9ts6p8TyduFd7vpNw==
X-Received: by 2002:a05:600c:4383:b0:3dc:4cb5:41c with SMTP id e3-20020a05600c438300b003dc4cb5041cmr13062087wmn.0.1676036210806;
        Fri, 10 Feb 2023 05:36:50 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q14-20020a05600c46ce00b003db12112fcfsm5689710wmo.4.2023.02.10.05.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 05:36:50 -0800 (PST)
Message-ID: <0313a4bb-1971-a4df-6e1e-3a5e551d0bef@linaro.org>
Date:   Fri, 10 Feb 2023 14:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clocksource: em_sti: Mark driver as non-removable
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20230207193010.469495-1-u.kleine-koenig@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230207193010.469495-1-u.kleine-koenig@pengutronix.de>
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

On 07/02/2023 20:30, Uwe Kleine-König wrote:
> The comment in the remove callback suggests that the driver is not
> supposed to be unbound. However returning an error code in the remove
> callback doesn't accomplish that. Instead set the suppress_bind_attrs
> property (which makes it impossible to unbind the driver via sysfs).
> The only remaining way to unbind a em_sti device would be module
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

