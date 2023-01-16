Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E6366B8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjAPIVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjAPIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:21:27 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE1869F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:21:26 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mp20so19616983ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kksFBY/c4yhHYkMVx1wegyQQqVDxSCpQBt8JCeX1iCk=;
        b=nOmJq7buDoTDyzrUxu7FfpoHH7KUU8JcMVlifu8tQJeqB4cDtLXUHKBPjk++/20av4
         gnk+w+UA5aA7NqG3FKtB37eJFkMR6nh7nYHKx0aZWtOLAj39Zg53PxHaVTel30LTC4W0
         qsVFKB7ZhuT4XiHwg4fIaCV0WM1P84cb0MomapZeMMZ9cHELYaOs5/x4J9nFfJRi+PDS
         otv73ddsFtkGD3oens04HBzy6+bkLpzVAEsq0IKh36MqSCMvXV+uWMS01/l78z+vv/Ex
         R6+6x66I9DBVXSp7uE6n6T04Zkh7Jh/kdnzzMVnCmrPxCS5MbYgRtHBHqLBMu9tuzqNz
         0hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kksFBY/c4yhHYkMVx1wegyQQqVDxSCpQBt8JCeX1iCk=;
        b=yOzsENoXOD6+AnBacX3mINAf0QzcyY27COTIvHi4ToZtLvnTATvVOcsNbzWYFAcNeK
         4QFzqNVCUid0+c7MCDDwDVLyHHridwigp/MbluX+G5W1iBUER3Sa3dsl30ZPKexh5oHe
         L1cQ1bm0qX+nv19X9NjB/RZ1wi+yOgF+DeIUmRLOnBGMgI/tRzKHxZeBbN8r1DcsPH52
         +s1kGSSkruDDciMb7tqegcKFCX+F+xkkDzgdSdY1v+2yrM3uVe8m4SEim18qduRIe2Ic
         HbM0rERQKDDWtjBKLdA0VECcxrQb2+UyFfdnjMfWXFqlr0SR8RUwzFIKuluMaCX+HDHa
         oh9A==
X-Gm-Message-State: AFqh2kpd/5gyZF8pMnV+OKNugDRqlkuY7+8uIB1JqeDYzlFay0wKgHoZ
        xRIKNTLRARR6H/IPbI9Cy71PLw==
X-Google-Smtp-Source: AMrXdXu8q1TeRl81UoABCjw4teuG1jB5u3MkwRSv4AiA4aggRmPCrQNPRQjeyDQ8bMRFiktD9zUpug==
X-Received: by 2002:a17:906:57c1:b0:84d:4646:1848 with SMTP id u1-20020a17090657c100b0084d46461848mr30710533ejr.44.1673857285594;
        Mon, 16 Jan 2023 00:21:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0084d242d07ffsm11169915ejm.8.2023.01.16.00.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:21:25 -0800 (PST)
Message-ID: <7de8a1dd-6e54-6fb5-1b3f-3162d2412608@linaro.org>
Date:   Mon, 16 Jan 2023 09:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl: support child mfd cells for the
 reset controller
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bastian Krause <bst@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
References: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
 <20230113-syscon-child-mfd-v1-2-0dd31b7de373@pengutronix.de>
 <392f6e9d-b7c2-37df-2067-f7d967a20f10@linaro.org>
In-Reply-To: <392f6e9d-b7c2-37df-2067-f7d967a20f10@linaro.org>
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

On 16/01/2023 09:20, Krzysztof Kozlowski wrote:
> On 13/01/2023 18:32, Bastian Krause wrote:
>> The actual syscon-reboot-mode child node can be added by a board
>> device-tree or fixed up by the bootloader. For the child node to be
>> probed, the compatible needs to include simple-mfd. The binding now
>> specifies this, so have the SoC dtsi adhere to it.
>>
>> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> Signed-off-by: Bastian Krause <bst@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>> index ff1e0173b39be..b16be39458aa6 100644
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -865,7 +865,8 @@ epit2: epit@20d4000 { /* EPIT2 */
>>  			};
>>  
>>  			src: reset-controller@20d8000 {
>> -				compatible = "fsl,imx6q-src", "fsl,imx51-src";
>> +				compatible = "fsl,imx6q-src", "fsl,imx51-src",
>> +					     "syscon", "simple-mfd";
> 
> You need children here. Otherwise simple-mfd does not make sense. If you
> expect something else to add children (I don't understand why, usually
> reboot capability is fixed per SoC and only sometimes extended with some
> other means), then this "else" will also change compatible.

Hm, although dtbs_check would complain... so let's clarify - why you are
not adding syscon-reboot now? It should be always here - either SoC
supports it or it does not. Board support is other thing, but this is
DTSI for SoC.

Best regards,
Krzysztof

