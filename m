Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4114766C24B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjAPOfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjAPOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:35:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C62551006
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:15:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d30so37995238lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwWy52CuSIZ9eeAn8m8F4RjsGnVyeTFSxR7ttkWFgbc=;
        b=ji55DZWAclT0NfXHWD303ChamS+f7PR4Lw5pAEjqzKWaWS+BsPBM6A7kHRO/Znlj7l
         lxj8UWk2RLHKaJaRg1knZiKGhZm+cVhjd2tj9K5NA0yHIUTuj4reBFZZ7vukP4zEdYxK
         1GO6/l7/651rrIleSh4VIL60XTO9gC521dwVBfr00w4bgLIozbGFM7UK/sxb/U0ebumR
         j/vfbBh+kjZfG5olSzZh21w/cquXFcTbWxaTu51hZrFKYRVzRpleYnngNgGhckGTIlk7
         m31DBlEbkL2XUmjOeOKwE6ZJO4TlbA0Qv7oCUVQ80oxtdwLWafujhB6kTMxSp1eykzhA
         DPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwWy52CuSIZ9eeAn8m8F4RjsGnVyeTFSxR7ttkWFgbc=;
        b=Fy1GO7QayS9E5AX6nBDKVH5YhXWoSkoQkvc4d+1mwDLA1K4RfsZsPK2ulTZjn5UY+x
         YUenPEYV/ngsVNnt7mEgfhoQG38xCIXaJ0pPtu7KMlGJFMr2KBwIxqNp0JEi7+Z3NvjZ
         wR91FoPRS7M+QHtD5EtPNp0+YMA5A9mqMKsTwgjZXDBp4f62jBTluBfT5aiWoIRfHoXi
         76uNr83aREWU9Him4plRSSoYFzoWjUDU1tk2zMc6ZvGztV4iEcu4HhRNmNlwmpk9HegG
         mGmj4lZQmtCnpBeh7ZfC9UGH142+uMjcpOxxFZmYH6IjtIhKWWYrxLokdqWvLkFyR894
         jAFg==
X-Gm-Message-State: AFqh2kpBe9CdlFy2uV8HlJfRcZbqSc4ligHVqgqg0an+K4uQ1oyHJT30
        7ITAM2L61O/bT5ANcBvxJUYflg==
X-Google-Smtp-Source: AMrXdXtvsGUapjXBIvvMOjjcI8t13mJHnthpf1KoQB0yhdkbdaQS+os+FXdJ3ObnXejoWhEHBkSpHw==
X-Received: by 2002:a05:6512:340e:b0:4cb:35dd:e58e with SMTP id i14-20020a056512340e00b004cb35dde58emr15727231lfr.49.1673878512524;
        Mon, 16 Jan 2023 06:15:12 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id u3-20020a056512040300b004d1454463basm1442136lfk.94.2023.01.16.06.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 06:15:12 -0800 (PST)
Message-ID: <ab07ee73-0ad4-769f-cb3b-445f7a2cf089@linaro.org>
Date:   Mon, 16 Jan 2023 15:15:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm630: Don't use underscores in
 node names
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116141337.469871-1-konrad.dybcio@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230116141337.469871-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.01.2023 15:13, Konrad Dybcio wrote:
> Rename the reserved-memory subnodes such that they don't use
> undescores.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Ignore this revision, I didn't click ctrl-c quickly enough..

Konrad
>  arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> index 0259e90aad1c..763b1df692f2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> @@ -133,12 +133,12 @@ ramoops@ffc00000 {
>  			status = "okay";
>  		};
>  
> -		debug_region@ffb00000 {
> +		debug@ffb00000 {
>  			reg = <0x00 0xffb00000 0x00 0x100000>;
>  			no-map;
>  		};
>  
> -		removed_region@85800000 {
> +		reserved@85800000 {
>  			reg = <0x00 0x85800000 0x00 0x3700000>;
>  			no-map;
>  		};
