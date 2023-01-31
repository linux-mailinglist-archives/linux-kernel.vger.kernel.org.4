Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5218E682CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjAaMpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjAaMpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:45:17 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A55D4B880
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:45:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mf7so22502768ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIG4XCWjRacvl+h1hS8hIYQoTLHGrO/Gz0j3qRIlm64=;
        b=WC9q9+AcVkB8YRxKL2W95jTF2dL4MjcIVw5SXWpMf/DDk5VRIe3q/jqP9dDxf/vNfm
         kD3U7Hs6/64Ny0PlKw+FNVVJNSUP6VNCEaBg1FKC/zYYwGm1Ko5b15kaOG1mfHF0FX7n
         JIzvt9nVvG+aEtGIP+l+4pPzRDx7o0G2uNyqlhPdyhNFBlXdKwghHRrzYlSdbJFkyxJ4
         Eo5pCltNdFsegIQ62mXSdDjumO0ft68uaupd9x10bCesW0IFJrZWkVHXmz1Mgh2m4NPh
         /s0+FHv5FtP/4k9hjYMJw/ay/BQA9B+NclSiyWHUy++DA6WiKb7LwboWN9QmosfRQ9iJ
         0hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIG4XCWjRacvl+h1hS8hIYQoTLHGrO/Gz0j3qRIlm64=;
        b=b0L+vhagoSQto0FqWRogVPihEBakz2QD5hbO5lIO/fToSBqY1vdFc5f/WZpub8FEnH
         lM0PfpwPKyU1/fDxqoCTmqciVe6+A/PhxwzjBkzigGDr4vb0507EFNjOS3FeAh4aj2EV
         8c8O/qRkkYRTf0uisVZFCvoy9xD5n+2ddnX9suTYC9CHzjxJ1aN9vInLHo+PB00ggPQG
         nCC12vdefYXInu66fVo3UjlY0N/GX7aZsBvgAays4F0C5E5Pd4emUut3RZcNzNL/UkxS
         JN6qETAxc23RkaR0NQNq/TBPK0pSHgyoV+zmqr53VTb9V7lfMt9qzNEY9gLao4CgLR1Z
         lZeg==
X-Gm-Message-State: AO0yUKXAvSz2J47ZmxoqE92/dJ8+/ClUER62NlZgHs5mDDlTRhO2ZmRD
        LANRG7m9LfdeFP5kr6scBRF6kA==
X-Google-Smtp-Source: AK7set82TTA740e3Z9R3mAUKNQBmbrXEzO4uR+swZlBIfH0iu+8ZyrzILJWos0jQfidYz4HDsCZSsQ==
X-Received: by 2002:a17:906:d0c2:b0:878:5fdc:3850 with SMTP id bq2-20020a170906d0c200b008785fdc3850mr22855998ejb.48.1675169113959;
        Tue, 31 Jan 2023 04:45:13 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906264400b0084d35ffbc20sm8372561ejc.68.2023.01.31.04.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:45:13 -0800 (PST)
Message-ID: <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org>
Date:   Tue, 31 Jan 2023 13:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
 <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
 <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.01.2023 12:06, Dmitry Baryshkov wrote:
> On Tue, 31 Jan 2023 at 12:54, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> On 24/01/2023 18:28, Amit Pundir wrote:
>>> Put cont splash memory region under the reserved-memory
>>> as confirmed by the downstream code as well.
>>>
>>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>> index f41c6d600ea8..2ae59432cbda 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>> @@ -100,6 +100,14 @@ hdmi_con: endpoint {
>>>               };
>>>       };
>>>
>>> +     reserved-memory {
>>> +             /* Cont splash region set up by the bootloader */
>>> +             cont_splash_mem: framebuffer@9d400000 {
>>> +                     reg = <0x0 0x9d400000 0x0 0x2400000>;
>>> +                     no-map;
>>> +             };
>>> +     };
>>> +
>>>       lt9611_1v8: lt9611-vdd18-regulator {
>>>               compatible = "regulator-fixed";
>>>               regulator-name = "LT9611_1V8";
>>
>> Doesn't this mean we loose 0x2400000 of DRAM for all rb3 platforms
>> though ? About what 37 megabytes.. ?
> 
> I think this memory is further used for display memory allocation. So
> we are not loosing it, but dedicating it to the framebuffer memory.
Not exactly, to do so, you'd have to use the memory-region property
with mdss, which nobody does. Otherwise it's just a hole for Linux.

Konrad
> 
> 
