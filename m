Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF396E4116
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDQHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjDQHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:32:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B344B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:31:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dm2so61707390ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716704; x=1684308704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12OUf6kLU6TNVZfMTHeDlcExQnBKxAwKBVZHkBwyBFQ=;
        b=XkRXvybLRILOCl9UjWWwC416VlmQ1cloVDtRdRMCaW6fCchS93jRl3ZZB3S/OKfOO1
         flVGv4nRiyhoaIQr6bpWJZ6ehBq3GdRdrJiCn2BuampIZGrn/5Qsdo0gNntwamuAIo8M
         fBHFGeQQzwulRe8nrxJNZgxjjrHwyzDM/UDsEo9PVk7I1D/3mRWMbX4gxiH6Aq7xxAu7
         yhXcnGxiO21/Xz+1lHaeT0W+DohMLnQol/iua8Pp2i3jF4NvsYd9+1CPznsGj2hWo8tK
         rfrOqxnBATcw68tJryEcohh/q30nypfck0kw97kuYdvDdMpcgC2RucFbp0zOvCCxQWMI
         517Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716704; x=1684308704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12OUf6kLU6TNVZfMTHeDlcExQnBKxAwKBVZHkBwyBFQ=;
        b=Rtshcp0gCrzubE6BOUNnzHKA7Yc3acTakG8jM1doDZa6LbB8D7zagxaypXMcLpwcyw
         8jzl62rcAUdxfEqBwWK6y5qN1/H2Yy18DQhDzl9WG+YaDJyJkxPk6THV11kY7nxPazCf
         8eYBz9Dg8tRsqZ1vf2QtnbHMSVtMgmVpagLuYaPqHgU3nowZ+v6oB+vqv6og/SG6mcy0
         px3yQnqIj/VKC28UgN5XYa706/X6uU3JyS/qX5EtuQoJ/Z9uAqAfyLu9drHNrd341nY6
         yW/4bC6EaEW5p1kcLLVIDVsAtO1dX3GrX/kFI9Y9MJPoZxU3oGz+MEfR34wj359S7AfA
         hfZw==
X-Gm-Message-State: AAQBX9dJ8FVxU+am23ojfMbyqgGtKtvCTzCMsIooQ+kc2+kbZ4b1WNpb
        zV6Ixh9EBNZAtV/q9336u1gHJg==
X-Google-Smtp-Source: AKy350Zun1iojsgu+Iufa0ecefqx6Gc/dz4MSNM63NxqwR0162CzaBXUQuv9HyZjSJm3stl/4Kc0QA==
X-Received: by 2002:a17:906:5151:b0:932:40f4:5c44 with SMTP id jr17-20020a170906515100b0093240f45c44mr5346557ejc.36.1681716704483;
        Mon, 17 Apr 2023 00:31:44 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ld4-20020a1709079c0400b0094eaa31aa63sm6004648ejc.77.2023.04.17.00.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:31:44 -0700 (PDT)
Message-ID: <09ff37fa-9f53-a53e-ab43-1da2576aa908@linaro.org>
Date:   Mon, 17 Apr 2023 09:31:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Fix finding alwon timer
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>
Cc:     Georgi Vlaev <g-vlaev@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230412064142.12726-1-tony@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230412064142.12726-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 08:41, Tony Lindgren wrote:
> Clean-up commit b6999fa1c847 ("clocksource/drivers/timer-ti-dm: Use
> of_address_to_resource()") caused a regression where pa is never set
> making all related SoCs fail to boot. Let's fix this by setting pa
> if found.
> 
> Fixes: b6999fa1c847 ("clocksource/drivers/timer-ti-dm: Use of_address_to_resource()")
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

