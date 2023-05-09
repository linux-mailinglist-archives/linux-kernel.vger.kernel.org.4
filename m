Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B816FC745
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjEIM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjEIM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:58:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1EA35B3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:58:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9659e9bbff5so1053577666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683637130; x=1686229130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7emZLWmbq57tRJlGtK7gIIvsEhrAEblhjMW33XUy364=;
        b=xyLx/eX4XTIt7Kqrv9qylXshl/BidRDhODMAA8canOv5pbcfguBeozWKNn76AJ7OBu
         97tdoa3gbAObnnJ8EDMxBaleLXxe2OaLMm8xXzqyORr5mdZU17ltyhkxAiK9Id7XMfQV
         cQsJIB5Yhpjahvg9kxLqQE8jnqmAPcqyz7/SN1dhvZJfh+TjYyZpyh93Q0+o+TfApw4r
         2R1+JQhZdbx2hkOO3aXp49y15GQJmRUZ3b3SbCId+2eocxL6ESuSgOxLBtLhOfd4b7I1
         bucVbGIyiCiIpqvGHQQ5OIlmSUfWmcRCstQhvmJn8M6KPG9v98WdOG5i2P5/ZA8N9lKa
         uznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683637130; x=1686229130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7emZLWmbq57tRJlGtK7gIIvsEhrAEblhjMW33XUy364=;
        b=C/xwpJI4J5htOP0YCzlbaUx9dV0/0JhgsRHL4S3rVFKLCpWtavXvK23BQORG3xUGkt
         21Z2fLUvopeSUTvJS4w9YYEaxia3Rv2ZjnllqJo7B+bbLMLipv61r94yXhKcPksv6bMH
         3nObM2bjeHBvNdU2AZdG+dMPCPZBPTxa+f0k2mqMqXmiMxyQQIryB2Jp4in4QWgyQpHs
         bMIX2vW02DMbzYdXI0qys0OSi8IN+BHXRUesmWzlTumce9xzFsZiE+dBobI12DePN8bz
         XE+HQRLBDIT3rBKnTPyDEnZR1EGi+WdGMzE33EozW23WOSQ0gVx29EwaZno97kKwOpNq
         MCjA==
X-Gm-Message-State: AC+VfDxdq4lk+yacUJi22hceDyLuyIGPs99fhJw/doHVn2Yv5pwyVmhG
        pEdNZEAdO5RtdSJSnmx92I0ErA==
X-Google-Smtp-Source: ACHHUZ56lTU5iDWQGq+ZkveUT3P5//LKk86sbqcSzvwdNzIfkoaVAn6EDsolvwBPJ88pmwn9fdX2MQ==
X-Received: by 2002:a17:907:928e:b0:94e:8cdb:bcee with SMTP id bw14-20020a170907928e00b0094e8cdbbceemr10610088ejc.70.1683637130168;
        Tue, 09 May 2023 05:58:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id s3-20020a170906bc4300b0095fde299e83sm1272123ejv.214.2023.05.09.05.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 05:58:49 -0700 (PDT)
Message-ID: <da268ca8-0548-748c-0c60-c190dad447d3@linaro.org>
Date:   Tue, 9 May 2023 14:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: arm: fsl: Enumerate Emtop SOM
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230509111920.3301542-1-himanshu.bhavani@siliconsignals.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509111920.3301542-1-himanshu.bhavani@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 13:19, Himanshu Bhavani wrote:
> Add entries to the list of imx8mm boards denoting
> the Emtop SOM from Emtop.
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 442ce8f4d675..06eb2c790f90 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -884,6 +884,7 @@ properties:
>                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
>                - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
>                - dmo,imx8mm-data-modul-edm-sbc # i.MX8MM eDM SBC
> +              - emtop,imx8mm-emtop          # i.MX8MM Emtop SoM

So the name of the board is emtop? Are you sure?

Anyway, organize and version your patches. Your work, which now I found,
must be one patchset. We have it very nicely documented

https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst
https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/5.Posting.rst

Best regards,
Krzysztof

