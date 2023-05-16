Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB2704912
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjEPJXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjEPJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:23:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16755A8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:22:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso24900483a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684228955; x=1686820955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmbe4ardltZO5J/zFBdgY/LnMe5yW9e5u5O6/jnVcFA=;
        b=ryHwipEUBbAf6sqEkxpZVnrX55o8fp/MzOa3Pt/zEydT4KIrIggBsUCmFUskSDYgxk
         WW9khsj9q1Zn1eAoovpUJgUOhf6P+KSzJ47p9W2DLbYFu5QUjhXZF850tj5MCobIlSJF
         jzFP+4eQQmX0NRgwElIPVz+prcH9SIdoxjBO+YmmOaSGuSgaisnXKriJkRm2Piex97d3
         GIzWMxpgbeFGzbrpZt2O9AYNhiJO3P6Hemls23mZwmMi2HDL8wLXy/HYtvSYeSrhFSVs
         UiOqmgo5wXqBvLyHJXD0MeQjqy0oyrW2JD8ImEkF1V0JzsntNJW3wZeZxqUatldFL0cw
         9MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228955; x=1686820955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmbe4ardltZO5J/zFBdgY/LnMe5yW9e5u5O6/jnVcFA=;
        b=J6HWgVKWbWim2yid5RZy8pjqiCJRlMTrKKoMz2phkxutwG7YP+eABOP0A1T6DRINa6
         kkcUYQoGbsgvATlvODSrVqvLpYlOGQznWqhOXT8z/Sda7mKBDBnIGFT5ain3bicMezuS
         dxI5V2Z51Q9Wep1egqLpQuOpdLuIgPbqPvZpmhL15yuv+p9xslyRr2ZjuAS0+2cO2KTO
         bqxKUETY++9oXzaMxIBu9d+rkT/d7jfv8RcKvkWunbkj0EGEcBuMED5FxZrZmOb894mj
         Sxs9jbhiid7v5XysL1TxHRAAbi/ISXEdt4M7ri3rzR1OZ/hIIBDfIkO0MhZfa7kkh5zV
         D/Qg==
X-Gm-Message-State: AC+VfDxYL/eXCfA5OFRR4u+zLob/uJ20hx0+9dF6LsJr/iJyG4ZlhaYf
        tDwCoL+JgflvGcrAPGKJNd4d0g==
X-Google-Smtp-Source: ACHHUZ4tuI9fGqIXB1tjrf4HSQs70Nzwg/KXG3Ygm9m/fj9Q6ly1yYElwDLUzzMr3Ka1UabKWd04CA==
X-Received: by 2002:aa7:d48b:0:b0:506:7304:15d3 with SMTP id b11-20020aa7d48b000000b00506730415d3mr26587956edr.14.1684228955508;
        Tue, 16 May 2023 02:22:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id m17-20020aa7c491000000b005068fe6f3d8sm7960982edq.87.2023.05.16.02.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 02:22:35 -0700 (PDT)
Message-ID: <2e06e7db-64f9-51f8-adf1-b240f30a2608@linaro.org>
Date:   Tue, 16 May 2023 11:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: arm: aspeed: add Inventec starscream-bmc
Content-Language: en-US
To:     =?UTF-8?B?Q2hlbi5QSiDpmbPmn4/ku7sgVEFP?= <Chen.PJ@inventec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?B?WWUuVmljIOiRieWuh+a4hSBUQU8=?= <ye.vic@inventec.com>,
        =?UTF-8?B?SHVhbmcuQWxhbmcg6buD6Iux6YOOIFRBTw==?= 
        <Huang.Alang@inventec.com>
References: <28f0ce0a82464083ae24f9ef2f598425@inventec.com>
 <c5dd9b64b4754da8b11efefd97527a4f@inventec.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c5dd9b64b4754da8b11efefd97527a4f@inventec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 11:15, Chen.PJ 陳柏任 TAO wrote:
> Document the new compatibles used on Inventec starscream-bmc
> 
> Signed-off-by: Chen PJ <Chen.pj@inventec.com>
> ---

Please always sent such patches together with DTS which introduces the user.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

