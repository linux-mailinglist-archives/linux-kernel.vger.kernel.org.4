Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009106D9F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbjDFRyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjDFRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:54:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBBD1BC6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:54:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h11so44901353lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680803650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/zXT571t+D7DOAkgC59pj3zGw7qdHH2ZzYRuKyFt5c=;
        b=gh2bCyChznvmAoXtartGrmeSLRaZ1qlPlyaFEOqyY6Ez2RDGjjL8YUJCvI4kIjZ9ht
         Z7jkgNSGbOaTd99KKphoDplLDwBIDaPzHecV2KmlHNkOX1TsM5xVHq8hWMTxu1mE33UC
         LY0OEuQlK/z+/qwAmKce65AqtiPVYnopn7XwHi/o8Q5jsiwZMnNSQjcNf6qb1/bgnoSN
         9aAhshWpwK22/5MVrQabM+SMFmRU3gYnwkwwf7DdfTpiTLn+ocjZzZcPQ1B66tzcAZGz
         3WOsbXkycz6SYukQfAU3675kFRFNQB82Pgn3+6Rm2+GEPl1C0tWFF8vSl9CAnpJ29Wj0
         qRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/zXT571t+D7DOAkgC59pj3zGw7qdHH2ZzYRuKyFt5c=;
        b=nfXzkyghqe95roibK/LK+ZhyPaf/FJjiSv0U5IFgAqBn+7YDJROm6J5iD059QbRn+6
         LY0vF/ntDatfePz5sCyKJIhKSyKxoyhHYnusZbkDdJZXh3wj9q3WfIAzada9FAdCymH9
         TEzN7XH6YHErHO/GtJQkB1CYbNNpLKRawllOeG5BkDIHN/Fn8xjX4FcjMuDBaIN0JYbG
         FINNAj/P4lvAuOB1O6R+PHbTG1fOhEGK3gwMMy8eajcba1mcRpkAUyg9ExvOxmAZOMeo
         4pIepZ/1alQgH5EgFbpjokVam+83LMWpFgvTrfu0tgEleIApbaDp/ZUSJuVQXIBxYkhL
         mppg==
X-Gm-Message-State: AAQBX9f3AwWsLVJTABNmOaYQHgenRqD6vhMMP24pk+TAiTI+bFgea6ku
        xAWBjcKhohw4w+455W69OIx1nU+NrGHQJ1GMK80=
X-Google-Smtp-Source: AKy350b11aqh7bMWmNTTHgegnWEvTfCO0FqsH1PYTmHGbt1cUK8tBqJ648WGDx7oactx22PLI5J7Dg==
X-Received: by 2002:ac2:410a:0:b0:4e8:6261:58bd with SMTP id b10-20020ac2410a000000b004e8626158bdmr23803lfi.37.1680803650321;
        Thu, 06 Apr 2023 10:54:10 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b004e90dee5469sm355833lfc.157.2023.04.06.10.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:54:09 -0700 (PDT)
Message-ID: <9554be2b-c80d-8c5b-48e3-2508a7b4ecd1@linaro.org>
Date:   Thu, 6 Apr 2023 20:54:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm6115-j606f: Add ramoops node
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
 <20230406-topic-lenovo_features-v1-1-c73a5180e48e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v1-1-c73a5180e48e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 18:25, Konrad Dybcio wrote:
> Add a ramoops node to enable retrieving crash logs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> index 10c9d338446c..fd064899791c 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> @@ -52,6 +52,17 @@ key-volume-up {
>   			wakeup-source;
>   		};
>   	};
> +
> +	reserved-memory {
> +		ramoops@ffc00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xffc00000 0x0 0x100000>;
> +			record-size = <0x1000>;
> +			console-size = <0x40000>;

no ftrace-size?

> +			ecc-size = <16>;
> +			no-map;

I see that other ramoops defines are not marked with no-map. Is there 
any reason for that?

> +		};
> +	};
>   };
>   
>   &dispcc {
> 

-- 
With best wishes
Dmitry

