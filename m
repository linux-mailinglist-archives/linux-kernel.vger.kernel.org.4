Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177B6F8DA5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjEFBew convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 May 2023 21:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjEFBeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:34:50 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CBD40C7;
        Fri,  5 May 2023 18:34:35 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8522424E1CE;
        Sat,  6 May 2023 09:34:32 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 6 May
 2023 09:34:32 +0800
Received: from [192.168.125.108] (183.27.98.219) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 6 May
 2023 09:34:31 +0800
Message-ID: <f9c3d29f-0507-e8a2-9e0a-4499ede6aeb5@starfivetech.com>
Date:   Sat, 6 May 2023 09:34:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/2] dt-binding: cdns,usb3: Add clock and reset
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20230502081805.112149-1-minda.chen@starfivetech.com>
 <20230502081805.112149-2-minda.chen@starfivetech.com>
 <c2b7fce9-0ca4-31ed-b851-cc415984add5@linaro.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <c2b7fce9-0ca4-31ed-b851-cc415984add5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.98.219]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/3 4:10, Krzysztof Kozlowski wrote:
> On 02/05/2023 10:18, Minda Chen wrote:
>> To support generic clock and reset init in Cadence USBSS
>> controller. Add clock and reset dts configuration.
> 
> s/. Add/, add/
> (although still weird sentence)
> 
ok
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 12 ++++++++++++
> 
> Also update the example or any in-tree DTS. Why existing users do not
> need it? Aren't you duplicating clocks with wrapping node?
> 
> Best regards,
> Krzysztof
> 
I will update the example. Exiting users are NXP and TI. NXP codes do not contain clock and resets, TI usb2 refclk require to set clock rate，
TI codes can't direct use it. And I don't know TI's hardware. Maybe Roger can take into account to use it.
