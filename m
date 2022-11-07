Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3401E61E8A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiKGCgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKGCgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:36:47 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15CAA38A1;
        Sun,  6 Nov 2022 18:36:45 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Nov 2022 11:36:44 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id A4D0020584CE;
        Mon,  7 Nov 2022 11:36:44 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 7 Nov 2022 11:36:44 +0900
Received: from [10.212.157.112] (unknown [10.212.157.112])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 3140EB62A4;
        Mon,  7 Nov 2022 11:36:44 +0900 (JST)
Message-ID: <c699e361-a8a3-c6d3-9db4-1e1d07fc6b5b@socionext.com>
Date:   Mon, 7 Nov 2022 11:36:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] dt-bindings: phy: Fix UniPhier SATA controller node
 names in example
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221027044920.23194-1-hayashi.kunihiko@socionext.com>
 <20221027044920.23194-3-hayashi.kunihiko@socionext.com>
 <20221028193859.GA2188803-robh@kernel.org>
 <0d7636f6-2c51-587d-1961-face98dfa056@socionext.com>
 <CAL_Jsq+8Rm9v4megza14JPyamV-9Yr4iAa5r+HhM6qtdHRWEBw@mail.gmail.com>
 <07155116-2027-2916-5a39-e4dff8298b27@socionext.com>
 <Y2YSGDOXpRQ8MIoR@matsya>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Y2YSGDOXpRQ8MIoR@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2022/11/05 16:34, Vinod Koul wrote:
> On 02-11-22, 08:14, Kunihiko Hayashi wrote:
>> On 2022/11/02 4:31, Rob Herring wrote:
>>> On Tue, Nov 1, 2022 at 4:10 AM Kunihiko Hayashi
>>> <hayashi.kunihiko@socionext.com> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> On 2022/10/29 4:38, Rob Herring wrote:
>>>>> On Thu, Oct 27, 2022 at 01:49:20PM +0900, Kunihiko Hayashi wrote:
>>>>>> The word "glue" is ambiguous for the controller node name.
> Should put
>>>>>> "sata-controller" instead of "ahci-glue" on the controller node.
>>>>>> And rename a phy node to "sata-phy".
>>>>>>
>>>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> | 4
>>>>>> ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git
>>>>>
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>>>>
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>>>>> index a3cd45acea28..89b8b133777a 100644
>>>>>> ---
>>>>>>
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
>>>>> yaml
>>>>>> +++
>>>>>>
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
>>>>> yaml
>>>>>> @@ -117,14 +117,14 @@ additionalProperties: false
>>>>>>
>>>>>>     examples:
>>>>>>       - |
>>>>>> -    ahci-glue@65700000 {
>>>>>> +    sata-controller@65700000 {
>>>>>
>>>>> But is this really the SATA controller aka AHCI?
>>>>>
>>>>> In cases where we don't have a standardized name, I don't think it
> makes
>>>>> sense changing node names from one non-standard name to another.
>>>>
>>>> I see. This can't be named generic, so this change will drop.
>>>> And "sata-phy" in the same way.
>>>
>>> I think sata-phy is fine. It may not be added, but usb3-phy or
>>> pcie-phy are common already.
>> I understand. But of cource "phy" is also common, so I defer the change
>> from "phy" to "sata-phy".
> 
> Should it not be just phy@xxx does it really need to be foo-phy?

This change was pointed out in the previous review for our devicetree,
so I made this change in the devicetree, however, I think I can leave it
as "phy" until the properties that depend on "sata-phy" are defined.

Thank you,

---
Best Regards
Kunihiko Hayashi
