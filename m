Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1133869E112
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjBUNJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjBUNJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:09:38 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CA028844
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:09:35 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a30so4437428ljr.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vojoAcfUuZFzbZ4NXFeMzemBjeLJC5XF1afZIyyXCcc=;
        b=BKvymr7g7GtkBXmqCdpf/taKauloWxanij5lD1QUkDuOXbN3q8I7hNjzkWkFm7ja8h
         Lnv2HREXgop8r40ION5WEA6Zi/+O3RgLnI7/3sfev+alJRvJZ5aMTiCnN61I/jDHorLq
         odm0eVnkpaDmzp9cLHu1OU2KWZaJe12e39Pnf5N7zQu96Jc11a6nqXWAgmCghuEGfQai
         ueFL7fttwW+lRhhuD8xLhXGhzrd64LCI3NjqhNh5SjTDrDJYNgGiisTXiAiIxaF2rJVN
         9M34OhMjzFLkd4ibj6gFxHGYm+v/0fWa/fRsAYYsomY5t70qQVWzyIoHe7AgIYh7+mQl
         3gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vojoAcfUuZFzbZ4NXFeMzemBjeLJC5XF1afZIyyXCcc=;
        b=UZJcG1HwMGWgQWq41WQ/HO62YkOU5vvlMai19MIYXyT8pE7EfTO1b0M9zp9a7FpA9/
         OUzD7y8Jx/X4QD+SULwdPG/hFmMD+tkqUstcGfyUw5NsMBr+i3T1IzbZNRQNd4OWXKfR
         BsqvVrWiK2nzPN3mY6LnZNDZhcYv5C0DF8AkAZwQbdIBE61YrDi5foEHBUbATNWSS565
         NAJ4S21Nyouw08D+SHvl/KzSlZ0pYvP6LWh/hTwKVWSHlibcbiGTzItzJvtz3SLZRykR
         b0VaHS5XnbyfzGgu5X2CNPHQalKegNXbuxwPypC1hqUNdnBBXTyrg/jtJkCCA4T7GNC2
         qcuA==
X-Gm-Message-State: AO0yUKUyqE2NodEkJZYz5Iz2jsOTA6nWPY4u8L5R66YVjZaJRgFRvuaH
        K0Pwz6T21qA0cgpRH/p8pp8pnA==
X-Google-Smtp-Source: AK7set/C1Ntt5qOJwBdZyOdjVB+T9JCWwDKooUuf7BcTZANWTJhOWEj0TcTgLQr3gPVK3+7TOeiEZQ==
X-Received: by 2002:a2e:7c18:0:b0:293:464f:feda with SMTP id x24-20020a2e7c18000000b00293464ffedamr1729099ljc.16.1676984973385;
        Tue, 21 Feb 2023 05:09:33 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id f22-20020a2e6a16000000b0029353201fddsm773835ljc.129.2023.02.21.05.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 05:09:33 -0800 (PST)
Message-ID: <efdd3472-57cf-6022-2cfa-53a2fd86c2f2@linaro.org>
Date:   Tue, 21 Feb 2023 14:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: Correct venus
 firmware path
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230221123633.25145-1-lujianhua000@gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230221123633.25145-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.02.2023 13:36, Jianhua Lu wrote:
> Missing vendor name for venus firmware path. Add it.
> 
> Fixes: a41b617530bf ("arm64: dts: qcom: sm8250: Add device tree for Xiaomi Mi Pad 5 Pro")
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
> index acaa99c5ff8b..a85d47f7a9e8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
> @@ -625,6 +625,6 @@ &ufs_mem_phy {
>  };
>  
>  &venus {
> -	firmware-name = "qcom/sm8250/elish/venus.mbn";
> +	firmware-name = "qcom/sm8250/xiaomi/elish/venus.mbn";
>  	status = "okay";
>  };
