Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F4727789
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjFHGny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjFHGnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:43:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E826AA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:43:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977d0288fd2so50406666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686206630; x=1688798630;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKifchXYMlN5+2AWBL2iJu9wgd/o/GbojOV3x5kNS0c=;
        b=JJOaHAJBSsmNiXdcSeQRVYguDgcMAPhD/0NvwEH+rwM7oadea/3imyyUH7GrPuTVua
         GWSi9tgu58jqb30nw4MqAlo7O5SWGMJ11FRooQrXh3yOTIYbgaQEPuLqC/Lj80S4sMCR
         1OLmmdxqQGHIPGYlODMhf9sfAkzhi432GaN6FH+6a/D2O6abiJC5FwWROcARIIFB1WwW
         Zfk2lDW7MlAyOtthOz0DAKJuvJUgp3Xhka1pZonjWO/rAHZAMdVhZl/aNbhZvNrG9uBz
         kBIisZDL7MwN6ZGMIOPrR/+Odg7x691Ct67h/alSjDtLPrvpNdp/5LEiK4kDM/7Jlkv8
         FG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206630; x=1688798630;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKifchXYMlN5+2AWBL2iJu9wgd/o/GbojOV3x5kNS0c=;
        b=QNyzgBmQUHQrqifOS6obWtnNkAMey7w/fLBmufRL2q993Z6NC2NJA8RbCVwmkI8m3b
         9faDcpEABFL+fsyntsm3P7U6FSPczEmxx7RrU73v1p5WGX5isgGr/iwYgY8ZPfzwAqSh
         1oZY0zV+YV7B7z0+m/STJwOYPwEvVOVnqi9aP4HxU160ZA/wWg2kFTTb709fsHBQwnsl
         AKJezl5ifyGI9eHX2KnIZpIrHQTLAgCnjQ2LxRqZe+ss4iRadAXRzMq+ziHXfktj7T4b
         m6b80erQ5EJAaeQS3UasBk55FIIbOdAeq8RAGCGVstDbDu5Tgcddrd75k5BR9/bdMLUu
         whWg==
X-Gm-Message-State: AC+VfDxMUnKlEolt51XofXxZH1b1VoEf+o5WhFfO1LjHfxTaagRUHlEM
        4/ef9hqJ0ptrSE+HyTHofmwz7Q==
X-Google-Smtp-Source: ACHHUZ615GandBmkZOQAM6x5MNaoNmT/us1RhpkDbmH/Hf32IQotU4lzJJnZ910ZD8BTz+8svgYJMg==
X-Received: by 2002:a17:907:72c9:b0:977:abac:9635 with SMTP id du9-20020a17090772c900b00977abac9635mr7665424ejc.20.1686206630126;
        Wed, 07 Jun 2023 23:43:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bq15-20020a170906d0cf00b0094edfbd475csm273385ejb.127.2023.06.07.23.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 23:43:49 -0700 (PDT)
Message-ID: <ce99a709-ba4a-eb53-39ac-88a194879000@linaro.org>
Date:   Thu, 8 Jun 2023 08:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
In-Reply-To: <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 09:24, Krzysztof Kozlowski wrote:
> On 23/11/2022 07:16, Billy Tsai wrote:
>> Add device binding for aspeed pwm-tach device which is a multi-function
>> device include pwm and tach function.
> 
> Subject: drop second, redundant "bindings".

Where did you implement this comment in your v6?

> Also use proper PATCH prefix.

Where did you implement this comment in your v6?

> 


Best regards,
Krzysztof

