Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0E60C9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJYK0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiJYKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:25:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E712A1D306
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:23:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f37so21058079lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/rueLkErXcyJyPk78wEDhbANCqJ+K9rCJeT2P0Ue/U=;
        b=P9QtxjbP8BFwnXyVhC1nZOpLkGohvfxMoxUcx+V/gFCCpd0hQ8tmqS2XyAqd2JmI7U
         Bk6ZTrpwAKjBEGgqbBTKNk7+V/mgWAWmKDWcsI+tZqwH7d35nbajBYcHqQWIwePGBmbq
         p61WuoWF63rHOfppgToZyeER/ZPP2xKAv+fijEcHgeXTcwN5rdpZbOWSqejnJuQL9Zwf
         IBkpOBl7CoUo73EZNvtTdFO+aQ5CZAwjEBKi0VL6VesW+xu7VxW9/dl7YFvIfRi/VkMN
         OhcfsrIs1kHdDXU7UBhuBJUvKpM1SO+a6eFOxxKuEVS/vKnVjBCuJYAwU7XeoxcmKEYO
         Q6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/rueLkErXcyJyPk78wEDhbANCqJ+K9rCJeT2P0Ue/U=;
        b=vDrlNWmC1eAxqpskLlow+xilBiJW9QL73Q7NaaHj1cTh+CJ5h/cb/hHosJsCX2QfoY
         VQcAK7amdUsURsgHDU5WECFETrRTEVHK4SdCy1XtO+lpo8NBRZKwTN8O231q0bjIJbr3
         p9o5kb4+RMItmqLWyxEqvnET5I7WN3CFNQpUhZLH9bpsBBtlfIJlwQfWDqHDj/HNm/bC
         LqtFoBZ28e9y1H5cDxoybEBdlNLIorAp6X6/2XZ3JO0LN2onP/jfHlh3hNlv6imETv82
         aPVLpK9b3BwreP/pvJTYhRHvFEjEtnRn/mLqaU39m/hYFTsD9uzqwxhPR+oXdF5jZrAR
         5yhw==
X-Gm-Message-State: ACrzQf3GtPEpa0FFJ9oJJKQJbcD62gBptO+riTNwEUCOCR18W0IWNAmT
        6O6ln4rHrWUyHbhV0tB9bZvQdg==
X-Google-Smtp-Source: AMsMyM5idpO1iNIZWroj7oq6xtgot4wdscnkHql4eiEWNBLInMpsyhaJYtPOx8iIUnNqcSl1mPx/lQ==
X-Received: by 2002:ac2:509a:0:b0:4a2:2bfc:3487 with SMTP id f26-20020ac2509a000000b004a22bfc3487mr14039269lfm.458.1666693386339;
        Tue, 25 Oct 2022 03:23:06 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id g5-20020a056512118500b00494978b0caesm348359lfr.276.2022.10.25.03.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 03:23:06 -0700 (PDT)
Message-ID: <98ed35ac-8dd4-e81f-713e-2e5213731976@linaro.org>
Date:   Tue, 25 Oct 2022 13:23:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] cpuidle: psci: Extend information in log about OSI/PC
 mode
Content-Language: en-GB
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221020115513.93809-1-ulf.hansson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221020115513.93809-1-ulf.hansson@linaro.org>
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

On 20/10/2022 14:55, Ulf Hansson wrote:
> It's useful to understand whether we are using OS-initiated (OSI) mode or
> Platform Coordinated (PC) mode, when initializing the CPU PM domains.
> Therefore, let's extend the print in the log after a successful probe with
> this information.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

