Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516C564E146
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiLOSsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiLOSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:48:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BED4A044
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:47:49 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so17084467lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KkdLICyiUp5qFB2toQ17AfWSNnf2bShuodp0di+vmY=;
        b=fhtn2iDsTUWzrfZpdRICozqp3nZHdxpDjsRnxMDZaxX6tyXFtU8AVKv5jG7Tjh13Dd
         trhUNElPTWYrrDPgvyB/QT39UAeqCJnkdCUSNzCfItXUEGrPsdY4BZSnR41Dycaoow0k
         H4ikoPsmZuTcOqrAAQtf56VIOxGhFHTEDN64eYfN5usylzYxhKjmHr7Tjnqkcebfphpx
         HUmDn9HHzrIRcL7p2a74dVDygQ+oXvtzfUh/Mf8DYUMTYXzewdzIMvQtSRduqDgRDoyQ
         xgI9weMM+WLIN8hh7hb7sjcqpr5ZsPY6NdqdcT8YdJ7DmIWQRu8Sa53mNGxWg4cMrc6h
         dg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KkdLICyiUp5qFB2toQ17AfWSNnf2bShuodp0di+vmY=;
        b=qdYusHcMwKDxQoaItBBBM1T89WPuoEF+NHD5uW8Y+YbZuj2+eKXlJMR4xioBInIl59
         snTil30feyb522pRUw+lawVPOefTck6g4iWoQCZaFCn2XiSZ9JwEBa9Ar3loj3VvVdgL
         GAeGUC19lFOe3/P3p8DHKgClP2e0yKkb5f8LX436cbeXfQ00ql91jzlVrX4S/Gd93tHw
         Rn5TMo+cuizKJSYgvp8lZs8nv4rfbgJ9Nqtx6zn3ptcVOdNUQlZ/arji/E+jAo8iJiDp
         u+0iSnIxD+BqJ137v/GpagF/DqZ57QOn9hYFs4sQNPmUG1v93sg8PE4fllGCydzMIqCJ
         0eww==
X-Gm-Message-State: ANoB5pm6A3gHyyRXhoEUTIGbMcysoFrms6xalPDWPH4xjBWNvAqQ5AGo
        zLJGjAaNLAUdjpiRarhxRWgqfw==
X-Google-Smtp-Source: AA0mqf5NTgyXSzMaNtMn4AyLAzkTbEAU972I/6hxHbKuFHvbJE+uHluh5tvP8NAq4DFR3zX4K5rNEg==
X-Received: by 2002:a05:6512:acf:b0:4a4:68b9:19f6 with SMTP id n15-20020a0565120acf00b004a468b919f6mr10111133lfu.30.1671130067481;
        Thu, 15 Dec 2022 10:47:47 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t7-20020a056512030700b004b583198d83sm1232003lfp.186.2022.12.15.10.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 10:47:46 -0800 (PST)
Message-ID: <fd8b7bbb-088c-59ce-2b2a-c6c9edb3f1af@linaro.org>
Date:   Thu, 15 Dec 2022 20:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-GB
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-3-quic_molvera@quicinc.com>
 <20221202033721.4slwz2utw5u6rv7b@builder.lan>
 <9e4e6149-bc24-b727-fff7-3fb7038fc066@quicinc.com>
 <5cd9e71c-8147-2ce1-b137-0342e271031b@linaro.org>
 <82620abd-105a-6ebc-ae58-e77fa058852b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <82620abd-105a-6ebc-ae58-e77fa058852b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 15/12/2022 19:56, Melody Olvera wrote:
> 
> 
> On 12/15/2022 12:44 AM, Krzysztof Kozlowski wrote:
>> On 14/12/2022 19:59, Melody Olvera wrote:
>>>>> +			#clock-cells = <0>;
>>>>> +		};
>>>>> +
>>>>> +		sleep_clk: sleep-clk {
>>>>> +			compatible = "fixed-clock";
>>>>> +			clock-frequency = <32000>;
>>>>> +			#clock-cells = <0>;
>>>>> +		};
>>>>> +
>>>>> +		pcie_0_pipe_clk: pcie-0-pipe-clk {
>>>> Afaict these clocks are not referenced anywhere, so please skip them.
>>> Yes, so I included them to be consistent with the bindings. They will be needed later;
>>> should I still remove?
>>>
>> If they are not referenced anywhere, how is it consistent with bindings?
>> Where do the bindings require defining such nodes?
> 
> These bindings here: https://lore.kernel.org/all/20221118181826.28269-2-quic_molvera@quicinc.com/
> I believe you commented that we either have these clocks or we don't, correct? I added them to
> the dt since these clocks exist and will be needed later when USB and PCIE nodes are added.
> As Konrad noted, these technically belong in the PHYs, but I was told to put stub fixed
> clocks instead here: https://lore.kernel.org/lkml/2c8c4642-8aee-3da3-7698-5e08b4c5894d@linaro.org/
> 
> How is this to be handled? Should I remove the clocks from the dt and the bindings and add them
> later when we need them? Do I leave stub clocks here with frequency 0 until needed? I am
> very confused right now.

You were told to use stub clocks in the bindings, not in the dtsi file. 
You can use <0> in the dtsi instead.

> 
> Thanks,
> Melody
> 
>>
>> Best regards,
>> Krzysztof
>>
> 

-- 
With best wishes
Dmitry

