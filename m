Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79773B51A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjFWKUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjFWKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:20:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02462D4A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:19:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f883420152so497295e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687515585; x=1690107585;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7T1/8qwRLUJOFJgmgWkh3qjUlbwxF0UTYDL3naXAKSE=;
        b=pgb2Ei2xtCNhsIGI4tXrFQjnDqiaXJU5/n0oeGSn26yvDnU9rr4r2gOyfMxIzjWbsT
         BfV+ydO89L2YxCqxONikhIakbGo3AfblNfX2x9DNb49SwVLKwqrdhxAJp4S1fxitrs3M
         QYN21QsCuF3FIskxzLVa72pATt0wioRp2uXxZsFub49fSVi5G89aCllT9kgdRb/xmPKO
         ZZnhf3Qkox+lBXOc29J7+2+gW1ajGltSZAzq0P3pdSJSBvuPHnzsjTyrKutq9VBPyRoK
         T/eKqOqnXESXOp+Ewz733G7SPKf2BCAZy8CMv+W+/60y6PY4Bxa6LkZN7i+Quh2KGtbg
         +NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515585; x=1690107585;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7T1/8qwRLUJOFJgmgWkh3qjUlbwxF0UTYDL3naXAKSE=;
        b=SBm/aMs7UNLyESaduLPewMMZghUoq4YZNccO6ov/V3z9G2MjGG/HFhfOyHci0sU5Uj
         B5u7FB4LFqdz7BtJhUhjj9lQEg+E5B3vYVMw0ezySgzgLv38oqQ6J7KJxU3X/9EUQYyU
         Yw7K3I6B5PnR3u/l3EF8HMam13KsTuQovzgP7LdqPeeHxK9sJo2yVCPqYqOaDvuCqRbE
         fctDtR13bPTacjfjIltR8kzjCU/8W6Uy5NP8+w1MBh/4CV/pJ/S7ViEOOV3yBHacVYDS
         G9vg+0Zd2mZVsbNDkoYlUmoyCVJlCeCklha5DAM0sJuKkwx86UQic4F1SMGAixnmotAL
         y8KQ==
X-Gm-Message-State: AC+VfDzoNz+k0pmYmdFQz/cMwJsx9jT/wfCYSBjpjndVs8t8vrucUTjU
        3w3CIgy+YedkjphcXQsOlV4ytw==
X-Google-Smtp-Source: ACHHUZ7wbU24D/YULWZfJBML/nWOcPnoboRPtX4OtPhvyyY7xnsAasPjPadNWyhO8e6i/IrnmC6rgA==
X-Received: by 2002:a19:e343:0:b0:4f5:bc19:68e8 with SMTP id c3-20020a19e343000000b004f5bc1968e8mr11951089lfk.54.1687515585133;
        Fri, 23 Jun 2023 03:19:45 -0700 (PDT)
Received: from [192.168.1.101] (abxh63.neoplus.adsl.tpnet.pl. [83.9.1.63])
        by smtp.gmail.com with ESMTPSA id y11-20020ac2446b000000b004f8792c5c75sm1396918lfl.24.2023.06.23.03.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:19:44 -0700 (PDT)
Message-ID: <d411cce3-aea5-8c88-179c-23506b18b41a@linaro.org>
Date:   Fri, 23 Jun 2023 12:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] IPQ8074 pcie/wcss fixes
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, mani@kernel.org,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230623094403.3978838-1-quic_srichara@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230623094403.3978838-1-quic_srichara@quicinc.com>
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

On 23.06.2023 11:43, Sricharan Ramabadhran wrote:
> These are required to have pcie/wcss working on IPQ8074 based
> boards. Pcie was broken recently, first patch fixes that and
> next 2 are for adding WCSS reset and 1 for adding reserved region
> for NSS.
> 
> Will be following this up with few more dts updates and pcie
> fixes.
I got this patch series twice, once without patch 4. This one should
have contained the word RESEND after PATCH and the reasoning for resending
should have been put into the cover letter.

Konrad
> 
> Sricharan Ramabadhran (4):
>   pcie: qcom: Fix the macro PARF_SLV_ADDR_SPACE_SIZE_2_3_3
>   dt-bindings: clock: qcom: Add reset for WCSSAON
>   clk: qcom: Add WCSSAON reset
>   dts: Reserve memory region for NSS and TZ
> 
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi        | 7 ++++++-
>  drivers/clk/qcom/gcc-ipq8074.c               | 1 +
>  drivers/pci/controller/dwc/pcie-qcom.c       | 2 +-
>  include/dt-bindings/clock/qcom,gcc-ipq8074.h | 1 +
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
