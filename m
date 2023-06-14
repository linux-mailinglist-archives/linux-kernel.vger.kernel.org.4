Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD69A72FEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbjFNMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjFNMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:43:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED5198
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:43:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f642a24568so8545808e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686746591; x=1689338591;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xr1V+LWyB4E+pek0N0wXhqnpk/YR1ub+Or3UrIkXcKI=;
        b=PGxMzcjVZYyTBmQOF9zIRR0zm+DlJgLIlP9J0TWHajoDvdi0hI0JmUEWi7thCwJVrC
         Q4K5+vhUdx49saBKXzfUrqGF8ujAsUAAie/VNrKdgtIrS6qga1jaM7Xyk6pDXUNT0yOf
         HyH7B8hmCLYmvRkxrA50SR6QS2dqi1fdvcHA02dMMnTBwJDyh2ynq5GZNfVaiRSAexN6
         NSa0h51Aa0Hpt07UiGJeQclXIC0AEaDio3FEzZlgbByyAccQneXReeXYU+l26moMhO7K
         uokJwOH9mKG66m08DRTtmqykJFWYkh9PncTjgWci07j8iDWqNjCH4ukigoJstCABVk3k
         5DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686746591; x=1689338591;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr1V+LWyB4E+pek0N0wXhqnpk/YR1ub+Or3UrIkXcKI=;
        b=FXzLzng1A/mM+sykWg436qGwS29HNt9u9nz0mkHt0fXsCMTrol9/R5MQzl5quk9121
         /G/k+LlRTCNyQzn3G8Wh28JF3mIhAf9Hj9MeHKsJ4OjFx2HDlzHtTcPcwMR7zFVn58JU
         lY1iyZlkRoTlR/dE8AW1bLc8lZSjqJIOVN+gXhbdgwUp+n5RSV3Gu+9zt6qy5+55Tv6E
         bYOiP72NwDOrlL+S/TEEFwGZGAyhzdXzgjwPPJeAt7IIosh2iMNPZAZhoTSzVKTB4TMW
         LYuPbZM8yRPmuDp9o5uDDCyi5Ed/RfdZqvr0XZR+GmtTitl7FFor2xKVV8GqqV9L4DBd
         AyyQ==
X-Gm-Message-State: AC+VfDzc8VAx5hwVOsub9JpaJQqEwMoMPKA9NgGnud/Abda5PHejq6o5
        nG2c+lgkaTo/0fi+10lH+y9EXA==
X-Google-Smtp-Source: ACHHUZ5S2yiBeIt59h0C1TIhl4JhTlqn2abkd9/fXxKTCTRgVVrD7qbazgxRVkXsPdlmcRQj8Y5GJw==
X-Received: by 2002:a2e:990d:0:b0:2af:bf0d:e1c8 with SMTP id v13-20020a2e990d000000b002afbf0de1c8mr6882838lji.12.1686746591578;
        Wed, 14 Jun 2023 05:43:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id h8-20020a2e3a08000000b002b200d9838bsm2480460lja.104.2023.06.14.05.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 05:43:11 -0700 (PDT)
Message-ID: <8d91dfc0-f6c0-813f-de9c-1befdd0ccfdf@linaro.org>
Date:   Wed, 14 Jun 2023 14:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8250-edo: Panel framebuffer is
 2.5k instead of 4k
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230606211418.587676-1-marijn.suijten@somainline.org>
 <974f68dc-b667-c9a7-94c4-1023ef271fab@linaro.org>
 <a69ddadd-8d59-e784-ddce-16c83a7f13a6@collabora.com>
 <kdu6apwgp7nu6mwqatufhxvnbunwodr4iu2uaqjacbjgbmmy5y@zh53imtpqfgs>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <kdu6apwgp7nu6mwqatufhxvnbunwodr4iu2uaqjacbjgbmmy5y@zh53imtpqfgs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.2023 14:40, Marijn Suijten wrote:
> On 2023-06-07 09:15:08, AngeloGioacchino Del Regno wrote:
>> Il 07/06/23 00:52, Konrad Dybcio ha scritto:
>>>
>>>
>>> On 6.06.2023 23:14, Marijn Suijten wrote:
>>>> The framebuffer configuration for edo pdx203, written in edo dtsi (which
>>>> is overwritten in pdx206 dts for its smaller panel) has to use a
>>>> 1096x2560 configuration as this is what the panel (and framebuffer area)
>>>> has been initialized to.  Downstream userspace also has access to (and
>>>> uses) this 2.5k mode by default, and only switches the panel to 4k when
>>>> requested.
>>>>
>>>> This is similar to commit be8de06dc397 ("arm64: dts: qcom:
>>>> sm8150-kumano: Panel framebuffer is 2.5k instead of 4k") which fixed the
>>>> same for the previous generation Sony platform.
>>>>
>>>> Fixes: 69cdb97ef652 ("arm64: dts: qcom: sm8250: Add support for SONY Xperia 1 II / 5 II (Edo platform)")
>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>> ---
>>> And so I derped again.
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> I would've liked more to see a commit saying "replace simple-framebuffer with xxxx"
>> (where xxxx is DSI panel, etc) but that will as well do for now... :-)
> 
> Fwiw we could keep it around as MDSS "gracefully" takes over when it
> probes a little bit later with fbcon over DRM/KMS, and it sometimes
> helps reading what is up when something fails before or during MDSS
> probe.
I believe we should do this. Perhaps even add some early code to drm/msm
that'd read out the address (and other configuration) from the mdp hw and
set it up automagically.

Konrad
> 
> - Marijn
> 
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>>>
>>> Konrad
>>>>
>>>> Changes since v2:
>>>> - Rename griffin (copy-paste from related patch) to pdx203 in comment.
>>>>
>>>>   arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 7 ++++---
>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
>>>> index 3d22be747f042..8f867f841cb83 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
>>>> @@ -54,9 +54,10 @@ chosen {
>>>>   		framebuffer: framebuffer@9c000000 {
>>>>   			compatible = "simple-framebuffer";
>>>>   			reg = <0 0x9c000000 0 0x2300000>;
>>>> -			width = <1644>;
>>>> -			height = <3840>;
>>>> -			stride = <(1644 * 4)>;
>>>> +			/* pdx203 BL initializes in 2.5k mode, not 4k */
>>>> +			width = <1096>;
>>>> +			height = <2560>;
>>>> +			stride = <(1096 * 4)>;
>>>>   			format = "a8r8g8b8";
>>>>   		};
>>>>   	};
>>
