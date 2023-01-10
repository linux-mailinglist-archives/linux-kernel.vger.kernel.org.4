Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1156641C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjAJN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238093AbjAJN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:28:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A03FC88;
        Tue, 10 Jan 2023 05:27:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so12367865pju.3;
        Tue, 10 Jan 2023 05:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpoceuX07Y+LzpttmqNDqMv0+/ZLcrXMqGYtxrEUkZM=;
        b=DQWIZLFkILn4uvOhdxf40M/4PWFqEpyHTNlqIINfq1IIKmVRqaVznn+rZ1ugvgjOZJ
         VQ+SWe6sgTokVYWSQ9i0Kk9PfVmrnCM1InSEjL9ooRl2jfYBehlyR82qfSkVVWt+TRom
         f0B08tZE0PxnvH/OXkkruAoF2n9Yz1H0Uk7dAQqqTn2LoHJtMJ2V+OLERuHFrjfjUH7P
         0XhHeFwqMcUcB/83XPuILzxHlZi6q5Cw7wldz0Gqg0pdWgdMcpxZqUuFEKyz8JzIqMVw
         hWSOqdTphfdWSPsP3Y/WXs2x3NWt9TyVBqptiXW2XZbvCbiTfByBs9VsYP5L5z6ClzDi
         DaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpoceuX07Y+LzpttmqNDqMv0+/ZLcrXMqGYtxrEUkZM=;
        b=ULrUjSiElVW+EuKTdfXSicuuGRCDUDiskkKaI48RkFzd4CYDeEYqKA5jbNDVaWwjUP
         PsQlt8w4rFvDrc8j13HNBLw1Bu1TQt9V8+0VTf+bZKEv8hI/JC8H1nXesRdnvwCybeXl
         VLysq8gk5H8goTCrag//7Pp3gr5is0JidFfccHjuvbimQ0G4L4xIZZHhX5QSvFlh3sJN
         jaBU78DwfOTZ33E1IAh67K3oToWfwvorfj898Mt4bHSiEk0lIP6uCo/nRyVLi9PQ4Rd0
         YvdOKFolSMtE8qL6iOPRRiNqMP2vqfmDHQC6j7/bGt/hlCwqYpekVNLIi8za9TLwy3Bg
         XeEw==
X-Gm-Message-State: AFqh2kpcC9XL0VWHrMLF71DqM1TsuNJOPjiwNUZgUNcxXDimCn0oC3bO
        +Id92PwEHyxj6ddJbjZwuoGH8Kg/OcHelQ==
X-Google-Smtp-Source: AMrXdXsRB9kXvSbkS8AyQTKt2I+GcpfA3y1RgJBTyB1uqxsVMTkEkg+/Orrk1IKdM8s7aD+8NeQpqw==
X-Received: by 2002:a17:902:904b:b0:186:95c9:ddc9 with SMTP id w11-20020a170902904b00b0018695c9ddc9mr81593104plz.55.1673357256253;
        Tue, 10 Jan 2023 05:27:36 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00189ac5a2340sm8125172plh.124.2023.01.10.05.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:27:35 -0800 (PST)
Message-ID: <e68cd1fd-0c15-f822-7ec7-eb7658771ce6@gmail.com>
Date:   Tue, 10 Jan 2023 22:27:30 +0900
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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

