Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D666DA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjAQJes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbjAQJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:33:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653C10C2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:32:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so20503514wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2yzfMbJs5xKELz2yPDwH60cP2GhKjFOWZEohX/Y0I8=;
        b=NPkmMpcdydwO1+gkNBLMZhQaXsRTZfq9HhPTl3oWwlHlOITKWDuv+khTtvDzTuyMCu
         YETb7afrc2Wo7dqz2DUu2oJrT0Pu1ZvuBBi2M7SGr0sE0A26iwGTvC76xCrIVvZcOq+9
         7jIX0hkERNfNy4w981jDnGuSS4M3oWnCq8oX74TRAo37JCOKEOnhnyRjU965bBaeozdB
         iqybrovx/oWcCpBY7Tcpn0Zj62WQpUymX4OoybSdHTFlsOUpAWQybV0YXzLOPYrHJUtn
         HcEjHDNNXlZ5G4VfcVa6vJlwPYPsDVOwW8t4Ua2e4eLHalPPAEAgH9ob9KB1s4hHMpEE
         IEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2yzfMbJs5xKELz2yPDwH60cP2GhKjFOWZEohX/Y0I8=;
        b=q5BL0R9x/f6nFswOGpRuMdnZh4Jz6PMNWAV/lfKCjs8tq1QXoiMdjaNdKVfShNsa63
         eTzHYLU4izIZoS9xpO1ojRcYLBhdzMd584ytXGkv9wkwauX95XHUTq6XjPxs+QYPTWBy
         iQSgN+AQV196aZlzf1mvPX7ksPNuA9BPnQwD4jJ1bljocMr6iKQfUAFXZt6vC+9TBSwU
         t9FDcupQaYhFG7zbfWfEqk8STiU6pR5wTZWW/xIm2jqcJhJKKsTP2MMl5ofZ4qKc7M0u
         35lrvkDllxKI0d9EpgDvmI9pmep9zBZdynIB67q9S7mwB0HdFpkAulpnxWRzA7DLZ+Yr
         cb0A==
X-Gm-Message-State: AFqh2kpndHlA/ASjmnTpqn5Ifeme9/M/gm9y81xS5rY5t6aQqh0Z7ZEY
        Fou3lUICpUJ13f2ApGehTIbbHw==
X-Google-Smtp-Source: AMrXdXvUOw0DSCNQ9Vr3Bmvy1v9bsCbgc2JmOkherEYAI47Voqu0MYkp7Zgqw7vWIEmcslFvoYRAbg==
X-Received: by 2002:a05:600c:31a3:b0:3da:6a6:739d with SMTP id s35-20020a05600c31a300b003da06a6739dmr2353249wmp.19.1673947972797;
        Tue, 17 Jan 2023 01:32:52 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z2-20020a5d6402000000b00297dcfdc90fsm28167437wru.24.2023.01.17.01.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 01:32:52 -0800 (PST)
Message-ID: <91ae246c-3a51-adc4-aceb-a78a842a5f96@linaro.org>
Date:   Tue, 17 Jan 2023 10:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] thermal/drivers/imx_sc_thermal: fix the loop
 condition
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230117091956.61729-1-viorel.suman@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230117091956.61729-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 10:19, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> The minimal resource ID is 0: IMX_SC_R_AP_0=0, so fix
> the loop condition. Aside of this - constify the array.
> 
> Fixes: 31fd4b9db13b ("thermal/drivers/imx_sc: Rely on the platform data to get the resource id")
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Reviewed-by: Dong Aisheng <Aisheng.dong@nxp.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

