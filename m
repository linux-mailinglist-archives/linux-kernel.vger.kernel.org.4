Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAAA6D5C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjDDJrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjDDJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:47:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE941997
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:47:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x17so41664383lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680601639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1O1fJ/QD0Sr5hbtJk4fgvp8dFxjfJ/As4fthYvER08=;
        b=y1VjK2qIxTXGbrhW7PuyfMAZVtvaxfqf0iOUb8Sv33oWQvC8nV+B43+sPccGbRS+9e
         qAVjct7qMylS7rbl5y46NonRmXe+5R3/A/gFUPgPXNBldTDLaT/E4pT5ve/7zQYhYYRT
         H6uzRnLruQ/dVVyrw2r1Cubv9OL0XA87qCT5eyD0Jt5EQ37Yy3tj9iREJtSYF/TWoNKN
         ISelXjacTEmkXrXHcZZu72y+Y75fjaJ+Ph+9INzk/l2E6r3tA/wxdjvo+4S22Hyc38yj
         xPrxr/OqmdZHv2m0VwcwPjtUy0w5nORtdkjsWTFwNHOiD95W/YTeNSIAHOfxvh5G4bj8
         H6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1O1fJ/QD0Sr5hbtJk4fgvp8dFxjfJ/As4fthYvER08=;
        b=Kz+kA3C/jVos27aCrwokbZE+uMRAASs/mx+wGqVVlh6lqTO8MetgaMtzmvPJ+ux6Lk
         quv2d06XUhNR8S/AseH8qEL4S09oPsJRdu2nwko+RiN+slZHHbPaxlDJ0cnSGXemCH1V
         hOxTR+gq8CUvOOMhGjtdNYM4mTTtLB63BTEXKw7M62KfJ2qa5pZsHe2ZOMKxefjqTKUU
         NVemuA+3QjLwA8W/w3BhLSVay/yjc2udmdjxqvbqrPU2Wss01jAJJBSgBwBm7wn0nDiH
         1/pT7tF+OtWyXGx6tXFwNS7/J98G4OPk8MD+vIg5fXVqJQ5zyNJk9XHvBeQQ6S6Abm2Y
         j5Tw==
X-Gm-Message-State: AAQBX9d/91k16OFEvG5KZKEjwge82xqn1wNrwPXrVXN29blaH9gbS9+M
        WqjnVuwbrOhFoAXFpeITTc18Vg==
X-Google-Smtp-Source: AKy350axP7aYuaRB6bZuTKw/BgneVXxibH2twHQ6/CpCCb9fd9pMdlpREVmardu9htFeu339Ig/XPA==
X-Received: by 2002:ac2:54a4:0:b0:4ea:4793:fad0 with SMTP id w4-20020ac254a4000000b004ea4793fad0mr579816lfk.5.1680601639329;
        Tue, 04 Apr 2023 02:47:19 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id y27-20020ac2447b000000b004e9b183fc5bsm2241581lfl.8.2023.04.04.02.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 02:47:18 -0700 (PDT)
Message-ID: <b99e4236-de56-95e4-f1a1-db52238e937f@linaro.org>
Date:   Tue, 4 Apr 2023 11:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/9] arm64: dts: qcom: Add initial QCM2290, PM2250 & RB1
 device trees
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
 <20230403-topic-rb1_qcm-v1-3-ca849b62ba07@linaro.org>
 <e1c2605c-6976-4d3e-25c8-e71145eea518@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e1c2605c-6976-4d3e-25c8-e71145eea518@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.04.2023 08:06, Krzysztof Kozlowski wrote:
> On 03/04/2023 19:36, Konrad Dybcio wrote:
>> Add initial device trees for the QCM2290 SoC, QC Robotics RB1 board, as
>> well as the bundled PM2250 PMIC.
>>
>> On the SoC part, CA53 compatibles were used, as Qualcomm claims that's
>> what has been implemented, despite the cores reporting a Qualcomm Kryo
>> MIDR_EL1[PART_NUM].
>>
>> To get a successful boot on RB1, run:
>>
>> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb >\
>> .Image.gz-dtb
>>
>> mkbootimg \
>>         --kernel .Image.gz-dtb \
>>         --ramdisk some_initrd \
>>         --output rb1-boot.img \
>>         --pagesize 4096 \
>>         --base 0x8000 \
>>         --cmdline 'some cmdline'
>>
>> fastboot boot rb1-boot.img
>>
>> There's no dtbo or other craziness to worry about.
>> For the best dev experience, you can erase boot and use fastboot boot
>> everytime, so that the bootloader doesn't mess with you.
>>
>> If you have a SoM revision 3 or older (there should be a sticker on it
>> with text like -r00, where r is the revision), you will need to apply
>> this additional diff:
>>
>>         aliases {
>> -               serial0 = &uart0;
>> +               serial0 = &uart4;
>>
>> /* UART connected to the Micro-USB port via a FTDI chip */
>> -&uart0 {
>> +&uart4 {
>>
>> That should however only concern preproduction boards.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
[...]

>> @@ -0,0 +1,63 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
This I think can go BSD3

> 
> Odd license. Unless you based it on 2.0+, please use standard dual-license.

[...]
>> +	pmic@1 {
>> +		compatible = "qcom,pm2250", "qcom,spmi-pmic";
>> +		reg = <0x1 SPMI_USID>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +	};
>> +};
>> \ No newline at end of file
> 
> Patch error to fix.
Ack.

> 
>> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>> new file mode 100644
>> index 000000000000..27d4742cdb19
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>> @@ -0,0 +1,848 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> 
> Same concern. Also in DTS.
This was based off of sm6115 dtsi, which is dual-licensed.
I'm not a legal expert, not sure how much flexibility we
can get here.

Konrad
> 
> Best regards,
> Krzysztof
> 
