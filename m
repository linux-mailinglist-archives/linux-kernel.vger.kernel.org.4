Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC66C60DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCWHcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCWHco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:32:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECE618B39
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:32:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b20so49677359edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679556760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFjdhGVAVLmJfJbsLJg+MW5XxCNPSaPcqy98LHLK7ZA=;
        b=Qs1Qji3UzVhAmRyICBZM7AUUwfUec3hvzWeWsVmRWN47ioJozTpJZg4G/C6yy/KfYs
         faoMBCAQXI6CMN4Rle2lVxdoM+7MUI2H3lbWyjOdLf5OMEK7OL7/DHKXqR7sSyuJIpJF
         k60P/Dy5KiWC15xPc68Zf8tDFwD6ISVJ+IO/N0Z3BTM0UfBoCTrsNNZwGkbhUYXfid0L
         YMuZbMMk91j+Ng8dOpc0PeDLsb/oYuwkU+/VAWPPk0nqP5RnMX9I26u14hSHsfeoaDkg
         2E1ajJ5kOdct7OeBlX/8f703PXW2wDrQEaGXUCyualhaAafWTFwrf2AT9rzFct6Fwodu
         wi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFjdhGVAVLmJfJbsLJg+MW5XxCNPSaPcqy98LHLK7ZA=;
        b=kQKSu/UHWDSId3gZxckKE6wOSXKOBuidyzFjlpcJy2e5d9cIwnI/dguqbljjIKxGQs
         hsqzLgs+uxMBGzht22XjzA+FmTCVgKbr0w7yitfA4QuZnJ972UVv74jdauhdg1ySPG7B
         /AJONpsSjRytzp8JuoOOH9Oo8EPiMBVkEzUwPZBvfVOYU6YvEJAgDJt7ikIbisAXpxXt
         zJyqngL4xDU0Jpb2CkFqtBSt9FXmTsCIMGxy2maMo/gdH190Ag0zSc131MRmXhjwyrna
         KgvFl6IF9baWAoj4vwvHqjovb/hPg/ie/Bupy8kNxT5tGVxhzQalHNuQ+9YKEWGp/q4o
         exjQ==
X-Gm-Message-State: AO0yUKV3+lwH1sgmmbNEyrS1x62dphPRgXZ04j4dY1K/Tq9JgJQAxcha
        2PdMxh7FAX8DKvfG8HarJEKArg==
X-Google-Smtp-Source: AK7set9pJbJnwcfSZN0TWiCnaqZcp1FZoWDB0fQIp2VGCLFec6jWw3j1RyKtbIhjTH3JMu1dRWjSBg==
X-Received: by 2002:a17:907:d410:b0:930:af80:5b9b with SMTP id vi16-20020a170907d41000b00930af805b9bmr11459345ejc.1.1679556760757;
        Thu, 23 Mar 2023 00:32:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id m20-20020a170906259400b0092b8c1f41ebsm8207595ejb.24.2023.03.23.00.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:32:40 -0700 (PDT)
Message-ID: <48aac8ec-f7f9-1ea2-7b98-1172c04edf47@linaro.org>
Date:   Thu, 23 Mar 2023 08:32:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: arm/soc: mediatek: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230322173501.3970991-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322173501.3970991-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 18:34, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

