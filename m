Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4A6F5C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjECQbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjECQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:31:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781E72AA
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:31:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9536df4b907so1094076166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683131459; x=1685723459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXJgfLVVj1pALvWUNLrKJS1/xJYeKNsh9YVn+qFWuk8=;
        b=E5YFDGy+IpKtyMz50/OBcRAizD3X+twgJ6+5BP9IEIL+hCf/pS/XQ5gm+/wtvosAKZ
         zJzJ8JUTByQe5vfvCuIhLyKtzMCGkVAgiawDeTzpsIKm0eVF1gwYVfVp6O9Ftg/AYVGO
         qgXmRLxMAeRvhBl+RmSPQqsMcuJFZ2xpjnrXA+jf+1VBQ72bWJHHAmyzJMGnPN+ZrEfN
         thmt42dAe6bgr2WjZK2+IjyX+/m43C3wQRzgeTyaO1w7RHPF3yoBeUBS3kY+kSduwIPc
         c/OxBf+OGhzHA4VnfSDoFnjWB2qcIPhfAip1YdOe77DVcIVFmRPgREyNs9eGq15WBGYF
         8O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131459; x=1685723459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXJgfLVVj1pALvWUNLrKJS1/xJYeKNsh9YVn+qFWuk8=;
        b=A5GgThOYsOHBL+pFfOfXQFgPqtZLgE76gPF8pF+NQwUhi9RVgaD6fGH2lFWiGKwpcf
         jwSoCBK5FubchGwkTSA+hH75ufmMLFNUNm8fOi781t1HiHq/2Mj5plBVPw/Pf0/Fh+Mo
         cLj3PgJc9HjixgfYNITJ/cSblj+ojaGRphEjyYBD9xV69lpR+PVGKT6S7wt6NyxRD0Lx
         IdFUoe3RpX0JNgbbrAXX60fsgwE8+8S873v+yf3u6Ol+SqN3RA/H0W/z5WlXtXAG3PNk
         9yHChYzKmTNHgPuVGpAs+y/IZtlKrIRBuLD0bFH7WD+3KDQB4JmD2CVBuHfoQT0r+JY5
         yJVA==
X-Gm-Message-State: AC+VfDyzThBjn1sBxTqbj55NSO2drbgtcbf4EI1UOXx94v7umtm4Ge0N
        IS30nqZE5p7SpNoSmDwObnJYsQ==
X-Google-Smtp-Source: ACHHUZ4jl6h1T4GpwW8ro5hRFKZ21S+ZFKnEJkGNAO51qnShKHP4eHiC1vV2YNWypxDnAmMzYtDVeA==
X-Received: by 2002:a17:907:a40b:b0:94e:5708:1564 with SMTP id sg11-20020a170907a40b00b0094e57081564mr3560157ejc.22.1683131459316;
        Wed, 03 May 2023 09:30:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:db42:e3d0:c55a:8cf1? ([2a02:810d:15c0:828:db42:e3d0:c55a:8cf1])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709061e4f00b0094f3d700868sm17515205ejj.80.2023.05.03.09.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 09:30:57 -0700 (PDT)
Message-ID: <5a48749d-61ca-8ade-9fe5-f0d68031f889@linaro.org>
Date:   Wed, 3 May 2023 18:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/1] arm64: dts: ti: k3-j721s2: Add reserved status in
 msmc
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>
Cc:     vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, afd@ti.com, u-boot@lists.denx.de,
        n-francis@ti.com
References: <20230503144706.1265672-1-u-kumar1@ti.com>
 <20230503144706.1265672-2-u-kumar1@ti.com>
 <20230503145107.e447yxvn5e6fmz4g@patronize>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230503145107.e447yxvn5e6fmz4g@patronize>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 16:51, Nishanth Menon wrote:
> On 20:17-20230503, Udit Kumar wrote:
>> Mark atf, l3-cache and tifs node as reserved.
> 
> why? (I am not reading the cover-letter for a 1 patch)

And you should not have to. :) The commit msg should explain why it is
useful.

Best regards,
Krzysztof

