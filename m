Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A576216A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiKHObQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiKHOat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:30:49 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9C2B114E;
        Tue,  8 Nov 2022 06:30:26 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Nov 2022 23:30:26 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2077220584CE;
        Tue,  8 Nov 2022 23:30:26 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 8 Nov 2022 23:30:26 +0900
Received: from [10.212.157.169] (unknown [10.212.157.169])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 45D44B62A4;
        Tue,  8 Nov 2022 23:30:25 +0900 (JST)
Message-ID: <df21cfca-67ed-0c78-7f1e-13e321edabe1@socionext.com>
Date:   Tue, 8 Nov 2022 23:30:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/5] arm64: dts: uniphier: Add NX1 SoC and boards
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
 <20221107103410.3443-6-hayashi.kunihiko@socionext.com>
 <f8f83839-2e76-e500-a16e-5fd2985a278d@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <f8f83839-2e76-e500-a16e-5fd2985a278d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/11/08 20:13, Krzysztof Kozlowski wrote:
> On 07/11/2022 11:34, Kunihiko Hayashi wrote:
>> Initial version of devicetree sources for NX1 SoC and boards.
>>
>> NX1 SoC belongs to the UniPhier armv8 architecture platform, and is
>> designed for IoT and AI/ML application fields.
>>
> 
>> +
>> +		soc_glue: syscon@1f800000 {
>> +			compatible = "socionext,uniphier-nx1-soc-glue",
>> +				     "simple-mfd", "syscon";
>> +			reg = <0x1f800000 0x2000>;
>> +
>> +			pinctrl: pinctrl {
>> +				compatible = "socionext,uniphier-nx1-pinctrl";
> 
> So instead of documenting the hardware precisily, you have one big bag
> for everything under simple-mfd. This is not how the SoC should be
> described in DTS.

Sorry I don't understand. This is inherited from the previous descriptions,
but is there some example to express DTS correctly about that?

> 
>> +			};
>> +		};
>> +
>> +		soc-glue@1f900000 {
>> +			compatible = "simple-mfd";
> 
> No, it is not allowed on its own. You need a specific compatible and
> bindings describing its children.

I saw the definition of "simple-mfd" itself is only in mfd/mfd.txt.

Currently there are only efuse devices as children, and this space means
nothing. I think it had better define the devices directly.

Thank you,
---
Best Regards
Kunihiko Hayashi
