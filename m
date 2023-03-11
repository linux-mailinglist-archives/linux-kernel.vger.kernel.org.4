Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70D86B5BE6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCKMkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjCKMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:40:51 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E0F138F64
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:40:49 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b13so8101775ljf.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678538448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6Lr4gzJvtEBRkjf5l74aquX1WXpc5uqOqTgdNPw48g=;
        b=AQqnQcTlrE0Nneqs6mBJqpsxMV0ZOVoOEVvYW894SinZWIMF7fm3+dtqRARsBz+yHl
         3G/jN7PAqnHvMaT2tputX5mXm+0KbL5pEJlWEgT/lWUHipbMEmTxup7lYjqrE+hbIy3Y
         QfqxsCc7cQAqWdPVsarXqsMcHj96poGc3UY6rg7BU2stlrzRsxELXwbU8lpQZ7spyFJw
         EUKTCrLRBgvdC4I1H7ThN9M76Tnm0uXC+YTEGjUi1vR+r74uM+bscyvc1ydxTTa4kBMQ
         C35/dvtstyRGiBeNeeYvRmen5LYjsBzpgdo8WpwyOLa47a1QQEOq1JN/E/L2GX1DoCIH
         129w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678538448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6Lr4gzJvtEBRkjf5l74aquX1WXpc5uqOqTgdNPw48g=;
        b=1t0MduwcmnVKx7cQfY/akUhlf1W5hBqvG5q47uMU3xHlC8O51mO9gydB2bmas5CSj3
         qqrHqZrKsUEgUyPHPtOQKMtJajFfwR/m7glMxsmzPoUPtkpamOFZHNjmwF615dXDjDBj
         UlD21EkNLLj/3ncHfaVc0a/T7rqw2ITBA1vuLQ4fL0thIBe+Vy5eB3Sh85mdpv7dZuKl
         YBUxAAItSamurKV+Dehv2biuyhvjwSaxtaZVnkmE9K2H34KUrpQvj5frXif6skaavrQ6
         X0w0MQlV/Q3LgpmFV7ciSnA/Vk4uz8+0zB7XocL0nxQrTiRaBvspznj7jKLTihYBrUma
         V5Ag==
X-Gm-Message-State: AO0yUKUJJaA/QMI0LeERk+0qZQjOP90kQbvIywOwGOn36EQ3wpkIhl/9
        OhMRkRfCenVg/U4OHzLRwYCHQw==
X-Google-Smtp-Source: AK7set+R9n+SGv+MTFU8760M6JgoauxWOUXwZGBeYq/l37Jb9upcXQMH0ryfN7UOoze7BEla0LdonA==
X-Received: by 2002:a2e:93c6:0:b0:293:2d4d:7e00 with SMTP id p6-20020a2e93c6000000b002932d4d7e00mr8732618ljh.12.1678538447739;
        Sat, 11 Mar 2023 04:40:47 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id k5-20020a2ea285000000b002906a3739dasm315070lja.19.2023.03.11.04.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:40:47 -0800 (PST)
Message-ID: <2b368fdc-8c81-8e87-68fc-866aef904413@linaro.org>
Date:   Sat, 11 Mar 2023 13:40:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC 00/15] Convert Qualcomm RPM message RAM to a
 simple-mfd
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
 <CAA8EJpqm6F6pvBR81xA=ZFyTPXpz+e+Ja+X4qF4ZD-3W5T2jJA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpqm6F6pvBR81xA=ZFyTPXpz+e+Ja+X4qF4ZD-3W5T2jJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.03.2023 12:24, Dmitry Baryshkov wrote:
> On Sat, 11 Mar 2023 at 03:21, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> The Qualcomm RPM message RAM is a part of the RPM low-power processor's
>> actual RAM that's exposed to the Application Processors as a MMIO-mapped
>> region. It contains a couple of things, most notably the RPM master stats,
>> detailing per-master (read: per-subsystem) sleep/wake statistics and an
>> interrupt controller that's crucial to achieving full SoC clock and/or
>> power collapse states (the MPM). This series tries to prepare the MSG
>> RAM node to be a host for such devices.
>>
>> Depends on https://lore.kernel.org/linux-arm-msm/20230308011705.291337-1-konrad.dybcio@linaro.org/
>>
>> to solve a warning in the example.
>>
>> The DTS commits don't add -cells or -ranges, as without children they're
>> not of very much use. They'll be introduced along with subnodes.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Konrad Dybcio (15):
>>       dt-bindings: mfd: Split out Qcom RPM MSG RAM
>>       arm64: dts: qcom: msm8916: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: msm8953: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: msm8976: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: msm8994: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: msm8996: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: msm8998: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: qcs404: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: sdm630: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: sm6115: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: sm6125: Add simple-mfd to rpm_msg_ram
>>       arm64: dts: qcom: sm6375: Add simple-mfd to rpm_msg_ram
>>       ARM: dts: qcom-apq8084: Add simple-mfd to rpm_msg_ram
>>       ARM: dts: qcom-msm8226: Add simple-mfd to rpm_msg_ram
>>       ARM: dts: qcom-msm8974: Add simple-mfd to rpm_msg_ram
> 
> These commits do not demonstrate the need for simple-mfd (other than
> qcom,mpm being mentioned in bindings). I'd suggest limiting the RFC to
> a single platform populated with rpm_msg_ram child devices. This way
> we can better understand the needs and the requirements for these
> patches.
Right.. I was debating whether to just send the bindings as a RFC, but
then I'd have to make simple-mfd optional just to retire it soon..

Konrad
> 
> 
