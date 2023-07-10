Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6774CCBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGJGX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGJGXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:23:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02612118
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:23:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e34ad47eeso5196466a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688970229; x=1691562229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bbe7QnWT/QjcdEKCg+pZJp4ZI9AuvrNUc23CcVecdSg=;
        b=IW6eLFt0eI/0iHHQPVmWlMwDfACfKBZ7R0ipo6DER8RHqa8pUxIUN7pXnYqEN60eFP
         XH2DW6nQbikCCpwnHRNz7DpwOd/CC8dGIlprXBO6Eq5iOCBo/oZuuRkJzVmtWls2+Rla
         1G5wrTrjtv//7VtzDBrUSh5P4hUkOXMMbyUpBER+UlMMKuHYPNJeu0yDztDy+5soltgS
         txPbhtoI+mMIa1e8z5yFWiUs/17ywOdhj1i8h4SaCmLyM1+Zx0OFA0auM8zZhHx8ndse
         M9ilhr2kbZOoh3aiCbKIN0z8ojgQwF44J8ZfcMP1D/Li/rWX6VLPHoWdTeXBVt9uMtIk
         xhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688970229; x=1691562229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbe7QnWT/QjcdEKCg+pZJp4ZI9AuvrNUc23CcVecdSg=;
        b=kcg08vU5tZyweYSPUNN9mrm8c5AyY4gksNJGBIYdufkuoHLacPplIn3QYofZXkSt/O
         xC3a/FTQWThm5xTKb3NlwB8vpH3cHpZGWFB1CcCmuRnCZl0s2743oYwskFdSscU3wRSe
         JCY85yDjnGXesIeNbqRvAzmeFB8/2WAjHlmnLt5qs7qOFmLaecj1tzLU+gtM9afepBwv
         5dtzQxAlqNgcbdjcTQycBgi8MSpRk7pPNfSy9+H0yfSHmvOP09AXdWL1aFjswRDDKuag
         7mP1d+U0vIW7HEB76Nu9PztRGbFD1A/KjjHWEHF6Bls9VLaZvgP3eVGiaHBw3a3WvP3C
         1kVA==
X-Gm-Message-State: ABy/qLbO7RQyhWt6lLQD93XxuYUILJKJSKSPuEJfjOlill/80fC4h5c0
        roQI0efS6Pyj14wpOawrbD3g6Q==
X-Google-Smtp-Source: APBJJlHGquRUbo4/JhzVeeLoruSHOray7sVtET3yIhwbTvUb+sI14Etu2bywKI8svBVCU5FTjqyfcA==
X-Received: by 2002:a17:907:3f0b:b0:98e:2423:708 with SMTP id hq11-20020a1709073f0b00b0098e24230708mr15205758ejc.62.1688970229385;
        Sun, 09 Jul 2023 23:23:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y23-20020a170906471700b00993928e4d1bsm5649847ejq.24.2023.07.09.23.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 23:23:48 -0700 (PDT)
Message-ID: <d69221f2-4947-f4e5-4a37-550ba13a0d9f@linaro.org>
Date:   Mon, 10 Jul 2023 08:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Varun Sethi <V.Sethi@nxp.com>
References: <20230616174050.644880-1-pankaj.gupta@nxp.com>
 <DU2PR04MB86300C782DC7637C469599EC9526A@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <PAXPR04MB8638AD814BC6A3BFF6A822209530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB8638AD814BC6A3BFF6A822209530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 07:27, Pankaj Gupta wrote:
> Hi All,
> 
> Gentle reminder. Please review this patch.
> 
> Thanks.
> Pankaj
> 
>> -----Original Message-----
>> From: Pankaj Gupta <pankaj.gupta@nxp.com>
>> Sent: Monday, June 26, 2023 10:17 AM
>> To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
>> imx@nxp.com>; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
>> Subject: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
>>
>> V2: Changed the email subject line.
>> ------------------------------------------------
>>
>>

That's not a place for changelog. It goes after --- .

>> Add crypto node in device tree for:
>> - CAAM job-ring
>>
>> Signed-off-by: Varun Sethi <v.sethi@nxp.com>
>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32
>> ++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
>> index 32193a43ff49..ce8de81cac9a 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
>> @@ -207,6 +207,38 @@ pcc3: clock-controller@292d0000 {
>>  				#reset-cells = <1>;
>>  			};
>>
>> +			crypto: crypto@292e0000 {
>> +				compatible = "fsl,sec-v4.0";
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				reg = <0x292e0000 0x10000>;

reg is after compatible

>> +				ranges = <0 0x292e0000 0x10000>;

ranges should be third.

>> +


Best regards,
Krzysztof

