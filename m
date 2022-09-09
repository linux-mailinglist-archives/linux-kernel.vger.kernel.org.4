Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318EC5B2F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiIIHOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiIIHOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:14:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE541DA46
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:14:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x14so1178344lfu.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4nbvtgapf/DbnFmqi93Nv0OlYIMtttn1cU2cr0YoWgA=;
        b=pZmjtcSBZ/2Ynrvacs3Oqiei4FzLWDJeSha22/DQU4noEPcMCqpy8CXFLfC/Ng2Cy8
         awj7MaL6B+YJZjrWN3If0VRa5E/HNwAu3E4qZMzvzCXyJSM8ZG14DPLxPQVqZPq/Uvwk
         Wol72ZRvRJ/f1ezLjWymXAIqMagEk6UbfjwN4NJeBi9wD/l9GhCVRuEOBKeJQQiIzedg
         bEdA786eyCAv/QUpvJM17ZNm4cq/lSbDGGs5untedAT7S9xDxSAEC7Sw5THCagVn75fx
         c82HXjpHSubUy6P9UME7nBv1PBaA2H4IEv4lVy4IabEn4NqCANeSyLfoJeMx0bep/GD6
         +9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4nbvtgapf/DbnFmqi93Nv0OlYIMtttn1cU2cr0YoWgA=;
        b=vMTOkwBGJw6LjOLo3YOANHedCpQ63k4Fw4zoBSndJO8wNiTwpl2tcS15QhOay9aEAx
         qm+9K9G2f9o0PFiYig6GxH5I7sWHJ86RN6pzhQA2z9kdRoovmPA/MgS9wzblJXhBx2y+
         U5vGiRJmlDAWN0FCoIC2g8eZtpHQRYB0gCUyEZTWuu4SR5hrvGEpJj//sN9AvVz9WhjP
         /sdxRbieUqpaP1dzU7lXfMbXwqSrLOQRK3wBpp4ywQcsgNWmL2O1HPOSpuO/289N8FmY
         6dq83+pwgUifmNt6xSgv/cvJ2rkRUUPx5u8z901jCvfzWI/L55CvJUI0FAD+gosG2y5Z
         RDuA==
X-Gm-Message-State: ACgBeo08/v501peT/iu0QFSlkuNb9CLvs/fGDtgTwDqFRAi6Bzg718bW
        9g2siPI8QXlmeuf+aJ+aTIG+Xw==
X-Google-Smtp-Source: AA6agR5SXJnle1aJY2acpppvmoi8PC0XcNOeUomBn3MgCIawLIpELv7rrrjZfDGElv6mDGyChsAc3w==
X-Received: by 2002:a05:6512:c0c:b0:48d:1e9d:aa14 with SMTP id z12-20020a0565120c0c00b0048d1e9daa14mr4180975lfu.322.1662707685119;
        Fri, 09 Sep 2022 00:14:45 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a2ea4a6000000b0026be23f24efsm170485ljm.18.2022.09.09.00.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:14:44 -0700 (PDT)
Message-ID: <9b009a58-5a2b-1276-49de-3c4f93b2f356@linaro.org>
Date:   Fri, 9 Sep 2022 09:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global
 clocks
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in
References: <2d4de63a-c536-669d-b90d-21f60bc6b6fb@linaro.org>
 <20220908230102.207682-1-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908230102.207682-1-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 01:01, Richard Acayan wrote:
>>> +        clock-names:
>>> +          items:
>>> +            - const: bi_tcxo
>>> +            - const: bi_tcxo_ao
>>> +            - const: sleep_clk
>>> +            - const: pcie_0_pipe_clk
>>> +            - const: pcie_1_pipe_clk
>>
>> Blank line here.
>>
>> With this:
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks for reviewing. While I'm at it, I might as well swap sdm670 and
> sdm845 if statements so they're at least in the same order as in the enum
> (I don't know what order to put them in).

Put them in alphabetical order.

Best regards,
Krzysztof
