Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9407664313
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjAJOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbjAJOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:20:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F255544FD;
        Tue, 10 Jan 2023 06:20:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9so13290091pll.9;
        Tue, 10 Jan 2023 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ez2mZli6D06vZpdj4fXBsrJU+DkfzTuM1pJBzBkzGOU=;
        b=pMn1XzDI8soISX6QvuSzywsxG2OGaFx2QfNF13+6gyhTHCwY7T495EGEpEkIz5hJBz
         K8Znv2KBwAa/InabxejBPMns29dvx95bE68Y3a/xTGEAWtZgtOsIjlH0A73QDW2Pp4g2
         SdU6Hifk8Ln01nEPtlu4dhatfZdS6UbiwpuQazNWzX1KnqsZ26+ENjni4aQUXCUTrdAb
         A4cEjIBZ+t/D5kB1ApdE+yfumw4phqNtbuvI1j8/7Nc3fTrY++AId5bvYgCdjiIOZ3ZA
         YNi1BySOvJJ/ATq7GIHVBV9ZNvIVNasKicCB0Hd+52rTpzk6AwHBZF6DLczmUxCVIbdZ
         OTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ez2mZli6D06vZpdj4fXBsrJU+DkfzTuM1pJBzBkzGOU=;
        b=0LqZOhjj5A38TBhWpcBcKRVrsooetD320ZlbhnooPJTalDAic9b+RwCCzkYb9xn8Zx
         VPr97lJbKxtWtE7Wr8fnEJbEBfGYaXmb7a8F8esEIRYQJ96Ibn+euDbiutxUzwvt+o9Y
         sfNlAkuoMZbxDOy53/AJwJAokNtmYO6FFH/IkMSMkEX80N/Rj2+OUXUlAwcEV7CfJPPX
         PDJUQG77zNbmPUmv4+jgbH3Zvi/leEF5gtHpu9ss67l/N0sBXHMsN20W9HF+8rC+a4QM
         mGGHQhXczDCJCKsDuNfNyUFZqK5T1+rjW7pWk/UwbPenbIwPU5SSNObOKmsfm/kD9niU
         X1kQ==
X-Gm-Message-State: AFqh2krYGJdD6m2Q6pKqUfa53k4bzEisuYss2rdNJ+HYJdIwymEd818G
        /QyTevXbAlz7/I8F42bEaNTr4tU4eMm11g==
X-Google-Smtp-Source: AMrXdXufQ5z/NOYz/j0h1zB1hVSDqnexy6+Lmq+PPpj9ZQs7r720d+jioVZU5yLjJMZohmNJYtt1Ng==
X-Received: by 2002:a05:6a20:9e05:b0:af:9391:449 with SMTP id ms5-20020a056a209e0500b000af93910449mr81224968pzb.45.1673360421678;
        Tue, 10 Jan 2023 06:20:21 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id r1-20020a654981000000b004785c24ffb4sm6933674pgs.26.2023.01.10.06.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 06:20:21 -0800 (PST)
Message-ID: <034265a5-0e16-d217-ad1d-e0a83f8440a4@gmail.com>
Date:   Tue, 10 Jan 2023 23:20:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/2 RESEND] dt-bindings: pm8941-misc: Fix usb_id and
 usb_vbus definitions
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        agross@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20221228133058.213886-1-bryan.odonoghue@linaro.org>
 <20221228133058.213886-2-bryan.odonoghue@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221228133058.213886-2-bryan.odonoghue@linaro.org>
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

On 22. 12. 28. 22:30, Bryan O'Donoghue wrote:
> dts validation is throwing an error for me on 8916 and 8939 with
> extcon@1300. In that case we have usb_vbus but not usb_id.
> 
> It wasn't immediately obvious if there was a valid use-case for the
> existing code for usb_id in isolation, however discussing further, we
> concluded that usb_id, usb_vbus or (usb_id | usb_vbus) are valid
> combinations as an external IC may be responsible for usb_id or usb_vbus.
> 
> Expand the definition with anyOf to capture the three different valid
> modes.
> 
> Fixes: 4fcdd677c4ea ("bindings: pm8941-misc: Add support for VBUS detection")
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> index 6a9c96f0352ac..1bc412a4ac5e6 100644
> --- a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> +++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> @@ -27,10 +27,14 @@ properties:
>  
>    interrupt-names:
>      minItems: 1
> -    items:
> -      - const: usb_id
> -      - const: usb_vbus
> -
> +    anyOf:
> +      - items:
> +          - const: usb_id
> +          - const: usb_vbus
> +      - items:
> +          - const: usb_id
> +      - items:
> +          - const: usb_vbus
>  required:
>    - compatible
>    - reg

Applied it. Thanks
-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

