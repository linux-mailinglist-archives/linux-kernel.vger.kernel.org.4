Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA660C9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiJYK0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiJYKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:25:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E553D7C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:22:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j16so1485913lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFiuwIbv+bAoeutli0BiRLmAbI6CnnPeevj6u0N7M/w=;
        b=BGuPe5QcSnGzzHh+DjA2iAbyCVJqZVLdSh9ICX86csmBECrYkGIB6qFrUkobuh5dwW
         hMBosiwXdHYV9HHYzOjGqHiXdCHhodIZBtoORgtvGYpha7biEZQMO8OdxkKt5qcanQ+Z
         DfIsrJSNh7lqAn3cmcwL/G0AaMBi5FpyhjWAk0RufhFieiKKlbkJ84XhiCT3MYkH2SBd
         gKZxyNmfBkXYXQpjM+/w1pitxSxH5TYvlw3I8koYdomddhkGAV0/6g2BM6K6ZUD3Ikhz
         nttLEwOKHPz1seytHqgrvre2Hdds99Gi2M+FT98nagHKD07XgynFfWEIBYOJLL/s9A7p
         e5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFiuwIbv+bAoeutli0BiRLmAbI6CnnPeevj6u0N7M/w=;
        b=I8IUsAt0kFd/h7MDhm+5Y8PesBz1CcYkLSKFXO5zD4MsP+joEJMka9PYwXA7064KYv
         qqQMz1hTQ9wW0rCCM7ckAOqgIy0+6Kv2dsmhZfHdws5QDnbXFUgb5uFBzF9A5jHFvhNV
         TXvQ6NS3QVxKKFtyZKKPw9zXGNITgn1LZ+U+f7dPOLN4F6E9c4mEJ1Wyqx+/pLCthUC4
         dkqEbMXMro0rXIIEMfAGG7hg58g+FOb66SP53pXL5yyBA0z5UCMW9DDgGOHRSJf3fI5Q
         PDsGhNvJHmVkNxZqGgazqrTYepXHXYmPt1dAcS7T9lZgMcxfB76zFNLKgrLFwAq7smFd
         TtZg==
X-Gm-Message-State: ACrzQf3TS99/aMgbNxRLstg0qieeefWh3ujIAGxQ8ZUEkBhZrbOCjtim
        gWnKR8ci+swyPuXtDDyy07jWhg==
X-Google-Smtp-Source: AMsMyM6Xv6Vk8YcvnuPbdV0vpeA7Q85xyPpOdCMt8HvyuufTj+fbTQYdSkFkiN0gdEyTb9qNUrj6bw==
X-Received: by 2002:a05:6512:b0f:b0:4ac:fa40:63ff with SMTP id w15-20020a0565120b0f00b004acfa4063ffmr2141859lfu.336.1666693377412;
        Tue, 25 Oct 2022 03:22:57 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id n22-20020a2e8796000000b002770a7e320esm424486lji.81.2022.10.25.03.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 03:22:56 -0700 (PDT)
Message-ID: <d5066de3-100e-669f-b32a-1c6e5628b996@linaro.org>
Date:   Tue, 25 Oct 2022 13:22:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] firmware/psci: demote suspend-mode warning to debug level
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221024143417.11463-1-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221024143417.11463-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 17:34, Johan Hovold wrote:
> On some Qualcomm platform, like SC8280XP, the attempt to set PC mode
> during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> is now logged at warning level:
> 
> 	psci: failed to set PC mode: -3
> 
> As there is nothing users can do about the firmware behaving this way,
> demote the warning to debug level.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
> 
> Note that a separate change to the cpuidle driver will start logging the
> mode actually used:
> 
> 	https://lore.kernel.org/all/20221020115513.93809-1-ulf.hansson@linaro.org/
> 
> Johan
> 
> 
>   drivers/firmware/psci/psci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index e7bcfca4159f..462f37fa6a86 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -165,7 +165,7 @@ int psci_set_osi_mode(bool enable)
>   
>   	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
>   	if (err < 0)
> -		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
> +		pr_debug("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
>   	return psci_to_linux_errno(err);
>   }
>   

-- 
With best wishes
Dmitry

