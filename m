Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7473F44D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF0GOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjF0GN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:13:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2831FC7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:13:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso11519805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687846435; x=1690438435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfwpHbbsGCKJMLfgMJV+HTBNlG4lMxS4KT5GYcIwgWs=;
        b=Cxdr9MjnhD1y1tv8kdfCCAoMYPwwgY5GRYKaZEqGT4GJaMZxYENg1sFqosTDfhfr0w
         GbbxDgQ+SBRVC9l/lx7HMh4gXokQIKMsn05xJBsK9yWZHzLHavYwYs29yaB7pY3AvjtK
         889XEItirMacODDaVk5FoFi0R6R6WRrYAvAWxbG7JJ8+mLXKIH78BLXAllE51iAllpCW
         cPUdjw8eL144xNVQKiO5DP/WACSQOMznscsPRJmf1KJkeEnIQz5FpIIggyE/qtzJS23M
         S1sHeYIE+zTPsesPD7wl/lGwsnJVmTthCpYXIxKLMXVgdmfyFHZ6DE0mhBu+aYrNzC2r
         +IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687846435; x=1690438435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfwpHbbsGCKJMLfgMJV+HTBNlG4lMxS4KT5GYcIwgWs=;
        b=FWGdtBUfMNicISmdHR5SbKWariaNoF/BNumJ1UA1V/ocWXLsPNOcrjUu6Uet0O6KFY
         4b692DOV1QizSn9oCM/4ejC22WU7mJPvq6NgCmN3LxJQ6cPTKF4jQKHWCCLX+VNXtU7X
         QACHJnPdFqwuE2VBUw24FAm1vWDYvTb+tScCjQPRCXenuZX04ZKbwAk9mBRbM4o/wzSg
         wTeFwVnqU2i8Xa8OdeGEAYLRJVqVXHijd7Z+b5ADZE55h5xe47WzLEZ6hLkD6i+URfsE
         C6cHUVmSYLJJ+N64Gt7EjZc/84BdswvHx9e9bQyHwWlWkCNg6pomcx9GpRomvrYQgOUk
         j49Q==
X-Gm-Message-State: AC+VfDyUPvsxHaaj1ogKz07TSwZ2PI/mG70wNv8cK6ILIrxsDClNe5g3
        W7+tGYJCpoXrUTVhqN0+Fj7KWg==
X-Google-Smtp-Source: ACHHUZ4VrZ3ppTufd3kRre67uS4/bLfAKihSZysTXpHw/VwowyjL5lnfxd4qusi+NuogkMTgLgY0xw==
X-Received: by 2002:a05:600c:3644:b0:3fb:a2b6:8dfd with SMTP id y4-20020a05600c364400b003fba2b68dfdmr751079wmq.32.1687846434949;
        Mon, 26 Jun 2023 23:13:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s7-20020adfeb07000000b0030ae901bc54sm9284680wrn.62.2023.06.26.23.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 23:13:54 -0700 (PDT)
Message-ID: <a5731e43-4e9d-2571-9156-c1f97696df8c@linaro.org>
Date:   Tue, 27 Jun 2023 08:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 3/3] dt-bindings: serial: fsl-lpuart: correct
 imx93-lpuart dt-binding item
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        shenwei.wang@nxp.com, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20230627025332.11133-1-sherry.sun@nxp.com>
 <20230627025332.11133-4-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627025332.11133-4-sherry.sun@nxp.com>
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

On 27/06/2023 04:53, Sherry Sun wrote:
> Correct the fsl,imx93-lpuart dt-binding item, imx93/imx8ulp add some new
> features based on imx7ulp lpuart, so need to add "fsl,imx8ulp-lpuart"
> for imx93 to enable those new features.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

