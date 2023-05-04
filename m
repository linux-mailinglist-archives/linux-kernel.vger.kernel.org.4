Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6586F6A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjEDLim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjEDLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:38:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ACB3C02
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 04:38:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso655764a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683200314; x=1685792314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imbx8O8Gq9FYrhBxDjjR/qtxtv1DX5RXevVj+xCkGJw=;
        b=k0NemQmFEaMKUWgoORo2gazI+immTvZ0B7/FXbbd3wtPs9COjiro9YDu/Nnbugo/B3
         gKym0+PIufKCKkM4r1D6D8jBPZjuzVdnqt/LVva6JLS9Xit0sKZ0KroqSTOGPMdCKY3w
         UhLLyPSReii+JnerksBDQrC4QnL14gGzVYsdENavPL0GhJ6kbhjMbEZpV1F9//Pb9ecn
         EOzzrXl8zV91n+VwFudGfpMKVlzDC1KI677xYCRs5mr8NyBzsqSwanpd8bFjCMRLMJdp
         KtAaYqzAM3Sh/6f1fb2yrbfMKvwJv+gDDhiKEu4bvHVZxVu753xWmbYOIXvdl8Pn91w6
         93Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683200314; x=1685792314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imbx8O8Gq9FYrhBxDjjR/qtxtv1DX5RXevVj+xCkGJw=;
        b=Dyj219j1VP+7SKTEBy8ioMrOWrzMluEiaNqZsdCmFQV58La+nLxscLip+s/RrBLA3r
         LMvOpZqkx3LIZ2sE/3fDtyruyb0VnbgzIt4tws5dQSPKdB+vHRFCinyKn+6FTyzTx1ty
         A8Ei2+HH57KEFdpMFIY4kL49+lgYNvY52tS5jEGy7s7oY3KaGpdsN6ga5drMW3Bt+wvP
         oJI3ESM+s5/pUWW9Tn4PYlZTULzl7OHkmMiJE0t2wIpwyqeyNG+A20bT11dXFv94qvqf
         alnVN4d2E0pNXaXqIBbYnDewmcU0EAJxXZeE9OEwZiMpxjdhvy4hMll9DkOxBlxiUb79
         S67w==
X-Gm-Message-State: AC+VfDxUktJ9WIKKWO1Q0wRTPH9mborTSHukkgzHuOSukQZQSa+/mLU4
        41RamgE7ERKy7BnlxyWnL2GqNQ==
X-Google-Smtp-Source: ACHHUZ6ZV4iawvy0J4tl2R5el/BhLbNnmTQJijy3JUhoxCdGSZobigQtHDZM3ZcPP8R0sy0fqOhxew==
X-Received: by 2002:aa7:d9d6:0:b0:4fd:c5e:79b8 with SMTP id v22-20020aa7d9d6000000b004fd0c5e79b8mr1308460eds.32.1683200314645;
        Thu, 04 May 2023 04:38:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fc0f000000b0050bd19ec39bsm1760459edr.83.2023.05.04.04.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 04:38:34 -0700 (PDT)
Message-ID: <fe94ed5c-c444-436d-720a-c96538c1026d@linaro.org>
Date:   Thu, 4 May 2023 13:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 02/18] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-3-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1683133352-10046-3-git-send-email-quic_mojha@quicinc.com>
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

On 03/05/2023 19:02, Mukesh Ojha wrote:
> Move minidump specific data types and macros to a separate internal
> header(qcom_minidump.h) so that it can be shared among different
> Qualcomm drivers.

No, this is not internal header. You moved it to global header.

There is no reason driver internals should be exposed to other unrelated
subsystems.

> 
> There is no change in functional behavior after this.

It is. You made all these internal symbols available to others.

> 

This comes without justification why other drivers needs to access
private and internal data. It does not look correct design. NAK.

Best regards,
Krzysztof

