Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D77747E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjGEH3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGEH3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:29:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9035A10C3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:29:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e285ac32eso170953a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 00:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688542172; x=1691134172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04KsCEQq3BTQ3Hv4slClhCupTLs++iE2IM0zdOeIRKk=;
        b=O7Q13QLtFiYubIqbr4dB4gWPNSwaF+mr4Cumj7k5dEPGuWLea/jl1B653FTWrAImMI
         2xnjRF4alacRxam3juvdPamAy/dVG4pEugr4Q1G3xJe4UUm2tHdaH8TQ3SRiX1UD4u7E
         9WQFZ3LtJjUo+k+93qgYCjQ8iUBct7fH3SDrHOdmNvmym/D5Hjh1EYkj3vSXMRlyi2GN
         maEw9cPy4pEGSOHj7lBFJ5maICU9aUgwJWDZzh53BR/RSNzgyG2TAHESLVYQBFvdVsKK
         HB3TPZLaIyvtwpwoRLdU3z0QO38fXG2pz2ujhNwfjUE5hyrnTg2j+VLl9SQQ7SPvmuq/
         bGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688542172; x=1691134172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04KsCEQq3BTQ3Hv4slClhCupTLs++iE2IM0zdOeIRKk=;
        b=lryNKIVlZxZf/t42Gwy7wwRuqDOwlr8hppwWZDb+4k7MREKS7tdmh8Lw6qHFYDrC+v
         sa6L4Th1E8zFy+/XpmWlyiyDUHn9FYv3xmLww8m6fZ6mWIlmosm1YETZGD3knMYJxx9q
         OQRToDSlOFS2qv+k6bBjJCqo7YHkHCygccgHZUoasoeDjX4TUH3iqr24pzb6xVFTRxko
         nS4xoC2pHsbqSdEsH2mMsYPWmtzKl6JrPTxk06bRLVVR3uAMpFqe32Y9GpESzrBFcJ3O
         onPiqO4LutV+9ymjeEOfsSj0DLGUKrBA/YZds6UbQeXztotksdqAc4OkHrDZKzkeuW8R
         H8lQ==
X-Gm-Message-State: ABy/qLYT+Gn18y8ZJB/ShvVjY9fQAt0bjesiGIjztAgHmDESJLfFkakQ
        e9XKqtY43q5/Cvc0QlAkeX4Ujg==
X-Google-Smtp-Source: APBJJlEt1mvtnReMBJcVFDryVN+XiJidc1ci2kcvMPZAKlMO7aNOrbX9FbwTnLjhGYQCJzEdo/yRiA==
X-Received: by 2002:a05:6402:b16:b0:51e:2664:e6e7 with SMTP id bm22-20020a0564020b1600b0051e2664e6e7mr900391edb.38.1688542172081;
        Wed, 05 Jul 2023 00:29:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g19-20020a50ee13000000b0051df5bd1cd8sm6189542eds.65.2023.07.05.00.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 00:29:31 -0700 (PDT)
Message-ID: <4fa4e983-03af-7222-3ffc-96ebe703a4f8@linaro.org>
Date:   Wed, 5 Jul 2023 09:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: fsl,imx8-acm: Add audio clock
 mux support
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1688521839-3036-1-git-send-email-shengjiu.wang@nxp.com>
 <1688521839-3036-2-git-send-email-shengjiu.wang@nxp.com>
 <41ee8c5c-7a6f-04b2-9853-67fb6bdb67b3@linaro.org>
 <CAA+D8ANEsQzXEDjz3+SgKbCWz+cqUHbtLVD6fkd2spbNb5uvgw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA+D8ANEsQzXEDjz3+SgKbCWz+cqUHbtLVD6fkd2spbNb5uvgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 08:45, Shengjiu Wang wrote:
>> Drop description, it's redundant. I did not ask to add it.
>>
>> Anyway, my comment is unanswered. Don't ignore the emails you receive.
>>
> Can someone provide rationale for this?
>>
> 
> The Audio clock mux is binded with all the audio IP and audio clocks in the
> subsystem
> so need to list the power domain of related clocks and IPs. Each clock and
> IPs has
> a power domain, so there are so many power domains.

OK, Reference Manual does not mention them but I see your SCU PD driver
actually registers such power domains.

Best regards,
Krzysztof

