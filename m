Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B7466D73D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjAQHvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbjAQHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:51:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BD714E94
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:51:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g10so21548119wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HurAsoClkkfNishWyH7zyhaS3SjeDCn6WcRooyIarSk=;
        b=HrQi2jM2o3k7MlGekuYzaRfGnWM40tf3DH1T7opEj1V16klaEMUxJI7aNqVcb/qg9r
         ocIQtAl5h2SHhb45/fc+ld45TMwe7JarYlfaCvgM0h3KOb+01x6MY9mm/XF8RChm6QKo
         mshyl8wMDh8x5RGAmN7kfShw+9NttQQWjBu2DRiX3r6NmYt4GPBRmHTorJ4HszSYa6Rw
         8SzUKv9Qvsrmbbn6sNbpuwvUXvpkj9EVyfBWBXZBCQ6mu5BfB44zwirK8AvmeWfPmv0f
         f0FJAcCviVIOc0lOejsbCVxherG0FCCtgZarK6JfyKqhqUVD0sabjJ9EzBHkbDp+jdeS
         y0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HurAsoClkkfNishWyH7zyhaS3SjeDCn6WcRooyIarSk=;
        b=pfip+stP/pafdeKFJVWaOOINvV6F+PUBiTj/e5eLy7Z7TCFEMBph40jqpUM5yRhRKI
         70qAJ+XlqY/Zq1nLIx2vKlRntBvi3re9YBry0yjavoi2AFiGZz2KKYbBudkUosXp1I0K
         vgi1Pdiucr1IxR4pEJ+XZfu2x/OPYBMbRfUPSrhNbMuPAoXU0PRxXEQi8nNQcPbmT9Aq
         LpqkxNadkA5FZyBpABb2T+FpD0la65VA8qI7JfDO38Qyk9Pk2TAsDC4yLGvBnDzu/kMB
         KfhsFBdlzBAL65NtrZQIuo4EmNXqmPRKMWeiisLQ3+bE9wnvvmclwdCiWhQh7YV8rzba
         j0bA==
X-Gm-Message-State: AFqh2kqunCK0Sc3CQDhl+TJfWasUMoy1Zw0LZ/JIedqmQNugsuPiEE09
        BpfRSPp8J4jkRSv8PFSSPXr3aA==
X-Google-Smtp-Source: AMrXdXvme5c+Y2+O5xOdzwHI53CavI+MeY/3uvmpsnhkqo7OyPX1WsvR43HhkCntqsykA4usyIw3mQ==
X-Received: by 2002:a05:600c:c16:b0:3da:26e5:10b6 with SMTP id fm22-20020a05600c0c1600b003da26e510b6mr2193294wmb.30.1673941903802;
        Mon, 16 Jan 2023 23:51:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t5-20020a1c7705000000b003daffc2ecdesm3815750wmi.13.2023.01.16.23.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 23:51:43 -0800 (PST)
Message-ID: <948d6fec-12e3-f4e6-8024-d444e5a41df5@linaro.org>
Date:   Tue, 17 Jan 2023 08:51:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sdm845: move WCD9340 codec to
 separate file
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
 <20230113162245.117324-2-krzysztof.kozlowski@linaro.org>
 <20230117035631.cgi6fjdrpz5eppca@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230117035631.cgi6fjdrpz5eppca@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 04:56, Bjorn Andersson wrote:
> On Fri, Jan 13, 2023 at 05:22:41PM +0100, Krzysztof Kozlowski wrote:
>> WCD9340 codec node is not a property of the SoC, but board.  Move it to
>> separate file and include it in the specific boards.  On all others,
>> keep the Slimbus node disabled as it is empty.
>>
> 
> I think this seems like a reasonable idea. But without clearly
> documenting your intentions/guidelines we will soon have
> sdm845-display.dtsi, sdm845-pcie.dtsi etc.
> 
> So please start there.

You said like this started the process but it is already there for
sc7280. Where do you want to store such documentation? In commit msg?

> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../boot/dts/qcom/sdm845-audio-wcd9340.dtsi   | 69 +++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  1 +
>>  .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  1 +
>>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  1 +
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 60 +---------------
>>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  1 +
>>  .../boot/dts/qcom/sdm850-samsung-w737.dts     |  1 +
>>  7 files changed, 75 insertions(+), 59 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
>> new file mode 100644
>> index 000000000000..5bcce7d0d709
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> 
> Why does this include the substring "audio"?

To indicate it covers entire audio, which points me to the fact that
probably I can also move there sound node.

Best regards,
Krzysztof

