Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56A066784D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbjALO53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbjALO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:56:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FD63D5E9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:43:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu8so28720111lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SachbnsjogB9d6VznmJ7gd3XdXdQ4weNjS4U9PfSA0=;
        b=lHbyQy+FNSi/meLPTdjOq7NTzEMuxLi4iUUn3c+/PXWcgaHj7llhT0nJmhX86Z+TCo
         GHuvV9WZZbZ1pRpdUsPw37NBE9xIQJwQWYovvGpaR42pZ+13ZKNrUe38ZtvJNylJwG4B
         wJBmA+2m7ENe2ZClbpg98qYjd5mcu4OrW2270zoB3PIvBmrIPekzEwRO8vGqdtKYp6Z4
         kLy8dRkMiNWsj4B0D016+3koH9l4hlJ5vvvxNscIMUIOoj0uN7TbOGNHrYFrZwejFzUg
         Yq1wrSNxKRYxjzKVAHRdDS+wYUvUNpZZaEixbdR7kSyqEP3XldD1p4vek/ifeUbKZf3Q
         1i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SachbnsjogB9d6VznmJ7gd3XdXdQ4weNjS4U9PfSA0=;
        b=IyHKET1YkgwWcjp+TFnjz/0Fh6v9J3/0wJae9ruQTKbP72YPPuYG8Sfj3z07lfrKNw
         q/eMYhD8rCSIbkKETBREOjDDQbQNsymcti0rYS+ybjAU7+SUe5fGIUUSOaAsXZC3trxy
         IFgJFcqe4PvsuEytDS3v0R0pm9RZGO+EMABIseF1gHrLv9bhxRuMKgR1nw7glA+3VbhA
         MY8gIsPJs+f72J+7nIoikwgPucf/ASDsm7aizSXo500W5/vkOiDYdC6x0389QV28MdoE
         nTz1wQ23w7kuEGVAYyKZccEJ4CvPgPoPdxDJWLgnKtOCSE6nVpTqkEPxxjqdzBksf1YV
         mUhQ==
X-Gm-Message-State: AFqh2kqCESqMtbtfs50DPe+71kZE6e88lj+CoDuKH3nnOwLkPB2w9ePQ
        LT/k+7wxTOK3QPA8SaLP6kYI7/FIyENuhJMA
X-Google-Smtp-Source: AMrXdXteBrqUViDjNqvb+oHsCd44njBcMUd77PqwBIZ1I35b614s1q1vnnGbjk9VCt7bz0X5c6TFnQ==
X-Received: by 2002:ac2:5082:0:b0:4c8:eceb:60d2 with SMTP id f2-20020ac25082000000b004c8eceb60d2mr19894251lfm.46.1673534599069;
        Thu, 12 Jan 2023 06:43:19 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id p7-20020ac24ec7000000b004b587e37265sm3299527lfr.58.2023.01.12.06.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 06:43:15 -0800 (PST)
Message-ID: <eb1418f6-43be-6b0e-555c-dd9887577b95@linaro.org>
Date:   Thu, 12 Jan 2023 15:43:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-crd: allow vreg_l3b to be
 disabled
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230112074503.12185-1-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230112074503.12185-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.01.2023 08:45, Johan Hovold wrote:
> The vreg_l3b supply is used by the eDP, UFS and USB1 PHYs which are now
> described by the devicetree so that the regulator no longer needs to be
> marked always-on.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index db12d8678861..e5e75cc2c670 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -150,7 +150,6 @@ vreg_l3b: ldo3 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-boot-on;
> -			regulator-always-on;
>  		};
>  
>  		vreg_l4b: ldo4 {
