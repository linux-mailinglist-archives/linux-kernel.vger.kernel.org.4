Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C7E6D1B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjCaJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCaJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:04:52 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE8A46A1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:04:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e9so7048471ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680253486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQhDEd07VyHSzl19bZH9QcfJtJJihI3OzZM5CRpJxGE=;
        b=W3cCu/uvty579Wn1PqSgOHwkvhg2UOoubwiwEbu9KVTF0A8L2mCNLJw2x67vIW2h8w
         vtUZuJg8334jrUSSko0UKVSwsELwRCrP6QadxlW1oZ47y5NbTEJOM4w0HJS4zvcLDuJQ
         lKbn5Y/k4/2RmVo6P+t5AC63ncNRhJTEe4jKDNW8gEqhd4k2XRjdzpWhXW/jqWp38HVp
         H/qkkFDw/Meb4kOhqwHg3ZfoUCvt2rPhWP+CoeDgxSQgNt7WBXfa72U4KpG3ckbMwdO2
         2l/evIYJ1ZRSrsjVgvoQVDbIhrKUgELrhCmMsYnEza67aBZ6ZTiPuDT/WEZsEsMtbqv4
         l52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQhDEd07VyHSzl19bZH9QcfJtJJihI3OzZM5CRpJxGE=;
        b=7luvYag3RgLdlStGxRHA6aLKCiLjhwic+hM+qzZYTpd0Z4wn1RU6dBNcEEUHTKQ8ej
         eMQ2JeLV3wYO2uie93kaP7dB6Rbbup0zxIzh/D1frnHGqskYxyxmiUuygX9onhngorUq
         SYdqmL3tC2Oxhby6zj323wsGITmCALrmhR62SxEQ7nTF+dWp0T0/iB+orRbLPnJjB3ro
         tu23mVKpH6cIWMwzGicaxEG/iew7J/7rDvjOhiniVquoVrpYPPfHWM7r3Oi8za2eKYEa
         MbVxgIE0IZcI5cBesNOgH4NI9pQGkMDLffHI11ZyWPlWp6f6d2T0OMfA2Bkda6Adspkc
         iJqw==
X-Gm-Message-State: AAQBX9dLbsnQKRVOl5ZGcyz0dH2F87+1v7F60HE/sKsGaSGpXE9wQLp5
        c7yu/YOutcNFuNxdCyX89hphTiIZ20xUzJFErVc=
X-Google-Smtp-Source: AKy350YHCWagYx9SzYMk3qxiWv08aaIBLTiS3ytiW2dINux7zaRC6mONVhhI8ICibBKTrCLtKzkxCA==
X-Received: by 2002:a2e:83d5:0:b0:299:6e0e:3a2a with SMTP id s21-20020a2e83d5000000b002996e0e3a2amr8357651ljh.49.1680253486330;
        Fri, 31 Mar 2023 02:04:46 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b1-20020a2e9881000000b002a5ffe1ed37sm275991ljj.48.2023.03.31.02.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:04:45 -0700 (PDT)
Message-ID: <0c40e240-2d5f-a2a8-cf32-0a15f05df0fc@linaro.org>
Date:   Fri, 31 Mar 2023 11:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/4] dts: arm64: qcom: sdm845-oneplus: enable SLPI
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230330165322.118279-1-me@dylanvanassche.be>
 <20230330165322.118279-4-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330165322.118279-4-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 18:53, Dylan Van Assche wrote:
> Enable the SLPI DSP on the Oneplus 6 phone with a Qualcomm SDM845 SoC.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 5 ++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

