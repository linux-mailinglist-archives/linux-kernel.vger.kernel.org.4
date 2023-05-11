Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33506FF83D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbjEKRRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238903AbjEKRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:17:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8DC5BA9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:17:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so11946978a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683825462; x=1686417462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BO10O8iW12DytJ1D0XEr7Txqs1Ww5REXRTxXbIG6fiU=;
        b=f0A93yTj+verQgVFIIytrLJioCA/4tVJme8XHNExd+sIzhoyQV84OjWUDsBUUu169M
         O/S8+4wIjd5SZGyvGAOKRcOMuHOIol2/t+DZRVvi5MC1QxG1oPx8cPo/NdVfhdS6LoCk
         JZAIYkNje4BWbdiUiZjYWRjg5gbqwGgS1tS03dJT0o4meI6/fbo0aXav4T2C3gt4Ibil
         jXWcr+2DshwGRMuusvMurUtezTIWdW+OyHPQJaM8IyuEqN67y4EaKlmYbTB1X4tKYg3W
         8RBNzHBN0g/OlZOpUM0/aJjHSr56v89AcmFXjQUaTaa6dyP4/nBO6BbaoCldjgKizamJ
         zyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825462; x=1686417462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO10O8iW12DytJ1D0XEr7Txqs1Ww5REXRTxXbIG6fiU=;
        b=bUO1NHVCI4f2HUp6ccJ9m37pOri20CV0MLzr147NSDbwQk8R4q3KEGy2m0HjT3UCMG
         ppOd0tVrPSVeu7e7a0i7iP6gB81HfXSUckeUjAb19q2GVTDZZwHAL61UF5bNR/LaWfDi
         JkPjjSJJKb50rQLzDuUU248mVQfvon0AXN0pAf+j6wLOcI7ixDW2juKJJRDUxQ0xHi+6
         RaJNNKCJZw/Wp3GRiMp29aVwWW+P+fIKuP5u7qLT4XTbKtWLZtJ2atFtlpLAEBtTyQQS
         zUG8mEsAX7QuNDEHlP66cejJKJdoN8CpVRD3mAoRC7v3Kip9oqK+pRkb7WCaW7ZmYDEE
         LSSw==
X-Gm-Message-State: AC+VfDwD7km431ENDym/htMk7g3T+f6ORmc1DX24z+1xZ9fX38zFaa/c
        c5lU6D+dyW+thvCgbJch6uZmzw==
X-Google-Smtp-Source: ACHHUZ5cgkWlTUCHRNisr81AR6zb+e6IL4lRvsjDC57u1GW1gp2L8yVihNq3CkPY229nDynudhkCfA==
X-Received: by 2002:a17:907:9347:b0:933:3814:e0f4 with SMTP id bv7-20020a170907934700b009333814e0f4mr20280180ejc.16.1683825462143;
        Thu, 11 May 2023 10:17:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7cd:1be6:f89d:7218? ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm4248476ejc.59.2023.05.11.10.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 10:17:41 -0700 (PDT)
Message-ID: <d8544d01-b0a0-f5f6-b0fe-8f6c25bed9bb@linaro.org>
Date:   Thu, 11 May 2023 19:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Need suggestions for smp related properties in cpus.yaml to
 support smpboot for cortex-r52 based platform
Content-Language: en-US
To:     Ayan Kumar Halder <ayankuma@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, geert+renesas@glider.be,
        magnus.damm@gmail.com, konrad.dybcio@linaro.org,
        andersson@kernel.org, mazziesaccount@gmail.com,
        conor.dooley@microchip.com, j@jannau.net, mailingradian@gmail.com,
        me@iskren.info, lpieralisi@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, Julien Grall <julien@xen.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Michal Orzel <michal.orzel@amd.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <c5ed90c7-7126-0757-a0e3-e3d1fcab2ecc@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c5ed90c7-7126-0757-a0e3-e3d1fcab2ecc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 11:35, Ayan Kumar Halder wrote:
> Hi Device Tree engineers,
> 
> 
> Recently I have ported Xen on Cortex-R52 (AArch32-V8R processor) for our 
> AMD platform.
> 
> I was discussing with xen-devel community about how we can properly 
> support smpboot when I was suggested that this might be the correct 
> forum for discussion.
> 
> Please refer 
> https://lists.xenproject.org/archives/html/xen-devel/2023-05/msg00224.html 
> and the follow-ups for context.
> 
> 
> The way smpboot works on our platform is as follows:-
> 
> 1. core0 writes to register (say regA) the address of the secondary core 
> initialization routine.
> 
> 2. core0 writes to another register (say regB) the value "0x1" to put 
> the secondary core in reset mode.
> 
> 3. core0 writes to regB the value "0x0" to pull the secondary core out 
> of reset mode.
> 
> regA, regB will differ for core1, core2, core3 and so on.
> 
> 
> Currently, I am trying to bringup core1 only.
> 
> 
> I am thinking to use "enable-method=spin-table" in the cpu node for 
> core1.  So that I can use "cpu-release-address" for regA.
> 
> For regB, I am thinking of introducing a new property 
> "amd-cpu-reset-addr" in the cpu node.

Propose a patch, that's how we discuss. Anyway as this is arm then you
have a machine for your platform right? The address is not fixed?

If the the regb is not a pen release-like, so you cannot use
secondary-boot-reg, then check how other machines are doing it.

Best regards,
Krzysztof

