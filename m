Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAEA729DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbjFIPCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbjFIPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:02:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5206B1FEB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:02:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso2867532a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322924; x=1688914924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IaYLdbl/TZHSk2cPY368IzUkxBaN/snAx/dMMgmk2Rg=;
        b=vzheymtmwpwZIbuSILAc2zsNTPEl5DYzgBmnh/ZVozn/aeDp6tpVRPOeaMjulkEeB6
         fnf2eO+/mmhFl2JkN9AWPEYwupg38t8+UPt5/Y8ipIPti07srn5O+uXQSYz+aD6KUdy3
         FRn6ZH+QRsqaynb2l7GGly/98z9QL296yJ+QijHC7gTHx87Znxt6M4eOHfHPzmxeD5uW
         gsVOvh8/xP5TBUHSPjNxY3EDfP+On/RLhyw/7z4SJlBuppcF7ZiW7a0zRxifNUYKsfVv
         s8sr1SiAV9c/1IHFh6s3ROjRyVDN8ecwQoyQdjSJCM7CxK0aiM1madm2mrAjRJerDxqb
         tT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322924; x=1688914924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaYLdbl/TZHSk2cPY368IzUkxBaN/snAx/dMMgmk2Rg=;
        b=WN19fNF71VdVAVwAmMUv6zfXZ4ot/zELTOI3p9d9xIRHzv4a1BpLEvd2SWgjXGqcIO
         +0HThX/h7eqr16PKTRdbzMADyExEdINOFyFTAxdGsyWFIG5ZuoZOnpfRM0jq2hQ1rwVG
         ugRgdAqc2QoGHrOJTDrium/nIC+W5n9aNVmi4Q32H+lY7Q79jJg1P8P3wgd1kxM9tK7o
         QLXUcpLuiii/Gjk9/zldLZUvYV/MqquGHwWxsSnpw86YIfK+XXEK4dFMczw4L+7PGVq5
         ROfmu/y8ako7598jkdev/43HUvAV6sugsIepe18i8fW6uvLN1SDhAnzeUjW6ArCke/K+
         ULEg==
X-Gm-Message-State: AC+VfDzino6pahFUpFqOTAxD+pwidTRvyyp0p4NdyV8BOxEG21QjCtBb
        z/sK/p9YlUcJ0dTvvusaSrX/8g==
X-Google-Smtp-Source: ACHHUZ5okxNKnU1pVg+ODHtWvUPjavwqyyL9RFD4S7ut04uQTkmZ0QlpMnrEvvhAED9oZdn7xjGCSg==
X-Received: by 2002:a17:907:3f82:b0:97a:e496:c121 with SMTP id hr2-20020a1709073f8200b0097ae496c121mr1262183ejc.69.1686322923812;
        Fri, 09 Jun 2023 08:02:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709063c1500b00978937e9dcdsm1382300ejg.42.2023.06.09.08.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:02:03 -0700 (PDT)
Message-ID: <51ca8020-f1f1-f0cc-7e2c-f3c6ef675484@linaro.org>
Date:   Fri, 9 Jun 2023 17:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] dt-bindings: riscv: cpus: drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230609140706.64623-1-krzysztof.kozlowski@linaro.org>
 <CAL_Jsq+5oZdHi6B-R1YUEwSOc8x8Vd9sHt1bgp5ydM_hAQJE3w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_Jsq+5oZdHi6B-R1YUEwSOc8x8Vd9sHt1bgp5ydM_hAQJE3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 16:34, Rob Herring wrote:
> On Fri, Jun 9, 2023 at 8:07 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
>> checking for this can be enabled in yamllint.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Note that I already have the whole tree done. Just not all split up.
> 
> Acked-by: Rob Herring <robh@kernel.org>

This was on latest next, so I assumed all your patches are already there
and few of them are missing.

Best regards,
Krzysztof

