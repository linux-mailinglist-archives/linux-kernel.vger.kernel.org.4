Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF66D41A5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjDCKPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjDCKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:15:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30306E85
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:14:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x3so115054595edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680516893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsukYsJ96WFhINrGZt8e0Hi8C2AMBaXqrSAuDDAO/Rg=;
        b=BY28xNWZdbIjPoGs5FyuM0H0/iQZ9xP5S3mvSXUOZsf7KoDznXc+EbRZUslHHE+gHg
         tYSvEpvc8BFMbUa16CtP6UZO8jZAPYe+rcGcFnNDE2K8qw/Fc8BTJKfTBxxbYOs0paEr
         gu30e2Abc1P1ocugd+Eh7hQWQCRmpjmyaupMEQLnRveZqaRuE/bA3dxigQYh4IyeuKed
         v5EEqJFgDkA756zSoD3ubqwPM0INDDiCmazJq1V4cYSKL0a+loTRLHujO4G2sn///wPi
         jRGnOE1N1xx9icgyGtqdvPJwszr3Y+boICrCQsLpSrT4ai/9HL09Z4jXORa6i+qFdKpl
         Gl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680516893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsukYsJ96WFhINrGZt8e0Hi8C2AMBaXqrSAuDDAO/Rg=;
        b=Rp5UBmF9alPZJwqK9Oh4VQ4jge9zezPVjlJh5HcTuQXu1y2I2xcVcekzDaiWiqKFhu
         tfEhJNmM9v2HveUVseykB3UgkmTv96r2Hz4qaFLsslPijcZ4UwFT2kTup50vzq07R9jz
         kf9+T3EwFxkINWLKttxOFn1vnNsJwjk21wNgh/ym/fO8BpzXP+MHzP1Xof2DFgQeiiLb
         gAohFVin6zt9k3Woe6JO6Nzt4NUlz1gJ7BChVOvQ+Zsr4lBH4Gk8850fHtRUAD18cr+h
         47L7QEhXhxU+n1tv+CaqEg8k3/d50Gb+dHKlOe61crUK0O/oEkNndYIkceOV9sdjJY2A
         TuKA==
X-Gm-Message-State: AAQBX9fmPblQYF1B8F3t/GrcmsJqBNjANqIIKRpK9Rvqr926b4uXGcKP
        b/3aBfmSrx5rRhfYimBaKacskg==
X-Google-Smtp-Source: AKy350bXEqO3rpHKXWUl2fdzn49JdhrIFS/nJ+i2jxJIMcKE7p3+277RQ8UUiCAsv2LnM5GKDBRi7Q==
X-Received: by 2002:a17:907:205b:b0:931:cac0:60ec with SMTP id pg27-20020a170907205b00b00931cac060ecmr33516704ejb.48.1680516893151;
        Mon, 03 Apr 2023 03:14:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id os3-20020a170906af6300b0093f3d41b9ebsm4306277ejb.220.2023.04.03.03.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:14:52 -0700 (PDT)
Message-ID: <0f757582-6bae-123c-7e21-ec8a6ac1447a@linaro.org>
Date:   Mon, 3 Apr 2023 12:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: linux-next: build failure after merge of the mediatek tree
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230403175220.5b946b60@canb.auug.org.au>
 <98a774d3-ade4-72a8-1c6a-3712d596682a@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <98a774d3-ade4-72a8-1c6a-3712d596682a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 10:43, AngeloGioacchino Del Regno wrote:
> Il 03/04/23 09:52, Stephen Rothwell ha scritto:
>> Hi all,
>>
>> After merging the mediatek tree, today's linux-next build (arm64
>> defconfig) failed like this:
>>
>> Error: arch/arm64/boot/dts/mediatek/mt6795.dtsi:647.21-22 syntax error
>> FATAL ERROR: Unable to parse input tree
>>
>> Maybe caused by commit
>>
>>    a7c7f1fe2fde ("arm64: dts: mediatek: mt6795: Add MMSYS node for multimedia clocks")
>>
>> but I don't know how.
>>
>> I have reverted that commit (and the following 2) for today.
>>
> 
> Matthias, this issue happens because you didn't apply 07/17 [1] from the
> 6795/xperia-m5 series...
> 
> [1]: 
> https://lore.kernel.org/all/20230327083647.22017-8-angelogioacchino.delregno@collabora.com/

Bindings are supposed to go via subsystem (driver) tree and only via ARM
SoC if the former is not interested in them.

I don't think the issue happens because Matthias did not apply binding
patch. Nothing in the cover letter or the patch mentioned such
dependency, so why he should pick up unrelated patch?

The submitter should clearly mark such dependencies or make patches
independent. It's nothing new, for clock/reset drivers (driver + binding
+ DTS) uncoupling the dependency is pretty often a requirement or
maintainers need to coordinate with cross-tree pulls (and DTS cannot get
pulled into the driver tree/branch).

> 
> That contains the mediatek,mt6795-gce.h header that has the definitions used in
> a7c7f1fe2fde ("arm64: dts: mediatek: mt6795: Add MMSYS node for multimedia clocks")
> ....and this is the reason of the syntax error.
> 
> Does this commit have to go through devicetree trees?

Bindings go via subsystem maintainer, so here rather mailbox. Not DT tree.

> I'm adding Krzysztof and Rob to the loop for this.

I guess now, the easiest would be if Matthias takes the binding change
with mailbox Ack. Assuming there are no conflicts there...


Best regards,
Krzysztof

