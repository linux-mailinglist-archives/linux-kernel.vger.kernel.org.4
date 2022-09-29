Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9105EF7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiI2Oea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiI2Oe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:34:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846EA1BEA6A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:34:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id j24so1758654lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xqO7boSGntSno3tBpht/Rqvzj2qvhSRjOWUVkdWFtBQ=;
        b=iH8BCt8voVsR0DnJ5f3TdhbiQ7B8m+riiYjqCQ5iXuWI00SIyrE/nPJP6e5UZHHgiD
         qyn9zwnx4xWCNEXkkGqNfVreJU4vfOl6MSBJfStcqVwYngUY/JuWVDnA532tBX/8XJhN
         SSZg/cOzMluTNkVPzwWkrhq7Xnxp1bHBNtivIW3F1Rwb1SSYtu9vgEnwj4skaNmomst5
         QWv6zYbXQJnVaEajlHZdoKV3UGR8SlIUJM8AdhrL4FZ/BntmeKNsRtggifuPNJc0isnF
         7eEUUFc5pUHf7BsZRWJKoS17X68rIWIa1+W3hxity1H7Vg7LsB8k50wSs3fcZqkf4VIV
         LPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xqO7boSGntSno3tBpht/Rqvzj2qvhSRjOWUVkdWFtBQ=;
        b=HF3NQC643q/REa18DqZSSMbI7sjT/2hPihBrpUa87kqlXiJHbVOXsk4g0Xt/iQVlI5
         u4vaUURp0GfHykGt97zOpX3p23Cs639sgCQnzrsjY6OWK4xilJJJvlLsLklTTRwRJg9m
         a+mlrSgESrqXM/PiZ8ytv42JPT348M/cG1C9qiGFVHWXxc+3LhSgy5kJtxSnvrx89l88
         t/Gma1fFRXa7vm7uEwEclK5Iu/YOgXZCglJwe5F5W90ZW1crrhe3thrOdPp1K9Z2cAJ7
         DyhbGCkixVw6lrqic1Swfnp7VYVxG19g4qpfYqOu3SX93xB7OS/8y2V5174FYCl3vAaM
         Ht2A==
X-Gm-Message-State: ACrzQf2pna3gn1E801pjiwx2uu/foZPAZtTDdv5UD/N50W499W5GsQdr
        0CToj4KoGFtStxC+n5mk9TfnqQ==
X-Google-Smtp-Source: AMsMyM7Z/LaoxosbVcWiuMFaeyweVvrU8N+LBV3Off9sKT066Le2b1TIDHKPXaqvM4w9Rai6ijyMDw==
X-Received: by 2002:a2e:1f01:0:b0:25f:ea3a:4ef0 with SMTP id f1-20020a2e1f01000000b0025fea3a4ef0mr1283681ljf.330.1664462063936;
        Thu, 29 Sep 2022 07:34:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f08000000b00497aae401edsm798124lfq.109.2022.09.29.07.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 07:34:23 -0700 (PDT)
Message-ID: <5cd77839-d75b-9290-5d34-90d6464938d6@linaro.org>
Date:   Thu, 29 Sep 2022 16:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 01/30] dt-bindings: riscv: Add StarFive JH7110 bindings
Content-Language: en-US
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929143225.17907-2-hal.feng@linux.starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929143225.17907-2-hal.feng@linux.starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 16:31, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>

Drop last "bindings" from subject, it's redundant.

> 
> Add device tree bindings for the StarFive JH7110 RISC-V SoC and the
> VisionFive2 board for it.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  Documentation/devicetree/bindings/riscv/starfive.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
> index 5b36243fd674..543be573921d 100644
> --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -21,6 +21,9 @@ properties:
>        - items:
>            - const: beagle,beaglev-starlight-jh7100-r0
>            - const: starfive,jh7100

Blank line.

> +      - items:
> +          - const: starfive,visionfive-v2
> +          - const: starfive,jh7110
>  
>  additionalProperties: true
>  

Best regards,
Krzysztof

