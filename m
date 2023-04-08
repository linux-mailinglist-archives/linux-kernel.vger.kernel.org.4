Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F826DBB10
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 15:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDHNFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDHNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 09:04:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CFFC159
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 06:04:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qb20so2179008ejc.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680959095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xh6bkPStbSQ1dpU7KkzU52JsHTt879N0HimG72vQ3b8=;
        b=nC2gVPZl249RFf3lqlnEwLwWaSnSBhNAAtAGz51eClGxhAosm6fjUWZPeTiE8fQAcN
         onc0QiQ86NbO04Ch6QpqEmeAa4xq2it6BIgeVTutKtZbQO7L5+fHcbBaHl1yI5ZW0TSY
         VbT/ntcEB21JGFm7srOvxNoqHU/DcHZlMu1hfYbExArDiLDB6DYMlB5YH0uFXkVCykFV
         QLJtz87vdQvGne7zLWLfOJ1LmMpYiWR9X9LvfqxgZSdeN49ARPnZ/cDzxLhmRF5Sy7yk
         66k4XbOQDgpQP1hQ8yzswguZYWQkV2SGe7IVN+c6VCWRXWYv5LMlqxzLagN1olSjk4Cy
         yyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680959095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh6bkPStbSQ1dpU7KkzU52JsHTt879N0HimG72vQ3b8=;
        b=ObgUKPQk0WRblqNKngjYAIDz1v7AdsnaErPvPx9dxk84d7aAacwqssSlI3OPVaeXBN
         ruYMUnc54nYRuSCnpsxX5b6wuc6YkgSRCkHLrKKRf9DbQgOSilI1AcwXnM0wpaTMPkVM
         G3ggFNk/dfuLr2aNVgndipkITpT/CNYb2vKA8C0WTav5tTcs+4+Eco874n0QlfMVM7pP
         buRghtoON3gn8XWqoE7EtTt0ypz9DzRc7MFmu6lzrpF3pg6gXZyPgtBhtpZ2XfpvbXEv
         x6NlR3rhDGnXUO6rwzaD7GtwFaHRAB/XGyVaGgE61f1o4/UN/u9daLMT+QecQxP9E43z
         zC+g==
X-Gm-Message-State: AAQBX9eVDQIZ68bebVryfdEh7AYwyJ0vMVv9YjvbqLpslPxAbCuLpivL
        KQAPY7YZYc3/0EKyrVputMDfyg==
X-Google-Smtp-Source: AKy350boyGnKqw7hqq5JoG0wMx75lTrgQ0trInMINpWhZDplgYwWd4Yao3TWoUpRzku1t20dTYUkNw==
X-Received: by 2002:a17:906:4b14:b0:94a:52bf:b820 with SMTP id y20-20020a1709064b1400b0094a52bfb820mr458098eju.46.1680959094876;
        Sat, 08 Apr 2023 06:04:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ecc:a9b7:a95b:bbea? ([2a02:810d:15c0:828:7ecc:a9b7:a95b:bbea])
        by smtp.gmail.com with ESMTPSA id xa16-20020a170907b9d000b00948aae5e3d3sm3104065ejc.184.2023.04.08.06.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 06:04:53 -0700 (PDT)
Message-ID: <0a5729a8-9fd8-a084-3932-cf8ebf00860b@linaro.org>
Date:   Sat, 8 Apr 2023 15:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add
 mdss and dsi panel
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230323005925.23179-1-lujianhua000@gmail.com>
 <20230323005925.23179-2-lujianhua000@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323005925.23179-2-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 01:59, Jianhua Lu wrote:
> Add nodes for BOE NT36523 panel found in xiaomi-elish. This panel
> is a dual dsi mode panel and the dsi phy type is cphy.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v2:
>   - Include missing <dt-bindings/phy/phy.h> for phy-type property.
> 
> Changes in v3:
>   - Sort include header.
>   - Move qcom,sync-dual-dsi to the front of qcom,master-dsi 
>   - Add newline before subnode.
> 
>  .../boot/dts/qcom/sm8250-xiaomi-elish-boe.dts |  5 ++
>  .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 75 +++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
> index bd9ad109daf9..8b2ae39950ff 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
> @@ -11,3 +11,8 @@ / {
>  	model = "Xiaomi Mi Pad 5 Pro (BOE)";
>  	compatible = "xiaomi,elish", "qcom,sm8250";
>  };
> +
> +&display_panel {
> +	compatible = "xiaomi,elish-boe-nt36523";

If you add new bindings and new nodes using these - in this case this
panel - please test it. This is why we have DT schema, so you can verify
your DTS. Sending DTS which is entirely different than the bindings you
sent, is adding quite an effort for us later to fix it.

Best regards,
Krzysztof

