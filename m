Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C9629F30
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiKOQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiKOQkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:40:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381827CF1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:40:21 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id be13so25330227lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YlMHH2zfcPz/2pANEPoP22i7VsdvmpYnBj7NWZ2VozI=;
        b=LTHwA7jVr1+wgJcYVJmwIYwRljgC21GFpz0VtGXl3ncZiJGDdSEsUGyLvcd18xO+Jz
         vqUKqMOj+JG+Pl6mGeRGFrmvqcBzYbaG6iWInaTiF/HNBhDk4buxCoSSgQsVsxYlL9i4
         qHf1sqGXntYNWo3ijKs8sXWHGnXNEGeVDtknJPQZNorRr0jvKMyIHM7Y+fDjHdG74ibQ
         Gc5F7IGoPORltWeEq83QfpZ38EWZ0dHxgOj/YPNJTbOvvGWytXdKdP07yhVqsrFq3FN3
         fJl/AMg3etlk9PgEljyIjIerSeQYprqqTzqd7l2XDucTwgN6Gc/9IaCS/eJA7NobjoUh
         ekfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlMHH2zfcPz/2pANEPoP22i7VsdvmpYnBj7NWZ2VozI=;
        b=aWc92w7/IpO6GpztkV5FAOhSt7FBOJkYw+mVa7jpU/vX1M71dcMN1/kqCIjseUYaes
         EaZPg6TZALSnoBD3S02mzLh7TwWfdjgMTgbx3eGJtgvxictdVn5KC5Ip90sJ0V8ydpJg
         vcCayC3as/Djtf6GbSTA80ohNncxNhitlum+Z6+bJoOj9s+Xw15VjY8pyyAPzbrpRO52
         LO67/h/iFN6YsZwVmLs1Taa2vVwSoX2WuADS+2358X86WQXLaEB3SlxMhq3IYXbEBSec
         beLER6u32Wlaik1hgvou+HZ7NIufEs9/MnXJ4FDtkxxm25ArHGVqhXEqgHCmiWprVeBV
         +wtQ==
X-Gm-Message-State: ANoB5pl0j8616GdmQEicsk84f2KRur8s0JK1uMgRmiHU02Pmo/xzRF9i
        rPE6RTLknaPzW4bZMoU/D3K0CA==
X-Google-Smtp-Source: AA0mqf7xTqLr6v3wHgV3M0VNy/DVVnQB9h04VGxdpYUeMnoUXLkzf3iPzbeZmzDrm94nUfWj10CKrw==
X-Received: by 2002:ac2:4e6f:0:b0:4af:eabf:3c57 with SMTP id y15-20020ac24e6f000000b004afeabf3c57mr5496946lfs.449.1668530419482;
        Tue, 15 Nov 2022 08:40:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n22-20020a05651203f600b0049496855494sm2276268lfq.104.2022.11.15.08.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:40:19 -0800 (PST)
Message-ID: <c30c0068-de5d-b3ab-9b05-5153ad8c4b3d@linaro.org>
Date:   Tue, 15 Nov 2022 17:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] dt-bindings: interrupt-controller: add yaml for
 LoongArch CPU interrupt controller
Content-Language: en-US
To:     Liu Peibao <liupeibao@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114113824.1880-1-liupeibao@loongson.cn>
 <20221114113824.1880-3-liupeibao@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114113824.1880-3-liupeibao@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 12:38, Liu Peibao wrote:
> Current LoongArch compatible CPUs support 14 CPU IRQs. We can describe how
> the 14 IRQs are wired to the platform's internal interrupt controller by
> devicetree.
> 
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

