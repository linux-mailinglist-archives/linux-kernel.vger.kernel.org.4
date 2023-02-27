Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19C6A3FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjB0KpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB0KpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:45:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B9EB75B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:45:19 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m6so7932673lfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677494717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfjmsqJC9S5uRIo+JPoAyc5Ef8JBEAdP5rQctKxSj5k=;
        b=NMM1JoMwJ4Qw/j/sBsGu2nc5CU19hz1sII+HLrMsy0mBo8KJpOW3Ty2YNMu7gVL/Ij
         dHwILQ7PZvsNgvLVWFGma4K7Pi8q0UqGejZohfMNqXBx15KXULLOw3QPaA1QP7JbX5bm
         Wp1Ab2mKZaJh5EyoBZCOPMmmDJvsmdeVBEpRQ0fFHbztXOxEhObHDvVTxuyfXUkVKlQr
         2uJ0Ttl1wlqwqFvYuLgyFbzVAMzyECCLhppODH3QgDxW03BbEpbZdZbxlQvG9Rm3A9/d
         4C14eR45pnaIkOnoZ8wxDBz/t+XuF1kkgD05T4aJ0EcHJPvT6SSJu1bTE6bKS+inonpU
         37uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677494717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfjmsqJC9S5uRIo+JPoAyc5Ef8JBEAdP5rQctKxSj5k=;
        b=05qVpxVU7Tb8a0BjZO1yV7aQKp1um87YNN6qfUNz0YwdzNSu3X08cDMKCBdhLE9KN+
         ji279+ups+tt0C8OqBymFzTUVuz/Pa7ySBLTTBuY1acealKezuCNADKYLQBmczf34JVF
         CeUKxnUc1u7O6ek3k0/Nb4oS2bwY+426rEUH7YBIyJg0QB66yT+y3N63wS4MhaUA1B/i
         eYyuq1j7dHqrXmdN+MoGR1Yiph87RaYPVSq49ANhXWkBavGGk+nWccNeA+wSV4i0huKo
         XMZgtLWl3olCbkX14MUXgcp1KWhSzIH6nTBXf+cVdV7/GAq0bSNQEwJ4NX9ZvzPI1UwW
         Q72A==
X-Gm-Message-State: AO0yUKXUfBFKETCFr4s7rQJ/mfuQYzsTlNhg1IYeWXmThXc+6oWwKFgt
        U1Bb0U0D0Z80Ll5dfbSayC3Igw==
X-Google-Smtp-Source: AK7set+nivcoX0kYRGE1+gk462k0UjOU2mFC4PctvVhZJ8cocReI8Ypj8vCbMc3f77ikk9Gih+q3uQ==
X-Received: by 2002:a05:6512:390e:b0:4dd:a66d:b6de with SMTP id a14-20020a056512390e00b004dda66db6demr4726598lfu.65.1677494717376;
        Mon, 27 Feb 2023 02:45:17 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id v28-20020ac2561c000000b004b5831b69dcsm865191lfd.140.2023.02.27.02.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 02:45:16 -0800 (PST)
Message-ID: <3d951b70-ecea-c97c-8a2e-72ca6b1a2bf7@linaro.org>
Date:   Mon, 27 Feb 2023 11:45:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] drm/msm/adreno: Use OPP for every GPU generation
Content-Language: en-US
To:     Chris Healy <cphealy@gmail.com>, dmitry.baryshkov@linaro.org
Cc:     airlied@gmail.com, Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        quic_abhinavk@quicinc.com, Rob Clark <robdclark@gmail.com>,
        sean@poorly.run, Marek Vasut <marex@denx.de>
References: <CAFXsbZqnstOLFBrVVa7aFLSGCPNj4VkjExqq1XUoRdUUuBKdog@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAFXsbZqnstOLFBrVVa7aFLSGCPNj4VkjExqq1XUoRdUUuBKdog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.02.2023 17:56, Chris Healy wrote:
> I may be missing something, but looking at the code path for a2xx,
> it's not clear to me how this would work with SoCs with a2xx that
> don't support 200MHz for GPU frequency.  For example, the NXP i.MX51
> requires the A205 GPU to run at 166MHz while the NXP i.MX53 requires
> the A205 GPU to run at 200MHz.
This is something outside the scope of this patch, I feel like.

If I'm reading the code correctly, the driver always assumed 200 MHz
for non-pwrlevels and non-OPP targets before this patch, and this
patch is meant to bring no difference in the rates selected.

Konrad
