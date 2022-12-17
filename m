Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1261464F960
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLQOaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiLQO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:29:58 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9F15A19
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:29:52 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bf43so7643716lfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKzaM/h7vl6R759siCibHu6TxUrRFv6DmVbOkDTjDuw=;
        b=YOPHMkPb/czTunzVGkCZOOu5lXuUDZNpdEpBOqW3bpkFbDPY4U3zCxIxnwHFZ6/8RQ
         Iq4g8Qq8v8nkOUCZF+PaBw6KYVA/yX43eB4VoTz+pOADfRLEfh6e2S/vF0M9kTv4dqdX
         q1vqd3E6vmasvjCE0RIJYwpOCPVdeSbakxvJLaAt0fThvMkWLl9u2gYAfXYHU/k1kxqF
         iHXso5pcgd5e79OeGS5wxIDpWyxlTTaYHzqDsc23nXgAZmh//8NoBgWkDvaYo63GFdBo
         1gR7SPnZ/9YlwBv7kVdLj1CC7Vu9xhCLMQ+HAf3fOzNw4FNx9Az/NgeFPqGi/DzAMiFG
         6TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKzaM/h7vl6R759siCibHu6TxUrRFv6DmVbOkDTjDuw=;
        b=4MCvtWcVFIYylk8R0YRZPkf58Acb46JNLgL2o/3Tn5vcezM/YFyfA7aKXcSCbufcXN
         GmpN2mi2phmixHW+kkGnFS/VOfYN6Wbtez7/0PMl0h+Bq0kslTPXj9JDAn42aXAc8Hog
         GhsCaysSg/VSSHc8ADNmqOZQADuOHUcFlJjy+9KfJU1T9xmzcJp5NyvbJdAwbQyaCZPN
         dlzJC7Fyo7VMQSiFi5omLVclfeVW2yLjMsbAd0espqibiqz1yQM+W/HCJK+vqrua7twf
         ibV2sfOcrLFUM3QX3Lr48/d6bPYYMzTOMHaKZWNyp5StltMTnsY8bKFfzrqLalsH0jtg
         DYQA==
X-Gm-Message-State: ANoB5pne/CIJrCeBLhSgv/ZDJKLQHYF2W20JOucb1vpq9QD5sQpKV+lj
        5fSszShn8X6HypulnafvZ+PDUA==
X-Google-Smtp-Source: AA0mqf4oYJgZJsBoQnoL6WGJjw+60x3a4oac4NeDaCysJL8NEIM5xeQcDJjBdDjoferec0D10QO1wQ==
X-Received: by 2002:a19:ca58:0:b0:4b5:8579:545d with SMTP id h24-20020a19ca58000000b004b58579545dmr9465392lfj.5.1671287391293;
        Sat, 17 Dec 2022 06:29:51 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id c19-20020a056512325300b004b577877286sm527095lfr.50.2022.12.17.06.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:29:50 -0800 (PST)
Message-ID: <3ca81685-fb8f-fa31-3ae8-ef72f3aca7f2@linaro.org>
Date:   Sat, 17 Dec 2022 15:29:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5] dt-bindings: soc: qcom,rpmh-rsc: Update to allow for
 generic nodes
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221216231349.22835-1-quic_molvera@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221216231349.22835-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.12.2022 00:13, Melody Olvera wrote:
> Update the bindings to allow for generic regulator nodes instead of
> device-specific node names.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
> 
> Changes from v4:
> * updated regulator pattern to accommodate more regulators
> 
> This patch comes from discussions on [1] and is separated out. It also
> has updated pattern matching to match the comments left from [1].
> 
> [1] https://lore.kernel.org/all/20221026200429.162212-2-quic_molvera@quicinc.com/
> 
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> index b246500d3d5d..5bb624f62edc 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> @@ -112,8 +112,9 @@ properties:
>      $ref: /schemas/power/qcom,rpmpd.yaml#
>  
>  patternProperties:
> -  '-regulators$':
> +  '^regulators(-[09])?$':
Wouldn't this only allow regulators-0 and regulators-9?

Konrad
>      $ref: /schemas/regulator/qcom,rpmh-regulator.yaml#
> +    unevaluatedProperties: false
>  
>  required:
>    - compatible
> 
> base-commit: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
