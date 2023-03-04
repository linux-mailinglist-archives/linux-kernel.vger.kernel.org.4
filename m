Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454836AA9CA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCDNGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCDNGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:06:32 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E351F5D9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:06:25 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t14so5045373ljd.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677935184;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nq7RQs0U77nY3Yu6+qe7lgnNWc3KY5n1/kyKW4La5xg=;
        b=Ub3GmbAe9LdLddNEl8G7TY47M4k6pvwbcag0kyux7eGT7fCdPpBJqcuHsy9ZtjrhIA
         r+A4PGSaZ0yp8fz7c2MrpJH0YdWj4lhv219GhYQe/4f42grcvvK3f0xtJbym6mger3Bz
         h6vsmSPClri0lv0ybfTodUyyrwsDefKZ4poLBQ5M503WkMwv9llNx0ZHy88dm1JG+OPE
         RxWDOaCT9vbObIEg+N0GpsN9ZAbvO3A01iI1zGwxQxPo5oXVRaGNYJrXFpgJoFh91O30
         +Aaypm8Wwt/qq0D8jDR9EmnKrzGSi0G0MVVtHfYqGfBh1WAoEC/iCWFWhYt+pgWojVbw
         WWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677935184;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nq7RQs0U77nY3Yu6+qe7lgnNWc3KY5n1/kyKW4La5xg=;
        b=3F3raALuRkTVT7wMqc5AZaLP+IkPeWazMrytLpJ+M/nQpBpEb9VVCYugFqbCTPU9P4
         VCE3VKsglQnlWxC09Xi5Y4sovRM6aRa13o+Uh4QjF/abkPVOHkr7SUTuUQH/Lc2fNLKR
         v5lioMX6X/B7CS36Emu67MR5+t3pzW0JUxU9NfOo3MiDRLn14IvWYsjC4wHkYkzq/YZj
         o+5Waqy6dym8VwuNM7xokCgVUcPgO4TTwhpwBPYa/nVBCiw4wrckEjqd2jYbWIjr7sCP
         nzDLVCZlQw7u+yRea1fOlE9QxmNB5h3WAryBrm+FN2m8AzkU25tarozaJUM1qOxgPUGw
         LFDg==
X-Gm-Message-State: AO0yUKXa2eBo3RAz8COYZsaJTmioWk3AeY4csp6aa82FTeJhPQ1GgwKX
        iyVZRIlvCHkFpZE3AZo/JZgJ4Q==
X-Google-Smtp-Source: AK7set9kOJL7U5kmS2hwnyPHAFCjV+srmsFP+snsnMIBbIxjSGLOzmGP/uu7jJscrr3FDOwTC5ULeg==
X-Received: by 2002:a2e:a411:0:b0:293:4b9c:a164 with SMTP id p17-20020a2ea411000000b002934b9ca164mr1549960ljn.48.1677935184215;
        Sat, 04 Mar 2023 05:06:24 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id o30-20020ac2495e000000b004d593f218absm817655lfi.108.2023.03.04.05.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 05:06:23 -0800 (PST)
Message-ID: <d90448f8-9bc4-3a14-1915-a18c2cba100a@linaro.org>
Date:   Sat, 4 Mar 2023 14:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8350-microsoft-surface: fix USB
 dual-role mode property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Katherine Perez <kaperez@linux.microsoft.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230304130315.51595-1-krzysztof.kozlowski@linaro.org>
 <20230304130315.51595-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230304130315.51595-2-krzysztof.kozlowski@linaro.org>
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



On 4.03.2023 14:03, Krzysztof Kozlowski wrote:
> The "dr_mode" is a property of USB DWC3 node, not the Qualcomm wrapper
> one:
>   sm8350-microsoft-surface-duo2.dtb: usb@a6f8800: 'dr_mode' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Fixes: c16160cfa565 ("arm64: dts: qcom: add minimal DTS for Microsoft Surface Duo 2")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> index b536ae36ae6d..3bd5e57cbcda 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> @@ -341,6 +341,9 @@ &ufs_mem_phy {
>  
>  &usb_1 {
>  	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
>  	dr_mode = "peripheral";
>  };
>  
