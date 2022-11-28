Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C33563A992
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiK1Ncf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiK1NcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:32:18 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBFC1E719
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:32:17 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r8so13143674ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTk1f4/UabUqSaJoF84fcu0LQGS8SFqgsuHi7F6fCmA=;
        b=bBXRoJxIBv+ZBlHdGK/YYBiHHzsROn2/wVRwIDc/Ftj+fiXiW/v3Smcs42r7Yhcr8/
         y2bopk4Qp79o4/MCW7oMrSvqN24Tui+ZjHzhPNxCV0PG3jvvEpnbFbgRETOKIOvwg8yB
         j6JfFuEsWIX2pBzRN/PNGferaGDmngRe5tDvmZBQu65yi7FPosv139CSEMm4gbe6zGbw
         l1VmmGXvZlRxYRrrZeByhnQdGn6ltLKqYwO0BbwAYVCbSW6ESYWgPnFNMMwV8TK11lZq
         uzxaPx29UNheINTbSIqL9NXO/pgpZHCtNoV/dKALc0FJFbD4iULKLw394eyF7ZMvkeGw
         rw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTk1f4/UabUqSaJoF84fcu0LQGS8SFqgsuHi7F6fCmA=;
        b=qIGSzDRapv2LqAF0tAngBudMDYk2YyTt4v70s8CJchVJs8F6RvsWvd59WHGRLVjljR
         Zuhu58noy/bUurfHjlBBtD8JaUhxvkQkTPAi9ro7J4abFvfemhJEPaPDbViAHestMudg
         sskJzf2zOeLmrhLpQfuctn6tQRXke2OF6Ump95D1sqqizafghQsIfS2g5N1ECZexQDgd
         z/K6qZBC8O38RXBlNf/IN7xkFOREh770OWbP9ioBJnwjBVYUaIBzD8bgjxORXTeatGNu
         UKtP9tOYu0Ncqz4yGbw3L8RUbsL8rirgPKKSJeEwBTknmFjfXhRlQ5v3YEbbgTHUc4Mu
         xeyQ==
X-Gm-Message-State: ANoB5pl8gUyxA9g1RDsr8HHXfbeu2u4cyncmuqkySBkEC7hOIS/RtIKg
        2jnolu4yPpCNH+upY2vDZv9lWA==
X-Google-Smtp-Source: AA0mqf7TjM+XfkD/x98kN9/YPxlKDY7URm0w5/ZKEJGOGW2kQ9rdPYDx9dbzRYXZoLEJPEhA7tolSQ==
X-Received: by 2002:a2e:2c0e:0:b0:279:8d29:193c with SMTP id s14-20020a2e2c0e000000b002798d29193cmr6056865ljs.167.1669642335016;
        Mon, 28 Nov 2022 05:32:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h19-20020a05651c159300b0026de0c8098csm1234052ljq.26.2022.11.28.05.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:32:14 -0800 (PST)
Message-ID: <6b445991-0843-6a1e-1bd0-1980a78a0481@linaro.org>
Date:   Mon, 28 Nov 2022 14:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V4 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>, bjorn.andersson@linaro.org,
        arnaud.pouliquen@foss.st.com, swboyd@chromium.org,
        quic_clew@quicinc.com, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>
References: <1669642093-20399-1-git-send-email-quic_sarannya@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1669642093-20399-1-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 14:28, Sarannya S wrote:
> Some transports like Glink support the state notifications between
> clients using flow control signals similar to serial protocol signals.
> Local glink client drivers can send and receive flow control status
> to glink clients running on remote processors.
> 
> Add APIs to support sending and receiving of flow control status by
> rpmsg clients.
> 
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  arch/arm64/configs/defconfig   |  2 ++

Thank you for your patch. There is something to discuss/improve.

defconfig changes are not related with code, please keep separate with
their own explanation.

>  drivers/rpmsg/rpmsg_core.c     | 20 ++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>  include/linux/rpmsg.h          | 15 +++++++++++++++
>  4 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0b6af33..2df3778 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -26,6 +26,8 @@ CONFIG_CGROUP_CPUACCT=y
>  CONFIG_CGROUP_PERF=y
>  CONFIG_CGROUP_BPF=y
>  CONFIG_USER_NS=y
> +CONFIG_RPMSG=y
> +CONFIG_RPMSG_CHAR=y

Why? It is already =m
I don't think this is correct patch hunk...

Best regards,
Krzysztof

