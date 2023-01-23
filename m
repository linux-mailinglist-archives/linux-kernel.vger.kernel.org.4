Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B275267761D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjAWIL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjAWIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:11:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0472859F8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:11:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m15so8307797wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93RRp/CE+5X0AvGdufbO/tTH6jLoZjBnwoSOHiWDUJE=;
        b=Urz5hybevb6Ec0BzhqSZmUHvCvSVKpSodLOWIRjIdJTLV+wJQiD82AB39hXjx8++hE
         ytBznF91G8K3sGh9itEhi8yqXCWJ/gAdPYwAwuLTru6fxl3qH/pdRjr/Lank2QKAoCG5
         Df5Gj/QBTk8CnG8xb4Y7N9xB8IVe1pQhfyeD1/Y8wulsVrnHbgCBEtktNZQoc3qR14tc
         naXTzKImSjjt2PzX7uk0k3w1X0z16gUz8eBn5Dve8qmF+FXMJBT1v9lOVT+RM8ERq7WV
         rdOaS2kNv2EJedc6LbCuw6r0f+UN5aJWyCAOnU9RPM6He0fFwDeMDdX4sx4I2zI1Mjuo
         MSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93RRp/CE+5X0AvGdufbO/tTH6jLoZjBnwoSOHiWDUJE=;
        b=qIubSwUvz5LMs5bUBXZnJhqIlqSs/2FU63/nUSTLCkS+AYh2ja0CP+FabN2HZRqwqq
         egUPDsH2Z6FgaKcqSjHts2YnG9Dm/r2ZLTcsxf1eV+RwK+r93fkWEjhSz2lwOgSf8vA3
         8sa1uhfbRFvxeq1a+pK7e3hzNvPNFRjTttog5oXIH0WbtntYGb4LhC4Wzry+ei2+bPhg
         GvuJShb7jp08DYK4vueyjts1CreCnEncFqjHjvIvMkE4WgNUTYVeUoKgA7xrD0LxUfal
         mFMQoRRuOpiKj9ffONgAdo2tpaBfUHssB54PrBxYOt/YBA+5fuX5CQHg7MaOume+kovA
         trcQ==
X-Gm-Message-State: AFqh2krza7hSLBTYCnVh05X8FTigdFkjj5dv0zapB/ractZBZR+7pJ6t
        VwG5T0rvWqagwbyOf58yjYG73A==
X-Google-Smtp-Source: AMrXdXv7WvwrgSbRzW4Hjdq3PsZM/lReAKVx7yjhKYzY6C4OUStyjYVrqDtwjTwfEsym9bNE+hLPhA==
X-Received: by 2002:a05:600c:5386:b0:3cf:9844:7b11 with SMTP id hg6-20020a05600c538600b003cf98447b11mr24000799wmb.23.1674461514572;
        Mon, 23 Jan 2023 00:11:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b002be07cbefb2sm21999369wrg.18.2023.01.23.00.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:11:54 -0800 (PST)
Message-ID: <bdff58bf-1a07-ab78-a782-d58d8c644e00@linaro.org>
Date:   Mon, 23 Jan 2023 09:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 09/15] dt-bindings: serial: add support for Ambarella
Content-Language: en-US
To:     Li Chen <lchen@ambarella.com>, Li Chen <me@linux.beauty>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-10-lchen@ambarella.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123073305.149940-10-lchen@ambarella.com>
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

On 23/01/2023 08:32, Li Chen wrote:
> Add compatible for Ambarella.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: I32513d98f52af0311dfb55dd5c4739a58f6b9fc1
> ---
>  .../bindings/serial/ambarella_uart.yaml       | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/ambarella_uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/ambarella_uart.yaml b/Documentation/devicetree/bindings/serial/ambarella_uart.yaml
> new file mode 100644
> index 000000000000..238d68078270
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/ambarella_uart.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/ambarella_uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella S6LM SoC UART Controller
> +
> +maintainers:
> +  - Li Chen <lchen@ambarella.com>
> +
> +properties:
> +  compatible:
> +    const: ambarella,uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  amb,ignore-fe:
> +    description: |
> +      ignore frame error report for CV2/CV22/CV25/S6LM because it's
> +      checked too strict so that normal stop may be treated as frame error.

Missing type. I don't understand why this is property of DT.

Anyway several problems mentioned earlier, please fix.


Best regards,
Krzysztof

