Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703BF65EE4E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjAEOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjAEODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:03:39 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC112D02
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:03:38 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bf43so55141485lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5zML+NPV/fPr0ZWlrrZXjBxIr8nZb+LuCRyRRcoWI8=;
        b=GOKUDttjA11IzZPrNzfinH3jYjtRfTLJpPSHvtDaquUjbpOJqzX6kHzIuzMNhk5Ayk
         evrSapDJP/n7OLxXflnC6UuYx2KZ/+ltwqhuvneDswtXyKAajgbqGR/gF8xB1hRtpJjg
         cOqtMhDw0G4EAgVrnxMp84JA9dChr5a2dl5NYOh+V1dE+luS2HULSwbwj7FhC531ymRJ
         GRcVO+q7SSbq7Sg6jX5fZMStF98hf02sUl4s6qtsZg5YnJxTrPFXAsptzkxmAyr7wQaC
         X1zBXCJn4WzW2GqCPXLKpzKcspZ+GlSyvhDXCt7aSvhMrQV5rLqXsY/0h1A4RduC9TJL
         jdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5zML+NPV/fPr0ZWlrrZXjBxIr8nZb+LuCRyRRcoWI8=;
        b=sF2MML4Z0oxgbPIbSZ8YxzDbBCBBfw+zXJ7CU2UiwGHvQ6ZHETbO5FoWiQLR9twdY6
         7aKUtxlUY5nnuZTB73cS93sFZXAfWXveLBL5HVdjRTCEeLIV7n2txPYlNKmK2M/d2vjU
         xylELxHxMdyvQB1xkEnZfuAdJ1E/UpepZdI2uYscUfQiHsY3XcVA5jjD9BYqsNl3ua6N
         KBfqYjDzH4UjYDr7W5gnUnrXWZBhcnz4HxTZDbnQh8VRi37aSG9n58iR6P/6uQr6NINj
         XEKq4yAfXL3eTu6e1RsJMZAra6ZaWNBZyKGljVC/HQqEqYQmV5g21xSmRJtUGS7YGibc
         FOEg==
X-Gm-Message-State: AFqh2kr/b62O7tDNq5bEfxAWEQ4crwQqAIkttxY7waOk+xy9w/bCOtTa
        ZT1yMsMf6nrmzVrNvv0zTeZ5Wg==
X-Google-Smtp-Source: AMrXdXts8OaV+by4rav+F2DbaiGsDbjZ0sNRC6o0V8rzGjOjaAoQWyON+agvW/5FM38n+C0UN23SCQ==
X-Received: by 2002:a05:6512:ba5:b0:4c0:91d0:e7b7 with SMTP id b37-20020a0565120ba500b004c091d0e7b7mr24071207lfv.27.1672927417012;
        Thu, 05 Jan 2023 06:03:37 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id bt17-20020a056512261100b00494942bec60sm5462737lfb.17.2023.01.05.06.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 06:03:36 -0800 (PST)
Message-ID: <517e749d-12c7-2ba1-f6e3-b96f682b432a@linaro.org>
Date:   Thu, 5 Jan 2023 16:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for disabling
 unused clocks
Content-Language: en-GB
To:     Abel Vesa <abel.vesa@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221227204528.1899863-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 22:45, Abel Vesa wrote:
> There are unused clocks that need to remain untouched by clk_disable_unused,
> and most likely could be disabled later on sync_state. So provide a generic
> sync_state callback for the clock providers that register such clocks.
> Then, use the same mechanism as clk_disable_unused from that generic
> callback, but pass the device to make sure only the clocks belonging to
> the current clock provider get disabled, if unused. Also, during the
> default clk_disable_unused, if the driver that registered the clock has
> the generic clk_sync_state_disable_unused callback set for sync_state,
> skip disabling its clocks.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v2:
>   * dropped the check for sync_state callback (clk_sync_state_disable_unused),
>     like Dmitry suggested
> 
>   drivers/clk/clk.c            | 57 +++++++++++++++++++++++++++++-------
>   include/linux/clk-provider.h |  1 +
>   2 files changed, 47 insertions(+), 11 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

