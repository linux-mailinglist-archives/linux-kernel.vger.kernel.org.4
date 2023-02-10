Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36225691FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjBJNhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjBJNhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:37:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C407166E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:37:11 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o18so5106668wrj.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4lgkW2CnF6CZihRmbuWa+py+Rr0tskHoMJqwV14Ito=;
        b=GzAdyi9w4Wvy2ADrB2tsYNrN1L9DTuu9SgUHN35TgalbiAmnu2PdBR/pdJV3CfPccK
         8jse8fXp72rjdmb5VSSFRAxbpGkGbZqE5FO8zCGlxrFVkniokBtMVOtWFYvHTw+C5Rra
         fYCtk+qW6Z42WCsqXioZmKxaOf9+1AKA9/drBAOLNEeJgR51DKK9Tpw+IhVDbNYX0mAv
         DcKN4BkLBEgdV/kZoljoLG6hrVxy2WfJsxClVi9j6gzNm9xaJZw/z+FVNPt50hhiTbe8
         iIu3QpH9jXRacpdaHmzm/Lg26UN7nRNQ/aEzz9s9vDsgZk/IM+4WHWzWgDnOGR+aphcA
         PQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4lgkW2CnF6CZihRmbuWa+py+Rr0tskHoMJqwV14Ito=;
        b=t7oSXgJpIffq2QFAQvEGuM1xgQ8Br8yb6NptUnkqrCRkZWb7D3Q76ogcCDAPmBV4fm
         BNVUH/m2otImLWgPKbPBlsDWT1nTP+Gbj1dppQUX8GQfj4QHMpckPrkNjPt3CYVA6aBK
         s24G8rkHiXZGQLMlrWEOn7mozbeyTQZVz1VO7e6kmusLerau5ktZeh77q0Cx2eBTeLtr
         El7FxagbtNX74wIzJQvpN2VDj7JyI3GQR5HwCDJMMM9wQorUxipLhKuYxi7zrHdLtReV
         63v+Yyza+SFSyYcOayuRIMVL/KGqetdejfE4++pi1F/zQkeYpjVTFBbxcDQ7JwlBKP32
         0Iyw==
X-Gm-Message-State: AO0yUKXZ0op8vwTvLy3rKLPDh7Uez/WP/p0b+8hJRo/7QWio2pVkpPwf
        gr8iLAFishUFmYuToIWYhOWFSg==
X-Google-Smtp-Source: AK7set/f0Wj5Sm4pfa6qK9Dbu/WBYtHqXOTxRnvim+9gPIMatTrNxway0TzA9AfmSOR/g2kKFpHghA==
X-Received: by 2002:adf:f851:0:b0:2bf:c364:47b3 with SMTP id d17-20020adff851000000b002bfc36447b3mr13848001wrq.26.1676036229361;
        Fri, 10 Feb 2023 05:37:09 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d16-20020a5d5390000000b002c4008f0daasm3585752wrv.107.2023.02.10.05.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 05:37:09 -0800 (PST)
Message-ID: <25e36532-3d98-dfa7-ac45-656999f3f0d2@linaro.org>
Date:   Fri, 10 Feb 2023 14:37:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clocksource: sh_tmu: Mark driver as non-removable
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20230207193614.472060-1-u.kleine-koenig@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230207193614.472060-1-u.kleine-koenig@pengutronix.de>
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

On 07/02/2023 20:36, Uwe Kleine-König wrote:
> The comment in the remove callback suggests that the driver is not
> supposed to be unbound. However returning an error code in the remove
> callback doesn't accomplish that. Instead set the suppress_bind_attrs
> property (which makes it impossible to unbind the driver via sysfs).
> The only remaining way to unbind a sh_tmu device would be module
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

