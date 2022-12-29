Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BA1658BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiL2KYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiL2KXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:23:40 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1145FAC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:19:12 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so26935640lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMKLMjJpe5LSVosq/kgKiCUoGwlkMRk7EHg56MOXRG0=;
        b=W0/mzJ+BVYSeYNkqjUy3oTgPwLK1Bx4J2+308QC0ISlojj5vA7qUfYge3guPCW0vHR
         b4uo//YVXlquaTDtBEvxbnRLbSNe2ihsWAdvxUgYoZl+UxYKxRxRXRGdEQEh7KaHZttC
         xpqJPTr4MDV22D3FtYZIe7qJK+0g+cgNpJuRko0WgzLNja/E9UpMy3KX18bIVuCgwKiL
         V8rVp2b+G80ZWFuy43MTMYfn63OXdXuXo5NEd6S8hbKUe/B6ad/PPDyK0m7G68Rp9Ud+
         WY5lvy6RWe3ZNXefsOkQFswi8xsP9eDLrPYQdvUe7Z+JZCEz5+l1pwcPfVV/fNbCcnr1
         3AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMKLMjJpe5LSVosq/kgKiCUoGwlkMRk7EHg56MOXRG0=;
        b=ptruT/rHFqRW6vBm75g59eoiZAI8iWPRf+f8CI9hsLIgZqqv7Wn7trHKLDZhZzngig
         kNvVZjt/+K7L2Neq8D2f0cBEEH5AKK7sJMI+QOcYe0OnoPmHTiqjoAgn3PaGBVmWQRj+
         2uLXFX8pxylIRPUawJ5TxrFOqkr09XJ5UjWEn/KsPDSu82p0aExbgGc68uAQTxo5wG1E
         I5kFPr6ohc8KNIe2VIUlel6BD2yzn7mnT6CXFjUcOagJlCvu4PReJWl8VDDVOBW6O1sT
         Ufwe7WVSgzQuP9wOT9F3gwRdyAjmIkqopR+K7ruMld8EkH9di70RDuBtqD5B8xGCQmLS
         yXSg==
X-Gm-Message-State: AFqh2koeUPKsz3fMZqOYY1jC/cvZanqOnecejF3F+5Doowdsy808o/Co
        PsVvsfANcIhrVhAGE+bwHyQHbA==
X-Google-Smtp-Source: AMrXdXvLe1i7tZ7mGvfACMbmYCAO3F40RJhpPtndbkRc12jHOJYE7rKTNP/9+510BhvQHTQwfbG2xg==
X-Received: by 2002:a05:6512:3b2c:b0:4a4:68b7:deab with SMTP id f44-20020a0565123b2c00b004a468b7deabmr11677612lfv.7.1672309151197;
        Thu, 29 Dec 2022 02:19:11 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d2-20020ac241c2000000b004a05402c5c3sm3024922lfi.93.2022.12.29.02.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 02:19:10 -0800 (PST)
Message-ID: <d84f46f5-9975-cde2-0b56-b51990e27150@linaro.org>
Date:   Thu, 29 Dec 2022 11:19:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 2/3] dt-bindings: usb: generic-xhci: add Samsung
 Exynos compatible
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221229100416epcas2p3614b693ab922aadbdc76c0387f768de9@epcas2p3.samsung.com>
 <1672307866-25839-3-git-send-email-dh10.jung@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672307866-25839-3-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 10:57, Daehwan Jung wrote:
> Add compatible for Samsung Exynos SOCs

Missing full stop. Please explain here in details the hardware.
Otherwise it looks it is not for any hardware and patch should be dropped.

Also, missing DTS. I am going to keep NAK-ing this till you provide the
user.

NAK.

> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-xhci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> index db841589fc33..f54aff477637 100644
> --- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> @@ -29,6 +29,8 @@ properties:
>          enum:
>            - brcm,xhci-brcm-v2
>            - brcm,bcm7445-xhci
> +      - description: Samsung Exynos SoCs with xHCI
> +        const: samsung,exynos-xhci

Missing fallback.

>        - description: Generic xHCI device>          const: xhci-platform
>          deprecated: true

Best regards,
Krzysztof

