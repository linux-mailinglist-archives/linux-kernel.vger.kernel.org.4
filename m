Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9943C6F4B63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjEBUar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjEBUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:30:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F819A2
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:30:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3063208beedso2064025f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683059442; x=1685651442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBB7l/srr+tP4GZyp5fCjE97P649+PUzRDgdEV6rGZA=;
        b=dzmHK68LA8m7RO25h4HY6aS89fDoz6/gk8GyjJqsBUWSqcqLpZALgof0p5cuJDhiDY
         LQ6uEX/cwgjhXp2ZIt6aawymZkuTbtrC0ehq4HJMTsudelWIodaou3JXcHiHpTszu7Z0
         M5vxgpZjG12VSxAVtn2ECgjDb1dX/Iii+yH66jyuwXkyKHwz6cwCyS2hBF1t11zHfuuH
         5qE/ooVZeOUMOvmFuYMAoz/yGMpSrO4fw8lmL62ZZgip0VXh7YlFnfdsU4OyZi9YkizO
         Aj1brV69RIdD0O/g+KKM4wu9FGA3cUzIQnWT67f8/+Ik2Tf8jtEoSSw0vZ4UwhxPkkAO
         Id3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683059442; x=1685651442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBB7l/srr+tP4GZyp5fCjE97P649+PUzRDgdEV6rGZA=;
        b=K5St3R3mv8exRlG/FZGGaz8hrmMuZn+OaXeF8m7ybSQRcGFN0V8NDPWjTjAqSFZO1v
         A3KBUBkXThF5N/MAxnXv1noJr9KziLk53FzGHvkaZ+a0zlVdzNtTF9vi7caUkN5a2kX2
         L29Lt9reK8wS5QnMcr6KYzt/Wx+s3NCqUd929DK2Qw8RdUTUGppsPFVAP+BPYms+mPYM
         enO2BR2X4lFlbxNDiEdTQVwieKoX68D3MqeQ8wobwxdGhob5y3//AQyydeU/NpB5oCri
         DGsdoiMJYFEUeFw67K3/SGafuK37xIVhOEw51TOepvrA9xxVfbaOwlpxSRdF7AXbN+ff
         SNEA==
X-Gm-Message-State: AC+VfDyWmOiza9sBAS8vg5eYCyElOWUu6l1ZWOHGOoVcD+cKMs91VP1o
        n3Oo9gn7s7OaP5BoX9KtJ3ob5w==
X-Google-Smtp-Source: ACHHUZ4+zjK+OPKjMDt90TGnAGS5p9jXdecgcEwVnd6F5u6m6lP2kq4YpJSbU2wiyE8/PM4yYXvjsQ==
X-Received: by 2002:adf:ec04:0:b0:2f6:ca0d:ec1c with SMTP id x4-20020adfec04000000b002f6ca0dec1cmr14541297wrn.10.1683059442008;
        Tue, 02 May 2023 13:30:42 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6246000000b002feea065cc9sm31808215wrv.111.2023.05.02.13.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:30:41 -0700 (PDT)
Message-ID: <7abff69e-52ce-a781-5e0a-fac4782d26ee@linaro.org>
Date:   Tue, 2 May 2023 21:30:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Change the interrupt from level_low to edge_falling
Content-Language: en-US
To:     tremblay.gabriel@gmail.com, Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230502-gtremblay-x13s-keyboard-v1-1-6bc3e59b0d39@gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230502-gtremblay-x13s-keyboard-v1-1-6bc3e59b0d39@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2023 19:31, Gabriel Tremblay via B4 Relay wrote:
> From: Gabriel Tremblay <tremblay.gabriel@gmail.com>
> 
> 
> 
> ---
> Lenovo's x13s internal keyboard shows responsivity issues when fast
> typing occurs. The problem is not replicated with external HID keyboard.
> 
> This fix tries to alleviate the problem but requires further testing
> and commenting.
> 
> Signed-off-by: Gabriel Tremblay <tremblay.gabriel@gmail.com>

Hi Gabriel,

Thanks for the patch. Just a small thing to improve: The subject line
should include some reference to which part of the kernel you're
changing as a prefix, so in this case something like:

arm64: dts: qcom: sc8280xp-x13s: use falling edge for keyboard interrupt

might be a more suitable subject line. You can usually look at previous
commits to figure out what the right prefix is, to see commits which
touched a specific file you can do something like this:

$ git log --oneline \
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts

I don't own an x13s so I can't comment on the change, but hopefully this
is helpful for a v2 or any future patches!

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index bdcba719fc38..e8d7f02c9bf3 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -639,7 +639,7 @@ keyboard@68 {
>  		reg = <0x68>;
>  
>  		hid-descr-addr = <0x1>;
> -		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts-extended = <&tlmm 104 IRQ_TYPE_EDGE_FALLING>;
>  		vdd-supply = <&vreg_misc_3p3>;
>  		vddl-supply = <&vreg_s10b>;
>  
> 
> ---
> base-commit: 84e2893b4573da3bc0c9f24e2005442e420e3831
> change-id: 20230502-gtremblay-x13s-keyboard-289935f922e2
> 
> Best regards,

-- 
Kind Regards,
Caleb (they/them)
