Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1F65EC9D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjAENOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjAENOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:14:03 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF0BD11C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:14:02 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v25so7523055lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yiPmujNybDTPr/Z1E6GBude39lwMJKILPlWC+E9Bds4=;
        b=zbFr83mAu7u/3d11PDpNYcDTbBVVXQx6UsPjqUnO40jiNh8XdZMeXwu4Fx1K8pkwAH
         8YoQzNZgAz43dZgcUroALwcvW9o0iQs9PiDjRQVRFRobrbhgFHd2hZxslgAz4q/00y8r
         w+Z+XkHnEjs5tbM0C9QgeGpGjjhBOXemIL4mCCGA5GZ7uQ4dG8RNBtI3On8iKM9Nbm1J
         9t+Io/Q2anmdgRubWC2Zng+aCfC6j77tUvmhUaRaTIFQpxv3jlB/64cwSHHwmaOWPVun
         QO6mDlWsJrHG3odF7JaVD9uYrnB8uWoU/WbVFyfVgtvGTucwKMezztWu2qHWHRF7yhYl
         1zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yiPmujNybDTPr/Z1E6GBude39lwMJKILPlWC+E9Bds4=;
        b=A7CEuBwAbC1nfVzVT5nDLhCLr6bGmeZ9xmUtUs6cBG9N6vw0cTlBmDSdbH9f6AgiXx
         RL80RST18zZE852Q2vKqTn+ONXqLcFeQqOkuTwNPBWQckiC5IWQEGyoap9j25ibzyidz
         3hEe4PmnjVlxbOEAJAOq5jOZ2REZ498Jtc5bsoAcuMzVRCUR8jUfqhYArRDfDju8WHWG
         EroS5ol/rcty/sdNT8wwZhtODD6/BVziEGeptY5W+NHJQ004C3fPUwz5oGgoM5T5YdP8
         oVQRoX+rtGJxz/7/3/mY3h4ZRYqpIY/VmcAFIJyDA9kw8wpLOMza6iPGBsRSf/abVp85
         YuoQ==
X-Gm-Message-State: AFqh2kpFrCaaS6EbYRIa6yAeVWdyUJEcnCF30Buwjgp6OGzV+zYY4oAL
        EbWiWeE+LMWQFP9oc+qG6+NYXA==
X-Google-Smtp-Source: AMrXdXtHl+uGKcQ7GbKbIT+x/AZ4dqdwZIOvB+Pn042cXskiL8yrv46/gBk5/cP3BM7M2o2U6UUcag==
X-Received: by 2002:a05:6512:2624:b0:4b5:8e1e:867b with SMTP id bt36-20020a056512262400b004b58e1e867bmr14521749lfb.59.1672924441077;
        Thu, 05 Jan 2023 05:14:01 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u1-20020ac243c1000000b004b18163476esm5447752lfl.112.2023.01.05.05.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 05:14:00 -0800 (PST)
Message-ID: <08679155-5b27-f2a9-522c-0a63a3525dc0@linaro.org>
Date:   Thu, 5 Jan 2023 15:13:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] firmware/psci: Don't register with debugfs if PSCI isn't
 available
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hector Martin <marcan@marcan.st>, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20230105090834.630238-1-maz@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230105090834.630238-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 11:08, Marc Zyngier wrote:
> Contrary to popular belief, PSCI is not a universal property of an
> ARM/arm64 system. There is a garden variety of systems out there
> that don't (or even cannot) implement it.
> 
> I'm the first one deplore such a situation, but hey...
> 
> On such systems, a "cat /sys/kernel/debug/psci" results in
> fireworks, as no invocation callback is registered.
> 
> Check for the invoke_psci_fn and psci_ops.get_version pointers
> before registering with the debugfs subsystem, avoiding the
> issue altogether.
> 
> Fixes: 3137f2e60098 ("firmware/psci: Add debugfs support to ease debugging")
> Reported-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

