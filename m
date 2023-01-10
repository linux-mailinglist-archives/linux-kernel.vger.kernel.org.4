Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB966430C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjAJOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjAJOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:19:09 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43C3BEAB;
        Tue, 10 Jan 2023 06:19:06 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g68so7223429pgc.11;
        Tue, 10 Jan 2023 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grrwPmhSqI3qJm8bnEmnj+X9on9ASlpgUcg+JwSNOD0=;
        b=WXKS/GBU4FZYrsiXefQU46l/2qnAzwWo3+XvukT30nxFYorfquNutSORFirhzEikkR
         sR9V+Z4z5PA/rkiBDQ7qms8R18RLXTF3ARNEuyga/IWtnpiDFbcHcqrxguziAPerPz+R
         YWt+CJxDBZSE+dpgD2ASXajxfXH/kt/VXgAJXtXdbX3Mtqt4u6Kou67XgTT656O6dWst
         j52iY+jWbOTyciO3LtMXeGCrtDEMQUYc87nWLaOyw1D2onMCYNLbo7SuhqfOpbQRJkPG
         VM+Bvhce7mADHURK5Yfw9b20X851cKwenWh8PQsSUI+hjdIZivmlPJ29vsV1yAq7Kupd
         idkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grrwPmhSqI3qJm8bnEmnj+X9on9ASlpgUcg+JwSNOD0=;
        b=0vcCnoXQZHKLmWCDWidSCkVU3TeuAnMIqN81u8oQZatoN2HjN5CU/D6j7H4SqZFbe4
         BgoUx02H0XA4ZjQVfW70REp6xuXo8dbkgifrLB8I93Jl6mAgrV57F9HZ0mIALh0vgUf3
         /4yyTxPX78XdC/8Ddr8XfhbwbuN6UZgRvjQq4lCUqbwzPjGsUMI+j0fm0EUOcxCksxf7
         H50bbIAfPCoVtYiLrWfNq5f/kF2gim8LUc2cdLTOMxuLGveUerATnUsf/me5cVtb4yr5
         jI4t+6XbIFhh/velKfsn/sNH0zwzj9naVJBJCvOE+cKU9uMI7rQhS+Y9ecOjfva4weeF
         PsZQ==
X-Gm-Message-State: AFqh2kqzXXtyaF80aoBa6r8GtC196QN22EhxfhG3hZpYTs1u3T6ClJjc
        TgmWBz7QK8W72N5GiV/Yj7Y=
X-Google-Smtp-Source: AMrXdXtYE34QyxBPqv0I5pIJm03YaHmh5GUiPa+Sj72o3nmUUnjAeIX9lFdxvM02JByIyjCeLHpoNQ==
X-Received: by 2002:a05:6a00:725:b0:581:a633:d41f with SMTP id 5-20020a056a00072500b00581a633d41fmr42563960pfm.34.1673360346114;
        Tue, 10 Jan 2023 06:19:06 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d3-20020aa797a3000000b005811c4245c7sm8142175pfq.126.2023.01.10.06.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 06:19:05 -0800 (PST)
Message-ID: <46489cf4-0ff7-faf6-3f19-dbb64acfeb29@gmail.com>
Date:   Tue, 10 Jan 2023 23:18:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: pm8941-misc: rename misc node name
Content-Language: en-US
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221228214636.6292-1-luca@z3ntu.xyz>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221228214636.6292-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 12. 29. 06:46, luca@z3ntu.xyz wrote:
> From: Luca Weiss <luca@z3ntu.xyz>
> 
> The spmi-pmic bindings is now using usb-detect@ for this node, so adjust
> the example to match.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> index 6a9c96f0352a..fbda899fd260 100644
> --- a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> +++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> @@ -49,7 +49,7 @@ examples:
>              interrupt-controller;
>              #interrupt-cells = <4>;
>  
> -            usb_id: misc@900 {
> +            usb_id: usb-detect@900 {
>                      compatible = "qcom,pm8941-misc";
>                      reg = <0x900>;
>                      interrupts = <0x0 0x9 0 IRQ_TYPE_EDGE_BOTH>;

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

