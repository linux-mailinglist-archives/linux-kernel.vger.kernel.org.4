Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE7E6884C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjBBQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjBBQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:46:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09926E417
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:46:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4171549wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Be6m4n2yTjxOG3cvlCymi9AVSjJxGyk5S0njtlmi7Ok=;
        b=cA0mfPHR1Xqc7an5XX9GrkCSeUT0nmi1XnDca8+0UZzJ2Aw0yyiiBYMu7rZSQ6nQmT
         pugxP8g9LCTbjZ8VXZlZ7R5eTXYNHfD23nDdHWCN+JNRV/rt+STOUL4fnIvq9Z5UkiS9
         zv1gIlR+XuaL02QSJgLFzPxtg8Iy8WRa7GMCJCggrm6RrEJ/ueNjm4++hYB9frOJjhoW
         U2ZA4Qjsy4oUrs8tgK2EefqkIpUv7B5q0ji1giOpqs8kjYfJROHm5ryzPeX1HfIcmy33
         ehY3W5VkuzEWZqk221STNsYgl9sHdhVM24j1piItHbfYJP3iIVWWl7E6ZPw5XB+Rt/Aa
         9WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Be6m4n2yTjxOG3cvlCymi9AVSjJxGyk5S0njtlmi7Ok=;
        b=31+Vl3mc//gE8g7sMtsQrdoC10r1i8FpxBU8pQO3uG4INvd0bYry1E0KLaZWQDG1Ad
         QsjyrHbVQm8s5zmuM6xnNDn1H6c31Ihh2ISiKa8Gcq0djs7h4DEI81aczNXtApTF5dOD
         ngNmB7kS19op2VGD1xPFkmjXVzjNZSeU9lUzx5baBpSUgYzGZKCE1QbrlaDVN53J3ORw
         m68Iqs5Hp26Pbrr5wRgwEVDfvdHLwldsE8W5eXMppQHS16iZzTbae6IrPqTfbI3+0HKG
         88qpPwP13+T8ItWdvUPyR7roRm4Ogvnqy3pANGnHkcv3bDuogxC2k6RHntjAXcbjg/KV
         kLPA==
X-Gm-Message-State: AO0yUKXj0Ns9x35Rl9PKK32jostRFD6Kq3Sz8mJJHTqStLJJJLVapd38
        QIEaLyBnuw0nm5kaXOG9GFMFNw==
X-Google-Smtp-Source: AK7set9k2KtdeDKVcscpUyx6R5b36GQ/sv5f3qbkMR16PnZLnkTxqesp0C66to1pdh7mwuTQqWi73Q==
X-Received: by 2002:a05:600c:1c88:b0:3dc:1687:9ba2 with SMTP id k8-20020a05600c1c8800b003dc16879ba2mr6840135wms.35.1675356363119;
        Thu, 02 Feb 2023 08:46:03 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r12-20020a05600c35cc00b003d9fba3c7a4sm5925540wmq.16.2023.02.02.08.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 08:46:02 -0800 (PST)
Message-ID: <88ddcf84-47ed-109c-5fe7-1c213abb0340@linaro.org>
Date:   Thu, 2 Feb 2023 17:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH RESEND] dt-bindings: timer: sifive,clint: add comaptibles
 for T-Head's C9xx
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230202072814.319903-1-uwu@icenowy.me>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230202072814.319903-1-uwu@icenowy.me>
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

On 02/02/2023 08:28, Icenowy Zheng wrote:
> T-Head C906/C910 CLINT is not compliant to SiFive ones (and even not
> compliant to the newcoming ACLINT spec) because of lack of mtime
> register.
> 
> Add a compatible string formatted like the C9xx-specific PLIC
> compatible, and do not allow a SiFive one as fallback because they're
> not really compliant.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

