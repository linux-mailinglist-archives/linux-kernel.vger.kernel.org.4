Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FFE73E33B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjFZP0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFZP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:26:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35581191
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:26:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3113dabc549so5054438f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687793170; x=1690385170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tw7C9oT93L7YXZBRkdfMrjtsff4cNqwiulutKWQ+2bQ=;
        b=Q0llsL7nMjYyRXTFnc4KHHs37dL5UZzylqD2tSdpr2izHti3uC/DvUggBruaxbLKRq
         jsAa4XfX40TBxFaqZ4MmofhupUyQIAK5p0F13TJ/rpF3UsQ0zVaNu2klNdcZrR76KKUy
         f/l+70dW/Hu3ngSz4rVsUD1/y/1IKkZsAGnOpJcYE2IzNCSflSsZDxrk+XlUzDLtXd/X
         09Yewg7ijV4zXIno4ba7y2681VXuIzu7Xl7DZklAsmh6g8lMu3k3x/NGK5G7DhfUzqBJ
         3/6kE9mqnZAMZFe5UX7ICYyR4VE+6F6+1udRx6CcnJ2+ZmIsjz3ZoUO5vGZyoEZsnnx5
         BViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793170; x=1690385170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tw7C9oT93L7YXZBRkdfMrjtsff4cNqwiulutKWQ+2bQ=;
        b=WVcGWCbVn3y9wtMtoLybhg41krOkpfIAKFXeURH3oFM+sp1lEnICb4TlwR0BFTGT5e
         oc9/Se6Pwp4mRciRZwHvLEzSz/dvLxs2L2vLbV7K7/bOb5Tkr9DtSzb8q4Y3sC8Q4ZCQ
         rUX/U9vmiLaDNaWeoX0Z7xhlONrsWdKIMJius0OPBSjelotB2yCSQvH/neiHy1Gqxu9A
         JzFWKQoBB0YbYLukT5wDvlB/VIzE/F+QbYASyFfKTife4+EC6sDpqb621NcMP+TDDOS+
         2nfStFTB+XRW/NQGzPj0uxAktbB01Ud062XxnLj5eDY0xRMCwVIeTT4lQTZXYn2vUuJm
         OOtg==
X-Gm-Message-State: AC+VfDxEvapSo3yVcAQKyqgtNnHhnDvtRn6IUC3ubwTLg+MBY8UPbloJ
        oeWBAn07PfLll7LrJlZ/OSIKkw==
X-Google-Smtp-Source: ACHHUZ7ubpwYvu7BiTPrQiruSbiDo19so9jcb0VpAKJaifwruU8APvyge2msFRwCDdPj5kwb46Y6Bg==
X-Received: by 2002:adf:f389:0:b0:313:f551:b037 with SMTP id m9-20020adff389000000b00313f551b037mr2426683wro.68.1687793170609;
        Mon, 26 Jun 2023 08:26:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id cw8-20020a056000090800b00311d8c2561bsm7645463wrb.60.2023.06.26.08.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:26:10 -0700 (PDT)
Message-ID: <f0f9d4d5-4603-7f62-ea18-ea7e120200c3@linaro.org>
Date:   Mon, 26 Jun 2023 17:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND v6 6/8] arm64: dts: qcom: sc7280: Modify VA/RX/TX macro
 clock nodes for audioreach solution
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        andersson@kernel.org, broonie@kernel.org, agross@kernel.org
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, judyhsiao@chromium.org,
        quic_visr@quicinc.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20230616103534.4031331-1-quic_mohs@quicinc.com>
 <20230616103534.4031331-7-quic_mohs@quicinc.com>
 <7d2e580e-1861-d22f-e67d-726a2a69043e@linaro.org>
 <3441b3cb-29dd-691c-1e95-5bddd66c684a@quicinc.com>
 <af148e01-4026-a086-af78-a1e252fcc724@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <af148e01-4026-a086-af78-a1e252fcc724@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 14:24, Konrad Dybcio wrote:
> On 26.06.2023 13:13, Mohammad Rafi Shaik wrote:
>>
>> On 6/16/2023 4:59 PM, Konrad Dybcio wrote:
>>> On 16.06.2023 12:35, Mohammad Rafi Shaik wrote:
>>>> From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>>
>>>> Modify VA, RX and TX macro and lpass_tlmm clock properties and
>>>> enable them. For audioreach solution mclk, npl and fsgen clocks
>>>> are enabled through the q6prm clock driver.
>>>>
>>>> Delete the power domain properties from VA, RX and TX macro,
>>>> for audioreach solution the macro, dcodec power domains enabled
>>>> through the q6prm clock driver.
>>>>
>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>>>> ---
>>> Maybe sc7280-audioreach.dtsi containing all these changes that could be
>>> reused by others would be in order?
>> Thanks for comment,
>>
>> yes, will create a common sc7280-audioreach.dtsi file, which will contain common audioreach changes
>> and could be reused by others.
>>>>   .../sc7280-herobrine-audioreach-wcd9385.dtsi  | 43 +++++++++++++++++++
>>>>   1 file changed, 43 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>>>> index 9daea1b25656..c02ca393378f 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>>>> @@ -196,3 +196,46 @@ q6prmcc: clock-controller {
>>>>           };
>>>>       };
>>>>   };
>>>> +
>>>> +&lpass_rx_macro {
>>>> +    /delete-property/ power-domains;
>>>> +    /delete-property/ power-domain-names;
>>> Surely they shouldn't cause issues, even if the vote would be
>>> superfluous? They are still powered by these power domains, I'd assume?
>> No, In Audioreach case this macro and decodec clocks are not power by power domains,
>> this macro and decodec hw clocks are enrolled by q6prmcc clock voting.
> So the same piece of hardware is modeled differently twice?
> 
> i.e. the same GDSCs are reached once with register accesses and once
> registered as "Q6 vote clocks"?
> 
> that sounds like a bit of an overstep to register them with genpd and CCF
> depending on what entity controls them.. perhaps the "q6 vote clocks" could
> be remodeled as power domains as that's what they're ultimately seem to
> be referencing.. Krzysztof should have an opinion.

I think on SM8450 and newer these were already modeled as clocks, not
power domains. Anyway, for me, the previous/existing/coming code looks
like done by coincidence or copying some downstream choices, not with
any design in mind. Unfortunately, I don't know what to do with it now,
because the bindings were merged like that.


Best regards,
Krzysztof

