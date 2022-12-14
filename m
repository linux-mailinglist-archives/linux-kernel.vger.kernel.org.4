Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C3664C94E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbiLNMxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLNMxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:53:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B768C2615
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:53:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c1so10263015lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XK95zLBX9Dtieu1aqBT/9HXsnzsIwMAqX7jYd/9IRMA=;
        b=Tw1gNdqSJGWzoTjJm1lgEogkgPhRAY7KSerdf8VkmwzSGABPwrJzcGirLVqSoPw27G
         mKIU2AxuV6q813f3xULTZQQBUlb8XSxhZaeFtTWs4Z9yyPH5nZYstDspcYHm7JqSBgca
         aUiLt2hEm4/wpzndv2MFkr1RhfztFMos0VcKNIbnjrqiYBUYl9a0sXh72UQdsI88NYWN
         a1N7Q5Wan85/XtfCTBDBdoVmxn8lVpg69NmcEMg0NZlgr1iAtKWSwEUurazhUU3cokC3
         B7X9mwGN8Nz1XLv1Ej8ddFQqoATKIITxLybaY3J5YW37EuU+ohyYPx3+j+62NUXaFLuY
         dbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XK95zLBX9Dtieu1aqBT/9HXsnzsIwMAqX7jYd/9IRMA=;
        b=UGLzdKLwk6SGbWqfckCzr+1VidlDDz8+9g7WFRPUPzRugBuyEgU8rHlfyvCbT2CzeQ
         5AI0MVefVWEh6jiwy9DFgnBLPK5v3xJgGp/38qQy5qBvYevsoZLai5LPr6NibSxXb7Hu
         +K05nAB0xtwBcR31mTg9OKJR2VazdrSD7U9M6q+b82teF+/o4i6/tNk7wihYwFafMEY9
         I4SsxAN6ndeNgc0PXQekRBgNlV5Clb4IJDYRCKE8soyAZxwyMBcbWPWnT2FUSvUqetRW
         ubiLjRbem/yD25Vin3ZmPmTUq6EucJCPsyekIXjcTDFnGXfELY+cRgUiQKjDDsYmMUVT
         rL/Q==
X-Gm-Message-State: ANoB5plUD6kyM+SSVMr64r4P2Z/oBnC45Dj2p3W2H/5bjkI1Kvh+cYwt
        vms+NKSzFGGkB/009VQ9U7aL6A==
X-Google-Smtp-Source: AA0mqf6iiztO0ZW8Bq4J+cymQz8gXYvbwZweyy6yLRNNGO4+febt/gdFadXTAHSOU4TxpKIHcy2lsA==
X-Received: by 2002:a05:6512:3050:b0:4b5:1545:222b with SMTP id b16-20020a056512305000b004b51545222bmr7985241lfb.47.1671022420105;
        Wed, 14 Dec 2022 04:53:40 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id u15-20020ac258cf000000b004a47e7b91c4sm793797lfo.195.2022.12.14.04.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 04:53:39 -0800 (PST)
Message-ID: <db668bab-ab6e-32a0-872b-5118a6f5cdaa@linaro.org>
Date:   Wed, 14 Dec 2022 13:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8540p-ride: add qup1_i2c15 and
 qup2_i2c18 nodes
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, quic_shazhuss@quicinc.com
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-4-bmasney@redhat.com>
 <309b3fad-933c-6c45-5cd7-4e082da62c15@linaro.org> <Y5nB1epKN4nbk3ma@x1>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y5nB1epKN4nbk3ma@x1>
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



On 14.12.2022 13:30, Brian Masney wrote:
> On Tue, Dec 13, 2022 at 03:48:27PM +0100, Konrad Dybcio wrote:
>>> +	qup1_i2c15_default: qup1-i2c15-state {
>>> +		mux-pins {
>>> +			pins = "gpio36", "gpio37";
>>> +			function = "qup15";
>>> +		};
>>> +
>>> +		config-pins {
>>> +			pins = "gpio36", "gpio37";
>>> +			drive-strength = <0x02>;
>>> +			bias-pull-up;
>>> +		};
>>> +	};
>>
>> You can drop mux/config-pins and have the pin properties live directly
>> under the qup1-i2cN-state node.
> 
> Hi Konrad (and Shazad below), 
> 
> I need to enable 5 i2c buses (0, 1, 12, 15, 18) on this board. I tried
> the following combinations with the pin mapping configuration and the
> only one that seems to work reliably for me is what I originally had.
> 
> With the following, only 2 out of the 5 buses are detected. There's no
> i2c mesages in dmesg.
> 
>     i2c0_default: i2c0-default-state {
>         pins = "gpio135", "gpio136";
>         function = "qup15";
>     };
> 
> Next, I added a drive-strength and bias-pull-up. All 5 buses are
> detected. One bus throws read errors when I probe it with i2cdetect, two
> others 'i2cdetect -a -y $BUSNUM' takes ~5 seconds to run, and the
> remaining two are fast.
> 
>     i2c0_default: i2c0-default-state {
>         pins = "gpio135", "gpio136";
>         function = "qup15";
>         drive-strength = <2>;
>         bias-pull-up;
>     };
> 
> This is the style where i2cdetect seems to be happy for all 5 buses and
> is fast:
> 
>     i2c0_default: i2c0-default-state {
>         mux-pins {
>             pins = "gpio135", "gpio136";
>             function = "qup0";
>         };
> 
>         config-pins {
>             pins = "gpio135", "gpio136";
>             drive-strength = <2>;
>             bias-pull-up;
>         };
>     };
Unless you made a typo somewhere, I genuinely have no explanation for this..

Konrad
> 
> 
> Shazad: 'i2cdetect -a -y $BUSNUM) shows that all 5 buses have the same
> addresses listening. Is that expected? That seems a bit odd to me.
> 
> [root@localhost ~]# i2cdetect -a -y 0
> Warning: Can't use SMBus Quick Write command, will skip some addresses
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:                                                 
> 10:                                                 
> 20:                                                 
> 30: -- -- -- -- -- -- -- --                         
> 40:                                                 
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 60:                                                 
> 70:                                                 
> 
> I triple checked that I have the QUP pins defined correctly for the 5
> buses. I checked them against what's in the downstream kernel and I also
> checked them against what's in upstream's
> drivers/pinctrl/qcom/pinctrl-sc8280xp.c. This is the pin mapping that I
> have:
> 
>     i2c0: gpio135, gpio136
>     i2c1: gpio158, gpio159
>     i2c12: gpio0, gpio1
>     i2c15: gpio36, gpio37
>     i2c18: gpio66, gpio67
> 
> Brian
> 
