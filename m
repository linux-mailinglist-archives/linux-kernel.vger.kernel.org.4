Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38669412D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBMJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjBMJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:30:53 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B8193D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:28:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id co8so7659572wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o773LmcUBl8OymGcQoiP93QpX2J1hD5pNWOtAJSPtj4=;
        b=khCke+fR/UAjzlxCyCMdKltVJkHHEleXyYwvMF0+50/DPzCg5A6RieKJpEDSHeeXVO
         VkrhsVzfSxq7JLXS6OeAwE0wF5Z6t3DF1Tuwu6PGXKqc/l0Nv/H+GQZNvSPOO0SaL5mF
         WMrOa5QytgsoUx5JuJTF5QqVyevgRPG4MCea2HNpua0jEtHr57tH0UrMqzzr9IqgckNR
         +VGANmvNa+9sdApt2H7h3H5K+gMrNEIxtIVCM0fKG8gT0sk8TCsM4mcyA+sikxR2XIXq
         QhZDRw2PKkffml82ifLT3eeGnBGrou/VkMORLtLun8UGmQX6N9ddd3vEc3Qwvf5ricI3
         g05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o773LmcUBl8OymGcQoiP93QpX2J1hD5pNWOtAJSPtj4=;
        b=rc2o4ubCoDcrOpkTI2qEXM0TIIAT1MwUKjTQS/5Ev5p+n890/ibCpPqvyIhraHuOUv
         GqCEwJbrjDBbOzkSnjt/DjRx9ZgOxz8huzo1e3OTH7IUbSd/gvy6JljWWcTBXEUAzSgg
         Rvahrk1tQVzNXlEo0hNkD9JmstrqzNp5m9kMXW9OQKzIkXYZyX7AEUMZjXZmJ20Yhspg
         J1bIBKdMgHvusz/WfC7QventttGq+1ewf5iL8GO0yw/5wXtUvpCw8ofwQK1xuHoaepAo
         xgs7TdMenKFP16pF6jdT74sQPSOiD0O8Ska+JoMydraWklCnEp2wZ4Qwtv3yDaUiaSlO
         vLTw==
X-Gm-Message-State: AO0yUKWZKIAqU3X9AIoiIQkyYzRuPoGoO/i25z3xbPrqRz1Ilkj/bXlD
        Z3mBI85V45WUj34dQ5DrkBoQog==
X-Google-Smtp-Source: AK7set9L87Lxu1KcxNg989VNiYJ7rY8aakXspZUnydQWYpAr5BVDZuwpmUPtR5Has1SVeEAQTwUUXQ==
X-Received: by 2002:a5d:4c8a:0:b0:2c5:588c:84a8 with SMTP id z10-20020a5d4c8a000000b002c5588c84a8mr2608664wrs.19.1676280492081;
        Mon, 13 Feb 2023 01:28:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d6984000000b002c552c6c8c2sm4363765wru.87.2023.02.13.01.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:28:11 -0800 (PST)
Message-ID: <e94c3d2c-10ab-01a6-ff41-cbca34b88fcf@linaro.org>
Date:   Mon, 13 Feb 2023 10:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/4] riscv: dts: starfive: jh7110: Add aon syscon node
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230210061713.6449-1-changhuang.liang@starfivetech.com>
 <20230210061713.6449-2-changhuang.liang@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230210061713.6449-2-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 07:17, Changhuang Liang wrote:
> Add aon syscon node for the Starfive JH7110 SoC. It can be used by
> other modules such as DPHY.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index cfbaff4ea64b..bce3e407ab60 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -251,6 +251,11 @@ soc {
>  		#size-cells = <2>;
>  		ranges;
>  
> +		aon_syscon: aon_syscon@17010000 {

No underscores in node names, generic node names.

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "syscon";

Nope. syscon cannot be alone. Run dtbs_check before sending DTS.


Best regards,
Krzysztof

