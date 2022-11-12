Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289CF626989
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 14:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiKLNBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 08:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiKLNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 08:01:45 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8A13CC0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 05:01:44 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u2so7392501ljl.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 05:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgT4tqP2ecPVWJcDHv0NKESulba86gjeg26EGAYNcos=;
        b=KDaH8WIRCdVR+GjRpWmcD3rfsOSDza5ir3TOH0XdT6uNU/QYW5PDqX2r6QpE0yXlfg
         yxmEG+V3X53+ObJl/HeTOK7HsH1vV3Iw9r34X1YWwxZpVxWWGRFLl8plqhFdKdfkDn40
         E4wB+oanzgr+EBGfZV3mHNS+g1A0KgcsZdJWSubVGv2KuyW683OcrBzSodIlSIbkxklv
         P60RQdL8l+9QV3otkFVnUrVwEY7xcDDSrMHD26o7VdhAfsvSY1rYPesGX9rpz1KytPFy
         4MLstgUD6zuz/KIgICGsI8a4QlRIYOc4wQzVaTKhg1cl3wlVPknefUstprF9AAlYUUyS
         M12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fgT4tqP2ecPVWJcDHv0NKESulba86gjeg26EGAYNcos=;
        b=rkmT6iBTh05wVnDNgvpgq5poEvck3mUsHxAsG+frD6bzIvN+Ry9ABIu6vrKrBz3qAq
         0NpZjSX+cHZXacOedzjgguNsZnN85Qjgth/s6zkM72vXbHVBVTOrEas8/JfhRWH54ODj
         1gq8WE4G/vRqKmUhUaK3m5q1WOtTmgSyBNNAMl/Jo8+9w+X4TuhtEgBd4sDyz295Ey7C
         0ueaa6JTMAXCL1LM1DTTPrLmpqZ/IPgKHdlkDsL+7ACS0nkLm/dnsR2IpMNVNK0qs4Zf
         ChNLfifyuk/2Hv6niNbmQtuWEWbqyzAIYWf4e0iBOuQdVGkkHIVcGh4v+qD7veXYf7V0
         H90g==
X-Gm-Message-State: ANoB5plcTj1b0h/z5MjKX8e5OUJF28WL3ylSKUpxVvfU6fJZKsgNEC6z
        KfwmvPbkgealU9dN1Pyv3IYNGw==
X-Google-Smtp-Source: AA0mqf63u9b5nsfNXBqTY2WNADR82cKmOxrl42REc6JHBBkLt4OlpHM0dEbKwj18EiMmq5e1j343Hw==
X-Received: by 2002:a2e:8e90:0:b0:277:f07:bea with SMTP id z16-20020a2e8e90000000b002770f070beamr1897086ljk.122.1668258102333;
        Sat, 12 Nov 2022 05:01:42 -0800 (PST)
Received: from [192.168.1.110] (95.49.29.126.neoplus.adsl.tpnet.pl. [95.49.29.126])
        by smtp.gmail.com with ESMTPSA id a22-20020a056512201600b004b48cc444ccsm742685lfb.100.2022.11.12.05.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 05:01:41 -0800 (PST)
Message-ID: <2a912517-4b43-304a-4be6-f3d1b78e62f6@linaro.org>
Date:   Sat, 12 Nov 2022 14:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 4/9] arm64: dts: qcom: sc8280xp-crd: enable NVMe SSD
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-5-johan+linaro@kernel.org>
 <d3aead5b-413a-e929-1b33-7956fa117d4d@linaro.org>
 <Y2524KFw1izDx3pG@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y2524KFw1izDx3pG@hovoldconsulting.com>
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


On 11/11/2022 17:22, Johan Hovold wrote:
> On Thu, Nov 10, 2022 at 12:06:45PM +0100, Konrad Dybcio wrote:
>> On 10/11/2022 11:35, Johan Hovold wrote:
>>> Enable the NVMe SSD connected to PCIe2.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 63 +++++++++++++++++++++++
>>>    1 file changed, 63 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> +	pcie2a_default: pcie2a-default-state {
>> Aren't they going to be identical for all boards anyway? Maybe there
>> could be some commonization..
> We had that discussion and decided that keeping the pinconfig in the dts
> is the right thing to do.
>
> And even if the clkreq pin will be the same for all boards that's not
> necessarily the case for the other two.

Okay then. I simply keep forgetting which pins we concluded go where..


Konrad

>
>>> +		clkreq-n-pins {
>>> +			pins = "gpio142";
>>> +			function = "pcie2a_clkreq";
>>> +			drive-strength = <2>;
>>> +			bias-pull-up;
>>> +		};
>>> +
>>> +		perst-n-pins {
>>> +			pins = "gpio143";
>>> +			function = "gpio";
>>> +			drive-strength = <2>;
>>> +			bias-pull-down;
>>> +		};
>>> +
>>> +		wake-n-pins {
>>> +		       pins = "gpio145";
>>> +		       function = "gpio";
>>> +		       drive-strength = <2>;
>>> +		       bias-pull-up;
>>> +	       };
>>> +	};
>>> +
>>>    	qup0_i2c4_default: qup0-i2c4-default-state {
>>>    		pins = "gpio171", "gpio172";
>>>    		function = "qup4";
> Johan
