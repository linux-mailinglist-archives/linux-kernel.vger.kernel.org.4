Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723336E3686
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjDPJQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjDPJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:16:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0362129
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:16:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50489b16e6aso5092352a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681636562; x=1684228562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQXACcFQhYMTTapf4fYrBnZy/KtxmeAb2/9BYxrU0Bg=;
        b=zNVG1f9czlGFT2SrHPjlDHaK/IzZU5sRnN6vfXw910do/0PVh3Q63Xz4Tu0c4YGdCJ
         xsb25VuOJ0vbBbKzz9pRkJihJBP0lHOXMOfxMo5I5RR+FCqSza26PAd/GEQolLGI3Pq3
         soeylxBcHmUU3jBz97j4mlyv/KOg6CuzWCdRt/nvE8SD+5CIzkpBKkCIEvDlxB3GOwg9
         kVFY0cZeF53ZSvuuXGvNkD3lTxC5opgjEckn5pjmj5Hatr3Msvj1agnlnpI3ZDFBSJ/o
         gzEyR56X7nXkIaD/tp1V/0xbFO7icJt+nGd8kqH9P1jqlnKAuaWeear9z+EcEaF32MhV
         9BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681636562; x=1684228562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQXACcFQhYMTTapf4fYrBnZy/KtxmeAb2/9BYxrU0Bg=;
        b=LDV5AJ85uU1Lj80fiG/FB1dXtcsy+6u3bB4753bQPJebIeFlG3tgtPIA2Av6Tezomv
         e+bpL9GsNVl2OXu5hhYVnhzV3J3Mx1+Z13PP5cpYqI67IH4XlmsEQQRkuKEFMgQ7oSEF
         4skApH/go6ijaWbQ0BwJe4GEKGTRo/GiceA8eZwT3NjkG0dm6dvOnqeGEkhY62q6Elmm
         W9CQ7bWN1d+CV8lrUx4b00mxa2LNjt0nDxNvnjRAIdav9IHhJJ5CHArA4Y+YnO9QbGSb
         /dMLVRxL0ElNSeaUTAiabPuQj8mqWWJVvU9rzP/iDnsdRs3ZQnqO9AaVZETp0gSs+S/O
         VxxQ==
X-Gm-Message-State: AAQBX9fcs7ahjbkWhBezgt1UlYrqZTOemCyZ3b8TjAkc0K1TGPH/umVA
        fqj10p2Z/5jVzv5ktu89Jq0ZCA==
X-Google-Smtp-Source: AKy350b8zNnrbYNWqzu2ymag2e1aIn96EHCycoVEwyxSuWpG9Q+Xeq/H1EjdtDt+sJ6qVBeCc9rslw==
X-Received: by 2002:a05:6402:10d2:b0:4fd:20e5:4142 with SMTP id p18-20020a05640210d200b004fd20e54142mr10405208edu.21.1681636562398;
        Sun, 16 Apr 2023 02:16:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id ay18-20020a056402203200b0050504648fc4sm4319723edb.80.2023.04.16.02.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:16:02 -0700 (PDT)
Message-ID: <2df035b4-edf6-b5c3-55a4-17fca6ea7f85@linaro.org>
Date:   Sun, 16 Apr 2023 11:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 8/9] arm64: dts: Add ipq5018 SoC and rdp432-c2 board
 support
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-9-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681468167-11689-9-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
> Add initial device tree support for the Qualcomm IPQ5018 SoC and
> rdp432-c2 board.
> 
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Fixed all review comments and DTS schema warnings
> 
>  arch/arm64/boot/dts/qcom/Makefile              |   1 +

You have some failures to fix. Difficult to say how much because your
patchset breaks other bindings, so validation aborted. For sure your
cache misses properties:

ipq5018-rdp432-c2.dtb: l2-cache: 'cache-unified' is a required property

Be sure that your DTS is clean and comes with no new warnings. If you
need help with them, get in touch. If your DTS is correct, but errors
come from other schema, try my pending branch:
https://github.com/krzk/linux/commits/pending/dt-bindings-qcom-new-and-fixes-for-warnings-linux-next

Best regards,
Krzysztof

