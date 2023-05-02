Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B7D6F4B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjEBUSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEBUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:17:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B082681
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:17:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so9066059a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683058659; x=1685650659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkGULLyqF8CC2Bp6dAKyvnTxkPczQ+NJ3Bki8TOIHmw=;
        b=EcF2SP95UU/BhrdQNCz/A2zrvTL2Tda6Lq1WpiPhMiUhlVa2laHS7RftgJifUWyWAt
         KOL+0CrXzcsAkxschr/TxSFNmgTspOUdrwoYogekNJt/8owN6UI4dvmkLBuACC57+fCe
         H3/xnvAqcjD/ftNvZpOpCKwn91SVve7sSNPORfrjJUjT6h3tLyCq7+VD1LxK6EOhbdzP
         EvapYtN49f7iSQDxH7jlfD/tLM8Pezx9Msu7QXB7PcdioxpIIiKFvHq0C0w6u3IRYllp
         ZTUsTIyAbGPqz9ArmklWlHP8hXHL5hwHAxDPmPHRQAG5uGCWEZ/JSGZGa0uuW7j5NNCJ
         Vl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058659; x=1685650659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkGULLyqF8CC2Bp6dAKyvnTxkPczQ+NJ3Bki8TOIHmw=;
        b=iLIiPIX0+UT3z7GKURuMymoeKTYd5+6D8QcCrMMV9QOGegzqD2KSIZMs4n953GP2jT
         pcd/qxhUytl8yWNFy+0N6rZyxbrfYgrBQ0G88QBcPikbvMvMV+XRV9jrubpRmuGYGnoI
         SfxBTdwgsZs+yOO1Nd13POEFdtyepgyw8gpP86bHzRqdtGuNU6NcIqOYScp3nhHoWWZU
         Rxb6LTZW+Qu1AcF8MzvnZSga82T6PRP7tuD6IToHGjO2U28z2Wk3Em5gGaVnu06bdx3q
         Rq6tXrusUw36OL/d8ChTMQIux9G1SKsAPSvmo6UEcm8ervUahpRjlzgB0TMDWYzg6dqf
         fQLQ==
X-Gm-Message-State: AC+VfDzK8U3Vuu8svPp5TEzGXBc1oX+c92ZJQBTMR92Eh34/DSguF1RJ
        RP6ewMeOAAk9Hf1+pWsIwmFjZKzYPnKr3rdCslG40Q==
X-Google-Smtp-Source: ACHHUZ7zGxsr0DvWKldqTBk/QCFwJTKsjmi/LPUolHgqBsjr3CFTWtkh536KoXTyH1F/P/6HHjoqoA==
X-Received: by 2002:a17:907:c28:b0:957:802:497d with SMTP id ga40-20020a1709070c2800b009570802497dmr1261507ejc.9.1683058659249;
        Tue, 02 May 2023 13:17:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:37be:eda5:e303:19e0? ([2a02:810d:15c0:828:37be:eda5:e303:19e0])
        by smtp.gmail.com with ESMTPSA id kw15-20020a170907770f00b0094f8ff0d899sm16154857ejc.45.2023.05.02.13.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:17:38 -0700 (PDT)
Message-ID: <f5431f96-0b3b-e2f8-2136-862ed529987c@linaro.org>
Date:   Tue, 2 May 2023 22:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: spi: zynqmp-qspi: Add power-domains and
 iommus properties
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
References: <87563d1a920458dff134bb92b27645471f4d9fca.1683035258.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87563d1a920458dff134bb92b27645471f4d9fca.1683035258.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 15:47, Michal Simek wrote:
> Describe optional power-domain property to fix dts_check warnings. The
> similar change was done by commit 0aec3958c88f ("dt-bindings: gpio: zynq:
> Add power-domains").
> And also by commit 84fa8f159022 ("dt-bindings: arm: coresight-tmc: Add
> 'iommu' property") for iommus property.

I am a bit pedantic, but you cannot use such arguments for this change.
Just because some other unrelated device (Coresight or GPIO controller)
has IOMMU does not mean your device has it as well. You know, some
device has reset-gpios, so shall you add it here?

The argument could be something around: The foo bar uses IOMMU and
belongs to a power domain.

Please re-phrase the commit msg.


Best regards,
Krzysztof

