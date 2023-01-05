Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED465E96C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjAEK5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjAEK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:57:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A8552757
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:56:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso1015171wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9VZahBvTxY/9MJBnzviay36QEWwo3jW0XFOox6Ia0A=;
        b=RhG7wkABz86kAAWTPkXstlLFTX/uUk6qY/Nvaa2kdOpWrerlB1y7LeSJlynyIIuNnt
         pcs6YUnCVbYB3k+AL6znPerB3O36ko/FRhbiZ6/1TRvbk3y83N/Y/CVe+wve1tYWygAd
         FeCiR07BWHC3L7oEJ0sBBRGy0IMgZwJ/yV+EE2GBtXU6nDVE4T4GGntmbvcdPjP+bQ80
         w2Td5FCgrdl6TLjD3sICR/F20PNyT47r7mf9VKPXQ6lI/8agDJJTlWCW+vGy5Nd59zQh
         GsI10ObsL4uCUnaxdS65ALxkr3gw/eTgocsRqAXNemQpCwyI1Cg8zO+k37XLqvS+tjF4
         WK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9VZahBvTxY/9MJBnzviay36QEWwo3jW0XFOox6Ia0A=;
        b=1R9GRXZtjYabkGNaniRVNTZObNAkLUsNUrh/V330s28vVJNzSSwkh8vdVDkjU0zMlb
         pCBN8EXO/FWmMrbBGvOtK1a8bOP6pIFUajTvWc2BY7hJyWJdZWOIWtzYEbp2PO0V3Tz0
         hGT1LipcZEfhmXzmvU/8ZA2V289OR72lSZJZuROs0lkVSyvAjyFNZCdmnQZbeCUShn7B
         NWsneJW+m4tMdWjtX5XYi+azSq5zNlLPg7iCG10E87Tq430TtVI6gky+OjEuQ0VuvAvd
         ogJ3rMjpO57m6hVA2NKEEEIzLz4De1wDs/7919fFgSnWIhghSefTDbUmSkCNVVvlo9Iv
         kD5A==
X-Gm-Message-State: AFqh2kq/JVDMENHeE5VcNAW7Y9H+Zp/m38lwhNYmKHOekO4cNJxvAm6R
        HaIv8apOAT3KmQMkpOfM/PXGfA==
X-Google-Smtp-Source: AMrXdXv8wpbouyeZjnTOPsEiyqNG81EFMf8XRbkvuKOZQLeLIOQYxl691SBvfLOzhZta5c2MBP0hpA==
X-Received: by 2002:a05:600c:5121:b0:3d9:d1bc:310 with SMTP id o33-20020a05600c512100b003d9d1bc0310mr1338069wms.25.1672916217498;
        Thu, 05 Jan 2023 02:56:57 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003d96c811d6dsm2082714wmq.30.2023.01.05.02.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 02:56:57 -0800 (PST)
Message-ID: <4a816ade-dc15-b954-9846-bb8a8b58041b@linaro.org>
Date:   Thu, 5 Jan 2023 10:56:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: tps6598x: Add wakeup property
Content-Language: en-US
To:     Jun Nie <jun.nie@linaro.org>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Cc:     sven@svenpeter.dev, shawn.guo@linaro.org
References: <20230105075058.924680-1-jun.nie@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230105075058.924680-1-jun.nie@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 07:50, Jun Nie wrote:
> Add wakeup property description. People can enable it with adding
> the property.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>   Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> index fef4acdc4773..348a715d61f4 100644
> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> @@ -23,6 +23,8 @@ properties:
>     reg:
>       maxItems: 1
>   
> +  wakeup-source: true
> +
>     interrupts:
>       maxItems: 1
>   
> @@ -48,6 +50,7 @@ examples:
>           tps6598x: tps6598x@38 {
>               compatible = "ti,tps6598x";
>               reg = <0x38>;
> +            wakeup-source;
>   
>               interrupt-parent = <&msmgpio>;
>               interrupts = <107 IRQ_TYPE_LEVEL_LOW>;

LGTM

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
