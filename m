Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD9E691DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBJLOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjBJLOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:14:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE07101D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:14:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso3792612wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5b+yVSfBFeZHjbbMYH6BQhmXFltHa3Qt3/YVtSfAf1A=;
        b=EzYFV0WX/cXIrguAo5DNgvSDhZTz8eNXyu7IwoN+GmDXPvfzld7Gt0d+0FDICPGQit
         hwqJGhUYdXhiE1NZTyaNn6asWYaFdjG9GrpDNnNLzKXpkLsDk4yicw6ezMDUwb6I1BE8
         fN6aowfYcUJRC4gLAfpPyiZCv1hhb6ZtX/qUkRuZ7ZnUXWdoKIjBkCwY2iigvlpz41H3
         DTQj35jQFl+PWEoK4gnblwo+bGF8mNZySlsB0dhouXWnE0nHTPcFKViowtqQdiQoiAUg
         L/FRLcyFtD3tnYkBo3XOeA/mCT2LUHxdj/LeEoo0tcAzHKcRVN97RcK6PmEgb2R2ZF0G
         zrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5b+yVSfBFeZHjbbMYH6BQhmXFltHa3Qt3/YVtSfAf1A=;
        b=ZwdQeQYQNnKv6OKLMtztm5jNjgOokSynMYqVs2HvUoo2k5yqEQGBhRcrq9kt6LANAj
         yo1bh3TBGilKmsQM6uR9iZAeda84X5HE5Hk1zVfXyShRIBQgitZgPK2iJYt0LqnnxBNd
         bCdHpr44IQ9AOAqhucjsvDIGNVHMQbrfvRM3vTTRkj/KXmljdVUwMjidtIP+m9dU1yBS
         8qt5jazlKQKzG5ge8b3TGAoufRbEHOfYqVAWoupTDvDcW38r7VUsgEDlfFCymLDGBNNh
         pfOr23xyh6tQSnrxbIDqg022wtrm8lIDPY8TiuFlabLxptVj6pxwGRYocJTy6KBA/cJG
         O/UQ==
X-Gm-Message-State: AO0yUKXSES10xaxu4RMaxHr6PBp+PJCKEa955HIlWuFTcEkI7dmclPmu
        kZ/f4be/UeaZj750p3jv0m4BUw==
X-Google-Smtp-Source: AK7set/pOE7BMe56hO0DEZ5F9vS1ipJHrd5K89AnU0ajKIXsAw5OZ+LT5izjSQ0DLsFjqKokOVg4vw==
X-Received: by 2002:a05:600c:329d:b0:3dd:97d6:8f2e with SMTP id t29-20020a05600c329d00b003dd97d68f2emr12260341wmp.17.1676027639995;
        Fri, 10 Feb 2023 03:13:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h4-20020a1ccc04000000b003dc4a47605fsm8076413wmb.8.2023.02.10.03.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:13:59 -0800 (PST)
Message-ID: <a68d90d9-ed26-1493-55f8-8e3d60501179@linaro.org>
Date:   Fri, 10 Feb 2023 12:13:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 4/8] arm64: dts: qcom: sc7280: Update VA/RX/TX macro
 clock nodes
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org,
        quic_mohs@quicinc.com
References: <1675700201-12890-1-git-send-email-quic_srivasam@quicinc.com>
 <1675700201-12890-5-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1675700201-12890-5-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 17:16, Srinivasa Rao Mandadapu wrote:
> Update VA, RX and TX macro and lpass_tlmm clock properties and
> enable them.

Please explain why power domains have to be disabled here and not in SoC
DTSI. I still do not get why these clocks are not inputs for every case
- also non-AudioReach. The hardware is the same...

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 5e99f49..9b04491 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -108,6 +108,43 @@
>  	};
>  };
>  
> +&lpass_rx_macro {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;



Best regards,
Krzysztof

