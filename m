Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642066C1DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjCTRaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjCTR3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:29:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E5113C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:25:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y20so15888456lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679333099;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+40F17R4r2j3Oa6hgihalVLyCdyNWY4c+LMQXZbgJQ=;
        b=cjbmYIKQo5lsWj1ch9ZWz3daxBvFMofo3k7xie5Xjmfs5T+PIfIENsxuozFIT+2iHF
         dV2novyZc+LxFOy0e8hgfX7XHp4N5xuqSNH5PGv+B9gousA9GfWD1l6RJLvutf6Tpowu
         ftyNoaKympt7mjvx3otP08Mt11w0/buGivH4m5qlhLIpot7+yRKjScO/cupLPbQvsily
         AUe8VjAGLOYR41p2lJWl6iEpe7G7YD7iJ0kz69Sjpw/+NXNLJunMixrO5F3N0Q+h1y4i
         s3W9atqhhVof7mkqZAs4i5pAqY4Yfby4j4/kMlRMXxgwbEHKFcPoOCCi2FoKO228HRC8
         d6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333099;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+40F17R4r2j3Oa6hgihalVLyCdyNWY4c+LMQXZbgJQ=;
        b=Fc4PB6RLT9birFgA6W2Np2cHr6xHdgJat/FKY8cUjcCrAH0EbGegXsP3T3tZ9GVu9Y
         rsiTjqkctWLT8wm+9Y/nYknSPfmf8Zl0Z2k0hA6kidhCKC6qfTtOzzVTfdH87mOygZiY
         20XFa//UI10fDRTtD7iW8+PdlBd2jF8wU1VojwCxTjHUpTIHjbvVStKUJPq/w8OtslFY
         V+Az5jJof3Bpz8VX2krGymX0IZDbHPQFHK4P3Vk3kwQcKAzGZFOB82KqG2ojTlz2lJMt
         7NzTUnak0herxC+6WSj6kWW7ff1bU8r211vo5hV4KtSZ5xk7x7P0x/BzOaCx0Ql9oTpl
         tLmQ==
X-Gm-Message-State: AO0yUKWWQUIITU0UIq06grEqLrBnkK/mGCBbtb6l+00WQfAXRPFq1BID
        6Wh1eCNYlMsJ9F92IKBq1FN/0Q==
X-Google-Smtp-Source: AK7set8zFljyy8dHcXkHKUOf31A8hZipF/B/M99aifxoFkUBPjyWNnCOLRLpicX+grbKR4Uy6qO0lg==
X-Received: by 2002:ac2:4905:0:b0:4df:7cc4:d1f3 with SMTP id n5-20020ac24905000000b004df7cc4d1f3mr191838lfi.20.1679333099529;
        Mon, 20 Mar 2023 10:24:59 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651203c900b004db2ac3a522sm1803756lfp.62.2023.03.20.10.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:24:59 -0700 (PDT)
Message-ID: <c74e0683-304d-7571-1d22-c2c65d02dc6a@linaro.org>
Date:   Mon, 20 Mar 2023 18:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 09/15] arm64: dts: qcom: sa8775p: add the Power On
 device node
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230320154841.327908-1-brgl@bgdev.pl>
 <20230320154841.327908-10-brgl@bgdev.pl>
 <65d15d82-c106-b0a7-11b4-703bf22c28b1@linaro.org>
In-Reply-To: <65d15d82-c106-b0a7-11b4-703bf22c28b1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 18:23, Konrad Dybcio wrote:
> 
> 
> On 20.03.2023 16:48, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Add the PON node to PMIC #0 for sa8775p platforms.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
Hold up, I am not sure if PBS is there on PMM8654AU. Check the
-pmic-overlay.dtsi.

Konrad
>>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
>> index afe220b374c2..dbc596e32253 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
>> @@ -12,6 +12,14 @@ pmm8654au_0: pmic@0 {
>>  		reg = <0x0 SPMI_USID>;
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +
>> +		pmm8654au_0_pon: pon@1200 {
>> +			compatible = "qcom,pmk8350-pon";
>> +			reg = <0x1200>, <0x800>;
>> +			reg-names = "hlos", "pbs";
>> +			mode-recovery = <0x1>;
>> +			mode-bootloader = <0x2>;
>> +		};
>>  	};
>>  
>>  	pmm8654au_1: pmic@2 {
