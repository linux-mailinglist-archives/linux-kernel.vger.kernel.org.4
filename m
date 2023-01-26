Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6067D20F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjAZQpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjAZQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:45:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A51166E1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:45:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so4235325wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Enp/w3Qf2+GBmoyJP5YWXCVerkN6XQoAVEmGTL8/Ffk=;
        b=Xyd0fYZ2Z4Dzdql/uaBJ46hhSoEIk6ggT9SW7hNelJ9d8vwaT/Xy0l0fAkQIgpf2I4
         PKfY8tBcZE64dUARwFW2rq5uxcbQT8F1Zk9LK9nxb0w3UVpSKA+gIftlV3iNejyfXr4U
         oehQ5kfsD9r5X5Qxm4tK15vQxNLwcHhPp0LNEgzXpWbnsHvnrvBF8XN/WSS16xKy6PtP
         592DmMk9cQfMMHttk0gelbDdOmf72iCNh+1vVzAUEKd9iNsJbqCKdmfNxsA8Km3TQQIx
         k0WE75bQ6r9GJFKuFiSR4hXyBGMTkc7EAMHNQovYjlTX1kFADz86TmpQIKPWNHf4CZr0
         mSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Enp/w3Qf2+GBmoyJP5YWXCVerkN6XQoAVEmGTL8/Ffk=;
        b=1ke8tt/I/ArrRAO1+Dvq7fcj/LPdz4KZQIA50KCL1mHRvcW4iOHrOMy3g4xk+PiNfB
         iHWMyusEdZUWuGLH+s0fUP/+UxwtFaKCMJy6rS4k9v3KqwgclBE170PkUKksdfha/gq/
         A49Vq4wT82LlfYLZFnBHeewZIo/A3SvMj6P39vblZSYD6LbcfyqGIj3xm9G+RicRJ8JI
         IJaoiRAXX1iY7atNuS07vvCi4PRwxP/97Ant4QbVKR2GzNaWGHKkkAMfGOp1JxkZMvAg
         3dtFIclZME6hGCgJOQMAKnne1bf1M8wOa8Lpt1yJLWKjEYeCiBbCB+bR0r0re5/phe5v
         k3QA==
X-Gm-Message-State: AFqh2kopjcAInYLNBYhN9WqBCehJwDRTL/POPdFE7XIMM3yWMAnzGz2y
        41r12wTYpc1Wvnp/TmLwYk1ypQ==
X-Google-Smtp-Source: AMrXdXsKsISR6oTne7xdvre6hZVcKLtZaCbJ0x+f/yFt4nW5JdHTj2Y8qWEvDgl0kEkdPIRSNpzWFA==
X-Received: by 2002:a05:600c:1e1d:b0:3cf:674a:aefe with SMTP id ay29-20020a05600c1e1d00b003cf674aaefemr35700234wmb.22.1674751542929;
        Thu, 26 Jan 2023 08:45:42 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003db06493ee7sm6005683wmb.47.2023.01.26.08.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 08:45:42 -0800 (PST)
Message-ID: <ff3aebd7-2932-fd9f-3e82-fe123b770a87@linaro.org>
Date:   Thu, 26 Jan 2023 16:45:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
 <Y86CPmgvAi+kChQI@gerhold.net>
 <87192098-b7f4-060f-9274-933d974c0a7d@linaro.org>
 <df4c76eb-aec7-823e-28f9-5ba96cc200c6@linaro.org>
 <b7343ea6-7194-e709-8fed-4a1a17f7beb5@linaro.org>
In-Reply-To: <b7343ea6-7194-e709-8fed-4a1a17f7beb5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 16:32, Bryan O'Donoghue wrote:
> The only input clock to GCC is XO or buffered CXO if routed through the 
> PMIC.
> 
> You can select via GCC::RCGR where dsiX_phy_pll_out_byteclk is *sourced* 
> from XO, GPLL0_AUX or P_DSI0_PHYPLL_BYTE.
> 
> So, obvs the byte clock can be any one of those input sources.
> 
> But the question is, if you select dsi0_phy_pll_out_byteclk - what 
> provides it ?
> 
> Reviewing the LK bootloader for 3.18, it *looks* to me like the dsi0 pll 
> is always switched on. The downstream kernel tree doesn't represent that.
> 
> 0x01A9811C MDSS_DSI_0_CLK_CTRL
> Type: RW
> Reset State: 0x00000000 -> BIT(4) -> Turns on/off BYTECLK for the DSI. 
> If set to 1, clock is ON.
> 
> Hmm. I think actually it must be the case that DSI1 is a slave of DSI0.

* If and only if you set P_DSI0_PHYPLL_BYTE::SRC_SEL = 0x01, using 
SRC_SEL = 0 (XO) or SRC_SEL = 0x02 (GPLL0_AUX) should negate the dependency.

I'll review downstream further - perhaps DSI1 in practice doesn't set 
P_DSI0_PHYPLL_BYTE as the source clock..

---
bod

