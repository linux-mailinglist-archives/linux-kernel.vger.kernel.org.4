Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85615B59F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiILMIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILMIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:08:12 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1462032EE9;
        Mon, 12 Sep 2022 05:08:09 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Sep 2022 21:08:09 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 6048120584CE;
        Mon, 12 Sep 2022 21:08:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 12 Sep 2022 21:08:09 +0900
Received: from [10.212.158.44] (unknown [10.212.158.44])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 1B5A9B62A4;
        Mon, 12 Sep 2022 21:08:08 +0900 (JST)
Subject: Re: [PATCH v2 2/8] ARM: dts: uniphier: Rename usb-phy node to
 usb-glue
To:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220912071511.1385-1-hayashi.kunihiko@socionext.com>
 <20220912071511.1385-3-hayashi.kunihiko@socionext.com>
 <2a386281-5a49-4df6-bafe-ef9de0fb0ca5@www.fastmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <5040fdd1-3ca0-1659-a572-fcc9b64499f9@socionext.com>
Date:   Mon, 12 Sep 2022 21:10:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2a386281-5a49-4df6-bafe-ef9de0fb0ca5@www.fastmail.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for checking.

On 2022/09/12 17:32, Arnd Bergmann wrote:
> On Mon, Sep 12, 2022, at 9:15 AM, Kunihiko Hayashi wrote:
>> Actual phy nodes are each child node. The parent node should be usb-glue
>> node. This applies to the devicetre for Pro4 SoC.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   arch/arm/boot/dts/uniphier-pro4.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi
>> b/arch/arm/boot/dts/uniphier-pro4.dtsi
>> index a53b73ee93e9..cf62821c69ca 100644
>> --- a/arch/arm/boot/dts/uniphier-pro4.dtsi
>> +++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
>> @@ -376,7 +376,7 @@ pinctrl: pinctrl {
>>   				compatible =
> "socionext,uniphier-pro4-pinctrl";
>>   			};
>>
>> -			usb-phy {
>> +			usb-glue {
>>   				compatible =
> "socionext,uniphier-pro4-usb2-phy";
>>   				#address-cells = <1>;
>>   				#size-cells = <0>;
> 
> Not sure about this one. What hardware does this node
> actaully represent? I don't see any other soc dts files
> refer to node names as 'glue', so there is probably a
> better name for it. In the binding document, it's called
> "usb-controller", but I'm not sure that is the right name
> either.
Surely, "glue" is uncommon, and "usb-controller" is suitable
to represent the integration of usb-related functionality.
I'll review the node names.

Thank you,

---
Best Regards
Kunihiko Hayashi
