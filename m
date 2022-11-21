Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764A5631DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKUKPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiKUKPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:15:50 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF9A13FAC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:15:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j4so18157673lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlPX0/HkEahkqIbJpSO1lxKpCnTdlVDg79RU4xh3Zhs=;
        b=yN/TuefqholGNYZIcqM90cxRsVaSZwKSYlRk8IBdp8d9OFPPB1atBR6DWEeDoWMUt5
         QpMn8AR5L2w06TUvFXbtlR820yvzLIBqJl4fPbPEv2mIe+LL522gbsqwKVPpnPZUymDJ
         9Hf4Ag1WtcgU+jaYtnO++HNyyNAJWeltz8aSNkXzPpYKtdaVSRdOcrfJf507/OjhrIY4
         zzOrIm57EgCNPlsGgOH5FzNTi0LTHUAb9wg+6qPPpviIxcsKL+lx9QhDEMJhPu5jRYY0
         YKV6FwYom1Wf0ZvS9rfsF8fPsDfhWpbAlT2/dBsQbI8LGkYIR4MIblP+MOalOcxFAX4i
         Rg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlPX0/HkEahkqIbJpSO1lxKpCnTdlVDg79RU4xh3Zhs=;
        b=wXjP1HaZYb/0vVQfhe9dXUV0FO2kcSNcH18sC45xyj4uhmJnpwT/um+5iPQ08HVf//
         Es6XntSZHCIVbrlUGiyTQW3GNw5fRsFAORvEE6cxRr0H6kDwrZW7qLDlDtAtR2sZ+UPU
         oajA5AmLARuDZA5ucddZpoGKtu+D+6VjY55KQ1E8SO5EmuP/dveSeX4S/FExtAKipRwl
         9SQ0IoJQHyogbM8gLbdGZZ81HRabYEAl7enBYoIW3m3DWfDWaWc/JWccatzpszcIqc08
         MDFlK2FrPGZsdk3vwm1VbS03BI3nMw501W8nw/8W6QG4SUX/vWHqueAZYzhXTH3oMeCs
         qkgA==
X-Gm-Message-State: ANoB5pm8cMC2tKj2O2L6z2pNiSwUBe3QyYfuFTk+o4BfRs42xOLmkH+p
        hFAV2O2ecSpH6qsTe0clbrOJnA==
X-Google-Smtp-Source: AA0mqf7q4Mb4IsKU4YpMv6ICs3I2hcyf1CVMfJHzV4QGvdtvFOb1j28NxRkfCSFEG+vRNXx1HVfr3g==
X-Received: by 2002:a05:6512:2520:b0:4a2:6907:98d8 with SMTP id be32-20020a056512252000b004a2690798d8mr2261994lfb.28.1669025748240;
        Mon, 21 Nov 2022 02:15:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p8-20020a19f008000000b004ac980a1ba1sm1959456lfc.24.2022.11.21.02.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:15:47 -0800 (PST)
Message-ID: <0c303534-190a-7480-f1bf-fa0b9a1d4dba@linaro.org>
Date:   Mon, 21 Nov 2022 11:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org
References: <20221121043437.21925-1-quic_rjendra@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121043437.21925-1-quic_rjendra@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 05:34, Rajendra Nayak wrote:
> Add compatibles for the Pro SKU of the sc7280 CRD boards
> which come with a Pro variant of the qcard.
> The Pro qcard variant has smps9 from pm8350c ganged up with
> smps7 and smps8.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

