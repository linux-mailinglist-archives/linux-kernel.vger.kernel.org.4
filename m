Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4769480A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBMO2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBMO2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:28:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8019F26;
        Mon, 13 Feb 2023 06:28:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73F72B81236;
        Mon, 13 Feb 2023 14:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E36C433D2;
        Mon, 13 Feb 2023 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676298517;
        bh=E4LVZvWW+7vAA9+BkosJMQCtMFxWg1rIQeJAsTCdtzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dLnWY8Tlfl6stw2OZFDay7dVkedLZxdtUWlVpTaAwVCCfwWHzXAA+kuOISqX/4NNp
         9xGO7rBWkjJNhOmnvlpxC1axosJb4STDmd4zqQ6dhdQnsm47cKDZX+8Z43x1fzqZcE
         REd+Vqr5J4eAzLsfuWnpm/HOXmqzEoaPOcnW0VNABkn0i1CU8+JJdD1SQRCfMYdPxj
         STXeI59tnG0Dlm/B28z/o7LLp+IRLUxjuvQequLgwqQNJG/iF4RwNAm9GycIvZW2jd
         8b33Vv+47oAJApoOJALbBq0l6Wc3wmawra8VQkicCz/VEHfHY89vXP+u0ph7KTVyEv
         XwB3pEWyfzd+Q==
Received: by mail-ej1-f51.google.com with SMTP id lf10so455921ejc.5;
        Mon, 13 Feb 2023 06:28:37 -0800 (PST)
X-Gm-Message-State: AO0yUKXkmQyb6VARBLQG8rgVxzOUwRx3reLBHfeYzTNfVGmJ3EnYbtNX
        7Or7zc2v5+KFlWwmd1JWAStzvpp6hEBH6fVHxN8=
X-Google-Smtp-Source: AK7set+B0QjPIbwkuKe7nWMC37VzqT42GBGsuEuJ4Nu+3/g5FaPQ6gMhgRwydGTDlABu3VTmwU4jWqLiwc33x74RgA0=
X-Received: by 2002:a17:906:8557:b0:87b:da7a:f202 with SMTP id
 h23-20020a170906855700b0087bda7af202mr4657088ejy.1.1676298515528; Mon, 13 Feb
 2023 06:28:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676289084.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1676289084.git.zhoubinbin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 13 Feb 2023 22:28:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5APruqAryFJiHBzu+X9dw79-tEVw59kBPX0Q93Lnr3Cg@mail.gmail.com>
Message-ID: <CAAhV-H5APruqAryFJiHBzu+X9dw79-tEVw59kBPX0Q93Lnr3Cg@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] Loongson: irqchip: Add loongson-eiointc DT init support
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Mon, Feb 13, 2023 at 8:15 PM Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Hi all:
>
> Add EIOINTC irqchip DT support, which is needed for Loongson chips
> that are DT-based and support EIOINTC, such as the Loongson-2K0500 SOC.
>
> We need to handle the "parent_irq" and "eio-num-vecs" parameters passed
> from DTS.
>
> Thanks.
>
> ---
> V2:
> - Add the dt-bindings file (1/2);
> - patch(2/2)
>   - Remove forgotten debugging messages;
>   - Rename properties name: "vec_count"->"loongson,eio-num-vecs";
>   - Change compatible string name to "loongson,eiointc-1.0".
>
> Binbin Zhou (2):
>   dt-bindings: interrupt-controller: Add Loongson EIOINTC
>   irqchip/loongson-eiointc: Add DT init support
>
>  .../loongson,eiointc.yaml                     |  80 ++++++++++++
>  drivers/irqchip/irq-loongson-eiointc.c        | 119 +++++++++++++-----
>  2 files changed, 165 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
>
> --
> 2.39.0
>
>
